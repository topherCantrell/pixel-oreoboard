CON
  _clkmode        = xtal1 + pll16x
  _xinfreq        = 5_000_000

{{
           
}}

CON
    PIN_D1 = 15
    PIN_D2 = 14
    PIN_D3 = 13
    PIN_D4 = 12

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
  byte 15      ' DD (pin number)
  byte 8*8*3  ' LL number of pixels
  byte 24     ' WW hasWhite
  byte 8      ' Number of variables max 256 (256 bytes)

eventInput ' Text input (null terminated). 32 bytes. First byte is trigger.
  byte 1, "INIT",0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0

palette  ' 64 longs (64 colors)
  long 0,0,$00_0F_00_00,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

patterns ' 16 pointers
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

callstack ' 32 pointers
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0     

variables ' Variable storage (2 bytes each)
  byte 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0

pixbuffer ' 1 byte per pixel
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1

events
  byte "INIT",0, $00,$08 ' At startup (8 bytes from start of event table)
  byte $FF  ' End of list

initHandler
    
  byte $0B, 0,3,3,  1,0,1,  0,1,0,  0,1,0 ' PATTERN(num=0,width=3,height=3, ...)

  byte $0C, 0,0, 0,7,  0,4, 0,1  ' DRAWPATTERN(num=0,x=2,y=4,coffset=0)

          '      WHITE  GREEN   RED    BLUE
  byte 9, 00,01, 00,00, 00,00,  00,00, 00,15 ' DEFCOLOR(color=1,white=0,green=0,red=0,blue=15)

  byte 4, 2, 00,23                   ' SET(variable=2, value=5)

  byte 4, 3, 00,00                   ' [3] = 0
  byte 7 , 00,$0A                    ' GOSUB
  byte 4, 3, 00,01                   ' [3] = 1
  byte 7 , 00,$03                     ' GOSUB
  
  byte 3, $FF, $EF                   ' GOTO -17

    
  byte 2, $80,03,   0,1              ' Set [03],1
  byte 1, $03, $E8                   ' Pause 1000
  byte 2, $80,03,   0,0              ' Set [03],0
  byte 1, $03, $E8                   ' Pause 1000
  byte 8                             ' RTS
                                                         