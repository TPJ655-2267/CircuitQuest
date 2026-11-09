#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Adafruit_VL53L0X.h>
#include <Keypad.h>
#include <Adafruit_MPU6050.h>
#include <math.h>
#include <DFRobotDFPlayerMini.h>
#include <esp_timer.h>
#include <WiFi.h>
#include <WebServer.h>
#include "dashboard.h"
#include "game_results.h"
#include "game_outputs.h"
#include <SPI.h>
#include <MFRC522.h>
#include "rfid_config.h"
#include <Adafruit_NeoPixel.h>

// Dashboard-controlled 12-pixel WS2812B ring. Common supply/ESP32 ground required.
constexpr uint8_t DASHBOARD_RGB_PIN = 21;
constexpr uint16_t DASHBOARD_RGB_COUNT = 12;
Adafruit_NeoPixel dashboardRgb(DASHBOARD_RGB_COUNT, DASHBOARD_RGB_PIN, NEO_GRB + NEO_KHZ800);
bool rgbOutputReady = false;
bool rgbOutputOn = false;
bool rgbFeedbackActive = false;
uint32_t rgbFeedbackStartedMs = 0;
constexpr uint32_t RGB_FEEDBACK_MS = 2000;

void showRingColor(uint8_t red, uint8_t green, uint8_t blue) {
    if (!rgbOutputReady) return;
    dashboardRgb.fill(dashboardRgb.Color(red, green, blue));
    dashboardRgb.show();
}

void setDashboardRgb(bool enabled) {
    if (!rgbOutputReady) return;
    // A dashboard command or game reset cancels any temporary feedback.
    rgbFeedbackActive = false;
    rgbOutputOn = enabled;
    showRingColor(0, enabled ? 25 : 0, 0);
}

void showChallengeFeedback(bool correct) {
    if (!rgbOutputReady) return;
    rgbFeedbackActive = true;
    rgbFeedbackStartedMs = millis();
    showRingColor(correct ? 0 : 25, correct ? 25 : 0, 0);
}

void serviceRgbFeedback() {
    if (rgbFeedbackActive && millis() - rgbFeedbackStartedMs >= RGB_FEEDBACK_MS) {
        // Restore the dashboard setting without blocking keypad, sensors or Wi-Fi.
        setDashboardRgb(rgbOutputOn);
    }
}

void initializeDashboardRgb() {
    dashboardRgb.begin();
    rgbOutputReady = dashboardRgb.getPixels() != nullptr;
    setDashboardRgb(false);
}

MFRC522 cardReader(RFID_SPI_SS, MFRC522::UNUSED_PIN);
bool cardReaderReady = false;
char lastCardUid[21] = {};
char rfidMessage[22] = {};
bool employeeRfidBypass = false;

enum class RfidAnswer { Unknown, Ampere, Watts, Ohms, Farad, Employee };
const char* lastRfidAnswer = "None";
uint32_t lastRfidAt = 0;
char lastKey[2] = {};
uint32_t lastKeyAt = 0;
bool motionSampleAvailable = false;
float liveAcceleration[3] = {};
float liveGyro[3] = {};
uint32_t lastMotionSampleAt = 0;

RfidAnswer identifyAnswerCard(const byte* uid, byte size) {
    // Require the complete four-byte UID, not a prefix of a longer card UID.
    if (size != 4) return RfidAnswer::Unknown;
    struct AnswerCard { byte uid[4]; RfidAnswer answer; };
    static constexpr AnswerCard cards[] = {
        {{0x7C, 0x97, 0x51, 0x34}, RfidAnswer::Ampere},
        {{0x1C, 0x78, 0x62, 0x34}, RfidAnswer::Watts},
        {{0xEC, 0xB4, 0x77, 0x32}, RfidAnswer::Ohms},
        {{0xDA, 0xFD, 0x6E, 0x32}, RfidAnswer::Farad},
        {{0x4C, 0x6E, 0x6D, 0x32}, RfidAnswer::Employee},
    };
    for (const auto& card : cards) {
        if (memcmp(uid, card.uid, sizeof(card.uid)) == 0) return card.answer;
    }
    return RfidAnswer::Unknown;
}

void initializeCardReader() {
    if (!RFID_ENABLED) {
        Serial.println("RFID disabled until reader hardware is ready.");
        return;
    }
    SPI.begin(RFID_SPI_SCK, RFID_SPI_MISO, RFID_SPI_MOSI, RFID_SPI_SS);
    cardReader.PCD_Init();
    delay(50);
    const uint8_t version = cardReader.PCD_ReadRegister(MFRC522::VersionReg);
    cardReaderReady = version != 0x00 && version != 0xFF;
    Serial.printf("RC522 version=0x%02X, responding=%u\n", version, cardReaderReady);
}

GameResults gameResults;
GameOutputs gameOutputs;

WebServer dashboardServer(80);
bool dashboardReady = false;
constexpr char DASHBOARD_WIFI_NAME[] = "CircuitQuest";
constexpr char DASHBOARD_WIFI_PASSWORD[] = "CircuitQuest26";

// Shared OLED/VL53L0X/MPU6050 bus: SDA -> GPIO5, SCL -> GPIO6, 3V3 and GND.
// Keypad: R1-R4 -> GPIO1,2,42,41; C1-C3 -> GPIO40,39,38.
// Servo command output is prepared for external power setup.
constexpr uint8_t OLED_SDA = 5;
constexpr uint8_t OLED_SCL = 6;
Adafruit_SSD1306 oled(128, 64, &Wire, -1);
Adafruit_VL53L0X distanceSensor;
Adafruit_MPU6050 motionSensor;
bool motionReady = false;
const char* motionStatus = "NO ACK";
uint8_t motionAddress = 0;
int motionChipId = -1;
bool motionAlert = false;
uint32_t lastMotionAt = 0;
constexpr float MOTION_THRESHOLD_RAD_S = 1.0f;
constexpr uint32_t MOTION_ALERT_MS = 2000;
bool oledReady = false;
bool distanceReady = false;
uint8_t oledAddress = 0;
// DFPlayer TX -> GPIO17; GPIO18 -> 680-ohm resistor -> DFPlayer RX.
constexpr uint8_t AUDIO_RX_PIN = 17;
constexpr uint8_t AUDIO_TX_PIN = 18;
constexpr uint8_t AUDIO_VOLUME = 30; // DFPlayer range: 0-30.
HardwareSerial audioSerial(1);
DFRobotDFPlayerMini audioPlayer;
bool audioReady = false;
constexpr uint16_t TRACK_GO_AHEAD = 1;
constexpr uint16_t TRACK_TRY_AGAIN = 2;
constexpr uint16_t TRACK_CONGRATULATIONS = 3;

void playPrompt(uint16_t track) {
    if (!audioReady) {
        Serial.println("Audio skipped: DFPlayer unavailable.");
        return;
    }
    audioPlayer.playMp3Folder(track);
    Serial.printf("Audio command sent: /mp3/%04u.mp3\n", track);
}

