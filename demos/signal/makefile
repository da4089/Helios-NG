#-----------------------------------------------------------------------------
# Helios generic make system - GENERIC COMPONENT MAKEFILE -
#-----------------------------------------------------------------------------
# Helios generic component make rules for: hello example
#
# File: /HSRC/demos/signal/makefile
#
# These are the host/processor independent rules and variables for this
# component of Helios. It is included by the processor specific makefile
# That may add to some of its functionality. You should only alter this
# makefile by using "ifneq ($(HPROC),YYY)" clauses for a specific processor.
#
# RcsId: $Id: makefile,v 1.11 1994/06/20 16:34:37 nickc Exp $
#		(c) Copyright 1994 Perihelion Distributed Software
#
# WARNING: assumes you are using GNUmake.
#
#-----------------------------------------------------------------------------

MV = mv

ifndef InProcMake
# This part of the makefile is run in the components generic source directory

  # These variables should already be set by your make script or environment.
  ifndef HPROC
    HPROC = C40
  endif

  ifndef HHOST
    HHOST = RS6000
  endif

  ifndef HSRC
    HSRC = /dsl/HeliosRoot/Helios
  endif

  ifndef HPROD
    HPROD = $(HSRC)/slashhelios/$(HPROC)
  endif

.PHONY: notarget
notarget:
	@$(MAKE) -C $(HPROC)

.DEFAULT:
	@$(MAKE) -C $(HPROC) $@

else
#-----------------------------------------------------------------------------
# This part of the makefile is always run in a processor specific subdirectory.

# Manditory variables for a component:
# name of this dir relative to $(HSRC)
COMPONENT = demos/signal

# Manditory includes
include $(HSRC)/makeinc/$(HHOST).mak	# Default host system variables
include $(HSRC)/makeinc/$(HPROC).mak	# Default processor rules and vars.

# Manditory phoney targets
.PHONY: default clean Xdefault Xclean
# "default"    - should make this component in its proc subdir
# "install"    - copy the new component to $(HPROD) production directory
# "clean"      - remove all intermediate and executable files from proc subdir
# Phoney targets prefixed by X are for adding processor specific targets.
#
# Processor specific sources are held in the processor specific subdir.,
# generic ones in the directory above it.
HVPATH := $(HSRC)/$(COMPONENT)

ifdef RSRC
HVPATH := $(RSRC)/$(COMPONENT)/$(HPROC):$(HVPATH):$(RSRC)/$(COMPONENT)
endif

vpath %.h $(HVPATH)
vpath %.c $(HVPATH)
vpath %.a $(HVPATH)
vpath %.hel $(HVPATH)

#-----------------------------------------------------------------------------
# Generic component make rules and variables added below here

DEMO = $(HPROD)/users/guest/examples/signal

# Note all final generic targets here
TARGETS = makefile.hel signal.c

default : Xdefault

install	: localinstall Xinstall
	$(TOUCH) install

localinstall: $(XTARGETS) $(TARGETS) 
	-$(MKDIR) $(DEMO)
	-$(foreach DM, $(TARGETS) $(XTARGETS), $(RM) $(DEMO)/$(DM); )
	$(CP) $^ $(DEMO)
	$(foreach DM, $(TARGETS) $(XTARGETS), $(CHMOD) ug+w $(DEMO)/$(DM); )
	$(MV) $(DEMO)/makefile.hel $(DEMO)/makefile
	$(TOUCH) localinstall

clean	: Xclean
	-$(RM)	mkout core ../mkout install installdef Xinstall localinstall

#-----------------------------------------------------------------------------
# for archive, backup and cleaning purposes,
# note all generic SOURCE and OBJECT files:

# Note all sources
SOURCES		= $(SOURCES.c) $(SOURCES.a) \
		   $(HEADERS.c) $(HEADERS.m) \
		   $(SOURCES.odd)

OBJECTS	= $(SOURCES.c:.c=.o) $(SOURCES.a:.a=.o)

# C source files
SOURCES.c	= signal.c

# AMPP source files
SOURCES.a	=


# C header files
HEADERS.c	= 

# AMPP macro files
HEADERS.m	=

# Any other source files
SOURCES.odd	= makefile makefile.hel


#-----------------------------------------------------------------------------
# Other generic component variables:
# @@@ should remove -DHELIOS and change source to reference __HELIOS
# Set any flags required
ifeq ($(HPROC),ARM)
  NCFLAGS := $(NCFLAGS) -DHELIOS -w
else
  NCFLAGS := $(NCFLAGS) -DHELIOS -wadfsv -ecpz -t4
endif


#-----------------------------------------------------------------------------
# Generic targets and their dependencies:


#-----------------------------------------------------------------------------
endif #InProcMake	# This line must be at EOF
