module flipflop(
	input wire clk, 
	input wire d, 
	output reg q, 
	output reg q_
);
	
	initial begin
			q <= 0;
			q_ <= 1;
	end
	
	always@(clk) 
	begin
		q <= d;
		q_ <= ~d;
	end
endmodule