void initializeAudio() {
    audioSerial.begin(9600, SERIAL_8N1, AUDIO_RX_PIN, AUDIO_TX_PIN);
    audioPlayer.setTimeOut(500);
    audioReady = audioPlayer.begin(audioSerial, true, true);
    if (audioReady) {
        audioPlayer.volume(AUDIO_VOLUME);
        Serial.println("DFPlayer online. Audio plays only during challenges.");
    } else {
        Serial.println("DFPlayer unavailable. Check 5V power, common GND, TX/RX and SD card; challenges continue.");
    }
}

void serviceAudio() {
    if (audioReady && audioPlayer.available()) {
        const uint8_t type = audioPlayer.readType();
        const uint16_t value = audioPlayer.read();
        if (type == DFPlayerError) {
            Serial.printf("DFPlayer error=%u (1=card unavailable, 5=index, 6=file missing)\n", value);
        } else if (type == DFPlayerPlayFinished) {
            Serial.printf("DFPlayer playback finished: %u\n", value);
        } else if (type == DFPlayerCardRemoved) {
            Serial.println("DFPlayer SD card removed; power off before reinserting.");
            audioReady = false;
        } else if (type == TimeOut || type == WrongStack) {
            Serial.printf("DFPlayer communication event: %u\n", type);
        }
    }
}

constexpr byte KEYPAD_ROWS = 4;
constexpr byte KEYPAD_COLS = 3;
char keyMap[KEYPAD_ROWS][KEYPAD_COLS] = {
    {'1', '2', '3'}, {'4', '5', '6'},
    {'7', '8', '9'}, {'*', '0', '#'}
};
byte rowPins[KEYPAD_ROWS] = {1, 2, 42, 41};
byte colPins[KEYPAD_COLS] = {40, 39, 38};
Keypad keypad(makeKeymap(keyMap), rowPins, colPins, KEYPAD_ROWS, KEYPAD_COLS);

enum class Challenge { PlayerId, Rfid, Distance, Binary, Wiring, EncoderCalibration, Encoder, Complete };
Challenge challenge = Challenge::PlayerId;
char playerId[9] = {};
uint8_t playerIdLength = 0;
bool playerIdRequired = false;
bool gameTimerRunning = false;
uint64_t gameStartedUs = 0;
uint64_t gameElapsedUs = 0;
uint64_t gamePenaltySeconds = 0;
constexpr uint32_t MOTION_PENALTY_SECONDS = 5;

uint64_t gameTimeSeconds() {
    const uint64_t elapsed = gameTimerRunning ?
        static_cast<uint64_t>(esp_timer_get_time()) - gameStartedUs : gameElapsedUs;
    return elapsed / 1000000ULL + gamePenaltySeconds;
}

void startGameTimer() {
    gameOutputs.reset();
    gameStartedUs = esp_timer_get_time();
    gameElapsedUs = 0;
    gamePenaltySeconds = 0;
    gameTimerRunning = true;
    motionAlert = false;
    lastMotionAt = 0;
}

void stopGameTimer() {
    if (gameTimerRunning) {
        gameElapsedUs = static_cast<uint64_t>(esp_timer_get_time()) - gameStartedUs;
        gameTimerRunning = false;
        gameResults.add(playerId, gameElapsedUs / 1000000ULL, gamePenaltySeconds);
        Serial.println(gameResults.lastSaveOk ? "Completed result saved to leaderboard."
                                              : "Result kept in RAM; flash save failed.");
    }
}
constexpr uint16_t TARGET_MIN_MM = 140;
constexpr uint16_t TARGET_MAX_MM = 160;
constexpr uint32_t TARGET_HOLD_MS = 10000;
constexpr char BINARY_QUESTION[] = "1110001";
constexpr char DECIMAL_ANSWER[] = "113";
static_assert(0b1110001 == 113, "Check the binary challenge answer");
bool holdingTarget = false;
uint32_t targetStarted = 0;
uint32_t heldMs = 0;
uint16_t distanceMm = 0;
bool distanceValid = false;
uint8_t distanceStatus = 255;
int distanceError = 0;
char answer[4] = {};
uint8_t answerLength = 0;
bool wrongAnswer = false;

// Six isolated terminals; connect only these terminals to each other.
// Each exposed terminal connects through its own 1k series resistor.
constexpr uint8_t WIRING_PINS[6] = {12, 13, 14, 7, 8, 9}; // A1,A2,A3,B1,B2,B3
constexpr uint32_t WIRING_HOLD_MS = 1000;
bool wiringPairOk[3] = {};
uint8_t wiringConnections[6] = {};
uint32_t lastWiringSampleAt = 0;
bool wiringFault = false;
bool wiringHolding = false;
uint32_t wiringStartedAt = 0;
uint32_t wiringHeldMs = 0;

void releaseWiringPins() {
    for (uint8_t pin : WIRING_PINS) pinMode(pin, INPUT_PULLUP);
}

bool scanWiring() {
    auto& connections = wiringConnections;
    memset(connections, 0, sizeof(connections));
    releaseWiringPins();
    delayMicroseconds(100);
    wiringFault = false;
    for (uint8_t pin : WIRING_PINS) {
        if (digitalRead(pin) == LOW) wiringFault = true;
    }
    // Drive only one terminal LOW; every other terminal remains an input.
    // Reading all six directions detects crossed wires and extra shared connections.
    for (uint8_t source = 0; source < 6; ++source) {
        digitalWrite(WIRING_PINS[source], LOW);
        pinMode(WIRING_PINS[source], OUTPUT);
        delayMicroseconds(100);
        for (uint8_t destination = 0; destination < 6; ++destination) {
            if (destination != source && digitalRead(WIRING_PINS[destination]) == LOW) {
                connections[source] |= 1U << destination;
            }
        }
        pinMode(WIRING_PINS[source], INPUT_PULLUP);
        delayMicroseconds(100);
    }
    bool correct = !wiringFault;
    for (uint8_t pair = 0; pair < 3; ++pair) {
        wiringPairOk[pair] = !wiringFault && connections[pair] == (1U << (pair + 3)) &&
                             connections[pair + 3] == (1U << pair);
        correct = correct && wiringPairOk[pair];
    }
    lastWiringSampleAt = millis();
    return correct;
}

// Bare EC11: A/B -> GPIO15/16, common -> GND; switch -> GPIO4/GND.
constexpr uint8_t EC11_A = 15;
constexpr uint8_t EC11_B = 16;
constexpr uint8_t EC11_BUTTON = 4;
portMUX_TYPE encoderMux = portMUX_INITIALIZER_UNLOCKED;
volatile uint8_t encoderPrevious = 0;
volatile int8_t encoderQuarterSteps = 0;
volatile int32_t encoderCount = 0;
DRAM_ATTR const int8_t encoderTransitions[16] = {
    0, -1, 1, 0, 1, 0, 0, -1, -1, 0, 0, 1, 0, 1, -1, 0
};
int32_t displayedEncoderCount = 0;
bool encoderButtonPressed = false;
bool encoderPressEvent = false;
int32_t encoderCountsPerTurn = 0;
int32_t encoderPositiveDirection = 1;
bool wrongEncoderAngle = false;
constexpr int32_t ENCODER_TARGET_DEGREES = 90;

