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
    PRG      : "ProgramData"     

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
    
  ZOEProc.init(PRG.getProgram)
'  ZOEProc.init(@zoetest) 



