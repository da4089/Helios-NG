/* @(#)msg_proc.c	1.1 87/11/04 3.9 RPCSRC */
/*
 * msg_proc.c: implementation of the remote procedure "printmessage"
 */
#include <stdio.h>
#include <rpc/rpc.h>	/* always need this here */
#include "msg.h"	/* need this too: msg.h will be generated by rpcgen */

/*
 * Remote verson of "printmessage"
 */
int *		
printmessage_1(msg)
	char **msg;	
{
	static int result; /* must be static! */
	FILE *f;

	f = fopen("/dev/console", "w");
	if (f == NULL) {
		result = 0;
		return (&result);
	}
	fprintf(f, "%s\n", *msg);
	fclose(f);
	result = 1;
	return (&result);
}
