#------------------------------------------------------------------------------
# Helios generic make system
#-----------------------------------------------------------------------------
# TRAN processor specific make rules for the nucleus.
#
# File: /HSRC/nucleus/TRAN/makefile
#
# This file contains the extra definitions of variables and rules that are
# required to make a processor specific version of this component.
#
# If you wish to overide a targets rule that has been defined in the generic
# part of the makefile, you should bracket it with "ifneq ($(HPROC),YYY)" and
# supply the new rule in this makefile.
#
# This makefile is always executed within this processor specific subdir.
# All processor specific source files should be kept here.
# All intermediate, object and binary files should be made in here.
#
# SccsId: %W% %G%
# RcsId: $Id: makefile,v 1.3 1992/08/17 11:10:51 paul Exp $
#		(C) Copyright 1990 Perihelion Software
#
# WARNING: assumes you are using GNUmake.
#-----------------------------------------------------------------------------

InProcMake = TRUE

BOOT 		= $(KERNEL)/TRAN/nboot.i

# Get generic component makefile
include ../makefile

#-----------------------------------------------------------------------------
# Add processor specific targets:
XTARGETS = 

Xdefault: $(XTARGETS)


# Install the extra targets:
Xinstall: $(XTARGETS)
#	$(CP) $(XTARGETS) $(LIB)
	$(TOUCH) Xinstall


# Remove any processor specific files other than targets and objects here:
Xclean:
#	-$(RM) xxx


#-----------------------------------------------------------------------------
# Add to lists of files, used for archive, backup and cleaning purposes.

# All extra processor specific sources
XSOURCES	= $(XSOURCES.c) $(XSOURCES.a) \
		   $(XHEADERS.c) $(XHEADERS.m) \
		   $(XSOURCES.odd)


#Full set of library object files
XOBJECTS	= $(XSOURCES.c:.c=.p) $(XSOURCES.a:.a=.p)
# Or if you are not a library:
#XOBJECTS	= $(XSOURCES.c:.c=.o) $(XSOURCES.a:.a=.o)


# Fill in processor specific sources here:
XSOURCES.c	= 

XSOURCES.a	=

XHEADERS.c	=

XHEADERS.m	=

XSOURCES.odd	= makefile


#-----------------------------------------------------------------------------
# Any additional processor specific rules and generic rule overides go here:

%.p : %.c
	$(NC) -l $(NCFLAGS) $(DEFINES) $< -s$(TEMP)/$*.s
	$(ASM) $(ASMFLAGS) -o $*.p $(TEMP)/$*.s
	-$(RMTEMP) $(TEMP)/$*.s


