
`timescale 1ns/10ps

module PC #(parameter init = 0)(
	input wire clk, 
	input wire rst,
	input wire enable,
	input wire IncPC,
	input wire [31:0] d,
	output reg [31:0] q
);

	initial q = init;
	always@(posedge clk) 
	begin
		if (IncPC) begin
			q[31:0] = q[31:0] + 32'd1;
		end
		if (rst) begin
			q = 32'b0;
		end
		else if(enable) begin
			q[31:0] = d[31:0];
		end 
	end
endmodule
