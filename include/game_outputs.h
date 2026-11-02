#pragma once
#include <Arduino.h>
#include <soc/ledc_caps.h>

// Servo: external 5V supply with shared ESP32 GND; signal -> GPIO9.
constexpr uint8_t SERVO_SIGNAL_PIN = 9;
constexpr uint8_t SERVO_PWM_CHANNEL = 0;
constexpr uint8_t SERVO_PWM_BITS = 14;
constexpr uint32_t SERVO_PWM_HZ = 50;
constexpr uint32_t SERVO_PERIOD_US = 1000000UL / SERVO_PWM_HZ;
constexpr uint32_t SERVO_MAX_DUTY = (1UL << SERVO_PWM_BITS) - 1;
static_assert(SERVO_PWM_BITS <= SOC_LEDC_TIMER_BIT_WIDE_NUM,
              "Servo PWM resolution exceeds this ESP32's LEDC capability");
constexpr uint8_t SERVO_LOCK_DEGREES = 0;
constexpr uint8_t SERVO_UNLOCK_DEGREES = 180;
constexpr uint16_t SERVO_MIN_PULSE_US = 1000;
constexpr uint16_t SERVO_MAX_PULSE_US = 2000;

class GameOutputs {
public:
    void begin() {
        const uint32_t frequency = ledcSetup(SERVO_PWM_CHANNEL, SERVO_PWM_HZ, SERVO_PWM_BITS);
        servoReady = frequency > 0;
        if (servoReady) {
            ledcAttachPin(SERVO_SIGNAL_PIN, SERVO_PWM_CHANNEL);
            setServo(false);
            Serial.printf("Servo PWM ready: GPIO%u, %lu Hz, %u bits. Physical position is not sensed.\n",
                          SERVO_SIGNAL_PIN, static_cast<unsigned long>(frequency), SERVO_PWM_BITS);
        } else {
            Serial.println("Servo PWM setup failed; no servo commands can be sent.");
        }
    }

    void setServo(bool unlock) {
        if (!servoReady) return;
        servoUnlocked = unlock;
        const uint32_t angle = unlock ? SERVO_UNLOCK_DEGREES : SERVO_LOCK_DEGREES;
        const uint32_t pulse = SERVO_MIN_PULSE_US +
            (SERVO_MAX_PULSE_US - SERVO_MIN_PULSE_US) * angle / 180;
        ledcWrite(SERVO_PWM_CHANNEL, (pulse * SERVO_MAX_DUTY + SERVO_PERIOD_US / 2) / SERVO_PERIOD_US);
    }

    void reset() {
        setServo(false);
    }

    bool servoReady = false;
    bool servoUnlocked = false;
};