void resetEncoderPosition() {
    portENTER_CRITICAL(&encoderMux);
    encoderCount = 0;
    encoderQuarterSteps = 0;
    portEXIT_CRITICAL(&encoderMux);
    displayedEncoderCount = 0;
}

int32_t encoderPositionInTurn() {
    if (!encoderCountsPerTurn) return 0;
    const int32_t position = displayedEncoderCount * encoderPositiveDirection;
    return ((position % encoderCountsPerTurn) + encoderCountsPerTurn) % encoderCountsPerTurn;
}

bool encoderAtTarget() {
    // Accept the closest representable position(s) to 90 degrees.
    return encoderCountsPerTurn > 0 &&
           abs(encoderPositionInTurn() * 360 - ENCODER_TARGET_DEGREES * encoderCountsPerTurn) <= 180;
}

void IRAM_ATTR onEncoderEdge() {
    portENTER_CRITICAL_ISR(&encoderMux);
    const uint8_t current = (digitalRead(EC11_A) << 1) | digitalRead(EC11_B);
    const uint8_t previous = encoderPrevious;
    encoderPrevious = current;
    if ((previous ^ current) == 3) {
        encoderQuarterSteps = 0; // Reject an invalid two-bit jump.
    } else {
        encoderQuarterSteps += encoderTransitions[(previous << 2) | current];
        if (encoderQuarterSteps >= 4) {
            if (encoderCount < 1000000) ++encoderCount;
            encoderQuarterSteps = 0;
        } else if (encoderQuarterSteps <= -4) {
            if (encoderCount > -1000000) --encoderCount;
            encoderQuarterSteps = 0;
        }
    }
    portEXIT_CRITICAL_ISR(&encoderMux);
}

void initializeEncoder() {
    pinMode(EC11_A, INPUT_PULLUP);
    pinMode(EC11_B, INPUT_PULLUP);
    pinMode(EC11_BUTTON, INPUT_PULLUP);
    encoderPrevious = (digitalRead(EC11_A) << 1) | digitalRead(EC11_B);
    attachInterrupt(digitalPinToInterrupt(EC11_A), onEncoderEdge, CHANGE);
    attachInterrupt(digitalPinToInterrupt(EC11_B), onEncoderEdge, CHANGE);
    Serial.println("EC11 ready. Encoder challenge follows the binary question.");
}

bool serviceEncoder() {
    static bool lastRawPressed = false;
    static uint32_t buttonChangedAt = 0;
    bool changed = false;
    encoderPressEvent = false;
    const bool rawPressed = digitalRead(EC11_BUTTON) == LOW;
    const uint32_t now = millis();
    if (rawPressed != lastRawPressed) {
        lastRawPressed = rawPressed;
        buttonChangedAt = now;
    }
    if (rawPressed != encoderButtonPressed && now - buttonChangedAt >= 30) {
        encoderButtonPressed = rawPressed;
        changed = true;
        Serial.println(rawPressed ? "EC11 button PRESSED" : "EC11 button RELEASED");
        if (rawPressed) {
            encoderPressEvent = true;
        }
    }
    portENTER_CRITICAL(&encoderMux);
    const int32_t count = encoderCount;
    portEXIT_CRITICAL(&encoderMux);
    if (count != displayedEncoderCount) {
        displayedEncoderCount = count;
        changed = true;
        Serial.printf("EC11 position: %ld\n", static_cast<long>(count));
    }
    return changed;
}

// MPU6500 register map: https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-6500-Register-Map2.pdf
bool readMotionRegisters(uint8_t reg, uint8_t* data, uint8_t count) {
    Wire.beginTransmission(motionAddress);
    Wire.write(reg);
    if (Wire.endTransmission(false) != 0 ||
        Wire.requestFrom(motionAddress, count) != count) return false;
    for (uint8_t i = 0; i < count; ++i) data[i] = Wire.read();
    return true;
}

bool writeMotionRegister(uint8_t reg, uint8_t value) {
    Wire.beginTransmission(motionAddress);
    Wire.write(reg);
    Wire.write(value);
    return Wire.endTransmission() == 0;
}

bool initializeMpu6500() {
    if (!writeMotionRegister(0x6B, 0x80)) return false; // Device reset.
    delay(100);
    if (!writeMotionRegister(0x6B, 0x01) || // Wake up, PLL clock.
        !writeMotionRegister(0x6C, 0x00) || // Enable all axes.
        !writeMotionRegister(0x1A, 0x04) || // Gyro low-pass filter.
        !writeMotionRegister(0x19, 0x09) || // 100 Hz sample rate.
        !writeMotionRegister(0x1B, 0x08) || // Gyro +/-500 deg/s.
        !writeMotionRegister(0x1C, 0x10) || // Accel +/-8 g.
        !writeMotionRegister(0x1D, 0x04)) return false; // Accel low-pass filter.
    delay(100);
    uint8_t power = 0, gyroConfig = 0, accelConfig = 0;
    return readMotionRegisters(0x6B, &power, 1) && (power & 0x7F) == 0x01 &&
           readMotionRegisters(0x1B, &gyroConfig, 1) && gyroConfig == 0x08 &&
           readMotionRegisters(0x1C, &accelConfig, 1) && accelConfig == 0x10;
}

bool readMotionSample(sensors_event_t& acceleration, sensors_event_t& gyro,
                      sensors_event_t& temperature) {
    if (motionChipId != 0x70) {
        return motionSensor.getEvent(&acceleration, &gyro, &temperature);
    }
    uint8_t raw[14];
    if (!readMotionRegisters(0x3B, raw, sizeof(raw))) return false;
    const auto axis = [&raw](uint8_t offset) -> int16_t {
        return static_cast<int16_t>((static_cast<uint16_t>(raw[offset]) << 8) | raw[offset + 1]);
    };
    constexpr float ACCEL_SCALE = 9.80665f / 4096.0f;
    constexpr float GYRO_SCALE = (PI / 180.0f) / 65.5f;
    acceleration.acceleration.x = axis(0) * ACCEL_SCALE;
    acceleration.acceleration.y = axis(2) * ACCEL_SCALE;
    acceleration.acceleration.z = axis(4) * ACCEL_SCALE;
    gyro.gyro.x = axis(8) * GYRO_SCALE;
    gyro.gyro.y = axis(10) * GYRO_SCALE;
    gyro.gyro.z = axis(12) * GYRO_SCALE;
    return true;
}

