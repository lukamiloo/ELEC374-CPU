
module CPU_datapath(
	input clk, 
	input rst,
	input R0in,
	input R1in,
	input R2in,
	input R3in,
	input R4in,
	input R5in,
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
	input ZHighIn, 
	input Cin, 
	input ZLowIn,
	input MARin, 
	input PCin, 
	input MDRin, 
	input IRin, 
	input Yin
	//input IncPC, Read;
);

//output wire enableselect;



register R0 (.clk (clk), .rst (rst), .enable (R0in), .d (BusMuxOUT), .q (R0_out));
register R1 (.clk (clk), .rst (rst), .enable (R1in), .d (BusMuxOUT), .q (R1_out));
register R2 (.clk (clk), .rst (rst), .enable (R2in), .d (BusMuxOUT), .q (R2_out));
register R3 (.clk (clk), .rst (rst), .enable (R3in), .d (BusMuxOUT), .q (R3_out));
register R4 (.clk (clk), .rst (rst), .enable (R4in), .d (BusMuxOUT), .q (R4_out));
register R5 (.clk (clk), .rst (rst), .enable (R5in), .d (BusMuxOUT), .q (R5_out));
register R6 (.clk (clk), .rst (rst), .enable (R6in), .d (BusMuxOUT), .q (R6_out));
register R7 (.clk (clk), .rst (rst), .enable (R7in), .d (BusMuxOUT), .q (R7_out));
register R8 (.clk (clk), .rst (rst), .enable (R8in), .d (BusMuxOUT), .q (R8_out));
register R9 (.clk (clk), .rst (rst), .enable (R9in), .d (BusMuxOUT), .q (R9_out));
register R10 (.clk (clk), .rst (rst), .enable (R10in), .d (BusMuxOUT), .q (R10_out));
register R11 (.clk (clk), .rst (rst), .enable (R11in), .d (BusMuxOUT), .q (R11_out));
register R12 (.clk (clk), .rst (rst), .enable (R12in), .d (BusMuxOUT), .q (R12_out));
register R13 (.clk (clk), .rst (rst), .enable (R13in), .d (BusMuxOUT), .q (R13_out));
register R14 (.clk (clk), .rst (rst), .enable (R14in), .d (BusMuxOUT), .q (R14_out));
register R15 (.clk (clk), .rst (rst), .enable (R15in), .d (BusMuxOUT), .q (R15_out));
register PC (.clk (clk), .rst (rst), .enable (PCin), .d (BusMuxOUT), .q (PC_out));
register IR (.clk (clk), .rst (rst), .enable (IRin), .d (BusMuxOUT), .q (IR_out));
register Zlow (.clk (clk), .rst (rst), .enable (ZLowIn), .d (BusMuxOUT), .q (Zlow_out));
register Zhigh (.clk (clk), .rst (rst), .enable (ZHighIn), .d (BusMuxOUT), .q (Zhigh_out));

register MAR (.clk (clk), .rst (rst), .enable (MARin), .d (BusMuxOUT), .q (MAR_out));
register HI (.clk (clk), .rst (rst), .enable (HIin), .d (BusMuxOUT), .q (HI_out));
register LO (.clk (clk), .rst (rst), .enable (LOin), .d (BusMuxOUT), .q (LO_out));
register Y (.clk (clk), .rst (rst), .enable (Yin), .d (AluOUT), .q (Y_out));
register InPort (.clk (clk), .rst (rst), .enable (), .d (), .q (InPort_out));
register C_sign_ex (.clk (clk), .rst (rst), .enable (Cin), .d (BusMuxOUT), .q (C_sign_ex_out));
// general purpose wireisters

wire [31:0] R0_out;
wire [31:0] R1_out;
wire [31:0] R2_out;
wire [31:0] R3_out;
wire [31:0] R4_out;
wire [31:0] R5_out;
wire [31:0] R6_out;
wire [31:0] R7_out;
wire [31:0] R8_out;
wire [31:0] R9_out;
wire [31:0] R10_out;
wire [31:0] R11_out;
wire [31:0] R12_out;
wire [31:0] R13_out;
wire [31:0] R14_out;
wire [31:0] R15_out;
wire [31:0] PC_out;
wire [31:0] IR_out;
wire [31:0] Zlow_out;
wire [31:0] Zhigh_out;
wire [31:0] MDR_out;
wire [31:0] MAR_out;
wire [31:0] HI_out;
wire [31:0] LO_out;
wire [31:0] Y_out;
wire [31:0] InPort_out;
wire [31:0] C_sign_ex_out;

wire [31:0] BusMuxOUT;
wire [4:0] encoderToMux;
wire [31:0] MDout;
wire [31:0] AluOUT;
 
encoder32_5 encoder (
	.encoderIn (),
	.enable (),
	.encoderOut(encoderToMux)

);

mux_32_5 mux1 (
	.BusMuxIn_R0 (R0_out),//general purpose wireisters R1-R15	
	.BusMuxIn_R1 (R1_out),	
	.BusMuxIn_R2 (R2_out),
	.BusMuxIn_R3 (R3_out),
	.BusMuxIn_R4 (R4_out),
	.BusMuxIn_R5 (R5_out),
	.BusMuxIn_R6 (R6_out),
	.BusMuxIn_R7 (R7_out),
	.BusMuxIn_R8 (R8_out),
	.BusMuxIn_R9 (R9_out),
	.BusMuxIn_R10 (R10_out),
	.BusMuxIn_R11 (R11_out),
	.BusMuxIn_R12 (R12_out),
	.BusMuxIn_R13 (R13_out),
	.BusMuxIn_R14 (R14_out),
	.BusMuxIn_R15 (R15_out),
	
	.BusMuxIn_HI (HI_out),
	.BusMuxIn_LO (LO_out),
	.BusMuxIn_Zhigh (Zhigh_out),
	.BusMuxIn_Zlow (Zlow_out),
	.BusMuxIn_PC (PC_out),
	.BusMuxIn_MDR (MDR_out),
	.BusMuxIn_InPort (InPort_out),
	.BusMuxIn_C_Sign_Extended (C_sign_ex_out),
	
	.BusMux_Out (BusMuxOUT),//output of multiplexer
	
	.signal_select (encoderToMux)
);

MDMUX mdmux (
	.BusMuxOut (BusMuxOUT),
	.MdataIn (),
	.Read (),
	.MDMuxOut (MDout)
);

MDR mdr (
	.inputD (MDout),
	.outputQ (MDR_out),
	.Clear (),
	.Clock (),
	.MDRin ()
);

ALU alu (
	.A (BusMuxOUT),
	.B (BusMuxOUT),
	.ALU_Sel (),
	.ALU_Out (AluOUT)
);


// use 32:1 multiplexer with five slect input signals coming from a 32-to-5 encoder
endmodule



	