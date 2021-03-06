#
# makefile for helios 3.xxx server for SUN3, SUN4, SUN386 running SunOS
#

# start with the makefile configuration
# 1) specify the host and target hardware
#host     = SUN3
host     = SUN4
#host     = SUN386

# 2) default depends on the host
# On Sun3: xview does not work
#default: helios.h server hydra hydramon serverwinsv serverwinxaw

# On Sun4: everything
#default: helios.h server hydra hydramon serverwinsv serverwinxv \
	 serverwinxaw

# On Sun386
#default: helios.h server hydra hydramon serverwinsv serverwinxaw

# On Solaris 2.3, not very much (yet)
default: helios.h server serverwinxt serverwinxaw

# 3) the host controls which link I/O modules are needed
# For Sun3 
#linkobjs = sun/linklib.o sun/niche.o sun/b011.o sun/b014.o sun/b016.o \
#		sun/volvox.o sun/telmat.o sun/hunt.o sun/vc40.o \
#		sun/cpswap.o sun/vy86pid.o
# For Sun4
# linkobjs = sun/linklib.o sun/niche.o sun/b011.o sun/b014.o sun/b016.o \
#		sun/volvox.o sun/telmat.o sun/hunt.o sun/vc40.o sun/vy86pid.o
# For Solaris 
linkobjs = sun/linklib.o sun/matchbox.o sun/hunt.o sun/vy86pid.o sun/volvox.o \
sun/telmat.o sun/niche.o
colibobjs = sun/colib.o
#colibobjs = solaris/sol_colib.o
colib_link =  -lsocket -lnsl \
-L/opt/transtech/lib -ltsp \
-L/usr/ucblib -lucb -ltermcap -lcurses \
-B dynamic -lposix4 -lthread -ldl

# and for Sun386
#linkobjs = sun/linklib.o sun/kpar.o

# 4) normally the server would use C coroutines implemented in terms of
# sun light-weight-processes. These do not work under SunOS 4.0,
# so an assembler coroutine library for the Sun3 only is available as
# an alternative 
#colibobjs = sun/colib.o
#colib_link = sun/colib.o -ltermcap -llwp

#colibobjs = sun/coasm.o 
#colib_link = -Bstatic sun/coasm.o -ltermcap -lX11

# 5) miscellaneous macros
sys      = /usr/include
header   = helios.h
#mycc     = cc -c -pipe -D$(host)
mycc	= CC -c -g -misalign -D_REENTRANT -DSOLARIS -I/opt/transtech/include
#mylink   = cc -Bstatic 
mylink	= CC -g -misalign -DSOLARIS

# these files compile for all the hardware
servobjs = server.o files.o devices.o tload.o cofuns.o \
	debug.o terminal.o linkio.o tcp.o sun/sunlocal.o


server: $(servobjs) $(linkobjs) $(colibobjs)
	$(mylink) -o server $(servobjs) $(linkobjs) $(colibobjs) $(colib_link)
	cp $@ ../bin.sol

hydra : sun/hydra.o $(linkobjs)
	$(mylink) -o hydra sun/hydra.o $(linkobjs)

hydramon : sun/hydramon.o
	$(mylink) -o hydramon sun/hydramon.o -Bstatic

serverwinsv: sun/serversv.c
	$(mycc) sun/serversv.c 
	mv serversv.o sun
	$(mylink) -o serverwinsv sun/serversv.o -lsuntool -lsunwindow -lpixrect
	cp $@ ../bin.sol

# These cannot be built statically, problems with libraries
serverwinxv: sun/serverxv.c
	$(mycc) -I/usr/openwin/include sun/serverxv.c 
	mv serverxv.o sun
	$(mylink) -o serverwinxv sun/serverxv.o -lsocket -lnsl \
-L/usr/ucblib -lucb -ltermcap \
-L/usr/openwin/lib -lXaw -lXt -lXmu -lXext -lX11 -ltermcap
#	$(mylink) -o serverwinxv sun/serverxv.o -lxview -lX11 -lolgx
	cp $@ ../bin.sol

serverwinxaw: sun/serverxaw.c
	$(mycc) -I/usr/openwin/include sun/serverxaw.c 
	mv serverxaw.o sun
	$(mylink) -o serverwinxaw sun/serverxaw.o -lsocket -lnsl \
-L/usr/ucblib -lucb -ltermcap \
-L/usr/openwin/lib -lXaw -lXt -lXmu -lXext -lX11 -ltermcap
#	$(mylink) -o serverwinxaw sun/serverxaw.o $(colib_link) -L/usr/openwin/lib -lXaw -lXt -lXmu -lXext -lX11 -ltermcap
	cp $@ ../bin.sol

serverwinxt: sun/serverxt.c
	$(mycc) -I/usr/openwin/include sun/serverxt.c 
	mv serverxt.o sun
	$(mylink) -o serverwinxt sun/serverxt.o -lsocket -lnsl \
-L/usr/ucblib -lucb -ltermcap \
-L/usr/openwin/lib -lXaw -lXt -lXmu -lXext -lX11 -ltermcap
#	$(mylink) -o serverwinxt sun/serverxt.o $(colib_link) -L/usr/openwin/lib -lXaw -lXt -lXmu -lXext -lX11 -ltermcap
	cp $@ ../bin.sol

