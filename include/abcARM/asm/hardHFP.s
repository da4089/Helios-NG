        SUBT    AB Functional Prototype hardware description > hardHFP/s
        ; Copyright (c) 1990, Active Book Company, Cambridge, United Kingdom.
        ; ---------------------------------------------------------------------
        ; Hardware description of the AB1 functional prototype
        ;
        ; started:      900801  JGSmith
        ; modified:     901115  BJKnight  Added MicroLink interface manifests
        ;
        ; This file describes the memory layout of the Hercules evaluation
        ; board Rev 0.0
        ;
        ; ---------------------------------------------------------------------

old_opt SETA    {OPT}
        OPT     (opt_off)

        ; ---------------------------------------------------------------------

        !       0,"Including hardHFP.s"
                GBLL    hardHFP_s
hardHFP_s       SETL    {TRUE}
        ASSERT  (basic_s)       ; ensure "basic.s" has been included

        ; ---------------------------------------------------------------------
        ; The following are used for indices into the memory map

zeromeg         *       (0 :SHL: 20)    ; 0MB value
twomeg          *       (2 :SHL: 20)    ; 2MB value
fourmeg         *       (4 :SHL: 20)    ; 4MB value
sixmeg          *       (6 :SHL: 20)    ; 6MB value
eightmeg        *       (8 :SHL: 20)    ; 8MB value 

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; Memory map
SRAM_base       *       &00000000       ;   0MB ; 512bytes of static RAM
MMU_base        *       &00200000       ;   2MB ; Memory Management Unit
DMA_base        *       &00300000       ;   3MB ; Direct Memory Access regs
IO_base         *       &00400000       ;   4MB ; on-chip IO devices
EXTIO1_base     *       &00800000       ;   8MB ; bank 1 of external IO devices
EXTIO2_base     *       &00C00000       ;  12MB ; bank 2 of external IO devices
EXTRAM1_base    *       &01000000       ;  16MB ; external RAM bank 1
EXTRAM2_base    *       &01800000       ;  24MB ; external RAM bank 2
RAM_base        *       &02000000       ;  32MB ; physical RAM
RAM1_base       *       &02000000       ;  32MB ; RAM bank 1
RAM2_base       *       &02800000       ;  40MB ; RAM bank 2
ROM_base        *       &03000000       ;  48MB ; physical ROM
ROM1_base       *       &03000000       ;  48MB ; ROM bank 1
ROM2_base       *       &03800000       ;  56MB ; ROM bank 2

        ; ---------------------------------------------------------------------
	; The Hercules processor currently has a fixed amount of internal
	; Fast Static RAM

SRAM_size	*	512 		; byte (128 words)

        ; ---------------------------------------------------------------------

ROM_size        *       (512 :SHL: 10)  ; Size of ROM in HEVAL boards

        [       {TRUE}
        ; The initial Active Book (with Hercules-1) will support a single
        ; external CARD (mapped into the RAM2 address space). Future Active
        ; Books (with the next-Hercules) will support two external CARDs
        ; (mapped into EXTMEM1 and EXTMEM2 respectively).

CARD_size       *       (8 :SHL: 20)    ; CARD slots are 8MBytes wide
CARD_limit      *       1               ; using Hercules-1
CARD1_base      *       RAM2_base       ; on Active Books
        ]

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; IO controllers
MEMMAP_regs     *       IO_base + &000000       ; System configuration
CLOCK_regs      *       IO_base + &020000       ; HW Clock registers
BANK_regs       *       IO_base + &040000       ; HW external timing registers
INT_regs        *       IO_base + &080000       ; Interrupt registers
DMA_regs        *       IO_base + &0C0000       ; DMA registers
TIMER_regs      *       IO_base + &100000       ; Timer registers
LCD_regs        *       IO_base + &140000       ; LCD registers
CODEC_regs      *       IO_base + &180000       ; CODEC registers
MLI_regs        *       IO_base + &1C0000       ; MicroLink registers

