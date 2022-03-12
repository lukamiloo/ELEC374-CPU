`timescale 1ns/10ps
module CPU_datapath(

	input [31:0] Mdatain,
	input clk, 
	input rst,
	
	input PCout,
	input Zhighout,
	input Zlowout,
	input MDRout,
	input R2out,
	input R4out,
	input MARin,
	input PCin,
	input MDRin,
	input IRin,
	input Yin,
	input IncPC,
	input Read,
   input wire [4:0] AND,		
	input R5in,
	input R2in,
	input R4in,
	input R1in, 
	input R3in, 
	input R6in, 
	input R7in, 
	input R8in, 
	input R9in, 
	input R10in, 
	input R11in,
	input R12in, 
	input R13in, 
	input R14in, 
	input R15in, 
	input HIin, 
	input LOin, 
	input Zin, 
	
	input Cin,
	
	
	output [31:0] bus_cont,
	output [63:0] alu_out
	
	
); 
	

	
	wire [31:0] bus_out;
	assign bus_cont = bus_out;
	
	
	
	wire R0out = 0;
	wire R1out = 0;
	//wire R2out;
	wire R3out = 0;
	//wire R4out;
	wire R5out = 0;
	wire R6out = 0;
	wire R7out = 0;
	wire R8out = 0;
	wire R9out = 0;
	wire R10out = 0;
	wire R11out = 0;
	wire R12out = 0;
	wire R13out = 0;
	wire R14out = 0;
	wire R15out = 0;
	wire HIout = 0;
	wire LOout = 0;
	wire InPortout = 0;
	wire Cout = 0;	
	wire [31:0] encoder_in;
	wire [31:0] MDout;
	
							
	 
	
		assign encoder_in = {
								{8{1'b0}},
								Cout,
								InPortout,
								MDRout,
								PCout,
								Zlowout,
								Zhighout,
								LOout,
								HIout,
								R15out,
								R14out,
								R13out,
								R12out,
								R11out,
								R10out,
								R9out,
								R8out,
								R7out,
								R6out,
								R5out,
								R4out,
								R3out,
								R2out,
								R1out,
								R0out
								};
		
	
wire [31:0] R0_dout;
wire [31:0] R1_dout;
wire [31:0] R2_dout;
wire [31:0] R3_dout;
wire [31:0] R4_dout;
wire [31:0] R5_dout;
wire [31:0] R6_dout;
wire [31:0] R7_dout;
wire [31:0] R8_dout;
wire [31:0] R9_dout;
wire [31:0] R10_dout;
wire [31:0] R11_dout;
wire [31:0] R12_dout;
wire [31:0] R13_dout;
wire [31:0] R14_dout;
wire [31:0] R15_dout;
wire [31:0] PC_dout;
wire [31:0] IR_dout;
wire [31:0] Zlow_dout;
wire [31:0] Zhigh_dout;
wire [31:0] MDR_dout;
wire [31:0] MAR_dout;
wire [31:0] HI_dout;
wire [31:0] LO_dout;
wire [31:0] Y_dout;
wire [31:0] InPort_dout;
wire [31:0] C_sign_ex_dout;
wire [63:0] C_dout;
//wire [31:0] ALU_dout;

assign alu_out = C_dout;

register R0 (.clk (clk), .rst (rst), .enable (1'b0), .d (bus_out), .q (R0_dout));
register R1 (.clk (clk), .rst (rst), .enable (R1in), .d (bus_out), .q (R1_dout));
register R2 (.clk (clk), .rst (rst), .enable (R2in), .d (bus_out), .q (R2_dout));
register R3 (.clk (clk), .rst (rst), .enable (R3in), .d (bus_out), .q (R3_dout));
register R4 (.clk (clk), .rst (rst), .enable (R4in), .d (bus_out), .q (R4_dout));
register R5 (.clk (clk), .rst (rst), .enable (R5in), .d (bus_out), .q (R5_dout));
register R6 (.clk (clk), .rst (rst), .enable (R6in), .d (bus_out), .q (R6_dout));
register R7 (.clk (clk), .rst (rst), .enable (R7in), .d (bus_out), .q (R7_dout));
register R8 (.clk (clk), .rst (rst), .enable (R8in), .d (bus_out), .q (R8_dout));
register R9 (.clk (clk), .rst (rst), .enable (R9in), .d (bus_out), .q (R9_dout));
register R10 (.clk (clk), .rst (rst), .enable (R10in), .d (bus_out), .q (R10_dout));
register R11 (.clk (clk), .rst (rst), .enable (R11in), .d (bus_out), .q (R11_dout));
register R12 (.clk (clk), .rst (rst), .enable (R12in), .d (bus_out), .q (R12_dout));
register R13 (.clk (clk), .rst (rst), .enable (R13in), .d (bus_out), .q (R13_dout));
register R14 (.clk (clk), .rst (rst), .enable (R14in), .d (bus_out), .q (R14_dout));
register R15 (.clk (clk), .rst (rst), .enable (R15in), .d (bus_out), .q (R15_dout));
register PC (.clk (clk), .rst (rst), .enable (PCin), .d (bus_out), .q (PC_dout));
register IR (.clk (clk), .rst (rst), .enable (IRin), .d (bus_out), .q (IR_dout));



register MAR (.clk (clk), .rst (rst), .enable (MARin), .d (bus_out), .q (MAR_dout));
register HI (.clk (clk), .rst (rst), .enable (HIin), .d (bus_out), .q (HI_dout));
register LO (.clk (clk), .rst (rst), .enable (LOin), .d (bus_out), .q (LO_dout));
register Y (.clk (clk), .rst (rst), .enable (Yin), .d (bus_out), .q (Y_dout));
register InPort (.clk (clk), .rst (rst), .enable (IncPC), .d (bus_out), .q (InPort_dout));
register C_sign_ex (.clk (clk), .rst (rst), .enable (Cin), .d (bus_out), .q (C_sign_ex_dout));
// general purpose reisters

register_64 Z (.clk (clk), .rst (rst), .enable (Zin), .d (C_dout), .high(Zhigh_dout), .low(Zlow_dout));
	
wire [4:0]encoderToMux;


//wire [31:0] AluOUT;
 
encoder32_5 encoder (
	.encoderIn (encoder_in),
	.encoderOut (encoderToMux)
); 

mux_32_5 mux1 (
	.BusMuxIn_R0 (R0_dout),
	.BusMuxIn_R1 (R1_dout),	
	.BusMuxIn_R2 (R2_dout),
	.BusMuxIn_R3 (R3_dout),
	.BusMuxIn_R4 (R4_dout),
	.BusMuxIn_R5 (R5_dout),
	.BusMuxIn_R6 (R6_dout),
	.BusMuxIn_R7 (R7_dout),
	.BusMuxIn_R8 (R8_dout),
	.BusMuxIn_R9 (R9_dout),
	.BusMuxIn_R10 (R10_dout),
	.BusMuxIn_R11 (R11_dout),
	.BusMuxIn_R12 (R12_dout),
	.BusMuxIn_R13 (R13_dout),
	.BusMuxIn_R14 (R14_dout),
	.BusMuxIn_R15 (R15_dout),
	
	.BusMuxIn_HI (HI_dout),
	.BusMuxIn_LO (LO_dout),
	.BusMuxIn_Zhigh (Zhigh_dout),
	.BusMuxIn_Zlow (Zlow_dout),
	.BusMuxIn_PC (PC_dout),
	.BusMuxIn_MDR (MDR_dout),
	.BusMuxIn_InPort (InPort_dout),
	.BusMuxIn_C_Sign_Extended (C_sign_ex_dout),
	
	.BusMux_Out (bus_out),//output of multiplexer
	
	.signal_select (encoderToMux)
);

MDMUX mdmux (
	.BusMuxOut (bus_out),
	.MDataIn (Mdatain),
	.Read (Read),
	.MDMuxOut (MDout)
);

register MDR (.clk (clk), .rst (rst), .enable (MDRin), .d (MDout), .q(MDR_dout));


ALU alu (
	.clk(clk),
	.clr(rst),
	.A (Y_dout),
	.B (bus_out),
	.ALU_Sel (AND),
	.ALU_Result (C_dout)
);


endmodule
	