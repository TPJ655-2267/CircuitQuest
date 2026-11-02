"""Generate a logical EAGLE/Fusion schematic draft, connectivity CSV and SVG preview.
No PCB footprints are assigned: verify actual boards before board conversion.
"""
from pathlib import Path
import csv
import xml.etree.ElementTree as E
from html import escape

ROOT = Path(__file__).resolve().parent
blocks = []

def block(sheet, ref, value, x, y, pins):
    blocks.append(dict(sheet=sheet, ref=ref, value=value, x=x, y=y, pins=pins))

gpio = [1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,38,39,40,41,42,47,48]
block(1,'U1','ESP32-S3 DEVKIT / HEADER MAPPING UNVERIFIED',65,245,
      [('3V3_OUT','V3V3'),('GND','GND'),('5VIN_VERIFY','DEVKIT_5V_VERIFY')]+
      [(f'GPIO{p}',f'IO{p}') for p in gpio])
block(1,'J1','OLED / cable order to verify',160,245,[('VCC','V3V3'),('GND','GND'),('SDA','IO8'),('SCL','IO47')])
block(1,'J2','VL53L0X / cable order to verify',160,215,[('VCC','V3V3'),('GND','GND'),('SDA','IO8'),('SCL','IO47')])
block(1,'J3','MPU6500 / ID 0x70',160,185,[('VCC','V3V3'),('GND','GND'),('SDA','IO8'),('SCL','IO47')])
block(1,'J4','KEYPAD 4x3',160,155,[(f'R{i+1}',f'IO{p}') for i,p in enumerate([1,2,5,6])]+[(f'C{i+1}',f'IO{p}') for i,p in enumerate([7,21,38])])
block(1,'J5','EC11 / label contacts by function',160,110,[('A','IO15'),('COMMON','GND'),('B','IO16'),('SW1','IO4'),('SW2','GND')])
block(1,'J6','RESET BUTTON / normally open',160,75,[('CONTACT1','IO13'),('CONTACT2','GND')])
block(1,'J7','WIRING A / isolated terminals',270,245,[('A1','IO39'),('A2','IO40'),('A3','IO41')])
block(1,'J8','WIRING B / isolated terminals',270,215,[('B1','IO42'),('B2','IO10'),('B3','IO11')])
block(1,'J9','RC522 / PROPOSED / firmware pending',270,180,[('SDA_SS','IO48'),('SCK','IO12'),('MOSI','IO19'),('MISO','IO20'),('IRQ_NC',None),('GND','GND'),('RST','RFID_RST'),('3V3','V3V3')])
block(1,'R1','10k / reader reset pull-up',270,135,[('1','V3V3'),('2','RFID_RST')])
block(1,'R2','10k / reader chip-select pull-up',270,110,[('1','V3V3'),('2','IO48')])
block(1,'R3','10k / reset-button pull-up',270,85,[('1','V3V3'),('2','IO13')])
block(2,'J10','REGULATED 5V INPUT / connector TBD',65,245,[('PLUS','EXT_5V'),('MINUS','GND')])
block(2,'F1','FUSE / rating TBD after load budget',65,215,[('IN','EXT_5V'),('OUT','FUSED_5V')])
block(2,'SW1','MAIN POWER / current rating TBD',65,185,[('IN','FUSED_5V'),('OUT','V5_MAIN')])
block(2,'JP1','OPEN: DO NOT BRIDGE until USB power reviewed',65,155,[('1','V5_MAIN'),('2','DEVKIT_5V_VERIFY')])
block(2,'C1','1000uF / >=10V / RGB bulk',65,120,[('PLUS','V5_MAIN'),('MINUS','GND')])
block(2,'C2','470uF / >=10V / servo bulk provisional',65,90,[('PLUS','V5_MAIN'),('MINUS','GND')])
block(2,'U2','SN74AHCT125 / 3V3 to 5V buffer',170,245,[('1OE_N','GND'),('1A','IO14'),('1Y','RGB_BUFFERED'),('2OE_N','GND'),('2A','IO9'),('2Y','SERVO_BUFFERED'),('GND','GND'),('3Y_NC',None),('3A','GND'),('3OE_N','V5_MAIN'),('4Y_NC',None),('4A','GND'),('4OE_N','V5_MAIN'),('VCC','V5_MAIN')])
block(2,'C3','100nF / at buffer supply pins',170,180,[('1','V5_MAIN'),('2','GND')])
block(2,'R4','10k / RGB boot pull-down',170,150,[('1','IO14'),('2','GND')])
block(2,'R5','10k / servo boot pull-down',170,125,[('1','IO9'),('2','GND')])
block(2,'R6','330 ohm / at ring data input',170,100,[('1','RGB_BUFFERED'),('2','RGB_DIN')])
block(2,'R7','220 ohm / servo signal series',170,75,[('1','SERVO_BUFFERED'),('2','SERVO_SIGNAL')])
block(2,'J11','RGB RING / 12 LEDs',280,245,[('5V','V5_MAIN'),('DIN','RGB_DIN'),('GND','GND')])
block(2,'J12','SERVO / plug polarity to verify',280,215,[('SIGNAL','SERVO_SIGNAL'),('5V','V5_MAIN'),('GND','GND')])
block(2,'J13','DFPLAYER / 5V final supply',280,180,[('VCC','V5_MAIN'),('GND','GND'),('TX','IO17'),('RX','DFPLAYER_RX'),('SPK1','SPK1'),('SPK2','SPK2')])
block(2,'R8','680 ohm / ESP TX to DF RX',280,140,[('1','IO18'),('2','DFPLAYER_RX')])
block(2,'J14','SPEAKER / neither lead to GND',280,110,[('1','SPK1'),('2','SPK2')])
block(2,'C4','100nF / near DFPlayer VCC',280,80,[('1','V5_MAIN'),('2','GND')])
block(2,'C5','100uF / >=10V / near DFPlayer',280,55,[('PLUS','V5_MAIN'),('MINUS','GND')])

