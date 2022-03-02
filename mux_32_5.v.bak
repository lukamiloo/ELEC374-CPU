module mux_32_5(

	input [31:0] BusMuxIn_R0,//general purpose registers R1-R15	
	input [31:0] BusMuxIn_R1,	
	input [31:0] BusMuxIn_R2,
	input [31:0] BusMuxIn_R3,
	input [31:0] BusMuxIn_R4,
	input [31:0] BusMuxIn_R5,
	input [31:0] BusMuxIn_R6,
	input [31:0] BusMuxIn_R7,
	input [31:0] BusMuxIn_R8,
	input [31:0] BusMuxIn_R9,
	input [31:0] BusMuxIn_R10,
	input [31:0] BusMuxIn_R11,
	input [31:0] BusMuxIn_R12,
	input [31:0] BusMuxIn_R13,
	input [31:0] BusMuxIn_R14,
	input [31:0] BusMuxIn_R15,
	
	input [31:0] BusMuxIn_HI,
	input [31:0] BusMuxIn_LO,
	input [31:0] BusMuxIn_Zhigh,
	input [31:0] BusMuxIn_Zlow,
	input [31:0] BusMuxIn_PC,
	input [31:0] BusMuxIn_MDR,
	input [31:0] BusMuxIn_InPort,
	input [31:0] BusMuxIn_C_Sign_Extended,
	
	output reg [31:0] BusMux_Out,//output of multiplexer
	
	input wire [4:0] signal_select//signal select coming from 32-5 encoder
);

	always@(*) begin
	
		case(signal_select)//signal select based on 5 bit binary input from encoder
			5'd0 : BusMux_Out = BusMuxIn_R0[31:0];
			5'd1 : BusMux_Out = BusMuxIn_R1[31:0];
			5'd2 : BusMux_Out = BusMuxIn_R2[31:0];
			5'd3 : BusMux_Out = BusMuxIn_R3[31:0];
			5'd4 : BusMux_Out = BusMuxIn_R4[31:0];
			5'd5 : BusMux_Out = BusMuxIn_R5[31:0];
			5'd6 : BusMux_Out = BusMuxIn_R6[31:0];
			5'd7 : BusMux_Out = BusMuxIn_R7[31:0];
			5'd8 : BusMux_Out = BusMuxIn_R8[31:0];
			5'd9 : BusMux_Out = BusMuxIn_R9[31:0];
			5'd10 : BusMux_Out = BusMuxIn_R10[31:0];
			5'd11 : BusMux_Out = BusMuxIn_R11[31:0];
			5'd12 : BusMux_Out = BusMuxIn_R12[31:0];
			5'd13 : BusMux_Out = BusMuxIn_R13[31:0];
			5'd14 : BusMux_Out = BusMuxIn_R14[31:0];
			5'd15 : BusMux_Out = BusMuxIn_R15[31:0];
			5'd16 : BusMux_Out = BusMuxIn_HI[31:0];
			5'd17 : BusMux_Out = BusMuxIn_LO[31:0];
			5'd18 : BusMux_Out = BusMuxIn_Zhigh[31:0];
			5'd19 : BusMux_Out = BusMuxIn_Zlow[31:0];
			5'd20 : BusMux_Out = BusMuxIn_PC[31:0];
			5'd21 : BusMux_Out = BusMuxIn_MDR[31:0];
			5'd22 : BusMux_Out = BusMuxIn_InPort[31:0];
			5'd23 : BusMux_Out = BusMuxIn_C_Sign_Extended[31:0];
			default : BusMux_Out = 32'd0;
		endcase
	end
endmodule



	