# Release notes. The main release should contain the following files:
#
# server.sun3 hydra.sun3 hydramon.sun3 serverwinsv.sun3 serverwinxaw.sun3
# server.sun4 hydra.sun4 hydramon.sun4 serverwinsv.sun4 serverwinxaw.sun4 
# serverwinxv.sun4
#
# The Sun386 release should contain:
# server.sun386 hydra.sun386 hydramon.sun386 serverwinsv.sun386
#
# In addition all Unix releases should contain suitable host.con files
#

tload.o: tload.c $(header)
	$(mycc) tload.c

server.o: server.c $(header) sccs.h fundefs.h \
	server.h defines.h
	$(mycc) server.c

files.o:       files.c   $(header)
	$(mycc) files.c

devices.o: devices.c $(header)
	$(mycc) devices.c

cofuns.o:     cofuns.c $(header)
	$(mycc) cofuns.c

debug.o : debug.c $(header)
	$(mycc) debug.c

terminal.o: terminal.c $(header)
	$(mycc) terminal.c

tcp.o: tcp.c $(header)
	$(mycc) tcp.c

linkio.o : linkio.c $(header)
	$(mycc) linkio.c

sun/sunasm.o : sun/sunasm.s $(header)
	as -o sun/sunasm.o sun/sunasm.s

sun/colib.o : sun/colib.c $(header)
#	$(mycc) -DSIGNALS sun/colib.c
#	$(mycc) -DLWP sun/colib.c
	$(mycc) -DTHREADS sun/colib.c
	mv colib.o $@

sun/sunlocal.o : sun/sunlocal.c $(header)
	$(mycc) sun/sunlocal.c
	mv sunlocal.o $@

sun/linklib.o : sun/linklib.c $(header) 
	$(mycc) sun/linklib.c
	mv linklib.o $@

sun/niche.o : sun/niche.c $(header)
	$(mycc) sun/niche.c
	mv niche.o $@

sun/telmat.o : sun/telmat.c $(header)
	$(mycc) -Isun sun/telmat.c
	mv telmat.o $@

sun/volvox.o : sun/volvox.c $(header)
	$(mycc) sun/volvox.c
	mv volvox.o $@

sun/b011.o : sun/b011.c $(header)
	$(mycc) sun/b011.c
	mv b011.o $@

sun/b014.o : sun/b014.c $(header)
	$(mycc) sun/b014.c
	mv b014.o $@

sun/b016.o : sun/b016.c $(header)
	$(mycc) sun/b016.c
	mv b016.o $@

sun/kpar.o : sun/kpar.c $(header)
	$(mycc) sun/kpar.c
	mv kpar.o $@

sun/hunt.o : sun/hunt.c $(header)
	$(mycc) sun/hunt.c
	mv hunt.o $@

sun/vc40.o : sun/vc40.c $(header) sml.h smlgen.c sun/c40sundriv.c
	$(mycc) -I. -Iariel_include -Isun sun/vc40.c
	mv vc40.o $@

sun/cpswap.o : sun/cpswap.s $(header)
	as -o sun/cpswap.o sun/cpswap.s

sun/vy86pid.o : sun/vy86pid.c $(header)
	$(mycc) sun/vy86pid.c
	mv vy86pid.o $@

sun/matchbox.o : sun/matchbox.c $(header)
	$(mycc) sun/matchbox.c
	mv matchbox.o $@

sun/hydra.o : sun/hydra.c $(header)
	$(mycc) sun/hydra.c
	mv hydra.o $@

sun/hydramon.o : sun/hydramon.c $(header)
	$(mycc) sun/hydramon.c
	mv hydramon.o $@

solaris/sol_colib.o : solaris/sol_colib.c $(header)
	$(mycc) solaris/sol_colib.c
	mv sol_colib.o $@

#
# The order of the header files is important. First I incorporate all the
# C header files. Then comes Defines.h to specify the environment in which the
# server is meant to run, which must come before any of the remaining headers.
# Barthdr declares some miscellaneous odds and ends. Next come all the helios
# header files from directory servinc. Finally the server's private header
# files, including the local one. structs.h declares the server's data
# structures and macros, fundefs declares the functions shared between modules,
# and server.h declares the shared variables.
#
helios.h: barthdr defines.h structs.h fundefs.h server.h debugopt.h \
		sun/sunlocal.h protocol.h
	cat $(sys)/stdio.h $(sys)/stdlib.h $(sys)/string.h $(sys)/sys/types.h  \
	$(sys)/ctype.h $(sys)/setjmp.h \
	$(sys)/sys/time.h $(sys)/errno.h $(sys)/sys/socket.h \
	$(sys)/sys/times.h $(sys)/signal.h $(sys)/fcntl.h \
	$(sys)/unistd.h $(sys)/sys/stat.h $(sys)/sys/param.h \
	$(sys)/sys/file.h $(sys)/memory.h $(sys)/sys/vfs.h \
	$(sys)/netinet/in.h $(sys)/netdb.h $(sys)/sys/un.h \
	$(sys)/dirent.h  $(sys)/termio.h $(sys)/pwd.h $(sys)/sys/wait.h \
	defines.h barthdr protocol.h structs.h \
	fundefs.h server.h debugopt.h sun/sunlocal.h \
	> helios.h