root=E.Element('eagle',version='9.6.2')
drawing=E.SubElement(root,'drawing')
settings=E.SubElement(drawing,'settings')
E.SubElement(settings,'setting',alwaysvectorfont='no')
E.SubElement(settings,'setting',verticaltext='up')
E.SubElement(drawing,'grid',distance='0.1',unitdist='inch',unit='inch',style='lines',multiple='1',display='no',altdistance='0.01',altunitdist='inch',altunit='inch')
layers=E.SubElement(drawing,'layers')
for n,name,color in [(91,'Nets',2),(92,'Busses',1),(93,'Pins',2),(94,'Symbols',4),(95,'Names',7),(96,'Values',7),(97,'Info',7),(98,'Guide',6)]:
    E.SubElement(layers,'layer',number=str(n),name=name,color=str(color),fill='1',visible='yes',active='yes')
sch=E.SubElement(drawing,'schematic',xreflabel='%F%N/%S.%C%R',xrefpart='/%S.%C%R')
E.SubElement(sch,'description').text='CircuitQuest logical draft. Not fabrication ready. Footprints and ESP32 header pad mapping unassigned.'
libs=E.SubElement(sch,'libraries');lib=E.SubElement(libs,'library',name='CircuitQuest_Draft')
E.SubElement(lib,'packages');symbols=E.SubElement(lib,'symbols');sets=E.SubElement(lib,'devicesets')
for b in blocks:
    name='BLOCK_'+b['ref'];sym=E.SubElement(symbols,'symbol',name=name)
    height=max(10.16,(len(b['pins'])+1)*2.54)
    for x1,y1,x2,y2 in [(0,2.54,50.8,2.54),(50.8,2.54,50.8,-height),(50.8,-height,0,-height),(0,-height,0,2.54)]:
        E.SubElement(sym,'wire',x1=str(x1),y1=str(y1),x2=str(x2),y2=str(y2),width='0.254',layer='94')
    E.SubElement(sym,'text',x='0',y='5.08',size='1.778',layer='95').text='>NAME'
    # Values are placed separately as smaller readable annotations.
    for i,(pin,net) in enumerate(b['pins']):
        E.SubElement(sym,'pin',name=pin,x='-5.08',y=str(-i*2.54),visible='pin',length='short',direction='pas')
    ds=E.SubElement(sets,'deviceset',name=name,prefix=b['ref'].rstrip('0123456789'),uservalue='yes')
    gates=E.SubElement(ds,'gates');E.SubElement(gates,'gate',name='G$1',symbol=name,x='0',y='0')
    devices=E.SubElement(ds,'devices');dev=E.SubElement(devices,'device',name='')
    techs=E.SubElement(dev,'technologies');E.SubElement(techs,'technology',name='')
