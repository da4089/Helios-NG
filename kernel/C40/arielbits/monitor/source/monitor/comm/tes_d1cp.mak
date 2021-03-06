C40_C=c:\c40\cl30
C40_ASM=c:\c40\asm30
C40_LNK=c:\c40\lnk30
COMPILE_ONLY=-v40 -n -s -g -ic:\c40
COMPILE=-v40 -c -ic:\c40
ASM_OPT=-v40

tes_d1cp.obj:	tes_d1cp.c
	$(C40_C) $(COMPILE_ONLY) tes_d1cp.c
	$(C40_ASM) $(ASM_OPT) tes_d1cp.asm

td1cp.obj:	td1cp.c
	$(C40_C) $(COMPILE_ONLY) td1cp.c
	$(C40_ASM) $(ASM_OPT) td1cp.asm

com_port.obj:	com_port.c
	$(C40_C) $(COMPILE_ONLY) com_port.c
	$(C40_ASM) $(ASM_OPT) com_port.asm

o_crdy.obj:	o_crdy.asm
	$(C40_ASM) $(ASM_OPT) o_crdy.asm

i_crdy.obj:	i_crdy.asm
	$(C40_ASM) $(ASM_OPT) i_crdy.asm


##########
## Link ##
##########
tes_d1cp.x40: tes_d1cp.obj td1cp.obj com_port.obj  o_crdy.obj i_crdy.obj 
	$(C40_LNK) -v40 tes_d1cp.lnk
