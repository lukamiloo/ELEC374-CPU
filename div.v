module div(
    input wire [31:0] A, 
    input wire [31:0] B, 
    output reg[63:0] out 

);
initial begin
	out = 64'b0;
end 
	always @(*) begin 
		begin
			out = {(A&B), (A-(A%B)) / B};
		end
	end
endmodule