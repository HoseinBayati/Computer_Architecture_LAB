// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.   
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module TOP_ARM
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT,							//	SD Card Data
		//SD_WP_N,						   //	SD Write protect 
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

	////////////////////////	Clock Input	 	////////////////////////
	input		   	CLOCK_27;				//	27 MHz
	input		   	CLOCK_50;				//	50 MHz
	input			   EXT_CLOCK;				//	External Clock
	////////////////////////	Push Button		////////////////////////
	input	   [3:0]	KEY;					//	Pushbutton[3:0]
	////////////////////////	DPDT Switch		////////////////////////
	input	  [17:0]	SW;						//	Toggle Switch[17:0]
	////////////////////////	7-SEG Dispaly	////////////////////////
	output	[6:0]	HEX0;					//	Seven Segment Digit 0
	output	[6:0]	HEX1;					//	Seven Segment Digit 1
	output	[6:0]	HEX2;					//	Seven Segment Digit 2
	output	[6:0]	HEX3;					//	Seven Segment Digit 3
	output	[6:0]	HEX4;					//	Seven Segment Digit 4
	output	[6:0]	HEX5;					//	Seven Segment Digit 5
	output	[6:0]	HEX6;					//	Seven Segment Digit 6
	output	[6:0]	HEX7;					//	Seven Segment Digit 7
	////////////////////////////	LED		////////////////////////////
	output	[8:0]	LEDG;					//	LED Green[8:0]
	output  [17:0]	LEDR;					//	LED Red[17:0]
	////////////////////////////	UART	////////////////////////////
	//output			UART_TXD;				//	UART Transmitter
	//input			   UART_RXD;				//	UART Receiver
	////////////////////////////	IRDA	////////////////////////////
	//output			IRDA_TXD;				//	IRDA Transmitter
	//input			   IRDA_RXD;				//	IRDA Receiver
	///////////////////////		SDRAM Interface	////////////////////////
	inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
	output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
	output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
	output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
	output			DRAM_WE_N;				//	SDRAM Write Enable
	output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
	output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
	output			DRAM_CS_N;				//	SDRAM Chip Select
	output			DRAM_BA_0;				//	SDRAM Bank Address 0
	output			DRAM_BA_1;				//	SDRAM Bank Address 0
	output			DRAM_CLK;				//	SDRAM Clock
	output			DRAM_CKE;				//	SDRAM Clock Enable
	////////////////////////	Flash Interface	////////////////////////
	inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
	output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
	output			FL_WE_N;				//	FLASH Write Enable
	output			FL_RST_N;				//	FLASH Reset
	output			FL_OE_N;				//	FLASH Output Enable
	output			FL_CE_N;				//	FLASH Chip Enable
	////////////////////////	SRAM Interface	////////////////////////
	inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
	output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
	output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
	output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
	output			SRAM_WE_N;				//	SRAM Write Enable
	output			SRAM_CE_N;				//	SRAM Chip Enable
	output			SRAM_OE_N;				//	SRAM Output Enable
	////////////////////	ISP1362 Interface	////////////////////////
	inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
	output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
	output			OTG_CS_N;				//	ISP1362 Chip Select
	output			OTG_RD_N;				//	ISP1362 Write
	output			OTG_WR_N;				//	ISP1362 Read
	output			OTG_RST_N;				//	ISP1362 Reset
	output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
	output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
	input			   OTG_INT0;				//	ISP1362 Interrupt 0
	input			   OTG_INT1;				//	ISP1362 Interrupt 1
	input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
	input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
	output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
	output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
	////////////////////	LCD Module 16X2	////////////////////////////
	inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
	output			LCD_ON;					//	LCD Power ON/OFF
	output			LCD_BLON;				//	LCD Back Light ON/OFF
	output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
	output			LCD_EN;					//	LCD Enable
	output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
	////////////////////	SD Card Interface	////////////////////////
	//inout	 [3:0]	SD_DAT;					//	SD Card Data
	//input			   SD_WP_N;				   //	SD write protect
	//inout			   SD_CMD;					//	SD Card Command Signal
	//output			SD_CLK;					//	SD Card Clock
	////////////////////////	I2C		////////////////////////////////
	inout			   I2C_SDAT;				//	I2C Data
	output			I2C_SCLK;				//	I2C Clock
	////////////////////////	PS2		////////////////////////////////
	input		 	   PS2_DAT;				//	PS2 Data
	input			   PS2_CLK;				//	PS2 Clock
	////////////////////	USB JTAG link	////////////////////////////
	input  			TDI;					// CPLD -> FPGA (data in)
	input  			TCK;					// CPLD -> FPGA (clk)
	input  			TCS;					// CPLD -> FPGA (CS)
	output 			TDO;					// FPGA -> CPLD (data out)
	////////////////////////	VGA			////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	////////////////	Ethernet Interface	////////////////////////////
	inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
	output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
	output			ENET_CS_N;				//	DM9000A Chip Select
	output			ENET_WR_N;				//	DM9000A Write
	output			ENET_RD_N;				//	DM9000A Read
	output			ENET_RST_N;				//	DM9000A Reset
	input			   ENET_INT;				//	DM9000A Interrupt
	output			ENET_CLK;				//	DM9000A Clock 25 MHz
	////////////////////	Audio CODEC		////////////////////////////
	inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
	input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
	inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
	output			AUD_DACDAT;				//	Audio CODEC DAC Data
	inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
	output			AUD_XCK;				//	Audio CODEC Chip Clock
	////////////////////	TV Devoder		////////////////////////////
	input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
	input			   TD_HS;					//	TV Decoder H_SYNC
	input			   TD_VS;					//	TV Decoder V_SYNC
	output			TD_RESET;				//	TV Decoder Reset
	input          TD_CLK27;            //	TV Decoder 27MHz CLK
	////////////////////////	GPIO	////////////////////////////////
	inout	[35:0]	GPIO_0;					//	GPIO Connection 0
	inout	[35:0]	GPIO_1;					//	GPIO Connection 1

	
	assign LEDR[0] = SW[0] | SW[1];
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	wire clk, rst;
	assign clk = CLOCK_50;
	assign rst = SW[17];
	
	wire flush, freeze;

	wire[31:0] if_pc_stage, if_instruction_stage, if_pc_stage_reg, if_instruction_stage_reg;
	wire[31:0] id_pc_stage, id_pc_stage_reg;
	wire[31:0] exe_pc_stage, exe_pc_stage_reg;
	wire[31:0] mem_pc_stage, mem_pc_stage_reg;
	wire[31:0] wb_pc_stage, wb_pc_stage_reg;

	wire [31:0] Result_WB, Val_Rn, Val_Rm, id_instruction_stage;
	wire writeBackEn, WB_EN, MEM_R_EN, MEM_W_EN, B_out, S_out, imm, Two_src;
	wire [3:0] Dest_wb, SR, EXE_CMD, Dest, src1, src2;
	wire [11:0] Shift_operand;
	wire [23:0] Signed_imm_24;

	wire WB_EN_reg_id_out, MEM_R_EN_reg_id_out, MEM_W_EN_reg_id_out, B_reg_out, S_reg_out;
	wire [3:0] EXE_CMD_out;
	wire [31:0] val_Rn_id_out, val_Rm_id_out;

	wire imm_id_out;
	wire [11:0] Shift_operand_out;
	wire [23:0] Signed_imm_24_out;
	wire [3:0] Dest_out;
	wire [31:0] id_instruction_stage_reg;
	wire [3:0] src_1_out, src_2_out;

	wire carry_out;

	wire [31:0] ALU_result, Br_Addr, Val_Rm_exe_out;
	wire [3:0] status_exe, Dest_exe_out;
	wire WB_EN_exe_out, MEM_W_EN_exe_out, MEM_R_EN_exe_out, WB_EN_exe_reg_out, MEM_W_EN_exe_reg_out, MEM_R_EN_exe_reg_out;
	wire WB_EN_mem_out, MEM_R_EN_mem_out, MEM_W_EN_mem_out;
	wire [31:0] ALU_result_exe_reg_out, Val_Rm_exe_reg_out;
	wire [31:0] ALU_result_mem_out;
	wire [3:0] Dest_mem_out, Dest_exe_reg_out;
	wire [31:0] Data_mem_out;

	wire WB_EN_mem_reg_out, MEM_R_EN_mem_reg_out;
	wire [31:0] ALU_result_mem_reg_out, Data_mem_reg_out;
	wire [3:0] Dest_mem_reg_out;

	wire [3:0] Dest_wb_out;
	wire WB_EN_wb_out;
	wire [31:0] outp;

	wire hazard;

	wire [1:0] sel_src1, sel_src2;

	IF_Stage if_stage (
		.clk(clk), 
		.rst(rst), 
		.freeze(hazard), 
		.Branch_taken(B_reg_out), 
		.BranchAddr(Br_Addr), 
		.PC(if_pc_stage), 
		.Instruction(if_instruction_stage)
	);

	IF_Stage_Reg if_stage_reg (
		.clk(clk),
		.rst(rst), 
		.freeze(hazard), 
		.flush(B_reg_out), 
		.PC_in(if_pc_stage), 
		.Instruction_in(if_instruction_stage), 
		.PC(if_pc_stage_reg), 
		.Instruction(if_instruction_stage_reg)
	);

	ID_Stage id_stage (
		.clk(clk),
		.rst(rst), 
		.Instruction(if_instruction_stage_reg),
		.Result_WB(outp),
		.writeBackEn(WB_EN_wb_out),
		.Dest_wb(Dest_wb_out),
		.hazard(hazard),
		.SR(SR),
		.PC_in(if_pc_stage_reg),
		.WB_EN(WB_EN),
		.MEM_R_EN(MEM_R_EN),
		.MEM_W_EN(MEM_W_EN), 
		.B_out(B_out), 
		.S_out(S_out), 
		.EXE_CMD(EXE_CMD),
		.Val_Rn(Val_Rn),
		.Val_Rm(Val_Rm),
		.Instruction_out(id_instruction_stage),
		.imm(imm),
		.Shift_operand(Shift_operand),
		.Signed_imm_24(Signed_imm_24),
		.Dest(Dest), 
		.src1(src1), 
		.src2(src2), 
		.Two_src(Two_src),
		.PC(id_pc_stage)
	);

	ID_Stage_Reg id_stage_reg(
		.clk(clk),
		.rst(rst),
		.flush(B_reg_out),
		.WB_EN_IN(WB_EN),
		.MEM_R_EN_IN(MEM_R_EN),
		.MEM_W_EN_IN(MEM_W_EN),
		.B_IN(B_out), 
		.S_IN(S_out),
		.EXE_CMD_IN(EXE_CMD),		  			 
		.PC_in(id_pc_stage),
		.Val_Rn_IN(Val_Rn),
		.Val_Rm_IN(Val_Rm),
		.imm_IN(imm),
		.Shift_operand_IN(Shift_operand),
		.Signed_imm_24_IN(Signed_imm_24),
		.Dest_IN(Dest),
		.Instruction(id_instruction_stage),
		.src_1_in(src1), 
		.src_2_in(src2),
		.carry_in(SR[2]),
		.WB_EN(WB_EN_reg_id_out),
		.MEM_R_EN(MEM_R_EN_reg_id_out),
		.MEM_W_EN(MEM_W_EN_reg_id_out),
		.B(B_reg_out),
		.S(S_reg_out),
		.EXE_CMD(EXE_CMD_out),		  	  
		.PC(id_pc_stage_reg),
		.Val_Rn(val_Rn_id_out),
		.Val_Rm(val_Rm_id_out),
		.imm(imm_id_out),
		.Shift_operand(Shift_operand_out),
		.Signed_imm_24(Signed_imm_24_out),
		.Dest(Dest_out),
		.Instruction_out(id_instruction_stage_reg),
		.src_1(src_1_out),
		.src_2(src_2_out),
		.carry_out(carry_out)		  
	);

	EXE_Stage exe_stage(
		.clk(clk), 
		.rst(rst), 
		.EXE_CMD(EXE_CMD_out),
		.WB_EN(WB_EN_reg_id_out),
		.MEM_R_EN(MEM_R_EN_reg_id_out),
		.MEM_W_EN(MEM_W_EN_reg_id_out),
		.PC_in(id_pc_stage_reg),
		.Val_Rn(val_Rn_id_out),
		.Val_Rm(val_Rm_id_out),
		.imm(imm_id_out),
		.Shift_operand(Shift_operand_out),
		.Signed_imm_24(Signed_imm_24_out),
		.C(carry_out),
		.Dest(Dest_out),
		.sel_src1(sel_src1),
		.sel_src2(sel_src2),
		.MEM_val(ALU_result_mem_out),
		.WB_val(outp),
		.ALU_result(ALU_result),
		.Br_addr(Br_Addr),
		.Val_Rm_out(Val_Rm_exe_out),
		.status(status_exe),
		.Dest_out(Dest_exe_out),
		.WB_EN_out(WB_EN_exe_out), 
		.MEM_W_EN_out(MEM_W_EN_exe_out), 
		.MEM_R_EN_out(MEM_R_EN_exe_out),
		.PC(exe_pc_stage)
	);

	EXE_Stage_Reg exe_stage_reg(
		.clk(clk),
		.rst(rst), 
		.freeze(freeze), 
		.flush(flush), 
		.WB_en_in(WB_EN_exe_out),		    	     
		.MEM_R_EN_in(MEM_R_EN_exe_out),
		.MEM_W_EN_in(MEM_W_EN_exe_out),    
		.PC_in(exe_pc_stage), 
		.ALU_result_in(ALU_result),
		.ST_val_in(Val_Rm_exe_out),
		.Dest_in(Dest_exe_out), 
		.PC(exe_pc_stage_reg),
		.WB_en(WB_EN_exe_reg_out), 
		.MEM_R_EN(MEM_R_EN_exe_reg_out), 
		.MEM_W_EN(MEM_W_EN_exe_reg_out),
		.ALU_result(ALU_result_exe_reg_out),
		.ST_val(Val_Rm_exe_reg_out),
		.Dest(Dest_exe_reg_out)			    
	);

	MEM_Stage mem_stage (
		.clk(clk),
		.rst(rst),
		.PC_in(exe_pc_stage_reg),
		.WB_en_in(WB_EN_exe_reg_out),
		.Mem_R_en_in(MEM_R_EN_exe_reg_out),
		.Mem_W_en_in(MEM_W_EN_exe_reg_out),
		.ALU_result_in(ALU_result_exe_reg_out),
		.Val_Rm(Val_Rm_exe_reg_out),
		.Dest_in(Dest_exe_reg_out),
		.PC(mem_pc_stage),
		.WB_en(WB_EN_mem_out),
		.Mem_R_en(MEM_R_EN_mem_out),
		.ALU_result(ALU_result_mem_out),
		.Dest(Dest_mem_out),
		.Data_mem_out(Data_mem_out)
	);

	MEM_Stage_Reg mem_stage_reg (
		.clk(clk),
		.rst(rst),
		.WB_en_in(WB_EN_mem_out),
		.Mem_R_en_in(MEM_R_EN_mem_out),
		.PC_in(mem_pc_stage),
		.ALU_result_in(ALU_result_mem_out),
		.Mem_read_value_in(Data_mem_out),
		.Dest_in(Dest_mem_out),
		.PC(mem_pc_stage_reg),
		.WB_en(WB_EN_mem_reg_out),
		.Mem_R_en(MEM_R_EN_mem_reg_out),
		.ALU_result(ALU_result_mem_reg_out),
		.Mem_read_value(Data_mem_reg_out),
		.Dest(Dest_mem_reg_out),
	);

	WB_Stage wb_stage (
		.clk(clk),
		.rst(rst),
		.PC_in(mem_pc_stage_reg),
		.Dest_in(Dest_mem_reg_out),
		.ALU_result(ALU_result_mem_reg_out),
		.MEM_result(Data_mem_reg_out),
		.MEM_R_en(MEM_R_EN_mem_reg_out),
		.WB_en_in(WB_EN_mem_reg_out),
		.PC(wb_pc_stage),
		.Dest(Dest_wb_out),
		.WB_en(WB_EN_wb_out),
		.out(outp),
	);
	
	Status_Register status_regist(
		.clk(clk),
		.rst(rst),
		.s(S_reg_out),
		.status_in(status_exe),
		.status_out(SR)
	);

	Hazard_Detection_Unit hazard_unit(
		.src1(src1),
		.src2(src2),
		.Exe_Dest(Dest_out),
		.Exe_WB_EN(WB_EN_reg_id_out),
		.Mem_Dest(Dest_exe_reg_out),
		.Mem_WB_EN(WB_EN_exe_reg_out),
		.With_Two_Source(Two_src),
		.Forwarding_Enable(Forwarding_Enable),
		.EXE_mem_read(MEM_R_EN_exe_out),
		.hazard_Detected(hazard)
	);

	Forwrding_Unit forward_unit(
		.Forwarding_Enable(Forwarding_Enable),
 		.src1(src_1_out),
		.src2(src_2_out),
  		.MEM_WB_EN(WB_EN_exe_reg_out), 
		.WB_EN(WB_EN_wb_out), 
  		.MEM_Dest(Dest_exe_reg_out), 
		.WB_Dest(Dest_wb_out),
  		.Sel_Src1(sel_src1), 
		.Sel_Src2(sel_src2)
	);

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
endmodule


