pub getProgram
  return @zoeProgram

DAT
zoeProgram

'config
  byte 13
  byte 22
  byte 24
  byte 0

'eventInput
  byte 1, "INIT",0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0

'palette  ' 64 longs (64 colors)
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  long 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

'patterns ' 16 pointers
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

'callstack ' 32 pointers
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

'variables ' Variable storage (2 bytes each)

'pixbuffer ' 1 byte per pixel
  byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

'events
  byte "INIT",0, $00,$08
  byte $FF

'INIT_handler
  '      configure (out=D3, length=22, hasWhite=false)
  byte $09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 ' 	  defineColor(color=0,   W=0, R=0,   G=0,   B=0)  	
  byte $09,$00,$01,$00,$00,$00,$00,$00,$00,$00,$0A ' 	  defineColor(color=1,   W=0, R=0,  G=0,   B=10)
  byte $0A,$00,$00 ' 	  solid(color=0)
  byte $02,$00,$02,$00,$01 ' 	  set(pixel=2,color=1)
  'HERE:
  byte $01,$03,$E8 ' 	  pause(time=1000)
  byte $03,$FF,$FA ' 	  goto(here)
  byte $08 '   }