E.SubElement(sch,'attributes');E.SubElement(sch,'variantdefs')
classes=E.SubElement(sch,'classes');E.SubElement(classes,'class',number='0',name='default',width='0',drill='0')
parts=E.SubElement(sch,'parts')
for b in blocks:E.SubElement(parts,'part',name=b['ref'],library='CircuitQuest_Draft',deviceset='BLOCK_'+b['ref'],device='',value=b['value'])
sheets=E.SubElement(sch,'sheets')
notes={1:['CIRCUITQUEST - CONTROLLER AND MODULE CONNECTORS - DRAFT A',
 'Logical symbols only. NO ESP32 socket pad mapping or PCB footprints assigned.',
 'RFID SPI proposal: SCK12 / MOSI19 / MISO20 / CS48. Use UART USB; native USB unavailable.',
 'RFID RST pulled HIGH; firmware must use software reset. GPIO48 onboard LED loading to verify.',
 'Cable pin orders are proposed harness functions, NOT verified module connector footprints.',
 'Shared I2C: verify breakout pull-ups, voltage and onboard regulators before finalizing.',
 'Only connect wiring terminals A1-B1, A2-B2, A3-B3. Never apply external power to terminals.'],
2:['CIRCUITQUEST - POWER AND OUTPUT DRIVERS - DRAFT A',
 'Use regulated external 5V. Fuse/switch/connector ratings require servo model and current budget.',
 'JP1 MUST STAY OPEN. For this draft power ESP32 via USB; external 5V powers output loads.',
 'Do not connect external 5V to the devkit until USB backfeed / power-path design is reviewed.',
 'V3V3 comes from devkit. Regulator capacity for OLED + ToF + IMU + RFID must be verified.',
 'U2 unused channels disabled. Unconnected pins are marked NC. All grounds share one net.',
 'These logical symbols intentionally have NO package; choose verified library devices before PCB.']}
for page in [1,2]:
    sheet=E.SubElement(sheets,'sheet');E.SubElement(sheet,'description').text=notes[page][0]
    plain=E.SubElement(sheet,'plain')
    for i,note in enumerate(notes[page]):E.SubElement(plain,'text',x='10',y=str(290-i*5),size='1.778' if i else '2.54',layer='97').text=note
    instances=E.SubElement(sheet,'instances');E.SubElement(sheet,'busses');nets=E.SubElement(sheet,'nets');netnodes={}
    for b in [b for b in blocks if b['sheet']==page]:
        E.SubElement(instances,'instance',part=b['ref'],gate='G$1',x=str(b['x']),y=str(b['y']),smashed='no')
        E.SubElement(plain,'text',x=str(b['x']),y=str(b['y']+9),size='1.27',layer='97').text=b['value']
        for i,(pin,net) in enumerate(b['pins']):
            x=b['x']-5.08;y=b['y']-i*2.54
            if net is None:
                E.SubElement(plain,'text',x=str(x-8),y=str(y),size='1.27',layer='97').text='NC'
                continue
            if net not in netnodes:netnodes[net]=E.SubElement(nets,'net',name=net,**{'class':'0'})
            seg=E.SubElement(netnodes[net],'segment')
            E.SubElement(seg,'pinref',part=b['ref'],gate='G$1',pin=pin)
            E.SubElement(seg,'wire',x1=str(x),y1=str(y),x2=str(x-15.24),y2=str(y),width='0.1524',layer='91')
            E.SubElement(seg,'label',x=str(x-15.24),y=str(y),size='1.27',layer='95')
E.SubElement(sch,'errors')
E.indent(root)
(ROOT/'CircuitQuest_Draft.sch').write_text('<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE eagle SYSTEM "eagle.dtd">\n'+E.tostring(root,encoding='unicode'),encoding='utf-8')
with (ROOT/'connections.csv').open('w',newline='',encoding='utf-8') as f:
    writer=csv.writer(f);writer.writerow(['sheet','reference','description','logical_pin','net'])
    for b in blocks:
        for pin,net in b['pins']:writer.writerow([b['sheet'],b['ref'],b['value'],pin,net or 'NC'])
# Vector preview uses the same source connectivity as the .sch; it is not a CAD screenshot.
svg=['<svg xmlns="http://www.w3.org/2000/svg" width="1500" height="2400" viewBox="0 0 1500 2400"><rect width="1500" height="2400" fill="white"/>']
for page in [1,2]:
    base=(page-1)*1200
    for i,note in enumerate(notes[page]):svg.append(f'<text x="25" y="{base+30+i*18}" font-family="sans-serif" font-size="{16 if i==0 else 11}">{escape(note)}</text>')
    for b in [b for b in blocks if b['sheet']==page]:
        x=b['x']*4;y=base+(300-b['y'])*4;h=max(36,len(b['pins'])*10.16+12)
        svg.append(f'<rect x="{x}" y="{y}" width="200" height="{h}" fill="#f6f9fc" stroke="#35465c"/><text x="{x}" y="{y-18}" font-size="12" font-family="sans-serif">{escape(b["ref"]+": "+b["value"])}</text>')
        for i,(pin,net) in enumerate(b['pins']):
            py=y+14+i*10.16
            svg.append(f'<text x="{x+6}" y="{py}" font-size="9" font-family="monospace">{escape(pin)}</text><line x1="{x-55}" y1="{py-3}" x2="{x}" y2="{py-3}" stroke="#19713a"/><text x="{x-58}" y="{py-5}" text-anchor="end" font-size="8" font-family="monospace">{escape(net or "NC")}</text>')
svg.append('</svg>');(ROOT/'CircuitQuest_preview.svg').write_text('\n'.join(svg),encoding='utf-8')
print(f'Generated logical draft: {len(blocks)} components, 2 sheets.')
