`timescale 1ns/10ps

module brnz_tb;
	reg clk, clr;
	reg IncPC, CON_enable; 
	reg [31:0] Mdatain;
	wire [31:0] bus_contents;
	reg RAM_write, RAM_read, MDR_enable, MDRout, MAR_enable, IR_enable;
	reg MDR_read;
	reg R_enable, Rout;
	reg Gra, Grb, Grc;
	reg HI_enable, LO_enable, ZIn, Y_enable, PC_enable, InPort_enable, OutPort_enable;
	reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
	wire [4:0] opcode;
	wire[31:0] OutPort_output;
	wire conOut;
	reg [31:0] InPort_input;
	
	parameter Default = 4'b0000, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
	reg [3:0] Present_state = Default;

	CPU_datapath DUT(	
		.PCout(PCout),          	
		.Zhighout(ZHighout),
		.Zlowout(ZLowout),  
		.MDRout(MDRout), 
		.MARin(MAR_enable), 
		.MDRin(MDR_enable),   	
		.PCin(PC_enable), 
		.IRin(IR_enable),
		.Yin(Y_enable),
		.Yout(Yout),
		.IncPC(IncPC),
		.Read(MDR_read),
		.clk(clk),
		.MDatain(Mdatain), 	
		.rst(clr),                       
		.HIin(HI_enable),                                
		.LOin(LO_enable),
		.HIout(HIout), 
		.LOout(LOout),                		
		.ZIn(ZIn),
		.Cout(Cout),
		.RAMin(RAM_write),
		.RAMrd(RAM_read),
		.GRA(Gra),								
		.GRB(Grb),                       
		.GRC(Grc), 	
		.Baout(BAout),
		.enableCon(CON_enable),
		.R_enableIn(R_enable), 
		.Rout_in(Rout),
		.enableInPort(InPort_enable),
		.enableOutPort(OutPort_enable),
		.InPortout(InPortout), 
		.InPort_input(InPort_input),
		.OutPort_output(OutPort_output),
		.bus_cont(bus_contents),
		.opcode(opcode),
		.conFF(conOut)	
);

initial
	begin
		DUT.CPU_datapath.R1.q = 32'd8; //instruction :10010 0001 0001 0000000000000101011
		DUT.CPU_datapath.R2.q = 32'd2;
		DUT.CPU_datapath.PC.q = 32'd0;
		
		clk = 0;
		clr = 0;
end

always
		#10 clk <= ~clk;

always @(posedge clk) 
	begin
		case (Present_state)
			Default			:	#40 Present_state = T0;
			T0					:	#40 Present_state = T1;
			T1					:	#40 Present_state = T2;
			T2					:	#40 Present_state = T3;
			T3					:	#40 Present_state = T4;
			T4					:	#40 Present_state = T5;
			T5					:	#40 Present_state = T6;
		endcase
end

always @(Present_state) 
	begin
	#10 
		case (Present_state) 
			Default: begin 
				PCout <= 0; ZLowout <= 0; MDRout <= 0; 
				MAR_enable <= 0; ZIn <= 0; CON_enable<=0; 
				InPort_enable<=0; OutPort_enable<=0;
				InPort_input<=32'd0;
				PC_enable <=0; MDR_enable <= 0; IR_enable <= 0; 
				Y_enable <= 0;
				IncPC <= 0; RAM_write<=0;
				Mdatain <= 32'h00000000; Gra<=0; Grb<=0; Grc<=0;
				BAout<=0; Cout<=0;
				InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				HI_enable<=0; LO_enable<=0;
				Rout<=0;R_enable<=0;MDR_read<=0; RAM_read <= 0; Yout <= 0;
				
				// how to correctly use enables
			end	
						
			

T0: begin 
	 PCout <= 1; MAR_enable <= 1;RAM_read <= 1; IncPC <=1; 
	 #19 IncPC <= 0;
end

T1: begin 
		MAR_enable <= 0;  PCout <= 0; 
		MDR_read <= 1; MDR_enable <= 1; 
end

T2: begin
	   MDR_read <= 0; MDR_enable <= 0; RAM_read <= 0;  ZLowout <= 0; 
	   MDRout <= 1; IR_enable <= 1; 
end

T3: begin
	 MDRout <= 0; IR_enable <= 0;	
	 Gra <= 1;  Rout<=1; CON_enable <= 1;
end

T4: begin
	 Gra <= 0; Rout<=0; CON_enable <= 0;
	 PCout <= 1 ; Y_enable <= 1;
end

T5: begin
	 PCout <= 0;  Y_enable <= 0;
	 Cout <= 1; ZIn <=1;
end

T6: begin
	 Cout <= 0; ZIn <= 0;
	 ZLowout <= 1; PC_enable <= conOut; 
end

endcase

end

endmodule