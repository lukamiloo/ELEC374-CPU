module select_encode(
	input wire [31:0] IR,
	input wire Gra,
	input wire Grb,
	input wire Grc,
	input wire Rin,
	input wire Rout,
	input wire BAout,
	
	output [15:0] Renable,
	output [15:0] R_out,
	output [31:0] Csign, 
	output [4:0] opcode
);


	//wire [3:0] a;
	//wire [3:0] b;
	//wire [3:0] c;
	wire [3:0] decoder_in;
	wire [15:0] decoder_out;
	
	

	//AND(a, IR[26:23], {4{Gra}});
	//AND(b, IR[22:19], {4{Grb}});
	//AND(c, IR[18:15], {4{Grc}});
	
	assign decoder_in = (IR[26:23] & {4{Gra}}) |  (IR[22:19] & {4{Grb}})	| (IR[18:15] & {4{Grc}});
	//OR(decoder_in, a, b, c);

	decoder_4_16 decoder(
		.d_in (decoder_in),
		.d_out (decoder_out)
	);

	assign opcode = IR[31:27];
	
	assign Renable = {16{Rin}} & decoder_out;

	assign R_out = ({16{Rout}} | {16{BAout}}) & decoder_out;

	assign Csign = {{13{IR[18]}}, IR[18:0]};// should be c

endmodule