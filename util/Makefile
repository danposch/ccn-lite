# ccnl/util/Makefile

CC?=gcc
CFLAGS=-Wall -g

PROGS=	ccn-lite-ctrl \
	ccn-lite-ccnb2hex \
	ccn-lite-ccnb2xml \
	ccn-lite-deF \
	ccn-lite-mkC \
	ccn-lite-mkF \
	ccn-lite-mkI \
	ccn-lite-peek

all: $(PROGS)

ccn-lite-ctrl: Makefile ccn-lite-ctrl.c ../ccnx.h ../ccnl.h ../ccnl-pdu.c ccnl-common.c
	$(CC) $(CFLAGS) ccn-lite-ctrl.c -o $@ 

ccn-lite-ccnb2hex: Makefile ccn-lite-ccnb2hex.c ../ccnx.h ../ccnl.h
	$(CC) $(CFLAGS) ccn-lite-ccnb2hex.c -o $@ 

ccn-lite-ccnb2xml: Makefile ccn-lite-ccnb2xml.c ../ccnx.h ../ccnl.h ccnl-common.c
	$(CC) $(CFLAGS) ccn-lite-ccnb2xml.c -o $@ 

ccn-lite-peek: Makefile ccn-lite-peek.c ../ccnx.h ../ccnl.h ../ccnl-pdu.c ccnl-common.c
	$(CC) $(CFLAGS) ccn-lite-peek.c -o $@ 

ccn-lite-deF: Makefile ccn-lite-deF.c ../ccnx.h ../ccnl.h ccnl-frag.h
	$(CC) $(CFLAGS) ccn-lite-deF.c -o $@ 

ccn-lite-mkC: Makefile ccn-lite-mkC.c ../ccnx.h ../ccnl.h
	$(CC) $(CFLAGS) ccn-lite-mkC.c -o $@ 

ccn-lite-mkF: Makefile ccn-lite-mkF.c ../ccnx.h ../ccnl.h ccnl-frag.h
	$(CC) $(CFLAGS) ccn-lite-mkF.c -o $@ 

ccn-lite-mkI: Makefile ccn-lite-mkI.c ../ccnx.h ../ccnl.h
	$(CC) $(CFLAGS) ccn-lite-mkI.c -o $@ 

demo: $(PROGS)
	./ccn-lite-mkI /ccn-lite/says/hello/world/äöü | ./ccn-lite-ccnb2hex
	./ccn-lite-mkI /ccn-lite/says/hello/world/äöü | ./ccn-lite-ccnb2xml

install: all
	install ${PROGS} ${INSTALL_PATH}/bin

uninstall:
	cd ${INSTALL_PATH}/bin && rm -f ${PROGS} && cd - > /dev/null

clean:
	rm -rf *~ $(PROGS)
