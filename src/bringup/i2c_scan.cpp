#include <Arduino.h>
#include <Wire.h>

// Step 1 wiring (disconnect USB before changing connections):
// OLED GND -> GND, SDA -> GPIO8, SCL -> GPIO47.
// OLED VCC -> 3V3 only if this module supports a 3.3 V input.
// Connect only the OLED for this test. No graphics are drawn.
namespace {
constexpr int kSdaPin = 8;
constexpr int kSclPin = 47;
constexpr uint32_t kScanIntervalMs = 5000;
bool busReady = false;

void scanBus() {
    unsigned int found = 0;
    unsigned int errors = 0;
    Serial.println("Scanning I2C: SDA=8, SCL=47, 100 kHz...");
    for (uint8_t address = 0x08; address <= 0x77; ++address) {
        Wire.beginTransmission(address);
        const uint8_t result = Wire.endTransmission();
        if (result == 0) {
            Serial.printf("ACK at 0x%02X\n", address);
            ++found;
        } else if (result != 2) {
            Serial.printf("Bus error %u at 0x%02X\n", result, address);
            ++errors;
        }
    }
    Serial.printf("Scan finished: %u responding address(es), %u bus error(s).\n",
                  found, errors);
    if (found == 0) {
        Serial.println("Check supply rating, wiring, and SDA/SCL pull-ups to 3.3 V.");
    }
    Serial.println("An ACK confirms communication, not the controller model.");
    Serial.println("The OLED remains blank during this test. Repeating in 5 seconds.\n");
}
}  // namespace

void setup() {
    Serial.begin(115200);
    const uint32_t started = millis();
    while (!Serial && millis() - started < 3000) {
        delay(10);
    }
    Serial.println("CircuitQuest - Step 1: OLED I2C connection test");
    busReady = Wire.begin(kSdaPin, kSclPin, 100000);
    if (!busReady) {
        Serial.println("I2C initialization failed. Reset after checking the setup.");
        return;
    }
    Wire.setTimeOut(50);
}

void loop() {
    if (busReady) {
        scanBus();
    }
    delay(kScanIntervalMs);
}
