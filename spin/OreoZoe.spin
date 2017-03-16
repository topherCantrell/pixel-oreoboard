CON
  _clkmode        = xtal1 + pll16x
  _xinfreq        = 5_000_000

{{
           
}}

CON
    PIN_D1 = 0
    PIN_D2 = 1
    PIN_D3 = 2
    PIN_D4 = 3

OBJ    
    
    NEOStrip : "NeoPixelStrip"
    ZOEProc  : "ZoeProcessor"
    PST      : "Parallax Serial Terminal"          

PUB Main

  ' Go ahead and drive the pixel plate data line low. The driver
  ' will too, but it might be a little while before it gets called.
  ' If we wait then the first pixel will show random data.
  dira[PIN_D1] := 1
  outa[PIN_D1] := 0
  dira[PIN_D2] := 1
  outa[PIN_D2] := 0
  dira[PIN_D3] := 1
  outa[PIN_D3] := 0

  ZOEProc.init(@zoetest)



DAT

zoetest

config
  byte 0      ' DD (pin number)
  byte 8*8*3  ' LL number of pixels
  byte 24     ' WW hasWhite
  byte 8      ' Number of variables max 256 (256 bytes)

eventInput ' Text input (null terminated). First byte is trigger.
  long 0,0,0,0,0,0,0,0

palette  ' 64 longs (64 colors)
  long 0,$05_05_05_05,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

patterns ' 16 pointers
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

callstack ' 32 pointers
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0     

variables ' Variable storage (2 bytes each)
  word 0,0,0,0,0,0,0,0

pixbuffer ' 1 byte per pixel
  byte 0,1,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

events
  byte "INIT",0
  word @initHandler
  '
  byte 0  ' End of list

initHandler
  byte 1 ' Test command





  




  


 