
module shl_logic(
	input wire [31:0] in,
	input wire [31:0] shift,
	output wire [31:0] out
);
	assign out[31:0] = in << shift;

endmodule 