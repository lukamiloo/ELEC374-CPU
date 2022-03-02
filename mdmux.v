// most likely needs work
`timescale 1ns/10ps
module MDMUX (
	output reg [31:0] MDMuxOut,
	input wire[31:0] BusMuxOut,
	input wire[31:0] MDataIn,
	input wire Read
);

	always@(*) begin
		if(Read) begin
			MDMuxOut[31:0] = MDataIn[31:0];
		end
		else begin
			MDMuxOut[31:0] = BusMuxOut[31:0];
		end
	end
endmodule
//`timescale 1ns/10ps
//module MDR(
//	input [31:0] inputD,
//	output reg [31:0] outputQ,
//	input Clock,
//	input write_enable,
//	input Clear
//);
//
//	initial outputQ = 0;
//	
//	always@(posedge Clock) 
//	begin
//		if (Clear) begin
//			outputQ[31:0] <= 32'b0;
//		end
//		else if (write_enable) begin
//			outputQ = inputD;
//		end 
//	end
//
////input [31:0] inputD;
////output [31:0] outputQ;
//
//endmodule