void initializeMotion() {
    // Address acknowledgement and WHO_AM_I are separate checks.
    for (uint8_t address : {0x68, 0x69}) {
        Wire.beginTransmission(address);
        const uint8_t ack = Wire.endTransmission();
        Serial.printf("MPU probe 0x%02X: I2C=%u (0=ACK)\n", address, ack);
        if (ack != 0) continue;
        motionAddress = address;
        Wire.beginTransmission(address);
        Wire.write(MPU6050_WHO_AM_I);
        if (Wire.endTransmission(false) != 0 ||
            Wire.requestFrom(address, static_cast<uint8_t>(1)) != 1) {
            motionStatus = "READ ERR";
            Serial.println("MPU WHO_AM_I read failed.");
            continue;
        }
        motionChipId = Wire.read();
        Serial.printf("MPU 0x%02X WHO_AM_I=0x%02X (6050=0x68, 6500=0x70)\n",
                      address, motionChipId);
        if (motionChipId != MPU6050_DEVICE_ID && motionChipId != 0x70) {
            motionStatus = "ID ERR";
            continue;
        }
        motionReady = motionChipId == 0x70 ? initializeMpu6500() : motionSensor.begin(address, &Wire);
        motionStatus = motionReady ? "OK" : "INIT ERR";
        if (motionReady) {
            if (motionChipId == MPU6050_DEVICE_ID) {
                motionSensor.setAccelerometerRange(MPU6050_RANGE_8_G);
                motionSensor.setGyroRange(MPU6050_RANGE_500_DEG);
                motionSensor.setFilterBandwidth(MPU6050_BAND_21_HZ);
            }
            break;
        }
    }
    Serial.printf("MPU diagnostic: %s\n", motionStatus);
}

bool findOled() {
    uint8_t candidates = 0;
    Serial.printf("Scanning I2C: SDA=GPIO%u, SCL=GPIO%u\n", OLED_SDA, OLED_SCL);
    for (uint8_t address = 0x08; address <= 0x77; ++address) {
        Wire.beginTransmission(address);
        if (Wire.endTransmission() == 0) {
            Serial.printf("ACK at 0x%02X\n", address);
            if (address == 0x3C || address == 0x3D) {
                oledAddress = address;
                ++candidates;
            }
        }
    }
    if (candidates != 1) {
        Serial.println("Expected one OLED at 0x3C or 0x3D. Check wiring with power off.");
        return false;
    }
    return true;
}

const char* dashboardStage() {
    switch (challenge) {
        case Challenge::PlayerId: return "player_id";
        case Challenge::Rfid: return "rfid";
        case Challenge::Distance: return "distance";
        case Challenge::Binary: return "binary";
        case Challenge::Wiring: return "wiring";
        case Challenge::EncoderCalibration: return "encoder_calibration";
        case Challenge::Encoder: return "encoder";
        case Challenge::Complete: return "complete";
    }
    return "player_id";
}

void sendDashboardStatus() {
    uint8_t step = 0;
    if (challenge == Challenge::Distance) step = 1;
    else if (challenge == Challenge::Binary) step = 2;
    else if (challenge == Challenge::Wiring) step = 3;
    else if (challenge == Challenge::EncoderCalibration || challenge == Challenge::Encoder) step = 4;
    else if (challenge == Challenge::Complete) step = 5;
    const uint64_t elapsedUs = gameTimerRunning ?
        static_cast<uint64_t>(esp_timer_get_time()) - gameStartedUs : gameElapsedUs;
    char distanceValue[16] = "null";
    if (distanceValid) snprintf(distanceValue, sizeof(distanceValue), "%u", distanceMm);
    char angleValue[24] = "null";
    if (encoderCountsPerTurn > 0) {
        snprintf(angleValue, sizeof(angleValue), "%.1f", encoderPositionInTurn() * 360.0f / encoderCountsPerTurn);
    }
    const unsigned correctPairs = wiringPairOk[0] + wiringPairOk[1] + wiringPairOk[2];
    char response[1024];
    // Player IDs contain digits only; all other strings come from firmware constants.
    const int length = snprintf(response, sizeof(response),
        "{\"player_id\":\"%s\",\"stage\":\"%s\",\"step\":%u,"
        "\"timer_running\":%s,\"elapsed_seconds\":%llu,\"total_seconds\":%llu,"
        "\"penalty_seconds\":%llu,\"motion_events\":%llu,\"motion_alert\":%s,"
        "\"distance_mm\":%s,\"distance_raw_mm\":%u,\"distance_valid\":%s,"
        "\"distance_status\":%u,\"distance_error\":%d,"
        "\"distance_hold_ms\":%lu,\"distance_hold_target_ms\":%lu,"
        "\"distance_min_mm\":%u,\"distance_max_mm\":%u,"
        "\"wiring_correct\":%u,\"encoder_degrees\":%s,"
        "\"oled_ready\":%s,\"distance_ready\":%s,\"motion_status\":\"%s\",\"audio_ready\":%s,"
        "\"rfid_enabled\":%s,\"rfid_ready\":%s}",
        challenge == Challenge::PlayerId ? "" : playerId, dashboardStage(), step,
        gameTimerRunning ? "true" : "false",
        static_cast<unsigned long long>(elapsedUs / 1000000ULL),
        static_cast<unsigned long long>(elapsedUs / 1000000ULL + gamePenaltySeconds),
        static_cast<unsigned long long>(gamePenaltySeconds),
        static_cast<unsigned long long>(gamePenaltySeconds / MOTION_PENALTY_SECONDS),
        motionAlert ? "true" : "false", distanceValue, distanceMm,
        distanceValid ? "true" : "false", distanceStatus, distanceError,
        static_cast<unsigned long>(heldMs), static_cast<unsigned long>(TARGET_HOLD_MS),
        TARGET_MIN_MM, TARGET_MAX_MM, correctPairs, angleValue,
        oledReady ? "true" : "false", distanceReady ? "true" : "false", motionStatus,
        audioReady ? "true" : "false", RFID_ENABLED ? "true" : "false",
        cardReaderReady ? "true" : "false");
    dashboardServer.sendHeader("Cache-Control", "no-store");
    if (length < 0 || static_cast<size_t>(length) >= sizeof(response)) {
        dashboardServer.send(500, "application/json", "{\"error\":\"Status unavailable\"}");
        return;
    }
    dashboardServer.send(200, "application/json", response);
}

