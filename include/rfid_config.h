#pragma once

// RC522 checkpoint enabled. Set false to run the game without the reader.
constexpr bool RFID_ENABLED = true;
constexpr uint8_t RFID_SPI_SCK = 10;
constexpr uint8_t RFID_SPI_MOSI = 19;
constexpr uint8_t RFID_SPI_MISO = 11;
constexpr uint8_t RFID_SPI_SS = 48;
// RC522 RST -> the reader's 3V3 supply (direct, or through a 10k pull-up).
// The driver uses software reset; do not connect RST to an ESP32 output.
// GPIO19 is used for SPI MOSI; native USB cannot be used while RFID is enabled.
// GPIO20 is unassigned. Leave the native USB connector disconnected.
// Program/monitor through the separate USB-to-UART connector.
// GPIO48 may also feed the onboard LED; confirm your board's circuit first.
