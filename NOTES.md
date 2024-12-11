# Goals

- Enable a modern Linux box to run the Helios Server, and attach (via
  USB-based host adaptor?) to a Transputer network
  - Start with the SUN4 build, and create a LINUX build

- Port Helios to a readily-available platform
  - But what makes sense?
    - Multi-core amd64?
    - Raspberry PiZero?
    - RP2040?
    - XMOS XCORE200?
  - And what makes sense for the inter-processor communication?
    - Could use C011-style bus?
    - SPI / I2C / something?
      - Too slow?
    - Interlaken (lol?)
    - PCIe?
    - USB?

- If we're using a standard multi-core CPU, the inter-processor links
  could just be shared-memory.
  - This would allow you to use pretty much any topology you like too
  


# Original Authors

al
alan
bart      aka BLV    Bart Veer (Perihelion, 1990-1991)
ben
brian                Brian Knight (Active Book Company, 1989-1990)
charles
chris     aka CS     Chris Selwyn (1988)
craig
eggert
martyn    aka MJT    Martyn Tovey (:Perihelion 1991-1992)
mgun                 Mike Gunning
nick      aka NHG    Nick Garnett (Perihelion, 1991-1993)
nickc     aka NC     Nick Clifton (Perihelion, 1991-1994)
????                 Nick Reeves  (Active Book Company, 1989)
paul      aka PAB    Paul A Beskeen (Perihelion, 1986-1996)
richardp
rnovak               Robert E Novak (Pyramid/MIPS 1986-1987
tony
vlsi
                     Andy England  (Perihelion, 1988)
		     John Grogan  (Active Book Company, 1990-1991)
jsmith		     James G Smith  (Active Book Company, 1990-1994)


JS
TJK
NJOC (aka nickc?)
DJCH (Bath University
ACE  Perihelion, 1990

lsmith
hmeekings
lee
crf 

C. Fleischer (Parsytec?, 1989-1990)
Gordian Jodlauk (Parsytec? 1990)
Oliver Reins (Telmat Informatique)
Tim Dobson (1986)
Jon G Thackray (1986) 
Alex Schuilenburg  (Perihelion, 1994)
Martin Porter (1988)
Tony Cruickshank (1989)
A Ishan (988)
H J Ermen
M Claus
Christopher A Kent
Mike Burrow
S A Wilson  CSIR - MIKOMTEK, 1990

## Third Party?
Mike Olson
Margo Seltzer
Richard Evans
Reinhold P Weicker
Tony Andrews
Steven Pemberton
John Ffitch
Spencer W Thomas
Curtis Smith