LINK0_base      *       EXTIO1_base + &000000   ; Link adaptor
LED_base        *       EXTRAM1_base + &000000  ; 8 LEDs (d8..d15)

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; Mapping register (MEMMAP_regs)        WRITE ONLY
        ; This register is reset to all zeroes by power on reset (POR)
        ;
        ;  bit      2        1        0
        ;       +--------+--------+--------+
        ;       | MAPEN  | OSMODE |  MODE  |
        ;       +--------+--------+--------+
        ;
MAPEN_PHYS      *       2_000           ; physical map forced by USR mode
MAPEN_USR       *       2_100           ; USR mode map
USR_MODE0       *       2_000           ; User mode 0; no ROM/RAM above 32MB
USR_MODE1       *       2_001           ; User mode 1; ROM re above 48MB
OS_MODE0        *       2_010           ; OS mode 0; ROM/RAM re above 32MB
OS_MODE1        *       2_011           ; OS mode 1; ROM/RAM rwe above 32MB

        ; ---------------------------------------------------------------------
        ; segment mapping registers
MMU_basemask    *       &0001FFFF       ; physical page base field [A25:9]
MMU_baseshift   *       0               ; left shift to align base field
MMU_limitmask   *       &1FFE0000       ; page limit field [A20:9]
MMU_limitshift  *       17              ; left shift to align limit field
MMU_mapup       *       &00000000       ; ascending segment
MMU_mapdown     *       &20000000       ; descending segment
MMU_mapRWE      *       &00000000       ; read/write/execute access
MMU_mapRE       *       &40000000       ; read/execute access
MMU_mapR        *       &80000000       ; read access
MMU_mapNONE     *       &C0000000       ; no access

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; Mapping register (CLOCK_regs)         WRITE ONLY
        ; All bits except GCODER are reset to zero by power on reset
        ; First write to this register clears the POR interrupt flag
        
GCODER_ON       *       (1 :SHL: 7)     ; enable gray-coding of ROM/RAM
TTEST_ON        *       (1 :SHL: 6)     ; timer test (always set to 0)
CTEST_ON        *       (1 :SHL: 5)     ; codec test (always set to 0)
CPU_OFF         *       (1 :SHL: 4)     ; halt ARM on next opcode fetch
NSYSCK_OFF      *       (1 :SHL: 3)     ; disable external sync clock
CLOCKS_OFF      *       (2_000)         ; all clock prescalers off (zero power)
CODEC_ON        *       (2_100)         ; CODEC clock prescaler enabled
TIMER_ON        *       (2_010)         ; CODEC and TIMER clock prescalers
MLI_ON          *       (2_001)         ; CODEC, TIMER and MLI clock prescalers

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; External BUS Interface (BANK_regs)

                ^       &00
BANK0_reg       #       word            ; EXTIO1 bank   (&00800000->&00BFFFFF)
BANK1_reg       #       word            ; EXTIO2 bank   (&00C00000->&00FFFFFF)
BANK2_reg       #       word            ; EXTMEM1 bank  (&01000000->&017FFFFF)
BANK3_reg       #       word            ; EXTMEM2 bank  (&01800000->&01FFFFFF)
BANK4_reg       #       word            ; RAM1 bank     (&02000000->&027FFFFF)
BANK5_reg       #       word            ; RAM2 bank     (&02800000->&02FFFFFF)
BANK6_reg       #       word            ; ROM1 bank     (&03000000->&037FFFFF)
BANK7_reg       #       word            ; ROM2 bank     (&03800000->&03FFFFFF)

        ; NOTE: ROM1 is visible at physical address &00000000 during reset.
        ;       These registers may only be written from priviledged mode.

        ; BUS timing
BANK_T1_4       *       2_00000000      ; bus phase 1 4 system clock periods
BANK_T1_2       *       2_00000100      ; bus phase 1 2 system clock periods
BANK_T1_1       *       2_00001000      ; bus phase 1 1 system clock periods
BANK_T1_0       *       2_00001100      ; bus phase 1 0 system clock periods

