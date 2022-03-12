`timescale 1ns/10ps
module ALU(
	input wire clk,
	input wire clr,
	input wire[31:0] A,B,
	input wire[4:0] ALU_Sel,
	output reg[63:0] ALU_Result
	
);
	wire [63:0] div_out;
	wire [63:0] mul_out;
	
    always @(*)
    begin
        case(ALU_Sel)
        5'b00011: // Add
           ALU_Result = A + B ; 
        5'b00100: // Sub
           ALU_Result = A - B ;
        5'b01110: // Mul
           ALU_Result = mul_out[63:0];
        5'b01111: begin//div 
			  ALU_Result = div_out[63:0];
			  end
        5'b00110: //shl
           ALU_Result = A << B;
        5'b00101: //shr
           ALU_Result = A >> B;
        5'b01000: begin// Rol
			  if (B < 32) begin
					ALU_Result = (A << B)|(A >> (32 - B));
			  end else 
					ALU_Result = (A << B%32)|(A >> (32 - B%32));
			  end
        5'b00111: begin// Ror
			  if (B < 32) begin
					ALU_Result = (A >> B)|(A << (32 - B));
			  end else
					ALU_Result = (A >> B%32)|(A << (32 - B%32));
				end
        5'b01001: //and 
           ALU_Result = A & B;
        5'b01010: //or
           ALU_Result = A | B;
        5'b10001: //not 
           ALU_Result = ~A;
        5'b10000: // neg
           ALU_Result = ~A + 1;
          default: ALU_Result = 64'b0; 
        endcase
    end
	 
	 
div DIV(. A(A), .B(B), .out(div_out));
mul MUL(. A(A), .B(B), .mul_out(mul_out));
endmodule






