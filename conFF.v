module conFF(
	input [1:0] c2,
	input [31:0] bus_in,
	input conin,
	output [31:0]con_out

);
	wire [3:0] decoder_out;
	wire[31:0] busa;
	
	decoder_2_4 decoder(c2,decoder_out);
		
	assign busa = ~(^bus_in);

	assign con_out = (decoder_out[0] & busa) | (decoder_out[1] & (~busa)) | (decoder_out[2] & (~bus_in)) | (decoder_out[3] & bus_in);
	
endmodule 