BANK_T2_4       *       2_00000000      ; bus phase 2 4 system clock periods
BANK_T2_2       *       2_00000001      ; bus phase 2 2 system clock periods
BANK_T2_1       *       2_00000010      ; bus phase 2 1 system clock periods
BANK_T2_0       *       2_00000011      ; bus phase 2 0 system clock periods

BANK_PC         *       2_00000000      ; pre-charge phase (1 SCP)
BANK_NOPC       *       2_00010000      ; NO pre-charge phase

        ; BUS mode (for ROM banks)
BANK_ROMMODE0   *       2_00000000      ; chip-select, strobed interface
BANK_ROMMODE1   *       2_00100000      ; read and write strobed interface

        ; BUS mode (for RAM banks)
BANK_RAMMODE0   *       2_00000000      ; SRAM interface
BANK_RAMMODE1   *       2_00100000      ; DRAM interface

        ; BUS width
BANK_W0         *       2_00000000      ; undefined
BANK_WMASK      *       2_11000000      ; mask value

BANK_W8         *       2_01000000      ; 8bit (byte)
BANK_W16        *       2_10000000      ; 16bit (halfword)
BANK_W32        *       2_11000000      ; 32bit (word)

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; DMA control/status registers (DMA_regs)

			^	&00		; offset from DMA_regs
DMA_routing		#	&00		; control (WRITE ONLY)
DMA_status		#	&04		; status (READ ONLY)

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; DMA routing register (DMA_routing)	WRITE ONLY
        ; This register is reset to all zeroes by power on reset

	; generic values for channels 1 2 and 3
DMAchan_off             *       2_000000000     ; channel 1 off
DMAchan_codecRX         *       2_000000001     ; CODEX RX  (channel 1 only)
DMAchan_codecTX         *       2_000000001     ; CODEX TX  (channel 2 only)
DMAchan_TEST            *       2_000000001     ; TEST MODE (channel 3 only)
DMAchan_MLIRX           *       2_000000010     ; MLI RX
DMAchan_MLITX           *       2_000000011     ; MLI TX
DMAchan_EXTA            *       2_000000100     ; external channel A
DMAchan_EXTB            *       2_000000101     ; external channel B
DMAchan_EXTC            *       2_000000110     ; external channel C
DMAchan_EXTD            *       2_000000111     ; external channel D

        ; channel 1 (high priority)
DMAchan1_off            *       2_000000000     ; channel 1 off
DMAchan1_codecRX        *       2_000000001     ; CODEX RX
DMAchan1_MLIRX          *       2_000000010     ; MLI RX
DMAchan1_MLITX          *       2_000000011     ; MLI TX
DMAchan1_EXTA           *       2_000000100     ; external channel A
DMAchan1_EXTB           *       2_000000101     ; external channel B
DMAchan1_EXTC           *       2_000000110     ; external channel C
DMAchan1_EXTD           *       2_000000111     ; external channel D

        ; channel 2 (medium priority)
DMAchan2_off            *       2_000000000     ; channel 1 off
DMAchan2_codecTX        *       2_000001000     ; CODEX TX
DMAchan2_MLIRX          *       2_000010000     ; MLI RX
DMAchan2_MLITX          *       2_000011000     ; MLI TX
DMAchan2_EXTA           *       2_000100000     ; external channel A
DMAchan2_EXTB           *       2_000101000     ; external channel B
DMAchan2_EXTC           *       2_000110000     ; external channel C
DMAchan2_EXTD           *       2_000111000     ; external channel D

        ; channel 3 (low priority)
