
`timescale 1ns/10ps

module register #(parameter init = 0)(
	input wire clk, 
	input wire rst,
	input wire enable,
	input wire [31:0] d,
	output reg [31:0] q
);


	initial q = init;
	always@(posedge clk) 
	begin
		if (rst) begin
			q = 32'b0;
		end
		else if(enable) begin
			q[31:0] = d[31:0];
		end 
	end
endmodule
