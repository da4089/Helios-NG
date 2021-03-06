

	/****************************************************************/
	/*								*/
	/* b422w10.c	Interface to write 10 for B422 INMOS SCSI TRAM.	*/
	/*		Copyright (C) INMOS Limited 1990.		*/
	/*								*/
	/* Date		Ver	Author		Comment			*/
	/* ----		---	------		-------			*/
	/* 26-Mar-90	1.0	Mike Burrow	Original		*/
	/*								*/
	/****************************************************************/


#include <helios.h>
#include "b422cons.h"
#include "b422err.h"
#include "b422pcol.h"
#include "b422fns.h"


void scsi_write_10(
	BYTE	link_to_scsi,
	BYTE	link_from_scsi,
	BYTE	target_id,
	BYTE	lun,
	INT64	logical_block_address,
	INT32	number_of_blocks,
	INT32	block_size,
	BYTE	control_byte,
	BYTE	*tx_data,
	BYTE	*message,
	BYTE	*msg_length,
	BYTE	*scsi_status,
	INT16	*execution_status)
{
	SCSI_CMND_10	scsi_command;
	BYTE		command_length;
	BYTE		data_transfer_mode;
	INT64		tx_transfer_length;
	NULL_BUFFER	rx_data;
	
	tx_transfer_length = block_size * number_of_blocks;

	compile_write_10(lun, 
			 logical_block_address, 
			 number_of_blocks, 
			 control_byte,
			 scsi_command, 
			 &command_length, 
			 &data_transfer_mode);

	xpt(link_to_scsi,
	    link_from_scsi, 
	    target_id,
	    command_length,
	    scsi_command,
	    data_transfer_mode,
	    NULL_LENGTH,
	    rx_data,
	    tx_transfer_length,
	    tx_data,
	    msg_length,
	    message,
	    scsi_status,
	    execution_status);
}



void compile_write_10(
	BYTE 	lun, 
	INT64	logical_block_address, 
	INT32	transfer_count, 
	BYTE	control_byte,
	BYTE	*scsi_command, 
	BYTE	*scsi_command_length, 
	BYTE	*data_transfer)
{
	scsi_command[0] = WRITE_10;
	scsi_command[1] = lun << 5;
	scsi_command[2] = getbyte((INT32)logical_block_address, 4);
	scsi_command[3] = getbyte((INT32)logical_block_address, 3);
	scsi_command[4] = getbyte((INT32)logical_block_address, 2);
	scsi_command[5] = getbyte((INT32)logical_block_address, 1);
	scsi_command[6] = 0;
	scsi_command[7] = getbyte(transfer_count, 2);
	scsi_command[8] = getbyte(transfer_count, 1);
	scsi_command[9] = control_byte;
	
	*scsi_command_length = SCSI_10;
	*data_transfer	     = HOST_TO_SCSI_VARIABLE;
}

