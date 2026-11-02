<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
  <drawing>
    <settings>
      <setting alwaysvectorfont="no" />
      <setting verticaltext="up" />
    </settings>
    <grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch" />
    <layers>
      <layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes" />
      <layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes" />
      <layer number="93" name="Pins" color="2" fill="1" visible="yes" active="yes" />
      <layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes" />
      <layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes" />
      <layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes" />
      <layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes" />
      <layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes" />
    </layers>
    <schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
      <description>CircuitQuest logical draft. Not fabrication ready. Footprints and ESP32 header pad mapping unassigned.</description>
      <libraries>
        <library name="CircuitQuest_Draft">
          <packages />
          <symbols>
            <symbol name="BLOCK_U1">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-78.74" width="0.254" layer="94" />
              <wire x1="50.8" y1="-78.74" x2="0" y2="-78.74" width="0.254" layer="94" />
              <wire x1="0" y1="-78.74" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="3V3_OUT" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="5VIN_VERIFY" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="GPIO1" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
              <pin name="GPIO2" x="-5.08" y="-10.16" visible="pin" length="short" direction="pas" />
              <pin name="GPIO4" x="-5.08" y="-12.7" visible="pin" length="short" direction="pas" />
              <pin name="GPIO5" x="-5.08" y="-15.24" visible="pin" length="short" direction="pas" />
              <pin name="GPIO6" x="-5.08" y="-17.78" visible="pin" length="short" direction="pas" />
              <pin name="GPIO7" x="-5.08" y="-20.32" visible="pin" length="short" direction="pas" />
              <pin name="GPIO8" x="-5.08" y="-22.86" visible="pin" length="short" direction="pas" />
              <pin name="GPIO9" x="-5.08" y="-25.4" visible="pin" length="short" direction="pas" />
              <pin name="GPIO10" x="-5.08" y="-27.94" visible="pin" length="short" direction="pas" />
              <pin name="GPIO11" x="-5.08" y="-30.48" visible="pin" length="short" direction="pas" />
              <pin name="GPIO12" x="-5.08" y="-33.02" visible="pin" length="short" direction="pas" />
              <pin name="GPIO13" x="-5.08" y="-35.56" visible="pin" length="short" direction="pas" />
              <pin name="GPIO14" x="-5.08" y="-38.1" visible="pin" length="short" direction="pas" />
              <pin name="GPIO15" x="-5.08" y="-40.64" visible="pin" length="short" direction="pas" />
              <pin name="GPIO16" x="-5.08" y="-43.18" visible="pin" length="short" direction="pas" />
              <pin name="GPIO17" x="-5.08" y="-45.72" visible="pin" length="short" direction="pas" />
              <pin name="GPIO18" x="-5.08" y="-48.26" visible="pin" length="short" direction="pas" />
              <pin name="GPIO19" x="-5.08" y="-50.8" visible="pin" length="short" direction="pas" />
              <pin name="GPIO20" x="-5.08" y="-53.34" visible="pin" length="short" direction="pas" />
              <pin name="GPIO21" x="-5.08" y="-55.88" visible="pin" length="short" direction="pas" />
              <pin name="GPIO38" x="-5.08" y="-58.42" visible="pin" length="short" direction="pas" />
              <pin name="GPIO39" x="-5.08" y="-60.96" visible="pin" length="short" direction="pas" />
              <pin name="GPIO40" x="-5.08" y="-63.5" visible="pin" length="short" direction="pas" />
              <pin name="GPIO41" x="-5.08" y="-66.04" visible="pin" length="short" direction="pas" />
              <pin name="GPIO42" x="-5.08" y="-68.58" visible="pin" length="short" direction="pas" />
              <pin name="GPIO47" x="-5.08" y="-71.12" visible="pin" length="short" direction="pas" />
              <pin name="GPIO48" x="-5.08" y="-73.66" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J1">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-12.7" width="0.254" layer="94" />
              <wire x1="50.8" y1="-12.7" x2="0" y2="-12.7" width="0.254" layer="94" />
              <wire x1="0" y1="-12.7" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="VCC" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="SDA" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="SCL" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J2">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-12.7" width="0.254" layer="94" />
              <wire x1="50.8" y1="-12.7" x2="0" y2="-12.7" width="0.254" layer="94" />
              <wire x1="0" y1="-12.7" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="VCC" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="SDA" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="SCL" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J3">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-12.7" width="0.254" layer="94" />
              <wire x1="50.8" y1="-12.7" x2="0" y2="-12.7" width="0.254" layer="94" />
              <wire x1="0" y1="-12.7" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="VCC" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="SDA" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="SCL" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J4">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-20.32" width="0.254" layer="94" />
              <wire x1="50.8" y1="-20.32" x2="0" y2="-20.32" width="0.254" layer="94" />
              <wire x1="0" y1="-20.32" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="R1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="R2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="R3" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="R4" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
              <pin name="C1" x="-5.08" y="-10.16" visible="pin" length="short" direction="pas" />
              <pin name="C2" x="-5.08" y="-12.7" visible="pin" length="short" direction="pas" />
              <pin name="C3" x="-5.08" y="-15.24" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J5">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-15.24" width="0.254" layer="94" />
              <wire x1="50.8" y1="-15.24" x2="0" y2="-15.24" width="0.254" layer="94" />
              <wire x1="0" y1="-15.24" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="A" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="COMMON" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="B" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="SW1" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
              <pin name="SW2" x="-5.08" y="-10.16" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J6">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="CONTACT1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="CONTACT2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J7">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="A1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="A2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="A3" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J8">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="B1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="B2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="B3" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J9">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-22.86" width="0.254" layer="94" />
              <wire x1="50.8" y1="-22.86" x2="0" y2="-22.86" width="0.254" layer="94" />
              <wire x1="0" y1="-22.86" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="SDA_SS" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="SCK" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="MOSI" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="MISO" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
              <pin name="IRQ_NC" x="-5.08" y="-10.16" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-12.7" visible="pin" length="short" direction="pas" />
              <pin name="RST" x="-5.08" y="-15.24" visible="pin" length="short" direction="pas" />
              <pin name="3V3" x="-5.08" y="-17.78" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R1">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R2">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R3">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J10">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="PLUS" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="MINUS" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_F1">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="IN" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="OUT" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_SW1">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="IN" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="OUT" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_JP1">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_C1">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="PLUS" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="MINUS" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_C2">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="PLUS" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="MINUS" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_U2">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-38.1" width="0.254" layer="94" />
              <wire x1="50.8" y1="-38.1" x2="0" y2="-38.1" width="0.254" layer="94" />
              <wire x1="0" y1="-38.1" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1OE_N" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="1A" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="1Y" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="2OE_N" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
              <pin name="2A" x="-5.08" y="-10.16" visible="pin" length="short" direction="pas" />
              <pin name="2Y" x="-5.08" y="-12.7" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-15.24" visible="pin" length="short" direction="pas" />
              <pin name="3Y_NC" x="-5.08" y="-17.78" visible="pin" length="short" direction="pas" />
              <pin name="3A" x="-5.08" y="-20.32" visible="pin" length="short" direction="pas" />
              <pin name="3OE_N" x="-5.08" y="-22.86" visible="pin" length="short" direction="pas" />
              <pin name="4Y_NC" x="-5.08" y="-25.4" visible="pin" length="short" direction="pas" />
              <pin name="4A" x="-5.08" y="-27.94" visible="pin" length="short" direction="pas" />
              <pin name="4OE_N" x="-5.08" y="-30.48" visible="pin" length="short" direction="pas" />
              <pin name="VCC" x="-5.08" y="-33.02" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_C3">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R4">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R5">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R6">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R7">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J11">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="5V" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="DIN" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J12">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="SIGNAL" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="5V" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J13">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-17.78" width="0.254" layer="94" />
              <wire x1="50.8" y1="-17.78" x2="0" y2="-17.78" width="0.254" layer="94" />
              <wire x1="0" y1="-17.78" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="VCC" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="GND" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
              <pin name="TX" x="-5.08" y="-5.08" visible="pin" length="short" direction="pas" />
              <pin name="RX" x="-5.08" y="-7.62" visible="pin" length="short" direction="pas" />
              <pin name="SPK1" x="-5.08" y="-10.16" visible="pin" length="short" direction="pas" />
              <pin name="SPK2" x="-5.08" y="-12.7" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_R8">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_J14">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_C4">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="1" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="2" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
            <symbol name="BLOCK_C5">
              <wire x1="0" y1="2.54" x2="50.8" y2="2.54" width="0.254" layer="94" />
              <wire x1="50.8" y1="2.54" x2="50.8" y2="-10.16" width="0.254" layer="94" />
              <wire x1="50.8" y1="-10.16" x2="0" y2="-10.16" width="0.254" layer="94" />
              <wire x1="0" y1="-10.16" x2="0" y2="2.54" width="0.254" layer="94" />
              <text x="0" y="5.08" size="1.778" layer="95">&gt;NAME</text>
              <pin name="PLUS" x="-5.08" y="0.0" visible="pin" length="short" direction="pas" />
              <pin name="MINUS" x="-5.08" y="-2.54" visible="pin" length="short" direction="pas" />
            </symbol>
          </symbols>
          <devicesets>
            <deviceset name="BLOCK_U1" prefix="U" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_U1" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J1" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J1" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J2" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J2" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J3" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J3" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J4" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J4" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J5" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J5" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J6" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J6" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J7" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J7" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J8" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J8" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J9" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J9" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R1" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R1" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R2" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R2" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R3" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R3" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J10" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J10" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_F1" prefix="F" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_F1" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_SW1" prefix="SW" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_SW1" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_JP1" prefix="JP" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_JP1" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_C1" prefix="C" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_C1" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_C2" prefix="C" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_C2" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_U2" prefix="U" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_U2" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_C3" prefix="C" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_C3" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R4" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R4" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R5" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R5" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R6" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R6" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R7" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R7" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J11" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J11" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J12" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J12" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J13" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J13" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_R8" prefix="R" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_R8" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_J14" prefix="J" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_J14" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_C4" prefix="C" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_C4" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
            <deviceset name="BLOCK_C5" prefix="C" uservalue="yes">
              <gates>
                <gate name="G$1" symbol="BLOCK_C5" x="0" y="0" />
              </gates>
              <devices>
                <device name="">
                  <technologies>
                    <technology name="" />
                  </technologies>
                </device>
              </devices>
            </deviceset>
          </devicesets>
        </library>
      </libraries>
      <attributes />
      <variantdefs />
      <classes>
        <class number="0" name="default" width="0" drill="0" />
      </classes>
      <parts>
        <part name="U1" library="CircuitQuest_Draft" deviceset="BLOCK_U1" device="" value="ESP32-S3 DEVKIT / HEADER MAPPING UNVERIFIED" />
        <part name="J1" library="CircuitQuest_Draft" deviceset="BLOCK_J1" device="" value="OLED / cable order to verify" />
        <part name="J2" library="CircuitQuest_Draft" deviceset="BLOCK_J2" device="" value="VL53L0X / cable order to verify" />
        <part name="J3" library="CircuitQuest_Draft" deviceset="BLOCK_J3" device="" value="MPU6500 / ID 0x70" />
        <part name="J4" library="CircuitQuest_Draft" deviceset="BLOCK_J4" device="" value="KEYPAD 4x3" />
        <part name="J5" library="CircuitQuest_Draft" deviceset="BLOCK_J5" device="" value="EC11 / label contacts by function" />
        <part name="J6" library="CircuitQuest_Draft" deviceset="BLOCK_J6" device="" value="RESET BUTTON / normally open" />
        <part name="J7" library="CircuitQuest_Draft" deviceset="BLOCK_J7" device="" value="WIRING A / isolated terminals" />
        <part name="J8" library="CircuitQuest_Draft" deviceset="BLOCK_J8" device="" value="WIRING B / isolated terminals" />
        <part name="J9" library="CircuitQuest_Draft" deviceset="BLOCK_J9" device="" value="RC522 / PROPOSED / firmware pending" />
        <part name="R1" library="CircuitQuest_Draft" deviceset="BLOCK_R1" device="" value="10k / reader reset pull-up" />
        <part name="R2" library="CircuitQuest_Draft" deviceset="BLOCK_R2" device="" value="10k / reader chip-select pull-up" />
        <part name="R3" library="CircuitQuest_Draft" deviceset="BLOCK_R3" device="" value="10k / reset-button pull-up" />
        <part name="J10" library="CircuitQuest_Draft" deviceset="BLOCK_J10" device="" value="REGULATED 5V INPUT / connector TBD" />
        <part name="F1" library="CircuitQuest_Draft" deviceset="BLOCK_F1" device="" value="FUSE / rating TBD after load budget" />
        <part name="SW1" library="CircuitQuest_Draft" deviceset="BLOCK_SW1" device="" value="MAIN POWER / current rating TBD" />
        <part name="JP1" library="CircuitQuest_Draft" deviceset="BLOCK_JP1" device="" value="OPEN: DO NOT BRIDGE until USB power reviewed" />
        <part name="C1" library="CircuitQuest_Draft" deviceset="BLOCK_C1" device="" value="1000uF / &gt;=10V / RGB bulk" />
        <part name="C2" library="CircuitQuest_Draft" deviceset="BLOCK_C2" device="" value="470uF / &gt;=10V / servo bulk provisional" />
        <part name="U2" library="CircuitQuest_Draft" deviceset="BLOCK_U2" device="" value="SN74AHCT125 / 3V3 to 5V buffer" />
        <part name="C3" library="CircuitQuest_Draft" deviceset="BLOCK_C3" device="" value="100nF / at buffer supply pins" />
        <part name="R4" library="CircuitQuest_Draft" deviceset="BLOCK_R4" device="" value="10k / RGB boot pull-down" />
        <part name="R5" library="CircuitQuest_Draft" deviceset="BLOCK_R5" device="" value="10k / servo boot pull-down" />
        <part name="R6" library="CircuitQuest_Draft" deviceset="BLOCK_R6" device="" value="330 ohm / at ring data input" />
        <part name="R7" library="CircuitQuest_Draft" deviceset="BLOCK_R7" device="" value="220 ohm / servo signal series" />
        <part name="J11" library="CircuitQuest_Draft" deviceset="BLOCK_J11" device="" value="RGB RING / 12 LEDs" />
        <part name="J12" library="CircuitQuest_Draft" deviceset="BLOCK_J12" device="" value="SERVO / plug polarity to verify" />
        <part name="J13" library="CircuitQuest_Draft" deviceset="BLOCK_J13" device="" value="DFPLAYER / 5V final supply" />
        <part name="R8" library="CircuitQuest_Draft" deviceset="BLOCK_R8" device="" value="680 ohm / ESP TX to DF RX" />
        <part name="J14" library="CircuitQuest_Draft" deviceset="BLOCK_J14" device="" value="SPEAKER / neither lead to GND" />
        <part name="C4" library="CircuitQuest_Draft" deviceset="BLOCK_C4" device="" value="100nF / near DFPlayer VCC" />
        <part name="C5" library="CircuitQuest_Draft" deviceset="BLOCK_C5" device="" value="100uF / &gt;=10V / near DFPlayer" />
      </parts>
      <sheets>
        <sheet>
          <description>CIRCUITQUEST - CONTROLLER AND MODULE CONNECTORS - DRAFT A</description>
          <plain>
            <text x="10" y="290" size="2.54" layer="97">CIRCUITQUEST - CONTROLLER AND MODULE CONNECTORS - DRAFT A</text>
            <text x="10" y="285" size="1.778" layer="97">Logical symbols only. NO ESP32 socket pad mapping or PCB footprints assigned.</text>
            <text x="10" y="280" size="1.778" layer="97">RFID SPI proposal: SCK12 / MOSI19 / MISO20 / CS48. Use UART USB; native USB unavailable.</text>
            <text x="10" y="275" size="1.778" layer="97">RFID RST pulled HIGH; firmware must use software reset. GPIO48 onboard LED loading to verify.</text>
            <text x="10" y="270" size="1.778" layer="97">Cable pin orders are proposed harness functions, NOT verified module connector footprints.</text>
            <text x="10" y="265" size="1.778" layer="97">Shared I2C: verify breakout pull-ups, voltage and onboard regulators before finalizing.</text>
            <text x="10" y="260" size="1.778" layer="97">Only connect wiring terminals A1-B1, A2-B2, A3-B3. Never apply external power to terminals.</text>
            <text x="65" y="254" size="1.27" layer="97">ESP32-S3 DEVKIT / HEADER MAPPING UNVERIFIED</text>
            <text x="160" y="254" size="1.27" layer="97">OLED / cable order to verify</text>
            <text x="160" y="224" size="1.27" layer="97">VL53L0X / cable order to verify</text>
            <text x="160" y="194" size="1.27" layer="97">MPU6500 / ID 0x70</text>
            <text x="160" y="164" size="1.27" layer="97">KEYPAD 4x3</text>
            <text x="160" y="119" size="1.27" layer="97">EC11 / label contacts by function</text>
            <text x="160" y="84" size="1.27" layer="97">RESET BUTTON / normally open</text>
            <text x="270" y="254" size="1.27" layer="97">WIRING A / isolated terminals</text>
            <text x="270" y="224" size="1.27" layer="97">WIRING B / isolated terminals</text>
            <text x="270" y="189" size="1.27" layer="97">RC522 / PROPOSED / firmware pending</text>
            <text x="256.92" y="169.84" size="1.27" layer="97">NC</text>
            <text x="270" y="144" size="1.27" layer="97">10k / reader reset pull-up</text>
            <text x="270" y="119" size="1.27" layer="97">10k / reader chip-select pull-up</text>
            <text x="270" y="94" size="1.27" layer="97">10k / reset-button pull-up</text>
          </plain>
          <instances>
            <instance part="U1" gate="G$1" x="65" y="245" smashed="no" />
            <instance part="J1" gate="G$1" x="160" y="245" smashed="no" />
            <instance part="J2" gate="G$1" x="160" y="215" smashed="no" />
            <instance part="J3" gate="G$1" x="160" y="185" smashed="no" />
            <instance part="J4" gate="G$1" x="160" y="155" smashed="no" />
            <instance part="J5" gate="G$1" x="160" y="110" smashed="no" />
            <instance part="J6" gate="G$1" x="160" y="75" smashed="no" />
            <instance part="J7" gate="G$1" x="270" y="245" smashed="no" />
            <instance part="J8" gate="G$1" x="270" y="215" smashed="no" />
            <instance part="J9" gate="G$1" x="270" y="180" smashed="no" />
            <instance part="R1" gate="G$1" x="270" y="135" smashed="no" />
            <instance part="R2" gate="G$1" x="270" y="110" smashed="no" />
            <instance part="R3" gate="G$1" x="270" y="85" smashed="no" />
          </instances>
          <busses />
          <nets>
            <net name="V3V3" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="3V3_OUT" />
                <wire x1="59.92" y1="245.0" x2="44.68" y2="245.0" width="0.1524" layer="91" />
                <label x="44.68" y="245.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J1" gate="G$1" pin="VCC" />
                <wire x1="154.92" y1="245.0" x2="139.67999999999998" y2="245.0" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="245.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J2" gate="G$1" pin="VCC" />
                <wire x1="154.92" y1="215.0" x2="139.67999999999998" y2="215.0" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="215.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J3" gate="G$1" pin="VCC" />
                <wire x1="154.92" y1="185.0" x2="139.67999999999998" y2="185.0" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="185.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J9" gate="G$1" pin="3V3" />
                <wire x1="264.92" y1="162.22" x2="249.68" y2="162.22" width="0.1524" layer="91" />
                <label x="249.68" y="162.22" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R1" gate="G$1" pin="1" />
                <wire x1="264.92" y1="135.0" x2="249.68" y2="135.0" width="0.1524" layer="91" />
                <label x="249.68" y="135.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R2" gate="G$1" pin="1" />
                <wire x1="264.92" y1="110.0" x2="249.68" y2="110.0" width="0.1524" layer="91" />
                <label x="249.68" y="110.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R3" gate="G$1" pin="1" />
                <wire x1="264.92" y1="85.0" x2="249.68" y2="85.0" width="0.1524" layer="91" />
                <label x="249.68" y="85.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GND" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GND" />
                <wire x1="59.92" y1="242.46" x2="44.68" y2="242.46" width="0.1524" layer="91" />
                <label x="44.68" y="242.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J1" gate="G$1" pin="GND" />
                <wire x1="154.92" y1="242.46" x2="139.67999999999998" y2="242.46" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="242.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J2" gate="G$1" pin="GND" />
                <wire x1="154.92" y1="212.46" x2="139.67999999999998" y2="212.46" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="212.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J3" gate="G$1" pin="GND" />
                <wire x1="154.92" y1="182.46" x2="139.67999999999998" y2="182.46" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="182.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J5" gate="G$1" pin="COMMON" />
                <wire x1="154.92" y1="107.46" x2="139.67999999999998" y2="107.46" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="107.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J5" gate="G$1" pin="SW2" />
                <wire x1="154.92" y1="99.84" x2="139.67999999999998" y2="99.84" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="99.84" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J6" gate="G$1" pin="CONTACT2" />
                <wire x1="154.92" y1="72.46" x2="139.67999999999998" y2="72.46" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="72.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J9" gate="G$1" pin="GND" />
                <wire x1="264.92" y1="167.3" x2="249.68" y2="167.3" width="0.1524" layer="91" />
                <label x="249.68" y="167.3" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="DEVKIT_5V_VERIFY" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="5VIN_VERIFY" />
                <wire x1="59.92" y1="239.92" x2="44.68" y2="239.92" width="0.1524" layer="91" />
                <label x="44.68" y="239.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO1" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO1" />
                <wire x1="59.92" y1="237.38" x2="44.68" y2="237.38" width="0.1524" layer="91" />
                <label x="44.68" y="237.38" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J4" gate="G$1" pin="R1" />
                <wire x1="154.92" y1="155.0" x2="139.67999999999998" y2="155.0" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="155.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO2" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO2" />
                <wire x1="59.92" y1="234.84" x2="44.68" y2="234.84" width="0.1524" layer="91" />
                <label x="44.68" y="234.84" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J4" gate="G$1" pin="R2" />
                <wire x1="154.92" y1="152.46" x2="139.67999999999998" y2="152.46" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="152.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO4" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO4" />
                <wire x1="59.92" y1="232.3" x2="44.68" y2="232.3" width="0.1524" layer="91" />
                <label x="44.68" y="232.3" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J5" gate="G$1" pin="SW1" />
                <wire x1="154.92" y1="102.38" x2="139.67999999999998" y2="102.38" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="102.38" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO5" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO5" />
                <wire x1="59.92" y1="229.76" x2="44.68" y2="229.76" width="0.1524" layer="91" />
                <label x="44.68" y="229.76" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J4" gate="G$1" pin="R3" />
                <wire x1="154.92" y1="149.92" x2="139.67999999999998" y2="149.92" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="149.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO6" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO6" />
                <wire x1="59.92" y1="227.22" x2="44.68" y2="227.22" width="0.1524" layer="91" />
                <label x="44.68" y="227.22" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J4" gate="G$1" pin="R4" />
                <wire x1="154.92" y1="147.38" x2="139.67999999999998" y2="147.38" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="147.38" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO7" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO7" />
                <wire x1="59.92" y1="224.68" x2="44.68" y2="224.68" width="0.1524" layer="91" />
                <label x="44.68" y="224.68" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J4" gate="G$1" pin="C1" />
                <wire x1="154.92" y1="144.84" x2="139.67999999999998" y2="144.84" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="144.84" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO8" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO8" />
                <wire x1="59.92" y1="222.14" x2="44.68" y2="222.14" width="0.1524" layer="91" />
                <label x="44.68" y="222.14" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J1" gate="G$1" pin="SDA" />
                <wire x1="154.92" y1="239.92" x2="139.67999999999998" y2="239.92" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="239.92" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J2" gate="G$1" pin="SDA" />
                <wire x1="154.92" y1="209.92" x2="139.67999999999998" y2="209.92" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="209.92" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J3" gate="G$1" pin="SDA" />
                <wire x1="154.92" y1="179.92" x2="139.67999999999998" y2="179.92" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="179.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO9" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO9" />
                <wire x1="59.92" y1="219.6" x2="44.68" y2="219.6" width="0.1524" layer="91" />
                <label x="44.68" y="219.6" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO10" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO10" />
                <wire x1="59.92" y1="217.06" x2="44.68" y2="217.06" width="0.1524" layer="91" />
                <label x="44.68" y="217.06" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J8" gate="G$1" pin="B2" />
                <wire x1="264.92" y1="212.46" x2="249.68" y2="212.46" width="0.1524" layer="91" />
                <label x="249.68" y="212.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO11" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO11" />
                <wire x1="59.92" y1="214.52" x2="44.68" y2="214.52" width="0.1524" layer="91" />
                <label x="44.68" y="214.52" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J8" gate="G$1" pin="B3" />
                <wire x1="264.92" y1="209.92" x2="249.68" y2="209.92" width="0.1524" layer="91" />
                <label x="249.68" y="209.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO12" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO12" />
                <wire x1="59.92" y1="211.98" x2="44.68" y2="211.98" width="0.1524" layer="91" />
                <label x="44.68" y="211.98" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J9" gate="G$1" pin="SCK" />
                <wire x1="264.92" y1="177.46" x2="249.68" y2="177.46" width="0.1524" layer="91" />
                <label x="249.68" y="177.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO13" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO13" />
                <wire x1="59.92" y1="209.44" x2="44.68" y2="209.44" width="0.1524" layer="91" />
                <label x="44.68" y="209.44" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J6" gate="G$1" pin="CONTACT1" />
                <wire x1="154.92" y1="75.0" x2="139.67999999999998" y2="75.0" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="75.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R3" gate="G$1" pin="2" />
                <wire x1="264.92" y1="82.46" x2="249.68" y2="82.46" width="0.1524" layer="91" />
                <label x="249.68" y="82.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO14" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO14" />
                <wire x1="59.92" y1="206.9" x2="44.68" y2="206.9" width="0.1524" layer="91" />
                <label x="44.68" y="206.9" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO15" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO15" />
                <wire x1="59.92" y1="204.36" x2="44.68" y2="204.36" width="0.1524" layer="91" />
                <label x="44.68" y="204.36" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J5" gate="G$1" pin="A" />
                <wire x1="154.92" y1="110.0" x2="139.67999999999998" y2="110.0" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="110.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO16" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO16" />
                <wire x1="59.92" y1="201.82" x2="44.68" y2="201.82" width="0.1524" layer="91" />
                <label x="44.68" y="201.82" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J5" gate="G$1" pin="B" />
                <wire x1="154.92" y1="104.92" x2="139.67999999999998" y2="104.92" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="104.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO17" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO17" />
                <wire x1="59.92" y1="199.28" x2="44.68" y2="199.28" width="0.1524" layer="91" />
                <label x="44.68" y="199.28" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO18" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO18" />
                <wire x1="59.92" y1="196.74" x2="44.68" y2="196.74" width="0.1524" layer="91" />
                <label x="44.68" y="196.74" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO19" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO19" />
                <wire x1="59.92" y1="194.2" x2="44.68" y2="194.2" width="0.1524" layer="91" />
                <label x="44.68" y="194.2" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J9" gate="G$1" pin="MOSI" />
                <wire x1="264.92" y1="174.92" x2="249.68" y2="174.92" width="0.1524" layer="91" />
                <label x="249.68" y="174.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO20" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO20" />
                <wire x1="59.92" y1="191.66" x2="44.68" y2="191.66" width="0.1524" layer="91" />
                <label x="44.68" y="191.66" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J9" gate="G$1" pin="MISO" />
                <wire x1="264.92" y1="172.38" x2="249.68" y2="172.38" width="0.1524" layer="91" />
                <label x="249.68" y="172.38" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO21" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO21" />
                <wire x1="59.92" y1="189.12" x2="44.68" y2="189.12" width="0.1524" layer="91" />
                <label x="44.68" y="189.12" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J4" gate="G$1" pin="C2" />
                <wire x1="154.92" y1="142.3" x2="139.67999999999998" y2="142.3" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="142.3" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO38" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO38" />
                <wire x1="59.92" y1="186.57999999999998" x2="44.68" y2="186.57999999999998" width="0.1524" layer="91" />
                <label x="44.68" y="186.57999999999998" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J4" gate="G$1" pin="C3" />
                <wire x1="154.92" y1="139.76" x2="139.67999999999998" y2="139.76" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="139.76" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO39" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO39" />
                <wire x1="59.92" y1="184.04" x2="44.68" y2="184.04" width="0.1524" layer="91" />
                <label x="44.68" y="184.04" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J7" gate="G$1" pin="A1" />
                <wire x1="264.92" y1="245.0" x2="249.68" y2="245.0" width="0.1524" layer="91" />
                <label x="249.68" y="245.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO40" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO40" />
                <wire x1="59.92" y1="181.5" x2="44.68" y2="181.5" width="0.1524" layer="91" />
                <label x="44.68" y="181.5" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J7" gate="G$1" pin="A2" />
                <wire x1="264.92" y1="242.46" x2="249.68" y2="242.46" width="0.1524" layer="91" />
                <label x="249.68" y="242.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO41" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO41" />
                <wire x1="59.92" y1="178.95999999999998" x2="44.68" y2="178.95999999999998" width="0.1524" layer="91" />
                <label x="44.68" y="178.95999999999998" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J7" gate="G$1" pin="A3" />
                <wire x1="264.92" y1="239.92" x2="249.68" y2="239.92" width="0.1524" layer="91" />
                <label x="249.68" y="239.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO42" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO42" />
                <wire x1="59.92" y1="176.42000000000002" x2="44.68" y2="176.42000000000002" width="0.1524" layer="91" />
                <label x="44.68" y="176.42000000000002" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J8" gate="G$1" pin="B1" />
                <wire x1="264.92" y1="215.0" x2="249.68" y2="215.0" width="0.1524" layer="91" />
                <label x="249.68" y="215.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO47" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO47" />
                <wire x1="59.92" y1="173.88" x2="44.68" y2="173.88" width="0.1524" layer="91" />
                <label x="44.68" y="173.88" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J1" gate="G$1" pin="SCL" />
                <wire x1="154.92" y1="237.38" x2="139.67999999999998" y2="237.38" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="237.38" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J2" gate="G$1" pin="SCL" />
                <wire x1="154.92" y1="207.38" x2="139.67999999999998" y2="207.38" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="207.38" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J3" gate="G$1" pin="SCL" />
                <wire x1="154.92" y1="177.38" x2="139.67999999999998" y2="177.38" width="0.1524" layer="91" />
                <label x="139.67999999999998" y="177.38" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO48" class="0">
              <segment>
                <pinref part="U1" gate="G$1" pin="GPIO48" />
                <wire x1="59.92" y1="171.34" x2="44.68" y2="171.34" width="0.1524" layer="91" />
                <label x="44.68" y="171.34" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J9" gate="G$1" pin="SDA_SS" />
                <wire x1="264.92" y1="180.0" x2="249.68" y2="180.0" width="0.1524" layer="91" />
                <label x="249.68" y="180.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R2" gate="G$1" pin="2" />
                <wire x1="264.92" y1="107.46" x2="249.68" y2="107.46" width="0.1524" layer="91" />
                <label x="249.68" y="107.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="RFID_RST" class="0">
              <segment>
                <pinref part="J9" gate="G$1" pin="RST" />
                <wire x1="264.92" y1="164.76" x2="249.68" y2="164.76" width="0.1524" layer="91" />
                <label x="249.68" y="164.76" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R1" gate="G$1" pin="2" />
                <wire x1="264.92" y1="132.46" x2="249.68" y2="132.46" width="0.1524" layer="91" />
                <label x="249.68" y="132.46" size="1.27" layer="95" />
              </segment>
            </net>
          </nets>
        </sheet>
        <sheet>
          <description>CIRCUITQUEST - POWER AND OUTPUT DRIVERS - DRAFT A</description>
          <plain>
            <text x="10" y="290" size="2.54" layer="97">CIRCUITQUEST - POWER AND OUTPUT DRIVERS - DRAFT A</text>
            <text x="10" y="285" size="1.778" layer="97">Use regulated external 5V. Fuse/switch/connector ratings require servo model and current budget.</text>
            <text x="10" y="280" size="1.778" layer="97">JP1 MUST STAY OPEN. For this draft power ESP32 via USB; external 5V powers output loads.</text>
            <text x="10" y="275" size="1.778" layer="97">Do not connect external 5V to the devkit until USB backfeed / power-path design is reviewed.</text>
            <text x="10" y="270" size="1.778" layer="97">V3V3 comes from devkit. Regulator capacity for OLED + ToF + IMU + RFID must be verified.</text>
            <text x="10" y="265" size="1.778" layer="97">U2 unused channels disabled. Unconnected pins are marked NC. All grounds share one net.</text>
            <text x="10" y="260" size="1.778" layer="97">These logical symbols intentionally have NO package; choose verified library devices before PCB.</text>
            <text x="65" y="254" size="1.27" layer="97">REGULATED 5V INPUT / connector TBD</text>
            <text x="65" y="224" size="1.27" layer="97">FUSE / rating TBD after load budget</text>
            <text x="65" y="194" size="1.27" layer="97">MAIN POWER / current rating TBD</text>
            <text x="65" y="164" size="1.27" layer="97">OPEN: DO NOT BRIDGE until USB power reviewed</text>
            <text x="65" y="129" size="1.27" layer="97">1000uF / &gt;=10V / RGB bulk</text>
            <text x="65" y="99" size="1.27" layer="97">470uF / &gt;=10V / servo bulk provisional</text>
            <text x="170" y="254" size="1.27" layer="97">SN74AHCT125 / 3V3 to 5V buffer</text>
            <text x="156.92" y="227.22" size="1.27" layer="97">NC</text>
            <text x="156.92" y="219.6" size="1.27" layer="97">NC</text>
            <text x="170" y="189" size="1.27" layer="97">100nF / at buffer supply pins</text>
            <text x="170" y="159" size="1.27" layer="97">10k / RGB boot pull-down</text>
            <text x="170" y="134" size="1.27" layer="97">10k / servo boot pull-down</text>
            <text x="170" y="109" size="1.27" layer="97">330 ohm / at ring data input</text>
            <text x="170" y="84" size="1.27" layer="97">220 ohm / servo signal series</text>
            <text x="280" y="254" size="1.27" layer="97">RGB RING / 12 LEDs</text>
            <text x="280" y="224" size="1.27" layer="97">SERVO / plug polarity to verify</text>
            <text x="280" y="189" size="1.27" layer="97">DFPLAYER / 5V final supply</text>
            <text x="280" y="149" size="1.27" layer="97">680 ohm / ESP TX to DF RX</text>
            <text x="280" y="119" size="1.27" layer="97">SPEAKER / neither lead to GND</text>
            <text x="280" y="89" size="1.27" layer="97">100nF / near DFPlayer VCC</text>
            <text x="280" y="64" size="1.27" layer="97">100uF / &gt;=10V / near DFPlayer</text>
          </plain>
          <instances>
            <instance part="J10" gate="G$1" x="65" y="245" smashed="no" />
            <instance part="F1" gate="G$1" x="65" y="215" smashed="no" />
            <instance part="SW1" gate="G$1" x="65" y="185" smashed="no" />
            <instance part="JP1" gate="G$1" x="65" y="155" smashed="no" />
            <instance part="C1" gate="G$1" x="65" y="120" smashed="no" />
            <instance part="C2" gate="G$1" x="65" y="90" smashed="no" />
            <instance part="U2" gate="G$1" x="170" y="245" smashed="no" />
            <instance part="C3" gate="G$1" x="170" y="180" smashed="no" />
            <instance part="R4" gate="G$1" x="170" y="150" smashed="no" />
            <instance part="R5" gate="G$1" x="170" y="125" smashed="no" />
            <instance part="R6" gate="G$1" x="170" y="100" smashed="no" />
            <instance part="R7" gate="G$1" x="170" y="75" smashed="no" />
            <instance part="J11" gate="G$1" x="280" y="245" smashed="no" />
            <instance part="J12" gate="G$1" x="280" y="215" smashed="no" />
            <instance part="J13" gate="G$1" x="280" y="180" smashed="no" />
            <instance part="R8" gate="G$1" x="280" y="140" smashed="no" />
            <instance part="J14" gate="G$1" x="280" y="110" smashed="no" />
            <instance part="C4" gate="G$1" x="280" y="80" smashed="no" />
            <instance part="C5" gate="G$1" x="280" y="55" smashed="no" />
          </instances>
          <busses />
          <nets>
            <net name="EXT_5V" class="0">
              <segment>
                <pinref part="J10" gate="G$1" pin="PLUS" />
                <wire x1="59.92" y1="245.0" x2="44.68" y2="245.0" width="0.1524" layer="91" />
                <label x="44.68" y="245.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="F1" gate="G$1" pin="IN" />
                <wire x1="59.92" y1="215.0" x2="44.68" y2="215.0" width="0.1524" layer="91" />
                <label x="44.68" y="215.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="GND" class="0">
              <segment>
                <pinref part="J10" gate="G$1" pin="MINUS" />
                <wire x1="59.92" y1="242.46" x2="44.68" y2="242.46" width="0.1524" layer="91" />
                <label x="44.68" y="242.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C1" gate="G$1" pin="MINUS" />
                <wire x1="59.92" y1="117.46" x2="44.68" y2="117.46" width="0.1524" layer="91" />
                <label x="44.68" y="117.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C2" gate="G$1" pin="MINUS" />
                <wire x1="59.92" y1="87.46" x2="44.68" y2="87.46" width="0.1524" layer="91" />
                <label x="44.68" y="87.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="1OE_N" />
                <wire x1="164.92" y1="245.0" x2="149.67999999999998" y2="245.0" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="245.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="2OE_N" />
                <wire x1="164.92" y1="237.38" x2="149.67999999999998" y2="237.38" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="237.38" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="GND" />
                <wire x1="164.92" y1="229.76" x2="149.67999999999998" y2="229.76" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="229.76" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="3A" />
                <wire x1="164.92" y1="224.68" x2="149.67999999999998" y2="224.68" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="224.68" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="4A" />
                <wire x1="164.92" y1="217.06" x2="149.67999999999998" y2="217.06" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="217.06" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C3" gate="G$1" pin="2" />
                <wire x1="164.92" y1="177.46" x2="149.67999999999998" y2="177.46" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="177.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R4" gate="G$1" pin="2" />
                <wire x1="164.92" y1="147.46" x2="149.67999999999998" y2="147.46" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="147.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R5" gate="G$1" pin="2" />
                <wire x1="164.92" y1="122.46" x2="149.67999999999998" y2="122.46" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="122.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J11" gate="G$1" pin="GND" />
                <wire x1="274.92" y1="239.92" x2="259.68" y2="239.92" width="0.1524" layer="91" />
                <label x="259.68" y="239.92" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J12" gate="G$1" pin="GND" />
                <wire x1="274.92" y1="209.92" x2="259.68" y2="209.92" width="0.1524" layer="91" />
                <label x="259.68" y="209.92" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J13" gate="G$1" pin="GND" />
                <wire x1="274.92" y1="177.46" x2="259.68" y2="177.46" width="0.1524" layer="91" />
                <label x="259.68" y="177.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C4" gate="G$1" pin="2" />
                <wire x1="274.92" y1="77.46" x2="259.68" y2="77.46" width="0.1524" layer="91" />
                <label x="259.68" y="77.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C5" gate="G$1" pin="MINUS" />
                <wire x1="274.92" y1="52.46" x2="259.68" y2="52.46" width="0.1524" layer="91" />
                <label x="259.68" y="52.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="FUSED_5V" class="0">
              <segment>
                <pinref part="F1" gate="G$1" pin="OUT" />
                <wire x1="59.92" y1="212.46" x2="44.68" y2="212.46" width="0.1524" layer="91" />
                <label x="44.68" y="212.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="SW1" gate="G$1" pin="IN" />
                <wire x1="59.92" y1="185.0" x2="44.68" y2="185.0" width="0.1524" layer="91" />
                <label x="44.68" y="185.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="V5_MAIN" class="0">
              <segment>
                <pinref part="SW1" gate="G$1" pin="OUT" />
                <wire x1="59.92" y1="182.46" x2="44.68" y2="182.46" width="0.1524" layer="91" />
                <label x="44.68" y="182.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="JP1" gate="G$1" pin="1" />
                <wire x1="59.92" y1="155.0" x2="44.68" y2="155.0" width="0.1524" layer="91" />
                <label x="44.68" y="155.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C1" gate="G$1" pin="PLUS" />
                <wire x1="59.92" y1="120.0" x2="44.68" y2="120.0" width="0.1524" layer="91" />
                <label x="44.68" y="120.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C2" gate="G$1" pin="PLUS" />
                <wire x1="59.92" y1="90.0" x2="44.68" y2="90.0" width="0.1524" layer="91" />
                <label x="44.68" y="90.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="3OE_N" />
                <wire x1="164.92" y1="222.14" x2="149.67999999999998" y2="222.14" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="222.14" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="4OE_N" />
                <wire x1="164.92" y1="214.52" x2="149.67999999999998" y2="214.52" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="214.52" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="U2" gate="G$1" pin="VCC" />
                <wire x1="164.92" y1="211.98" x2="149.67999999999998" y2="211.98" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="211.98" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C3" gate="G$1" pin="1" />
                <wire x1="164.92" y1="180.0" x2="149.67999999999998" y2="180.0" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="180.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J11" gate="G$1" pin="5V" />
                <wire x1="274.92" y1="245.0" x2="259.68" y2="245.0" width="0.1524" layer="91" />
                <label x="259.68" y="245.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J12" gate="G$1" pin="5V" />
                <wire x1="274.92" y1="212.46" x2="259.68" y2="212.46" width="0.1524" layer="91" />
                <label x="259.68" y="212.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J13" gate="G$1" pin="VCC" />
                <wire x1="274.92" y1="180.0" x2="259.68" y2="180.0" width="0.1524" layer="91" />
                <label x="259.68" y="180.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C4" gate="G$1" pin="1" />
                <wire x1="274.92" y1="80.0" x2="259.68" y2="80.0" width="0.1524" layer="91" />
                <label x="259.68" y="80.0" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="C5" gate="G$1" pin="PLUS" />
                <wire x1="274.92" y1="55.0" x2="259.68" y2="55.0" width="0.1524" layer="91" />
                <label x="259.68" y="55.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="DEVKIT_5V_VERIFY" class="0">
              <segment>
                <pinref part="JP1" gate="G$1" pin="2" />
                <wire x1="59.92" y1="152.46" x2="44.68" y2="152.46" width="0.1524" layer="91" />
                <label x="44.68" y="152.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO14" class="0">
              <segment>
                <pinref part="U2" gate="G$1" pin="1A" />
                <wire x1="164.92" y1="242.46" x2="149.67999999999998" y2="242.46" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="242.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R4" gate="G$1" pin="1" />
                <wire x1="164.92" y1="150.0" x2="149.67999999999998" y2="150.0" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="150.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="RGB_BUFFERED" class="0">
              <segment>
                <pinref part="U2" gate="G$1" pin="1Y" />
                <wire x1="164.92" y1="239.92" x2="149.67999999999998" y2="239.92" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="239.92" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R6" gate="G$1" pin="1" />
                <wire x1="164.92" y1="100.0" x2="149.67999999999998" y2="100.0" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="100.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO9" class="0">
              <segment>
                <pinref part="U2" gate="G$1" pin="2A" />
                <wire x1="164.92" y1="234.84" x2="149.67999999999998" y2="234.84" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="234.84" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R5" gate="G$1" pin="1" />
                <wire x1="164.92" y1="125.0" x2="149.67999999999998" y2="125.0" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="125.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="SERVO_BUFFERED" class="0">
              <segment>
                <pinref part="U2" gate="G$1" pin="2Y" />
                <wire x1="164.92" y1="232.3" x2="149.67999999999998" y2="232.3" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="232.3" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R7" gate="G$1" pin="1" />
                <wire x1="164.92" y1="75.0" x2="149.67999999999998" y2="75.0" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="75.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="RGB_DIN" class="0">
              <segment>
                <pinref part="R6" gate="G$1" pin="2" />
                <wire x1="164.92" y1="97.46" x2="149.67999999999998" y2="97.46" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="97.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J11" gate="G$1" pin="DIN" />
                <wire x1="274.92" y1="242.46" x2="259.68" y2="242.46" width="0.1524" layer="91" />
                <label x="259.68" y="242.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="SERVO_SIGNAL" class="0">
              <segment>
                <pinref part="R7" gate="G$1" pin="2" />
                <wire x1="164.92" y1="72.46" x2="149.67999999999998" y2="72.46" width="0.1524" layer="91" />
                <label x="149.67999999999998" y="72.46" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J12" gate="G$1" pin="SIGNAL" />
                <wire x1="274.92" y1="215.0" x2="259.68" y2="215.0" width="0.1524" layer="91" />
                <label x="259.68" y="215.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO17" class="0">
              <segment>
                <pinref part="J13" gate="G$1" pin="TX" />
                <wire x1="274.92" y1="174.92" x2="259.68" y2="174.92" width="0.1524" layer="91" />
                <label x="259.68" y="174.92" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="DFPLAYER_RX" class="0">
              <segment>
                <pinref part="J13" gate="G$1" pin="RX" />
                <wire x1="274.92" y1="172.38" x2="259.68" y2="172.38" width="0.1524" layer="91" />
                <label x="259.68" y="172.38" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="R8" gate="G$1" pin="2" />
                <wire x1="274.92" y1="137.46" x2="259.68" y2="137.46" width="0.1524" layer="91" />
                <label x="259.68" y="137.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="SPK1" class="0">
              <segment>
                <pinref part="J13" gate="G$1" pin="SPK1" />
                <wire x1="274.92" y1="169.84" x2="259.68" y2="169.84" width="0.1524" layer="91" />
                <label x="259.68" y="169.84" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J14" gate="G$1" pin="1" />
                <wire x1="274.92" y1="110.0" x2="259.68" y2="110.0" width="0.1524" layer="91" />
                <label x="259.68" y="110.0" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="SPK2" class="0">
              <segment>
                <pinref part="J13" gate="G$1" pin="SPK2" />
                <wire x1="274.92" y1="167.3" x2="259.68" y2="167.3" width="0.1524" layer="91" />
                <label x="259.68" y="167.3" size="1.27" layer="95" />
              </segment>
              <segment>
                <pinref part="J14" gate="G$1" pin="2" />
                <wire x1="274.92" y1="107.46" x2="259.68" y2="107.46" width="0.1524" layer="91" />
                <label x="259.68" y="107.46" size="1.27" layer="95" />
              </segment>
            </net>
            <net name="IO18" class="0">
              <segment>
                <pinref part="R8" gate="G$1" pin="1" />
                <wire x1="274.92" y1="140.0" x2="259.68" y2="140.0" width="0.1524" layer="91" />
                <label x="259.68" y="140.0" size="1.27" layer="95" />
              </segment>
            </net>
          </nets>
        </sheet>
      </sheets>
      <errors />
    </schematic>
  </drawing>
</eagle>