// Report cached game samples only: dashboard requests never scan or drive pins.
void sendDashboardInputs() {
    char motionValues[192] = "null";
    const bool validMotion = motionReady && motionSampleAvailable &&
        isfinite(liveAcceleration[0]) && isfinite(liveAcceleration[1]) &&
        isfinite(liveAcceleration[2]) && isfinite(liveGyro[0]) &&
        isfinite(liveGyro[1]) && isfinite(liveGyro[2]);
    if (validMotion) {
        snprintf(motionValues, sizeof(motionValues),
                 "{\"acceleration\":[%.3f,%.3f,%.3f],\"gyro\":[%.3f,%.3f,%.3f]}",
                 liveAcceleration[0], liveAcceleration[1], liveAcceleration[2],
                 liveGyro[0], liveGyro[1], liveGyro[2]);
    }
    const bool keypadActive = challenge == Challenge::PlayerId ||
        challenge == Challenge::Binary || challenge == Challenge::EncoderCalibration;
    const char* entry = challenge == Challenge::PlayerId ? playerId :
        (challenge == Challenge::Binary ? answer : "");
    char response[2048];
    // All strings are fixed labels, hexadecimal UIDs, digits, or keypad characters.
    const int length = snprintf(response, sizeof(response),
        "{\"stage\":\"%s\",\"motion\":%s,\"motion_age_ms\":%lu,\"motion_alert\":%s,"
        "\"rfid_ready\":%s,\"rfid_active\":%s,\"rfid_uid\":\"%s\","
        "\"rfid_answer\":\"%s\",\"rfid_age_ms\":%lu,"
        "\"keypad_active\":%s,\"last_key\":\"%s\",\"key_age_ms\":%lu,\"entry\":\"%s\","
        "\"wiring_active\":%s,\"wiring_sampled\":%s,\"wiring_age_ms\":%lu,"
        "\"wiring_connections\":[%u,%u,%u,%u,%u,%u],\"wiring_pairs\":[%s,%s,%s],"
        "\"wiring_fault\":%s,\"encoder_count\":%ld,\"encoder_counts_per_turn\":%ld,"
        "\"encoder_degrees\":%.2f,\"encoder_pressed\":%s}",
        dashboardStage(), motionValues,
        static_cast<unsigned long>(millis() - lastMotionSampleAt), motionAlert ? "true" : "false",
        cardReaderReady ? "true" : "false", challenge == Challenge::Rfid ? "true" : "false",
        lastCardUid, lastRfidAnswer, static_cast<unsigned long>(millis() - lastRfidAt),
        keypadActive ? "true" : "false", lastKey,
        static_cast<unsigned long>(millis() - lastKeyAt), entry,
        challenge == Challenge::Wiring ? "true" : "false", lastWiringSampleAt ? "true" : "false",
        static_cast<unsigned long>(millis() - lastWiringSampleAt),
        wiringConnections[0], wiringConnections[1], wiringConnections[2],
        wiringConnections[3], wiringConnections[4], wiringConnections[5],
        wiringPairOk[0] ? "true" : "false", wiringPairOk[1] ? "true" : "false",
        wiringPairOk[2] ? "true" : "false", wiringFault ? "true" : "false",
        static_cast<long>(displayedEncoderCount), static_cast<long>(encoderCountsPerTurn),
        encoderCountsPerTurn > 0 ? encoderPositionInTurn() * 360.0 / encoderCountsPerTurn : 0.0,
        encoderButtonPressed ? "true" : "false");
    dashboardServer.sendHeader("Cache-Control", "no-store");
    if (length < 0 || static_cast<size_t>(length) >= sizeof(response)) {
        dashboardServer.send(500, "application/json", "{\"error\":\"Inputs unavailable\"}");
        return;
    }
    dashboardServer.send(200, "application/json", response);
}

void sendDashboardResults() {
    String response;
    response.reserve(8000);
    response = "{\"capacity\":50,\"storage_ok\":";
    response += gameResults.storageReady && gameResults.lastSaveOk ? "true" : "false";
    response += ",\"runs\":[";
    for (uint8_t i = 0; i < gameResults.data.count; ++i) {
        const CompletedRun& run = gameResults.data.runs[i];
        char row[200];
        snprintf(row, sizeof(row),
            "%s{\"attempt\":%lu,\"player_id\":\"%s\",\"elapsed_seconds\":%llu,\"penalty_seconds\":%llu,\"total_seconds\":%llu}",
            i ? "," : "", static_cast<unsigned long>(run.attempt), run.playerId,
            static_cast<unsigned long long>(run.elapsedSeconds),
            static_cast<unsigned long long>(run.penaltySeconds),
            static_cast<unsigned long long>(run.elapsedSeconds + run.penaltySeconds));
        response += row;
    }
    response += "]}";
    dashboardServer.sendHeader("Cache-Control", "no-store");
    dashboardServer.send(200, "application/json", response);
}

void sendOutputStatus() {
    char response[240];
    snprintf(response, sizeof(response),
        "{\"servo_ready\":%s,\"servo_unlocked\":%s,\"servo_angle\":%u,\"rgb_ready\":%s,\"rgb_on\":%s}",
        gameOutputs.servoReady ? "true" : "false", gameOutputs.servoUnlocked ? "true" : "false",
        gameOutputs.servoUnlocked ? SERVO_UNLOCK_DEGREES : SERVO_LOCK_DEGREES,
        rgbOutputReady ? "true" : "false", rgbOutputOn ? "true" : "false");
    dashboardServer.sendHeader("Cache-Control", "no-store");
    dashboardServer.send(200, "application/json", response);
}

void handleOutputControl() {
    if (dashboardServer.header("X-CircuitQuest-Control") != "1") {
        dashboardServer.send(403, "application/json", "{\"error\":\"Use the dashboard controls\"}");
        return;
    }
    const String device = dashboardServer.arg("device");
    if (device == "servo") {
        const String action = dashboardServer.arg("action");
        if (action != "lock" && action != "unlock") {
            dashboardServer.send(400, "application/json", "{\"error\":\"Invalid servo action\"}");
            return;
        }
        if (!gameOutputs.servoReady) {
            dashboardServer.send(503, "application/json", "{\"error\":\"Servo PWM unavailable\"}");
            return;
        }
        gameOutputs.setServo(action == "unlock");
    } else if (device == "rgb") {
        const String action = dashboardServer.arg("action");
        if (action != "on" && action != "off") {
            dashboardServer.send(400, "application/json", "{\"error\":\"Invalid RGB action\"}");
            return;
        }
        if (!rgbOutputReady) {
            dashboardServer.send(503, "application/json", "{\"error\":\"RGB output unavailable\"}");
            return;
        }
        setDashboardRgb(action == "on");
    } else {
        dashboardServer.send(400, "application/json", "{\"error\":\"Unknown output\"}");
        return;
    }
    Serial.printf("Dashboard output command: %s\n", device.c_str());
    sendOutputStatus();
}

void resetGame();

void handleDashboardGameReset() {
    if (dashboardServer.header("X-CircuitQuest-Control") != "1") {
        dashboardServer.send(403, "application/json", "{\"error\":\"Use the dashboard controls\"}");
        return;
    }
    resetGame();
    sendDashboardStatus();
}

void initializeDashboard() {
    WiFi.mode(WIFI_AP);
    dashboardReady = WiFi.softAP(DASHBOARD_WIFI_NAME, DASHBOARD_WIFI_PASSWORD, 1, false, 4);
    if (!dashboardReady) {
        Serial.println("Dashboard Wi-Fi could not start; physical game remains available.");
        return;
    }
    dashboardServer.on("/", HTTP_GET, []() {
        dashboardServer.sendHeader("Cache-Control", "no-store");
        dashboardServer.sendHeader("X-Frame-Options", "DENY");
        dashboardServer.send_P(200, "text/html; charset=utf-8", DASHBOARD_HTML);
    });
    dashboardServer.on("/api/status", HTTP_GET, sendDashboardStatus);
    dashboardServer.on("/api/inputs", HTTP_GET, sendDashboardInputs);
    dashboardServer.on("/api/results", HTTP_GET, sendDashboardResults);
    const char* controlHeaders[] = {"X-CircuitQuest-Control"};
    dashboardServer.collectHeaders(controlHeaders, 1);
    // Old bookmarks or already-open login pages lead directly to the dashboard.
    const auto redirectToDashboard = []() {
        dashboardServer.sendHeader("Cache-Control", "no-store");
        dashboardServer.sendHeader("Location", "/");
        dashboardServer.send(303, "text/plain", "");
    };
    dashboardServer.on("/login", HTTP_GET, redirectToDashboard);
    dashboardServer.on("/login", HTTP_POST, redirectToDashboard);
    dashboardServer.on("/logout", HTTP_POST, redirectToDashboard);
    dashboardServer.on("/api/outputs", HTTP_GET, sendOutputStatus);
    dashboardServer.on("/api/outputs", HTTP_POST, handleOutputControl);
    dashboardServer.on("/api/game/reset", HTTP_POST, handleDashboardGameReset);
    dashboardServer.onNotFound([]() { dashboardServer.send(404, "text/plain", "Not found"); });
    dashboardServer.begin();
    Serial.printf("Dashboard Wi-Fi: %s; open http://%s\n", DASHBOARD_WIFI_NAME,
                  WiFi.softAPIP().toString().c_str());
}

