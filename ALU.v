module ALU(
	input wire clk,
	input wire clr,
	input wire[31:0] A,B,
	input wire[4:0] ALU_Sel,
	output reg[63:0] ALU_Result
	
);
	
    always @(*)
    begin
        case(ALU_Sel)
        5'b00011: // Addition
           ALU_Result = A + B ; 
        5'b00100: // Subtraction
           ALU_Result = A - B ;
        5'b01110: // Multiplication
           ALU_Result = A * B;
        5'b01111: // Division
           ALU_Result = A/B;
        5'b00110: // Logical shift left
           ALU_Result = A << B;
        5'b00101: // Logical shift right
           ALU_Result = A >> B;
        5'b01000: // Rotate left
           ALU_Result = (A << B)|(A >> (32 - B));
        5'b00111: // Rotate right
           ALU_Result = (A << B)|(A >> (32 - B));
        5'b01001: //  Logical and 
           ALU_Result = A & B;
        5'b01010: //  Logical or
           ALU_Result = A | B;
        5'b10001: //  Logical not 
           ALU_Result = ~A;
        5'b10000: //  Logical neg
           ALU_Result = ~A + 1;
          default: ALU_Result = A + B ; 
        endcase
    end
endmodule