DMAchan3_off            *       2_000000000
DMAchan3_TEST           *       2_001000000     ; TEST MODE
DMAchan3_MLIRX          *       2_010000000     ; MLI RX
DMAchan3_MLITX          *       2_011000000     ; MLI TX
DMAchan3_EXTA           *       2_100000000     ; external channel A
DMAchan3_EXTB           *       2_101000000     ; external channel B
DMAchan3_EXTC           *       2_110000000     ; external channel C
DMAchan3_EXTD           *       2_111000000     ; external channel D

DMAchannel_maximum	*	(3)		; maximum DMA channel number

	; ---------------------------------------------------------------------
        ; DMA status register (DMA_regs)        READ ONLY
        ; channel 1  => bits [2:0]
        ; channel 2  => bits [5:3]
        ; channel 3  => bits [8:6]
        ; test flags => bits [11:9]

DMAstatus_buff          *       2_001   ; reflects current buffer number
DMAstatus_empty         *       2_010   ; buffer empty
DMAstatus_next          *       2_000   ; next buffer set
DMAstatus_overrun       *       2_110   ; overrun error, DMA disabled

        ; DMA subsystem
                ^       &00             ; offset from "DMA_base"
                ; DMA channel 0
LCDscreen_base0 #       word
LCDscreen_ptr0  #       word
LCDscreen_base1 #       word
LCDscreen_ptr1  #       word
                ; DMA channel 1
DMAchan1_b0src  #       word
DMAchan1_b0dest #       word
DMAchan1_b1src  #       word
DMAchan1_b1dest #       word
                ; DMA channel 2
DMAchan2_b0src  #       word
DMAchan2_b0dest #       word
DMAchan2_b1src  #       word
DMAchan2_b1dest #       word
                ; DMA channel 3
DMAchan3_b0src  #       word
DMAchan3_b0dest #       word
DMAchan3_b1src  #       word
DMAchan3_b1dest #       word

        ; Source (READ) DMA pointers
        ; bit    31                            6 5 4 3 2 1 0
        ;       +-------------------------------+-+-+-+-+-+-+
        ;       |            A[25:0]            |x|c|s|d|w|w|
        ;       +-------------------------------+-+-+-+-+-+-+
        ;
DMA_8bit        *       2_000001        ; 8bit transfers
DMA_16bit       *       2_000010        ; 16bit transfers
DMA_32bit       *       2_000011        ; 32bit transfers
DMA_inc_dest    *       2_000100        ; increment destination pointer
DMA_inc_src     *       2_001000        ; increment source pointer
DMA_inc_count   *       2_010000        ; increment transfer count
DMA_src_shift   *       6               ; shift for source address field

        ; Destination (WRITE) DMA pointers
        ; Note: since the transfer count is "incremented", the 2's complement
        ;       of the number of transfers required should be programmed.

        ; 8bit  A[25:0]
DMA8_xfer_mask  *       2_00111111      ; 8bit transfer count mask
        ; destination address should be shifted right 0 and then shifted left 6

        ; 16bit A[25:1]
DMA16_xfer_mask *       2_01111111      ; 16bit transfer count mask
        ; destination address should be shifted right 1 and then shifted left 7

        ; 32bit A[25:2]
DMA32_xfer_mask *       2_11111111      ; 32bit transfer count mask
        ; destination address should be shifted right 2 and then shifted left 8

        ; Dedicated LCD channel
DMALCD_xfer     *       2_0001011       ; all (source and destination)
        ; addresses should be shifted right 2 and then shifted left 8

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; Interrupt subsystem Status Register (INT_regs)        READ ONLY
        ; All flags are cleared to zero by power on reset.

                ^       &00
INT_status      #       word            ; Interrupt status/test register
FIQ_control     #       word            ; FIQ Mask/Request register
IRQ_control     #       word            ; IRQ Mask/Request register

        ; ---------------------------------------------------------------------
        ; Status register (INT_status)                  READ ONLY
        ; All flags are cleared to zero by power on reset.

