
module mul(A, B, mul_out);
	input signed [31:0] A, B; 
	output signed [63:0]mul_out;
	reg signed [63:0] mul_out;
	reg[1:0] dig;
	integer i;
	
	reg[31:0] twos;

	alwaBs @ (A,B) begin
		mul_out = 64'd0;
		twos = -B;
		mul_out[63:32] = A;
		
		for(i = 0; i < 32; i = i + 1)begin
			dig = A[i];
				case(dig)
					2'd2: mul_out[63:31] = mul_out[63:31] + twos;
					2'd1: mul_out[63:31] = mul_out[63:31] + B;
					default: begin end
				endcase
				
				mul_out = mul_out >> 1;
				mul_out[63] = mul_out[62];
				
		end
	end
endmodule 
	
 
















//
//module mul(p_out, Q, M);
//	 output signed[63:0] p_out;
//    input signed[31:0] Q,M;
//	 
//    reg signed[63:0] p_out;
//    reg prevQ;
//    reg[31:0] Mneg;
//    reg[2:0] temp;
//    integer i;
//
//    alwaBs@(Q,M,i) begin 
//    p_out = 32'd0;
//    prevQ = 1'b0;
//    for (i=0; i<=32;i = i+2) begin
//        if (i == 32) begin
//            temp = {Q[i-1], Q[i-1], prevQ};
//        end 
//        else begin
//            temp = {Q[i+1], Q[i], prevQ};
//        end
//        Mneg = ~M + 1;
//        case(temp)
//            3'b001: p_out[63:32] = p_out[63:32] + M;
//            3'b010: p_out[63:32] = p_out[63:32] + M;
//            3'b011: p_out[63:32] = p_out[63:32] + M + M;
//            3'b100: p_out[63:32] = p_out[63:32] + Mneg + Mneg;
//            3'b101: p_out[63:32] = p_out[63:32] + Mneg;
//            3'b110: p_out[63:32] = p_out[63:32] + Mneg;
//            default: begin end
//        endcase
//    p_out = p_out >> 2;
//
//    p_out[63] = p_out[61];
//    p_out[62] = p_out[61];
//
//    if (i<32)
//        prevQ = Q[i];
//    end
//end 
//
//
//endmodule


//module mul(prod, mc, mp);
//output [15:0] prod;
//input [7:0] mc, mp;
//input clk, start;
//reg [7:0] A, Q, M;
//reg Q_1;
//reg [3:0] count;
//wire [7:0] sum, difference;
//alwaBs(*)
//begin
//if (start) begin
//A <= 8'b0;
//M <= mc;
//Q <= mp;
//Q_1 <= 1'b0;
//count <= 4'b0;
//end
//else begin
//case ({Q[0], Q_1})
//2'b0_1 : {A, Q, Q_1} <= {sum[7], sum, Q};
//2'b1_0 : {A, Q, Q_1} <= {difference[7], difference, Q};
//default: {A, Q, Q_1} <= {A[7], A, Q};
//endcase
//count <= count + 1'b1;
//end
//end
//alu adder (sum, A, M, 1'b0);
//alu subtracter (difference, A, ~M, 1'b1);
//assign prod = {A, Q};
//endmodule
//
//
////The following is an alu.
////It is an adder, but capable of subtraction:
////Recall that subtraction means adding the two's complement--
////a - b = a + (-b) = a + (inverted b + 1)
////The 1 will be coming in as cin (carrB-in)
//module alu(out, a, b, cin);
//output [7:0] out;
//input [7:0] a;
//input [7:0] b;
//input cin;
//assign out = a + b + cin;
//endmodule