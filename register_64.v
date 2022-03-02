`timescale 1ns/10ps

module register_64 #(parameter qInitial = 0)(
	input wire clk, 
	input wire rst,
	input wire enable,
	input wire [63:0] d,
	output reg [31:0] high,
	output reg [31:0] low
);


	initial high = qInitial;
	initial low = qInitial;
	always@(posedge clk) 
	begin
		if (rst) begin
			high = 32'b0;
			low = 32'b0;
		end
		else if(enable) begin
			high[31:0] = d[63:32];
			low[31:0] = d[31:0];
		end 
	end
endmodule