INT_POR *       (1 :SHL: 14)    ; Power On Reset (write to "CLOCK_regs" clears)
INT_DB3 *       (1 :SHL: 13)    ; DMA channel 3 buffer service
INT_DB2 *       (1 :SHL: 12)    ; DMA channel 2 buffer service
INT_DB1 *       (1 :SHL: 11)    ; DMA channel 1 buffer service
INT_MBK *       (1 :SHL: 10)    ; MicroLink receive BREAK condition
INT_LCD *       (1 :SHL: 9)     ; LCD vertical sync.
INT_TIM *       (1 :SHL: 8)     ; Timer interrupt
INT_EXD *       (1 :SHL: 7)     ; External request D
INT_EXC *       (1 :SHL: 6)     ; External request C
INT_EXB *       (1 :SHL: 5)     ; External request B
INT_EXA *       (1 :SHL: 4)     ; External request A
INT_MTX *       (1 :SHL: 3)     ; MicroLink transmit data latch empty
INT_MRX *       (1 :SHL: 2)     ; MicroLink receive data latch full
INT_CTX *       (1 :SHL: 1)     ; CODEC transmit data latch empty
INT_CRX *       (1 :SHL: 0)     ; CODEC receive data latch full

        ; A WRITE ONLY TEST register occupies the same address. This register
        ; can be used to explicitly set and clear the interrupt service
        ; request flags.
        ; ---------------------------------------------------------------------
        ; FIQ Mask/Request register (FIQ_control)
        ; The bits are a subset of those in the "INT_status" register.
        ; The following manifests represent the allowable FIQ bits:
        ;       INT_EXD ; External request D
        ;       INT_EXC ; External request C
        ;       INT_EXB ; External request B
        ;       INT_EXA ; External request A
        ;       INT_MTX ; MicroLink transmit data latch empty
        ;       INT_MRX ; MicroLink receive data latch full
        ;       INT_CTX ; CODEC transmit data latch empty
        ;       INT_CRX ; CODEC receive data latch full

FIQ_set *       (1 :SHL: 15)
        ; WRITE - if set (1) then set the selected lo-order bits
        ;       - if clear (0) then clear the selected lo-order bits
        ; READ  - if set (1) then FIQ active, request bits are set

FIQ_sources     *       8
FIQ_allsources  *       2_0000000011111111

        ; ---------------------------------------------------------------------
        ; IRQ Mask/Request register (IRQ_control)
        ; All of the bits in "INT_status" are allowed.

IRQ_set *       (1 :SHL: 15)
        ; WRITE - if set (1) then set the selected lo-order bits
        ;       - if clear (0) then clear the selected lo-order bits
        ; READ  - if set (1) then IRQ active, request bits are set

IRQ_sources     *       14
IRQ_allsources  *       2_0011111111111111

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; Timer (TIMER_regs)
        ; All bits are cleared to zero by power on reset

                ^       &00
TIMER_count     #       null            ; READ ONLY
TIMER_control   #       word            ; WRITE ONLY
TIMER_countCLR  #       word            ; READ ONLY (clears interrupt)

TIMER_enable    *       (1 :SHL: 7)     ; timer enable (1) or disable (0)
TIMER_psn_mask  *       (2_00011111)    ; (xclk / (6 * (TIMER_psn + 1)))

TIMER_int_src   *       (1 :SHL: 10)    ; bit in "TIMER_count" used as
                                        ; interrupt source

TIMER_xclk      *       25344000        ; system clock in Hz
        ; NOTE: psn_value = ((TIMER_xclk / (xHz * 6 * 2048)) - 1)
        ;       where "psn_value" is the value to place into "TIMER_psn_mask"
        ;       and "xHz" is the desired interrupt frequency. The actual
        ;       "psn_value" may be fractional and may need to be rounded to
        ;       the nearest integer.
        ;
        ;       eg. 100Hz (10milli-second) interrupt required:
        ;               (TIMER_xclk / (100 * 6 * 2048)) - 1 = 19.625
        ;               rounded to 20 actually gives a frequency of
        ;               (TIMER_xclk / (6 * 2048 * (20 + 1))) == 98.2142857Hz
