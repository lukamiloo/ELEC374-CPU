// creating registers - not sure if it works

module register(
	input wire clk, 
	input wire rst,
	input wire enable,
	input wire [31:0] d,
	output reg [31:0] q
);


	
	always@(posedge clk) 
	begin
		if (rst) begin
			q = 32'b0;
		end
		else if(enable) begin
			q = d;
		end 
	end
endmodule
