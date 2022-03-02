`timescale 1ns/10ps
module encoder32_5 (
	input wire [31:0] encoderIn, // 32 encoder inputs
	output reg [4:0] encoderOut // 5 output signals
	//input  enable 
);

//input wire [31:0] encoderIn; // 32 encoder inputs
//output reg [4:0] encoderOut; // 5 output signals
//input  enable; 
	
	always@(*) begin
	// Switch for determining encoder output
		case(encoderIn)
			32'h00000001 : encoderOut <= 5'd0;   
			32'h00000002 : encoderOut <= 5'd1;     
			32'h00000004 : encoderOut <= 5'd2;      
			32'h00000008 : encoderOut <= 5'd3;     
			32'h00000010 : encoderOut <= 5'd4;     
			32'h00000020 : encoderOut <= 5'd5;      
			32'h00000040 : encoderOut <= 5'd6;    
			32'h00000080 : encoderOut <= 5'd7;     
			32'h00000100 : encoderOut <= 5'd8;     
			32'h00000200 : encoderOut <= 5'd9;      
			32'h00000400 : encoderOut <= 5'd10;    
			32'h00000800 : encoderOut <= 5'd11;   
			32'h00001000 : encoderOut <= 5'd12;    
			32'h00002000 : encoderOut <= 5'd13;  
			32'h00004000 : encoderOut <= 5'd14; 
			32'h00008000 : encoderOut <= 5'd15; 
			32'h00010000 : encoderOut <= 5'd16;     
			32'h00020000 : encoderOut <= 5'd17;     
			32'h00040000 : encoderOut <= 5'd18;  
			32'h00080000 : encoderOut <= 5'd19;   
			32'h00100000 : encoderOut <= 5'd20;     
			32'h00200000 : encoderOut <= 5'd21;
			32'h00400000 : encoderOut <= 5'd22; 
			32'h00800000 : encoderOut <= 5'd23;     
			default: encoderOut <= 5'd31;
		endcase
	end
endmodule