TIMER_multiplier        *       (6 * 2048)      ; useful manifest

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; CODEC


        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; MicroLink Interface (MLI_regs)

                ^       &00
MLI_RXD         #       word    ; (READ ONLY)   Receive data
MLI_TXD         *       MLI_RXD ; (WRITE ONLY)  Transmit data
MLI_STA         #       word    ; (READ ONLY)   Status
MLI_CON         *       MLI_STA ; (WRITE ONLY)  Control

        ; Bits in status register (MLI_STA)
MLI_ENF         *       (1 :SHL: 0)     ; link enabled
MLI_BIF         *       (1 :SHL: 1)     ; break packet received
MLI_RIF         *       (1 :SHL: 2)     ; rx interrupt pending
MLI_FRE         *       (1 :SHL: 3)     ; frame error
MLI_TIF         *       (1 :SHL: 4)     ; tx interrupt pending
MLI_TGD         *       (1 :SHL: 5)     ; currently transmitting data packet
MLI_TGA         *       (1 :SHL: 6)     ; currently transmitting ack packet
MLI_TGB         *       (1 :SHL: 7)     ; currently transmitting break packet

        ; Bits in control register (MLI_CON)
MLI_ENA         *       (1 :SHL: 0)     ; enable both receiver & transmitter
MLI_ICP         *       (1 :SHL: 1)     ; 1 => internal clock, 0 => external
        ; Bits 2-6 unused
MLI_TXB         *       (1 :SHL: 7)     ; send break packet then clear this bit

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; LCD (LCD_regs)

                ^       &00
LCD_control     #       null    ; WRITE ONLY
LCD_status      #       word    ; READ ONLY
LCD_linelength  #       null    ; WRITE ONLY
LCD_linestatus  #       word    ; READ ONLY
LCD_linerate    #       word    ; WRITE ONLY
LCD_numlines    #       word    ; WRITE ONLY
LCD_clrint      #       word    ; WRITE ONLY
LCD_clrovr      #       word    ; WRITE ONLY

                ^       &00020000
LCD_dataregA    #       word    ; WRITE ONLY
LCD_dataregB    #       word    ; WRITE ONLY

        ; LCD screen shape information
LCD_displaywidth        *       80              ; display width (in bytes)
LCD_planewidth          *       128             ; plane width (in bytes)
LCD_planes              *       2               ; number of planes
LCD_tier_height         *       200             ; number of rasters in tier

                        ; number of bytes in a complete raster
LCD_stride              *       (LCD_planes * LCD_planewidth)

                        ; number of rasters in a complete display
LCD_height              *       (LCD_tier_height * 2)

                        ; number of bytes in a physical screen
LCD_size                *       (LCD_height * LCD_stride)

                        ; default video RAM address
LCD_base                *       (RAM1_base + twomeg - LCD_size)
LCD_base_tier1          *       (LCD_base)
LCD_base_tier2          *       (LCD_base + (LCD_size / 2))

                        ; end address of the physical screen
LCD_end                 *       (LCD_base + LCD_height)

        ; ---------------------------------------------------------------------
        ; Control register (LCD_control)

LCD_CPN_mask    *       (2_00001111)    ; internally generated clock (CP) rate

LCD_LPT_mask    *       (2_00110000)    ; sets the LCD latch pulse (LP) type

        ; The DLY (delay) sets the data position relative to the clock (CP)
LCD_DLY_DEF     *       (2_00 :SHL: 6)  ; default delay
LCD_DLY_40      *       (2_01 :SHL: 6)  ; 40ns delay
LCD_DLY_80      *       (2_10 :SHL: 6)  ; 80ns delay
LCD_DLY_120     *       (2_11 :SHL: 6)  ; 120ns delay

