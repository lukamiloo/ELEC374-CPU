`timescale 1ns/10ps
module CU (
output reg	PCout, ZHighout, ZLowout, MDRout, MAR_enable, MDR_enable, PC_enable, IR_enable, Y_enable,
				Yout,IncPC, MDR_read,  HI_enable, LO_enable,HIout, LOout, ZIn, Cout, RAM_write,
				RAM_read, Gra, Grb, Grc, BAout, CON_enable, R_enable, Rout, InPort_enable, OutPort_enable, InPortout, 
			   
output reg [31:0]Mdatain,
output reg [31:0]InPort_input,
output reg [31:0]MDatain,				
input [31:0] IR,
input conOut,
input [4:0]opcode,
input [31:0]bus_contents,
input [31:0]OutPort_output,
output reg clk, rst
);
parameter Reset_state= 8'b00000000, fetch0 = 8'b00000001, fetch1 = 8'b00000010, fetch2= 8'b00000011, fetch3 = 8'b0101110,
							add3 = 8'b00000100, add4= 8'b00000101, add5= 8'b00000110, 
							sub3 = 8'b00000111, sub4 = 8'b00001000, sub5 = 8'b00001001, 
							and3 = 8'b00001010, and4 = 8'b00001100, and5 = 8'b00001101,
							or3 = 8'b00001110, or4 = 8'b00001111, or5 = 8'b00010000,
							mul3 = 8'b00010001, mul4 = 8'b00010010, mul5 = 8'b00010011, 
							div3 = 8'b00010101, div4 = 8'b00010110, div5 = 8'b00010111, div6 = 8'b00011000,
							shl3 = 8'b00011001, shl4 = 8'b00011010, shl5 = 8'b00011011, 
							shr3 = 8'b00011100, shr4 = 8'b00011101, shr5 = 8'b00011110, 
							ror3 = 8'b00011111, ror4 = 8'b00100000, ror5 = 8'b00100001,
							rol3 = 8'b00100010, rol4 = 8'b00100011, rol5 = 8'b00100100,
							not3 = 8'b00100101, not4 = 8'b00100110, not5 = 8'b00100111,
							neg3 = 8'b00101000, neg4 = 8'b00101001, neg5 = 8'b00101010,
							addi3 = 8'b00101011, addi4 = 8'b00101100, addi5 = 8'b00101101,
							andi3 = 8'b00101110, andi4 = 8'b00101111, andi5 = 8'b00110000,
							ori3 = 8'b00110001, ori4 = 8'b00110010, ori5 = 8'b00110011,
							ld3 = 8'b00110100, ld4 = 8'b00110101, ld5 = 8'b00110110, ld6 = 8'b00110111, ld7 = 8'b00111000, 
							st3 = 8'b00111001, st4 = 8'b00111010, st5 = 8'b00111011,st6 = 8'b0111110,
							ldi3 = 8'b00111110, ldi4 = 8'b00111111, ldi5 = 8'b01000000,
							br3 = 8'b01000001, br4 = 8'b01000010, br5 = 8'b01000011, br6 = 8'b0101110,
							jal = 8'b01000101, 
							jr = 8'b01000111,
							mfhi = 8'b01001000,
							mflo = 8'b01001001,
							in = 8'b01001010,
							out = 8'b01001011,
							halt = 8'b0100110;
							


								
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
		.rst(rst),                       
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
		.conFF(conOut),
		.IRout(IR)
);								
								
 // adjust the bit pattern based on the number of state
initial
	begin
		clk = 0;
		rst = 0;
end

always 
		#10 clk <= ~clk;
		
reg [7:0] Present_state = Reset_state;		
always @(posedge clk, posedge rst) 
	begin
		if(rst == 1'b1) Present_state = Reset_state;
		else case(Present_state)
			Reset_state : #45 Present_state = fetch0;
			fetch0 : #40 Present_state = fetch1;
			fetch1 : #45 Present_state = fetch2;
			fetch2 : #45 Present_state = fetch3;
			fetch3 : begin
							case (IR[31:27]) 
								5'b00011 	: #40 Present_state = add3;
								5'b00100		: #40	Present_state=sub3;
								5'b01110		: #40	Present_state=mul3;
								5'b01111		: #40	Present_state=div3;
								5'b00101		: #40	Present_state=shr3;
								5'b00110		: #40	Present_state=shl3;
								5'b00111		: #40	Present_state=ror3;
								5'b01000		: #40 Present_state=rol3;
								5'b01001		: #40 Present_state=and3;
								5'b01010		: #40	Present_state=or3;
								5'b10000		: #40	Present_state=neg3;
								5'b10001		: #40	Present_state=not3;
							   5'b00000		: #40	Present_state=ld3;
								5'b00001		: #40 Present_state=ldi3;
								5'b00010		: #40	Present_state=st3;
								5'b01011		: #40	Present_state=addi3;
								5'b01100		: #40	Present_state=andi3;
								5'b01101		: #40	Present_state=ori3;
								5'b10010		: #40	Present_state=br3;
								5'b10011		: #40	Present_state=jr;
								5'b10100		: #40	Present_state=jal;
								5'b10111		: #40	Present_state=mfhi;
								5'b11000		: #40	Present_state=mflo;
								5'b10101		: #40	Present_state=in;
								5'b10110		: #40	Present_state=out;
								5'b11010		: #40	Present_state=halt;
					
							endcase
						end
						
						
			add3				: 	#45 Present_state = add4;
			add4				:	#45 Present_state = add5;
			add5 				:	#45 Present_state = fetch0;
			
			addi3				: 	#45 Present_state = addi4;
			addi4				:	#45 Present_state = addi5;
		   addi5 			:	#45 Present_state = fetch0;
			
			sub3				: 	#45 Present_state = sub4;
			sub4				: 	#45 Present_state = sub5;
			sub5				:	#45 Present_state = fetch0;
			
			mul3				: 	#45 Present_state = mul4;
			mul4				: 	#45 Present_state = mul5;
			mul5           :	#45 Present_state = fetch0; 
			
			div3				: 	#45 Present_state = div4;
			div4				: 	#45 Present_state = div5;
			div5				: 	#45 Present_state = div6;
			div6				:	#45 Present_state = fetch0;
			
			or3				: 	#45 Present_state = or4;
			or4				: 	#45 Present_state = or5;
			or5				:	#45 Present_state = fetch0;
			
			and3				: 	#45 Present_state = and4;
			and4				: 	#45 Present_state = and5;
			and5   			:	#45 Present_state = fetch0;
			
			shl3				: 	#45 Present_state = shl4;
			shl4				: 	#45 Present_state = shl5;
			shl5 				:	#45 Present_state = fetch0;
			
			shr3				: 	#45 Present_state = shr4;
			shr4				: 	#45 Present_state = shr5;
			shr5 				:	#45 Present_state = fetch0;
			
			rol3				: 	#45 Present_state = rol4;
			rol4				: 	#45 Present_state = rol5;
			rol5 				:	#45 Present_state = fetch0;
			
			ror3				: 	#45Present_state = ror4;
			ror4				: 	#45 Present_state = ror5;
			ror5 				:	#45 Present_state = fetch0;
			
			neg3				: 	#45 Present_state = neg4;
			neg4				: 	#45 Present_state = neg5;
			neg5				: 	#45 Present_state = fetch0;
			
			not3				: 	#45 Present_state = not4;
			not4				: 	#45 Present_state = not5;
			not5				: 	#45 Present_state = fetch0;
			
			ld3				: 	#45 Present_state = ld4;
			ld4				: 	#45 Present_state = ld5;
			ld5				: 	#45 Present_state = ld6;
			ld6				: 	#45 Present_state = ld7;
			ld7				:  #45 Present_state = fetch0;
			
			ldi3				: 	#45 Present_state = ldi4;
			ldi4				: 	#45 Present_state = ldi5;
			ldi5 				:	#45 Present_state = fetch0;
			
			st3				: 	#45 Present_state = st4;
			st4				: 	#45 Present_state = st5;
			st5				: 	#45 Present_state = st6;
			st6				: 	#45 Present_state = fetch0;
			
			
			andi3				: 	#45 Present_state = andi4;
			andi4				: 	#45 Present_state = andi5;
			andi5 			:	#45 Present_state = fetch0;
			
			ori3				: 	#45 Present_state = ori4;
			ori4				: 	#45 Present_state = ori5;
			ori5 				:	#45 Present_state = fetch0;
			
			jal				: 	#45 Present_state = fetch0;
			
			
			jr 				:	#45 Present_state = fetch0;
			
			br3				: 	#45 Present_state = br4;
			br4				: 	#45 Present_state = br5;
			br5				: 	#45 Present_state = br6;
			br6  				:	#45 Present_state = fetch0;
			
			
			out 				:	#45 Present_state = fetch0;
			
			in				:	#45 Present_state = fetch0;
			
			mflo 			:	#45 Present_state = fetch0;
			
			mfhi 			:	#45 Present_state = fetch0;
			
			
	endcase
end

always @(Present_state) // do the job for each state
	begin
		case (Present_state) // assert the required signals in each state
			Reset_state: begin
				Gra <= 0; Grb <= 0; Grc <= 0; Y_enable <= 0; ZHighout <= 0; PC_enable <= 0; Yout <= 0; HI_enable <= 0; LO_enable <= 0; Cout <= 0; RAM_write <=0; HIout <= 0; LOout <=0;ZIn <= 0;
				BAout <= 0; CON_enable <=0; R_enable <= 0; InPort_enable <= 0; InPort_enable <= 0; OutPort_enable <= 0; InPortout <= 32'b0; Mdatain <= 32'b0;InPort_input <= 32'b0;MDatain <= 32'b0;// initialize the signals
			end
		
			fetch0: begin
				#10 R_enable <= 0; Rout = 0; ZLowout <= 0;Gra <=0; PC_enable <=0;
				#19 PCout <= 1; MAR_enable <= 1; IncPC <= 1; ZIn <= 1;
				
			end
			fetch1: begin
				#10 MAR_enable <= 0;  PCout <= 0;IncPC <= 0; ZIn <= 0;
				#15 RAM_read <=1; MDR_read <= 1; MDR_enable <= 1; ZLowout <= 1; PC_enable <= 1;
			end
			fetch2: begin
				#10 MDR_read <= 0; MDR_enable <= 0; RAM_read <= 0;ZLowout <= 0; PC_enable <= 0 ; 
				#15 MDRout <= 1; IR_enable <= 1;	
			end
			// 
			add3: begin
			   MDRout <= 0; IR_enable <= 0;	
				Grb <= 1;  Rout <=1; Y_enable <= 1;
			end
			add4: begin
				Grb <= 0;Rout<=0;Y_enable <= 0;
				 Cout <= 1; ZIn <= 1;
			end
			add5: begin
				 Cout<=0;  ZIn <= 0;
	         ZLowout <= 1; Gra <= 1; R_enable <= 1;
			end
			
			//
			addi3: begin
				 MDRout <= 0; IR_enable <= 0;	
				 Grb <= 1;  Rout <=1; Y_enable <= 1;
			end
			addi4: begin
				 Grb <= 0;Rout<=0;Y_enable <= 0;
				 Cout <= 1; ZIn <= 1;
			end
			addi5: begin
				Cout<=0;  ZIn <= 0;
	         ZLowout <= 1; Gra <= 1; R_enable <= 1;
			end
			
			//
			sub3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;
			end
			sub4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;
			end
			sub5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;	
			end
			
			//
			mul3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;
			end
			mul4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;
			end
			mul5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			div3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;
			end
			div4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;
			end
			div5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			or3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;
			end
			or4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;
			end
			or5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			and3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;	
			end
			and4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;	
			end
			and5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			shl3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;	
			end
			shl4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;	
			end
			shl5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			shr3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;	
			end
			shr4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;	
			end
			shr5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			ror3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;	
			end
			ror4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;	
			end
			ror5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			rol3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;	
			end
			rol4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;		
			end
			rol5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			neg3: begin
				#10 Gra <= 1;Rout <= 1; Y_enable <= 1;
				#15 Rout <= 0; Y_enable <= 0;Gra <= 0;	
			end
			neg4: begin
				Grb <= 1; Rout <= 1; ZIn <= 1;
				#25 Grb <= 0; Rout <= 0; ZIn <= 0;	
			end
			neg5: begin
				ZLowout <= 1; R_enable <= 1;
				#30 ZLowout <= 0; R_enable <= 0;
			end
			
			//
			ld3: begin
				MDRout <= 0; IR_enable <= 0;	
		      Grb <= 1;  BAout<=1; Y_enable <= 1;
			end
			ld4: begin
				Grb <= 0;BAout<=0;Y_enable <= 0; 
	         Cout <= 1 ; ZIn <= 1;
			end
			ld5: begin
				Cout<=0;  ZIn <= 0;
	         ZLowout <= 1; MAR_enable <= 1;
			end
			ld6: begin
				ZLowout <= 0; MAR_enable <= 0;
				MDR_read <= 1; MDR_enable <= 1; RAM_read <= 1;
			end
			ld7: begin
				RAM_read <= 0;
				#20 MDR_enable <=0; MDRout <= 1; Gra <= 1; R_enable <= 1;
			end
			
			//
			ldi3: begin
				#10 MDRout <= 0; IR_enable <= 0;	
	         #15 Grb <= 1; Rout <= 1; BAout<=1; Y_enable <= 1;
			end
			ldi4: begin
				#10 Grb <= 0;BAout<=0;Y_enable <= 0; Rout <= 0;
	         #15 Cout <= 1 ; ZIn <= 1;
			end
			ldi5: begin
				#10 Cout<=0;  ZIn <= 0;
				#25 ZLowout <= 1; Gra <=1; R_enable <= 1;
			end
			
			//
			st3: begin
				MDRout <= 0; IR_enable <= 0;	
				Grb <= 1;  BAout<=1; Y_enable <= 1;
			end
			st4: begin
				Grb <= 0;BAout<=0;Y_enable <= 0;
				Cout <= 1 ; ZIn <= 1;
			end
			st5: begin
				Cout<=0;  ZIn <= 0;
				ZLowout <= 1; MAR_enable<=1;
			end
			st6: begin
				ZLowout <= 0; MAR_enable <= 0;
				Gra <= 1; Rout <= 1; RAM_write <= 1;
			end
			
			//
			andi3: begin
				MDRout <= 0; IR_enable <= 0;	
				Grb <= 1;  Rout <=1; Y_enable <= 1;
			end
			andi4: begin
				 Grb <= 0;Rout<=0;Y_enable <= 0;
				 Cout <= 1; ZIn <= 1;
			end
			andi5: begin
				 Cout<=0;  ZIn <= 0;
				 ZLowout <= 1; Gra <= 1; R_enable <= 1;
			end
			
			//
			jal: begin
				MDRout <= 0; IR_enable <= 0;	
				Gra <= 1;  R_enable <=1; PCout <= 1;
			end
			
			//
			jr: begin
				 MDRout <= 0; IR_enable <= 0;	
				 Gra <= 1;  Rout<=1; PC_enable <= 1;
			end
			br3: begin
				MDRout <= 0; IR_enable <= 0;	
				Gra <= 1;  Rout<=1; CON_enable <= 1;
			end
			br4: begin
				Gra <= 0; Rout<=0; CON_enable <= 0;
				PCout <= 1 ; Y_enable <= 1;
			end
			br5: begin
				PCout <= 0;  Y_enable <= 0;
				Cout <= 1; ZIn <=1;
			end
			br6: begin
				Cout <= 0; ZIn <= 0;
				ZLowout <= 1; PC_enable <= conOut;
			end
			out: begin
				MDRout <= 0; IR_enable <= 0;	
				Gra <= 1;  Rout<=1; OutPort_enable <= 1;
			end
			in: begin
				MDRout <= 0; IR_enable <= 0;	
				Gra <= 1;  R_enable<=1; InPortout <= 1;
			end
			mfhi: begin
				MDRout <= 0; IR_enable <= 0;	
				Gra <= 1;  R_enable<=1; HIout <= 1;
			end
			mflo: begin
				MDRout <= 0; IR_enable <= 0;	
				Gra <= 1;  R_enable<=1; LOout <= 1;
			end
			//
		endcase
	end
endmodule