void drawChallenge() {
    oled.clearDisplay();
    oled.setTextSize(1);
    oled.setTextColor(SSD1306_WHITE);
    oled.setCursor(0, 0);
    if (challenge == Challenge::PlayerId) {
        oled.println("CircuitQuest");
        oled.setCursor(0, 16);
        oled.println("Enter player ID:");
        oled.print("> ");
        oled.println(playerId);
        oled.println(playerIdRequired ? "Enter at least 1 digit" : "1-8 digits");
        oled.setCursor(0, 56);
        oled.print("*:clear  #:start");
    } else if (challenge == Challenge::Rfid) {
        oled.println("RFID QUESTION");
        oled.setCursor(0, 10);
        if (!cardReaderReady) {
            oled.println("RC522 not responding");
            oled.println("Check wiring + reset");
        } else {
            oled.println("Unit of resistance?");
            oled.setCursor(0, 22);
            oled.print("A Ampere   B Watts");
            oled.setCursor(0, 32);
            oled.print("C Ohms     D Farad");
            oled.setCursor(0, 43);
            oled.print(rfidMessage[0] ? rfidMessage : "Tap an answer card");
            oled.setCursor(0, 56);
            oled.print(rfidMessage[0] ? "Remove / scan again" : "Choose with RFID");
        }
    } else if (challenge == Challenge::EncoderCalibration) {
        oled.println("ENCODER CALIBRATION");
        oled.setCursor(0, 14);
        oled.println("Turn ONE full circle");
        oled.println("clockwise, then press");
        oled.printf("Count: %ld\n", static_cast<long>(displayedEncoderCount));
        oled.println("Start/end same mark");
        oled.setCursor(0, 56);
        oled.print("*: restart measuring");
    } else if (challenge == Challenge::Encoder) {
        oled.println("CHALLENGE 4: ENCODER");
        oled.setCursor(0, 14);
        oled.println("Target: 90 deg CW");
        oled.printf("Angle: %.1f deg\n", encoderPositionInTurn() * 360.0f / encoderCountsPerTurn);
        oled.println(wrongEncoderAngle ? "Wrong angle - retry" :
                     (encoderAtTarget() ? "On target! Press knob" : "Turn to target"));
        oled.setCursor(0, 56);
        oled.print("Press knob to submit");
    } else if (challenge == Challenge::Distance) {
        oled.printf("1:DIST M:%s A:%s", motionStatus, audioReady ? "OK" : "--");
        oled.setCursor(0, 16);
        if (!distanceReady) {
            oled.println("VL53L0X not found");
            oled.println("Check wires + reset");
        } else {
            if (distanceValid) {
                oled.printf("Distance: %.1f cm\n", distanceMm / 10.0f);
            } else {
                oled.println("No valid reading");
            }
            oled.println("Target: 14-16 cm");
            oled.printf("Hold: %.1f / 10 s\n", heldMs / 1000.0f);
            oled.println(holdingTarget ? "Keep steady..." : "Move object to target");
            oled.drawRect(0, 56, 128, 8, SSD1306_WHITE);
            oled.fillRect(1, 57, heldMs * 126UL / TARGET_HOLD_MS, 6, SSD1306_WHITE);
        }
    } else if (challenge == Challenge::Wiring) {
        oled.println("CHALLENGE 3: WIRING");
        oled.setCursor(0, 14);
        for (uint8_t pair = 0; pair < 3; ++pair) {
            oled.printf("A%u -> B%u: %s\n", pair + 1, pair + 1, wiringPairOk[pair] ? "OK" : "CHECK");
        }
        oled.println(wiringFault ? "Check unwanted ground" : "Use 3 separate wires");
        oled.setCursor(0, 56);
        oled.printf("Hold: %.1f / 1 s", wiringHeldMs / 1000.0f);
    } else if (challenge == Challenge::Binary) {
        oled.printf("2:BIN M:%s A:%s", motionStatus, audioReady ? "OK" : "--");
        oled.setCursor(0, 12);
        oled.println("Distance complete!");
        oled.print(BINARY_QUESTION);
        oled.println(" binary");
        oled.println("Enter decimal value:");
        oled.print("> ");
        oled.println(answer);
        oled.println(wrongAnswer ? "Wrong - try again" : "");
        oled.setCursor(0, 56);
        oled.print("*:clear  #:submit");
    } else {
        oled.printf("DONE M:%s A:%s", motionStatus, audioReady ? "OK" : "--");
        oled.setCursor(0, 20);
        oled.println("Correct! Well done!");
        oled.println("All challenges done");
        oled.print("Player: ");
        oled.println(playerId);
        oled.setCursor(0, 56);
        oled.print("Reset via dashboard");
    }
    if (challenge != Challenge::PlayerId) {
        // Reserve the top line for the stage and a right-aligned elapsed timer.
        oled.fillRect(0, 0, 128, 8, SSD1306_BLACK);
        oled.setCursor(0, 0);
        if (motionAlert && gameTimerRunning) oled.printf("MOVE +%lus", static_cast<unsigned long>(MOTION_PENALTY_SECONDS));
        else if (challenge == Challenge::Rfid) oled.print("RFID");
        else if (challenge == Challenge::Distance) oled.print("1:DIST");
        else if (challenge == Challenge::Binary) oled.print("2:BINARY");
        else if (challenge == Challenge::Wiring) oled.print("3:WIRING");
        else if (challenge == Challenge::EncoderCalibration) oled.print("CALIBRATE");
        else if (challenge == Challenge::Encoder) oled.print("4:ENCODER");
        else oled.print("DONE");
        char timerText[24];
        snprintf(timerText, sizeof(timerText), "%llus", static_cast<unsigned long long>(gameTimeSeconds()));
        const int16_t timerWidth = strlen(timerText) * 6;
        oled.setCursor(128 - timerWidth, 0);
        oled.print(timerText);
    }
    oled.display();
}