LCD_WAI *       (1 :SHL: 15)    ; enable (1) or disable (0) wait for DMA
LCD_BWP *       (1 :SHL: 14)    ; display plane 1 (0) or plane 2 (1)
LCD_GRY *       (1 :SHL: 13)    ; blank and white (0) or gray level (1) display
LCD_LON *       (1 :SHL: 12)    ; enable (1) or disable (0) LCD drive signals
LCD_LPE *       (1 :SHL: 11)    ; enable (1) or disable (0) power save (LP)
LCD_CPE *       (1 :SHL: 10)    ; enable (1) or disable (0) power save (CP)
LCD_ICP *       (1 :SHL: 9)     ; internal (1) or external (0) clock
LCD_TIE *       (1 :SHL: 8)     ; single tier (0) or two tier (1) display

        ; "LCD_CPE", "LCD_LPE" and "LCD_LON" are used to control the state of
        ; the LCD as follows:
LCD_normal      *       (LCD_LON :OR: LCD_LPE :OR: LCD_CPE :OR: LCD_TIE)
LCD_nodisplay   *       (LCD_LPE :OR: LCD_CPE)
LCD_off         *       &00000000
        ; When in the "LCD_nodisplay" mode, the LCD interface will continue
        ; to refresh memory.

        ; ---------------------------------------------------------------------
        ; Status register (LCD_status)

LCD_PLN         *       (1 :SHL: 0) ; displayed plane (0 = plane 1;1 = plane 2)
LCD_OVR         *       (1 :SHL: 1) ; DMA request overrun
LCD_TOP         *       (1 :SHL: 2) ; local copy of "top of frame" interrupt

        ; ---------------------------------------------------------------------
        ; Line length register (LCD_linelength)
        ; Set the display line length in multiples of 8 pixels.
LCD_LLMASK      *       (2_01111111)    ; pixels = (8 * (LCD_linelength + 1))

        ; ---------------------------------------------------------------------
        ; Line rate register (LCD_linerate)
        ; Adjusts the line rate in multiples of 4 pixels.
LCD_LRMASK      *       (2_11111111)    ; rate = (4 * (LCD_linerate + 1))

        ; ---------------------------------------------------------------------
        ; Number of lines register (LCD_numlines)
        ; Sets the number of lines in multiples of 4 rasters.
LCD_NLMASK      *       (2_11111111)    ; lines = (4 * (LCD_numlines + 1))

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; External Serial


        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; External INMOS Link (LINK0_base)

                ^       &00
LINK_read       #       word    ; READ ONLY
LINK_write      #       word    ; WRITE ONLY
LINK_rstatus    #       word    ; READ/WRITE
LINK_wstatus    #       word    ; READ/WRITE

LINK_data       *       (1 :SHL: 0)     ; set then data present/buffer empty
LINK_intenable  *       (1 :SHL: 1)     ; suitable interrupt enable
        ; All other bits in the status/control registers should be zero

LINK_interrupt  *       INT_EXA         ; location in interrupt control regs

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; LEDs (LED_base)
        ; The LEDs are actually in bits 8..15. However we rely on the trick
        ; of performing a byte write, and it then replicating across the data
        ; bus.
LED_bit0        *       (1 :SHL: 0)
LED_bit1        *       (1 :SHL: 1)
LED_bit2        *       (1 :SHL: 2)
LED_bit3        *       (1 :SHL: 3)
LED_bit4        *       (1 :SHL: 4)
LED_bit5        *       (1 :SHL: 5)
LED_bit6        *       (1 :SHL: 6)
LED_bit7        *       (1 :SHL: 7)


        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; MMUMAP
        ; Requires "r0" to contain the address of the memory management
        ; segment registers. "r1" is corrupted during this MACRO call.
        ;
        ;       seg:                    segment number (0..15)
        ;
        ;       pages:                  number of 512byte chunks
        ;
        ;       paddr:                  512byte aligned physical address
        ;
        ;       access: NONE            no access
        ;               READ            read only
        ;               EXECUTE         read/execute
        ;               WRITE           read/execute/write
        ;
        ;       updown: UP
        ;               DOWN

        MACRO
