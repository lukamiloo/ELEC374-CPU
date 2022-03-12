
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



