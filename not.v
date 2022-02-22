
module not_logic(
	input wire [31:0] Ra,
	output wire [31:0] Rb
);
	
	genvar i;
	generate
		for (i=0; i<32; i=i+1) begin : loop
			assign Rb[i] = !Ra[i];
		end
	endgenerate
endmodule
