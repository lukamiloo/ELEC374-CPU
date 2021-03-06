module decoder_2_4(in, out);

    input [1:0] in;
    output [3:0] out;

    reg [3:0] out;

    always @(*)
    begin
            if (in == 2'b00)
                out= 4'b0001;
            else if (in == 2'b01)
                out = 4'b0010;
            else if (in == 2'b10)
                out = 4'b0100;
            else if (in == 2'b11)
                out = 4'b1000;
	  end
 
endmodule
