

	/****************************************************************/
	/*								*/
	/* b422cap.c	Interface to read capacity for B422 INMOS SCSI	*/
	/*		TRAM. Copyright (C) INMOS Limited 1990.		*/
	/*								*/
	/* Date		Ver	Author		Comment			*/
	/* ----		---	------		-------			*/
	/* 27-Mar-90	1.0	Mike Burrow	Original		*/
	/*								*/
	/****************************************************************/


#include <helios.h>
#include "b422cons.h"
#include "b422err.h"
#include "b422pcol.h"
#include "b422fns.h"


void scsi_read_capacity_10(
	BYTE	link_to_scsi,
	BYTE	link_from_scsi,
	BYTE	target_id,
	BYTE	lun,
	BYTE	reserved_0,
	BOOL	reladr,
	INT32	logical_block_address,
	BYTE	reserved_1,
	BYTE	reserved_2,
	BYTE	reserved_3,
	BOOL	pmi,
	BYTE	control_byte,
	BYTE	*read_capacity_data,
	BYTE	*message,
	BYTE	*msg_length,
	BYTE	*scsi_status,
	INT16	*execution_status)
{
	SCSI_CMND_10	scsi_command;
	BYTE		command_length;
	BYTE		data_transfer_mode;
	INT64		read_capacity_length;
	NULL_BUFFER	null_buffer;
	
	read_capacity_length = 8;
		
	compile_read_capacity_10(lun, 
				 reserved_0,
				 reladr,
			 	 logical_block_address, 
			 	 reserved_1,
			 	 reserved_2,
			 	 reserved_3,
			 	 pmi,
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
	    read_capacity_length,
	    read_capacity_data,
	    NULL_LENGTH,
	    null_buffer,
	    msg_length,
	    message,
	    scsi_status,
	    execution_status);
}



void compile_read_capacity_10(
	BYTE 	lun, 
	BYTE	reserved_0,
	BOOL	reladr,
	INT32	logical_block_address, 
	BYTE	reserved_1,
	BYTE	reserved_2,
	BYTE	reserved_3,
	BOOL	pmi,
	BYTE	control_byte,
	BYTE	*scsi_command, 
	BYTE	*scsi_command_length, 
	BYTE	*data_transfer)
{
	scsi_command[0] = READ_CAPACITY;
	scsi_command[1] = ((lun << 5) & 0xe0) | ((reserved_0 << 1) & 0x1e);
	if (reladr)
		scsi_command[1] |= 0x01;
	scsi_command[2] = getbyte(logical_block_address, 4);
	scsi_command[3] = getbyte(logical_block_address, 3);
	scsi_command[4] = getbyte(logical_block_address, 2);
	scsi_command[5] = getbyte(logical_block_address, 1);
	scsi_command[6] = reserved_1;
	scsi_command[7] = reserved_2;
	scsi_command[8] = pmi ? reserved_3 | 0x01 : reserved_3 & 0xfe;
	scsi_command[9] = control_byte;
	
	*scsi_command_length = SCSI_10;
	*data_transfer	     = SCSI_TO_HOST_VARIABLE;
}