void resetGame() {
    setDashboardRgb(false);
    gameOutputs.reset();
    if (audioReady) audioPlayer.stop();
    challenge = Challenge::PlayerId;
    gameTimerRunning = false;
    gameStartedUs = 0;
    gameElapsedUs = 0;
    gamePenaltySeconds = 0;
    memset(playerId, 0, sizeof(playerId));
    playerIdLength = 0;
    playerIdRequired = false;
    lastCardUid[0] = '\0';
    lastRfidAnswer = "None";
    lastRfidAt = 0;
    lastKey[0] = '\0';
    lastKeyAt = 0;
    rfidMessage[0] = '\0';
    employeeRfidBypass = false;
    memset(answer, 0, sizeof(answer));
    answerLength = 0;
    wrongAnswer = false;
    memset(wiringPairOk, 0, sizeof(wiringPairOk));
    memset(wiringConnections, 0, sizeof(wiringConnections));
    lastWiringSampleAt = 0;
    wiringFault = false;
    wiringHolding = false;
    wiringStartedAt = 0;
    wiringHeldMs = 0;
    releaseWiringPins();
    holdingTarget = false;
    targetStarted = 0;
    heldMs = 0;
    distanceMm = 0;
    distanceValid = false;
    distanceStatus = 255;
    distanceError = 0;
    resetEncoderPosition();
    encoderCountsPerTurn = 0;
    encoderPositiveDirection = 1;
    wrongEncoderAngle = false;
    encoderPressEvent = false;
    motionAlert = false;
    lastMotionAt = 0;
    Serial.println("Game reset. Enter a new player ID.");
    if (oledReady) drawChallenge();
}

void setup() {
    initializeDashboardRgb();
    Serial.begin(115200);
    gameOutputs.begin();
    const uint32_t started = millis();
    while (!Serial && millis() - started < 3000) delay(10);
    Serial.println("CircuitQuest: distance -> binary -> wiring -> encoder.");
    delay(1000);
    if (!Wire.begin(OLED_SDA, OLED_SCL, 100000)) {
        Serial.println("I2C initialization failed.");
        return;
    }
    Wire.setTimeOut(50);
    if (!findOled()) return;
    if (!oled.begin(SSD1306_SWITCHCAPVCC, oledAddress)) {
        Serial.println("OLED initialization failed.");
        return;
    }
    oledReady = true;
    oled.clearDisplay();
    oled.setTextSize(1);
    oled.setTextColor(SSD1306_WHITE);
    oled.setCursor(0, 0);
    oled.display();
    distanceReady = distanceSensor.begin(0x29, false, &Wire);
    Serial.println(distanceReady ? "Hold at 14-16 cm for 10 seconds."
                                 : "VL53L0X not detected. Check wires, then reset.");
    initializeMotion();
    initializeAudio();
    initializeEncoder();
    initializeCardReader();
    releaseWiringPins();
    gameResults.begin();
    initializeDashboard();
    drawChallenge();
}

