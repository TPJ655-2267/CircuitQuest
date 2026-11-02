CircuitQuest / Fusion Electronics schematic draft A

FILES
CircuitQuest_Draft.sch: EAGLE XML logical schematic for import into Fusion Electronics.
CircuitQuest_preview.svg: vector preview generated from the same connectivity.
connections.csv: component / logical pin / net table.
generate_schematic.py: regenerates those three files.

IMPORT
Use Fusion Electronics' EAGLE schematic import/open workflow for the .sch file.
Autodesk documentation:
https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/How-to-migrate-from-EAGLE-Schematics-PCBs-Libraries-to-Autodesk-Fusion-Electronics.html

STATUS
This is an editable logical draft, NOT a fabrication-ready design.
The XML and pin-reference connectivity have been checked programmatically.
Native Fusion import and electrical rules checking have not been performed. Report any importer error before editing the generated XML.
The custom logical symbols deliberately have no PCB packages. In Fusion,
replace them with verified library devices and assign verified footprints.
GPIO numbers are chip signal names, NOT development-board header pad numbers.
Connector contact sequences in this draft are proposed cable functions, NOT
verified physical pad arrangements of purchased modules.
Existing firmware was not modified by this schematic work.

SHEET 1: CONTROLLER AND MODULE CONNECTORS
U1 is the existing ESP32-S3 development board, represented logically.
OLED, VL53L0X and MPU6500 share SDA GPIO8 and SCL GPIO47, powered from V3V3.
Keypad rows: 1,2,5,6. Columns: 7,21,38.
EC11 A/B: 15/16; button: 4; common and button return: GND.
Reset button: GPIO13 to GND, normally open. External 10k pull-up included.
Wiring A1/A2/A3: 39/40/41. Wiring B1/B2/B3: 42/10/11.
The three challenge jumpers connect only A1-B1, A2-B2, A3-B3.

RFID PROPOSAL, PENDING BOARD CHECK AND HARDWARE TESTING
RC522 SCK=12, MOSI=19, MISO=20, SDA/SS=48, RST via 10k to V3V3.
IRQ unused. Reader supply is 3.3V, never 5V.
This avoids changing all currently working peripheral assignments.
GPIO19/20 are native USB signals. This proposal REQUIRES use of the separate
USB-to-UART port; do not connect the native USB connector during RFID operation.
GPIO48 is the onboard RGB data input on some development-board revisions.
Confirm the actual board circuit before accepting it as reader chip select.
The onboard LED may see the chip-select transitions. No other firmware may drive
that pin concurrently. The old disabled prototype RFID map is NOT this proposal.
The MFRC522 library supports UNUSED_PIN for RST and software reset, so no fifth
GPIO is necessary. Verify reader breakout reset circuitry before assembly.
Library reference: https://github.com/miguelbalboa/rfid/blob/master/src/MFRC522.cpp
ESP32 board reference:
https://documentation.espressif.com/esp-dev-kits/en/latest/esp32s3/esp32-s3-devkitc-1/user_guide_v1.0.html
RFID reference: https://www.nxp.com/docs/en/data-sheet/MFRC522.pdf

SHEET 2: POWER AND OUTPUT DRIVERS
External input is REGULATED 5V, not an unregulated barrel adapter.
F1 fuse, SW1 switch, power connector and wiring ratings remain unspecified until
the servo model and worst-case current budget are known.
For this draft the ESP32 remains USB powered. JP1 is an OPEN optional link
between external 5V and the devkit's as-yet-unverified 5VIN input.
DO NOT BRIDGE JP1. Final standalone power and simultaneous USB programming need
a verified power-path/backfeed solution for the actual purchased board.
The devkit's 3.3V regulator currently supplies the sensor/reader bus. Check its
remaining current capability and module onboard regulator requirements. If
insufficient, revise to a dedicated regulated logic supply with source isolation.
Do not parallel an external 3.3V regulator with the devkit's 3.3V output.

U2 SN74AHCT125: 5V buffer with TTL-compatible inputs, providing level conversion
for RGB data (GPIO14) and servo signal (GPIO9). The shown pin functions follow
the 14-pin device pinout; choose an actual package/device in Fusion.
Unused inputs are grounded; unused outputs are unconnected; their enables are
held high. Active-channel enables are grounded. C3 is local 100nF decoupling.
RGB: 330-ohm series data resistor, 1000uF / >=10V bulk capacitor.
Servo: provisional 220-ohm signal resistor and 470uF / >=10V bulk capacitor.
Capacitance does not replace an adequately rated supply or suitable power traces.
Firmware lock/unlock positions currently 0/90 degrees; check mechanics before load.
DFPlayer: external 5V supply, common GND, TX to GPIO17, GPIO18 through 680 ohm to RX.
Speaker connects SPK1 to SPK2; neither speaker lead connects to ground.
Buffer reference: https://www.ti.com/product/SN74AHCT125
RGB reference: https://learn.adafruit.com/adafruit-neopixel-uberguide/best-practices
Audio reference: https://wiki.dfrobot.com/dfr0299/

I2C AND MECHANICAL REVIEW REQUIRED
Inspect breakout pull-ups. Multiple parallel pull-ups may be too strong; any
optional carrier pull-ups must be chosen using the actual bus and module values.
Verify OLED connector order, exact development-board header count/pitch/spacing,
module mounting-hole locations, all connector orientations and speaker rating.
Keep copper/metal clear of the ESP32 antenna as required by its actual module.
Place bulk capacitors near load connectors and buffer bypass close to VCC/GND.
Use a ground plane and return high-current loads without forcing their current
through sensitive sensor ground paths. Size traces after the current budget.
No PCB outline or 3D enclosure dimensions have been assumed.

NEXT REVIEW INPUTS
1. Actual ESP32 board front/back photographs and board dimensions.
2. Servo model, RGB ring model, speaker impedance/power rating.
3. Preferred external 5V connector/adapter and intended battery or wall operation.
4. Module measurements and enclosure arrangement.
5. Successful Fusion import; then replace logical symbols with verified devices.

RFID FIRMWARE
Optional RC522 checkpoint is now implemented in src/main.cpp.
Set RFID_ENABLED=true in include/rfid_config.h only when hardware is connected.
Default is false, preserving the existing game without a reader.
When enabled: Player ID -> RFID -> Distance -> Binary -> Wiring -> Encoder.
Any successfully read compatible tag passes this gameplay checkpoint; no UID
allowlist or cryptographic card authentication is implemented.
The timer starts at player-ID submission, including time spent at RFID.
