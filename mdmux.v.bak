// most likely needs work

module MDMUX (
	output reg [31:0] MDMuxOut,
	input [31:0] BusMuxOut,
	input [31:0] MdataIn,
	input Read
);

	always@(*) begin
		case(Read)
			
			1 : MDMuxOut = MdataIn[31:0];
			default: MDMuxOut = BusMuxOut[31:0];
		endcase
	end
endmodule

module MDR(
	input [31:0] inputD,
	output reg [31:0] outputQ,
	input clk,
	input write_enable,
	input clear
);

	//initial outputQ = Q_next;
	
	always@(posedge clk) 
	begin
		if (clear) begin
			outputQ[31:0] <= 32'b0;
		end
		else if (write_enable) begin
			outputQ[31:0] = inputD[31:0];
		end 
	end

//input [31:0] inputD;
//output [31:0] outputQ;

endmodule