void loop() {
    if (dashboardReady) dashboardServer.handleClient();
    serviceRgbFeedback();
    serviceAudio();
    // Leave keypad GPIOs untouched until the distance challenge is complete.
    const char key = (challenge == Challenge::PlayerId || challenge == Challenge::EncoderCalibration || challenge == Challenge::Binary) ? keypad.getKey() : NO_KEY;
    if (key) {
        lastKey[0] = key;
        lastKeyAt = millis();
    }
    const bool encoderChanged = serviceEncoder();
    bool redraw = encoderChanged && (challenge == Challenge::EncoderCalibration || challenge == Challenge::Encoder);
    if (challenge == Challenge::PlayerId && key) {
        if (key == '*') {
            playerIdLength = 0;
            playerId[0] = '\0';
            playerIdRequired = false;
        } else if (key == '#') {
            if (playerIdLength) {
                challenge = RFID_ENABLED ? Challenge::Rfid : Challenge::Distance;
                startGameTimer();
                Serial.printf("Starting game for player ID: %s\n", playerId);
            } else {
                playerIdRequired = true;
            }
        } else if (key >= '0' && key <= '9' && playerIdLength < sizeof(playerId) - 1) {
            playerId[playerIdLength++] = key;
            playerId[playerIdLength] = '\0';
            playerIdRequired = false;
        }
        redraw = true;
    }
    static uint32_t lastCardScan = 0;
    if (challenge == Challenge::Rfid && cardReaderReady && millis() - lastCardScan >= 100) {
        lastCardScan = millis();
        if (cardReader.PICC_IsNewCardPresent() && cardReader.PICC_ReadCardSerial()) {
            memset(lastCardUid, 0, sizeof(lastCardUid));
            for (uint8_t i = 0; i < cardReader.uid.size && i < 10; ++i) {
                snprintf(lastCardUid + i * 2, 3, "%02X", cardReader.uid.uidByte[i]);
            }
            const RfidAnswer selected = identifyAnswerCard(cardReader.uid.uidByte, cardReader.uid.size);
            lastRfidAt = millis();
            switch (selected) {
                case RfidAnswer::Ampere: lastRfidAnswer = "Ampere"; break;
                case RfidAnswer::Watts: lastRfidAnswer = "Watts"; break;
                case RfidAnswer::Ohms: lastRfidAnswer = "Ohms"; break;
                case RfidAnswer::Farad: lastRfidAnswer = "Farad"; break;
                case RfidAnswer::Employee: lastRfidAnswer = "Employee"; break;
                default: lastRfidAnswer = "Unknown"; break;
            }
            cardReader.PICC_HaltA();
            cardReader.PCD_StopCrypto1();
            Serial.printf("RFID answer card UID: %s\n", lastCardUid);
            if (selected == RfidAnswer::Ohms || selected == RfidAnswer::Employee) {
                employeeRfidBypass = selected == RfidAnswer::Employee;
                Serial.println(employeeRfidBypass ? "Employee card: RFID question bypassed."
                                                 : "Correct: resistance is measured in ohms.");
                rfidMessage[0] = '\0';
                challenge = Challenge::Distance;
                showChallengeFeedback(true);
                playPrompt(TRACK_GO_AHEAD);
            } else {
                const char* message = "Unknown card. Retry";
                if (selected == RfidAnswer::Ampere) message = "Wrong: Ampere";
                else if (selected == RfidAnswer::Watts) message = "Wrong: Watts";
                else if (selected == RfidAnswer::Farad) message = "Wrong: Farad";
                strlcpy(rfidMessage, message, sizeof(rfidMessage));
                Serial.println(message);
                showChallengeFeedback(false);
                playPrompt(TRACK_TRY_AGAIN);
            }
            redraw = true;
        }
    }
    if (challenge == Challenge::EncoderCalibration) {
        if (key == '*') {
            resetEncoderPosition();
            redraw = true;
        } else if (encoderPressEvent) {
            const int32_t counts = abs(displayedEncoderCount);
            if (counts >= 4 && counts <= 200) {
                encoderCountsPerTurn = counts;
                encoderPositiveDirection = displayedEncoderCount > 0 ? 1 : -1;
                resetEncoderPosition();
                challenge = Challenge::Encoder;
                Serial.printf("Encoder calibrated: %ld counts/turn. Current position is 0 degrees.\n", static_cast<long>(counts));
            } else {
                Serial.println("Calibration needs one full clockwise revolution. Press * to restart.");
            }
            redraw = true;
        }
    } else if (challenge == Challenge::Encoder) {
        if (encoderChanged && !encoderPressEvent) wrongEncoderAngle = false;
        if (encoderPressEvent) {
            if (encoderAtTarget()) {
                stopGameTimer();
                challenge = Challenge::Complete;
                gameOutputs.setServo(true);
                Serial.println("Correct encoder angle. All challenges complete!");
                Serial.printf("Final time: %llu seconds (penalties: %llu seconds)\n",
                              static_cast<unsigned long long>(gameTimeSeconds()),
                              static_cast<unsigned long long>(gamePenaltySeconds));
                playPrompt(TRACK_CONGRATULATIONS);
            } else {
                wrongEncoderAngle = true;
                Serial.println("Wrong encoder angle. Turn to 90 degrees and press again.");
                playPrompt(TRACK_TRY_AGAIN);
            }
            redraw = true;
        }
    }
    static uint32_t lastMotionSample = 0;
    const uint32_t motionNow = millis();
    if (motionReady && motionNow - lastMotionSample >= 100) {
        lastMotionSample = motionNow;
        sensors_event_t acceleration = {}, gyro = {}, temperature = {};
        if (readMotionSample(acceleration, gyro, temperature)) {
            motionSampleAvailable = true;
            lastMotionSampleAt = motionNow;
            liveAcceleration[0] = acceleration.acceleration.x;
            liveAcceleration[1] = acceleration.acceleration.y;
            liveAcceleration[2] = acceleration.acceleration.z;
            liveGyro[0] = gyro.gyro.x;
            liveGyro[1] = gyro.gyro.y;
            liveGyro[2] = gyro.gyro.z;
            const bool rotating = fabsf(gyro.gyro.x) >= MOTION_THRESHOLD_RAD_S ||
                                  fabsf(gyro.gyro.y) >= MOTION_THRESHOLD_RAD_S ||
                                  fabsf(gyro.gyro.z) >= MOTION_THRESHOLD_RAD_S;
            if (rotating) {
                if (!motionAlert) {
                    Serial.println("MOTION DETECTED: possible tamper.");
                    if (gameTimerRunning) {
                        gamePenaltySeconds += MOTION_PENALTY_SECONDS;
                        Serial.printf("Motion penalty: +%lu seconds; total penalties=%llu seconds\n",
                                      static_cast<unsigned long>(MOTION_PENALTY_SECONDS),
                                      static_cast<unsigned long long>(gamePenaltySeconds));
                        redraw = true;
                    }
                }
                lastMotionAt = motionNow;
            }
            const bool nextAlert = rotating || (motionAlert && motionNow - lastMotionAt < MOTION_ALERT_MS);
            if (nextAlert != motionAlert) redraw = true;
            motionAlert = nextAlert;
            static uint32_t lastMotionLog = 0;
            if (motionNow - lastMotionLog >= 1000) {
                lastMotionLog = motionNow;
                Serial.printf("MPU accel m/s2: %.2f %.2f %.2f; gyro rad/s: %.2f %.2f %.2f\n",
                              acceleration.acceleration.x, acceleration.acceleration.y,
                              acceleration.acceleration.z, gyro.gyro.x, gyro.gyro.y, gyro.gyro.z);
            }
        } else {
            Serial.println("MPU sample failed.");
            motionReady = false;
            motionStatus = "READ ERR";
            motionAlert = false;
            redraw = true;
        }
    }
    if (key && challenge == Challenge::Binary) {
        Serial.printf("Key pressed: %c\n", key);
        if (key == '*') {
            answerLength = 0;
            answer[0] = '\0';
            wrongAnswer = false;
        } else if (key == '#') {
            if (strcmp(answer, DECIMAL_ANSWER) == 0) {
                challenge = Challenge::Wiring;
                wiringHolding = false;
                wiringHeldMs = 0;
                Serial.println("Binary correct. Connect A1-B1, A2-B2, A3-B3; hold correct for 1 second.");
                showChallengeFeedback(true);
                playPrompt(TRACK_GO_AHEAD);
            } else {
                wrongAnswer = true;
                answerLength = 0;
                answer[0] = '\0';
                Serial.println("Wrong answer. Enter a new answer and press #.");
                showChallengeFeedback(false);
                playPrompt(TRACK_TRY_AGAIN);
            }
        } else if (key >= '0' && key <= '9' && answerLength < sizeof(answer) - 1) {
            wrongAnswer = false;
            answer[answerLength++] = key;
            answer[answerLength] = '\0';
        }
        redraw = true;
    }

    static uint32_t lastMeasurement = 0;
    const uint32_t now = millis();
    static uint32_t lastWiringScan = 0;
    if (challenge == Challenge::Wiring && now - lastWiringScan >= 100) {
        lastWiringScan = now;
        const bool correct = scanWiring();
        const uint32_t scannedAt = millis();
        if (!correct) {
            wiringHolding = false;
            wiringHeldMs = 0;
        } else {
            if (!wiringHolding) {
                wiringHolding = true;
                wiringStartedAt = scannedAt;
            }
            wiringHeldMs = scannedAt - wiringStartedAt;
            if (wiringHeldMs >= WIRING_HOLD_MS) {
                resetEncoderPosition();
                challenge = Challenge::EncoderCalibration;
                Serial.println("Wiring complete. Turn encoder ONE full clockwise circle, then press to calibrate.");
                playPrompt(TRACK_GO_AHEAD);
            }
        }
        redraw = true;
    }
    if (challenge == Challenge::Distance && distanceReady && now - lastMeasurement >= 100) {
        lastMeasurement = now;
        VL53L0X_RangingMeasurementData_t measurement = {};
        const auto result = distanceSensor.rangingTest(&measurement, false);
        distanceError = static_cast<int>(result);
        distanceStatus = measurement.RangeStatus;
        distanceValid = result == VL53L0X_ERROR_NONE && measurement.RangeStatus == 0;
        distanceMm = measurement.RangeMilliMeter;
        const bool inTarget = distanceValid && distanceMm >= TARGET_MIN_MM && distanceMm <= TARGET_MAX_MM;
        const uint32_t measuredAt = millis();
        if (!inTarget) {
            holdingTarget = false;
            heldMs = 0;
        } else {
            if (!holdingTarget) {
                holdingTarget = true;
                targetStarted = measuredAt;
            }
            heldMs = measuredAt - targetStarted;
            if (heldMs >= TARGET_HOLD_MS) {
                heldMs = TARGET_HOLD_MS;
                challenge = Challenge::Binary;
                Serial.println("Distance complete! Enter decimal value of 1110001 binary. * clears; # submits.");
                showChallengeFeedback(true);
                playPrompt(TRACK_GO_AHEAD);
            }
        }
        static uint32_t lastStatus = 0;
        if (measuredAt - lastStatus >= 1000) {
            lastStatus = measuredAt;
            Wire.beginTransmission(0x29);
            const uint8_t busResult = Wire.endTransmission();
            Serial.printf("Distance=%u mm, valid=%u, status=%u, error=%d, I2C=%u, hold=%lu ms\n",
                          distanceMm, distanceValid, distanceStatus, distanceError,
                          busResult, static_cast<unsigned long>(heldMs));
        }
        redraw = true;
    }
    static uint64_t lastDisplayedSeconds = 0;
    const uint64_t currentSeconds = gameTimeSeconds();
    if (currentSeconds != lastDisplayedSeconds) {
        lastDisplayedSeconds = currentSeconds;
        if (challenge != Challenge::PlayerId) redraw = true;
    }
    if (oledReady && redraw) drawChallenge();
    delay(5);
}