$label  MMUMAP  $seg,$pages,$paddr,$access="WRITE",$updown="UP"
$label
        LCLA    value
value   SETA    &00000000
        [       (($paddr :AND: &1FF) = 0)
        [       (($paddr :AND: (&3F :SHL: 26)) = 0)
value   SETA    (value :OR: (($paddr :SHR: 9) :AND: MMU_basemask))
        |
        ASSERT  (1 = 0) ; physical address is too large
        ]
        |
        ASSERT  (1 = 0) ; physical address is NOT multiple of 512 bytes
        ]
        [       ("$updown" = "DOWN")
value   SETA    (value :OR: MMU_mapdown :OR: $pages)
        |
        [       ("$updown" = "UP")
value   SETA    (value :OR: MMU_mapup :OR: (4096 - $pages))
        |
        ASSERT  (1 = 0) ; invalid updown specifier "$updown" (UP,DOWN)
        ]
        ]
        [       ("$access" = "NONE")
value   SETA    (value :OR: MMU_mapNONE)
        |
        [       ("$access" = "READ")
value   SETA    (value :OR: MMU_mapR)
        |
        [       ("$access" = "EXECUTE")
value   SETA    (value :OR: MMU_mapRE)
        |
        [       ("$access" = "WRITE")
value   SETA    (value :OR: MMU_mapRWE)
        |
        ASSERT  (1 = 0) ; invalid access "$access" (NONE,READ,EXECUTE,WRITE)
        ]
        ]
        ]
        ]
        LDR     r1,=value               ; load "value" into r1
        STR     r1,[r0,#($seg * 4)]     ; and store into the correct register
        MEND

        ; ---------------------------------------------------------------------
        ; MMUVAL
        ;       pages:                  number of 512byte chunks
        ;
        ;       paddr:                  512byte aligned physical address
        ;
        ;       access: NONE            no access
        ;               READ            read only
        ;               EXECUTE         read/execute
        ;               WRITE           read/execute/write
        ;
        ;       updown: UP
        ;               DOWN

        MACRO
$label  MMUVAL  $pages,$paddr,$access="WRITE",$updown="UP"
$label
        LCLA    value
value   SETA    &00000000
        [       (($paddr :AND: &1FF) = 0)
        [       (($paddr :AND: (&3F :SHL: 26)) = 0)
value   SETA    (value :OR: (($paddr :SHR: 9) :AND: MMU_basemask))
        |
        ASSERT  (1 = 0) ; physical address is too large
        ]
        |
        ASSERT  (1 = 0) ; physical address is NOT multiple of 512 bytes
        ]
        [       ("$updown" = "DOWN")
value   SETA    (value :OR: MMU_mapdown :OR: $pages)
        |
        [       ("$updown" = "UP")
value   SETA    (value :OR: MMU_mapup :OR: (4096 - $pages))
        |
        ASSERT  (1 = 0) ; invalid updown specifier "$updown" (UP,DOWN)
        ]
        ]
        [       ("$access" = "NONE")
value   SETA    (value :OR: MMU_mapNONE)
        |
        [       ("$access" = "READ")
value   SETA    (value :OR: MMU_mapR)
        |
        [       ("$access" = "EXECUTE")
value   SETA    (value :OR: MMU_mapRE)
        |
        [       ("$access" = "WRITE")
value   SETA    (value :OR: MMU_mapRWE)
        |
        ASSERT  (1 = 0) ; invalid access "$access" (NONE,READ,EXECUTE,WRITE)
        ]
        ]
        ]
        ]
        &       (value)                 ; place value into memory
        MEND

        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------
        ; ---------------------------------------------------------------------

        OPT     (old_opt)

        ; ---------------------------------------------------------------------
        END     ; EOF hardHFP/s
