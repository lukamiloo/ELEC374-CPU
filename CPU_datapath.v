`timescale 1ns/10ps
module CPU_datapath(

	input PCout,          	////missing not onwure from 32 bit mux to conff not-zero and gate
									//
	input Zhighout,
	input Zlowout,  
	input MDRout, 
	input MARin, 
	input MDRin,   	
	input PCin, 
	input IRin,
	input Yin,
	input Yout,
	input IncPC,
	input Read,
	input clk,
	input [31:0]MDatain, 	
	input rst,                       
	input HIin,                                
	input LOin,
	input HIout, 
	input LOout,                		
	input ZIn,
	input Cout, //gonna have problems
	input RAMin,
	input RAMrd,
	input GRA,								
	input GRB,                       
	input GRC, 	
	input Baout,
	input enableCon,//problem
	input R_enableIn, 
	input Rout_in,
	input enableInPort,
	input enableOutPort,
	input InPortout, 
	input [31:0] InPort_input,
	output  [31:0]OutPort_output,
	output [4:0] opcode,	
	output conFF,
	output [31:0]IRout,
	
	
	output [31:0] bus_cont
	//output [63:0] alu_out
	
	
); 
	
	
	
	wire [31:0] bus_out;
	wire conOut;
	wire [31:0] OutPort_dout;
	assign bus_cont = bus_out;
	assign conFF = conOut;
	assign OutPort_output = OutPort_dout;
	
	
	
	wire R0out = 0;
	wire R1out = 0;
	wire R2out = 0;
	wire R3out = 0;
	wire R4out = 0;
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
	//wire HIout = 0;
	//wire LOout = 0;
	//wire InPortout = 0;
	//wire Cout = 0;	
	wire [31:0] encoder_in;
	wire [31:0] MDout;
	wire [4:0] op;
	wire [15:0] Renable;
	wire [15:0] RegOut;
	wire [31:0] Mdatain;
 	
	assign opcode = op;	
	//assign MDatain = Mdatain;
	 
	

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
//wire [31:0] OutPort_dout;
wire [31:0] C_sign_ex_dout;
wire [63:0] alu_dout;
//wire BA_out;
//wire [31:0] ALU_dout;

//assign alu_out = alu_dout;
assign OutPort_output = OutPort_dout;
assign IRout = IR_dout;

mem ram(
	.clock (clk),
	.data (bus_out),
	.address (MAR_dout[8:0]),
	.wren (RAMin),
	.rden (RAMrd),
	.q (Mdatain)
);


select_encode sel_en(
	.IR (IR_dout),
	.Gra (GRA),
	.Grb (GRB),
	.Grc (GRC),
	.Rin (R_enableIn),
	.Rout (Rout_in),
	.BAout (Baout),
	.Renable (Renable),
	.R_out (RegOut),
	.Csign (C_sign_ex_dout),
	.opcode (op)
);

wire con_out;
conFF conff(
	.c2 (IR_dout[20:19]),
	.bus_in (bus_out),
	.con_out(con_out)

);

flipflop ff(
	.clk (clk), 
	.d(con_out), 
	.q(conOut), 
	.q_()
);



register R0 (.clk (clk), .rst (rst), .enable (Renable[0]), .d (bus_out), .q (R0_dout));
register R1 (.clk (clk), .rst (rst), .enable (Renable[1]), .d (bus_out), .q (R1_dout));
register R2 (.clk (clk), .rst (rst), .enable (Renable[2]), .d (bus_out), .q (R2_dout));
register R3 (.clk (clk), .rst (rst), .enable (Renable[3]), .d (bus_out), .q (R3_dout));
register R4 (.clk (clk), .rst (rst), .enable (Renable[4]), .d (bus_out), .q (R4_dout));
register R5 (.clk (clk), .rst (rst), .enable (Renable[5]), .d (bus_out), .q (R5_dout));
register R6 (.clk (clk), .rst (rst), .enable (Renable[6]), .d (bus_out), .q (R6_dout));
register R7 (.clk (clk), .rst (rst), .enable (Renable[7]), .d (bus_out), .q (R7_dout));
register R8 (.clk (clk), .rst (rst), .enable (Renable[8]), .d (bus_out), .q (R8_dout));
register R9 (.clk (clk), .rst (rst), .enable (Renable[9]), .d (bus_out), .q (R9_dout));
register R10 (.clk (clk), .rst (rst), .enable (Renable[10]), .d (bus_out), .q (R10_dout));
register R11 (.clk (clk), .rst (rst), .enable (Renable[11]), .d (bus_out), .q (R11_dout));
register R12 (.clk (clk), .rst (rst), .enable (Renable[12]), .d (bus_out), .q (R12_dout));
register R13 (.clk (clk), .rst (rst), .enable (Renable[13]), .d (bus_out), .q (R13_dout));
register R14 (.clk (clk), .rst (rst), .enable (Renable[14]), .d (bus_out), .q (R14_dout));
register R15 (.clk (clk), .rst (rst), .enable (Renable[15]), .d (bus_out), .q (R15_dout));
PC PC (.clk (clk), .rst (rst), .IncPC(IncPC), .enable (PCin), .d (bus_out), .q (PC_dout));
register IR (.clk (clk), .rst (rst), .enable (IRin), .d (bus_out), .q (IR_dout));



register MAR (.clk (clk), .rst (rst), .enable (MARin), .d (bus_out), .q (MAR_dout));
register HI (.clk (clk), .rst (rst), .enable (HIin), .d (bus_out), .q (HI_dout));
register LO (.clk (clk), .rst (rst), .enable (LOin), .d (bus_out), .q (LO_dout));
register Y (.clk (clk), .rst (rst), .enable (Yin), .d (bus_out), .q (Y_dout));
register InPort (.clk (clk), .rst (rst), .enable (enableInPort), .d (bus_out), .q (InPort_dout));
register OutPort (.clk (clk), .rst (rst), .enable (enableOutPort), .d (bus_out), .q (OutPort_dout));
//register C_sign_ex (.clk (clk), .rst (rst), .enable (Cin), .d (bus_out), .q (C_sign_ex_dout));//problem
// general purpose reisters

register_64 Z (.clk (clk), .rst (rst), .enable (ZIn), .d (alu_dout), .high(Zhigh_dout), .low(Zlow_dout));
	
wire [4:0]encoderToMux;

		assign encoder_in = {
								{8{1'b0}},
								Cout,//probelm
								InPortout,
								MDRout,
								PCout,
								Zlowout,
								Zhighout,
								LOout,
								HIout,
								RegOut
								};
		
	
//wire [31:0] AluOUT;
 
wire [31:0] R0_dat;
assign R0_dat = (~Baout) & R0_dout;//problem


encoder32_5 encoder (
	.encoderIn (encoder_in),
	.encoderOut (encoderToMux)
); 

mux_32_5 mux1 (
	.BusMuxIn_R0 (R0_dat),
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
	.ALU_Sel (op),
	.ALU_Result (alu_dout)
);




endmodule
	