#
# @(#)Makefile	1.5 87/11/20 3.9 RPCSRC
#
#   Files and programs for /etc.  rpclib must have already been installed.
#
DESTDIR=
CFLAGS=	-wA -D_BSD -DDEBUG
LIB = -lrpclib
LDFLAGS= $(LIB)

BIN = portmap rpcinfo
MISC= rpc

all:	${BIN}

portmap: portmap.o
	${CC} ${CFLAGS} -o $@ $@.o ${LDFLAGS}

rpcinfo:	getopt.o rpcinfo.o
	${CC} ${CFLAGS} -o $@ $@.o getopt.o ${LDFLAGS}

install: ${BIN}
	cp portmap /helios/lib
	cp rpcinfo /helios/bin
#	-mkdir ${DESTDIR}/etc && chown bin ${DESTDIR}/etc && \
#		chmod 755 ${DESTDIR}/etc
#	@echo "Installing RPC utility files in ${DESTDIR}/etc"
#	@set -x;for i in ${BIN}; do \
#		(install -s $$i ${DESTDIR}/etc/$$i); done
#	@echo "Installing ${DESTDIR}/etc/rpc"
#	@set -x;for i in ${MISC}; do \
#		(install -c -m 644 $$i ${DESTDIR}/etc/$$i); done

clean:
	rm -f core *.o
	rm -f ${BIN}

depend: ${BIN}
	rm -f makedep
	for i in ${BIN}; do \
	    ${CC} -M ${INCPATH} $$i.c | sed 's/\.o//' | \
	    awk ' { if ($$1 != prev) { print rec; rec = $$0; prev = $$1; } \
		else { if (length(rec $$2) > 78) { print rec; rec = $$0; } \
		else rec = rec " " $$2 } } \
		END { print rec } ' >> makedep; done
	echo '/^# DO NOT DELETE THIS LINE/+2,$$d' >eddep
	echo '$$r makedep' >>eddep
	echo 'w' >>eddep
	cp Makefile Makefile.bak
	ed - Makefile < eddep
	rm eddep makedep
	echo '# DEPENDENCIES MUST END AT END OF FILE' >> Makefile
	echo '# IF YOU PUT STUFF HERE IT WILL GO AWAY' >> Makefile
	echo '# see make depend above' >> Makefile


depend.42BSD depend.42bsd:
	cp /dev/null x.c
	for i in $(BIN) ; do \
              (/bin/grep '^#[         ]*include' x.c $$i.c | sed \
                      -e 's,<\(.*\)>,"/usr/include/\1",' \
                      -e 's/:[^"]*"\([^"]*\)".*/: \1/' \
	                  -e 's/\.c/\.o/' >>makedep); done
	echo '/^# DO NOT DELETE THIS LINE/+2,$$d' >eddep
	echo '$$r makedep' >>eddep
	echo 'w' >>eddep
	cp Makefile Makefile.bak
	ed - Makefile < eddep
	rm eddep makedep x.c
	echo '# DEPENDENCIES MUST END AT END OF FILE' >> Makefile
	echo '# IF YOU PUT STUFF HERE IT WILL GO AWAY' >> Makefile
	echo '# see make depend above' >> Makefile

# DO NOT DELETE THIS LINE -- make depend uses it


