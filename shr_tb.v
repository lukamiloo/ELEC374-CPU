`timescale 1ns/10ps
module shr_tb;       
    reg  PCout, Zlowout, Zhighout, MDRout, R2out, R4out;           //add any other signals to see in your simulation 
    reg  MARin, PCin, MDRin, IRin, Yin, Cin, Zin;    
    reg  IncPC, Read, R5in, R2in, R4in;
	 reg  [4:0] SHR;
	 reg  R1in, R3in, R6in, R7in, R8in, R9in, R10in, R11in; 
	 reg  R12in, R13in, R14in, R15in;
    reg  clk, rst;
	 reg  LOin, HIin; 
    reg  [31:0] Mdatain;
	 
	 wire [31:0] bus_cont;
	 wire [63:0] alu_out;
	 //wire [15:0] enableR;
	 
	
	 
parameter   Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, 
Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
				
reg   [3:0] Present_state = Default; 
 
CPU_datapath DUT(.Mdatain(Mdatain), .PCout(PCout), .Zhighout(Zhighout), .Zlowout(Zlowout), .MDRout(MDRout), .R2out(R2out), .R4out(R4out), .MARin(MARin), .PCin(PCin), .MDRin(MDRin), 
.IRin(IRin), .Yin(Yin), .IncPC(IncPC), .Read(Read),.AND(SHR), .R5in(R5in), .R2in(R2in), .R4in(R4in), .clk(clk), .rst(rst), .R1in(R1in), .R3in(R3in), 
.R6in(R6in), .R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in), .HIin(HIin), .LOin(LOin), 
.Zin(Zin), .Cin(Cin), .bus_cont(bus_cont), .alu_out(alu_out));
 
 initial rst = 0;
// add test logic here 
initial  
    begin 
       clk = 0; 
       forever #10 clk = ~ clk; 
end 
 
always @(posedge clk)  // finite state machine; if clock rising-edge 
   begin 
      case (Present_state) 
			Default   :   #40 Present_state = Reg_load1a; 
			Reg_load1a  :  #40 Present_state = Reg_load1b; 
			Reg_load1b  :  #40 Present_state = Reg_load2a; 
			Reg_load2a  :  #40 Present_state = Reg_load2b; 
			Reg_load2b  :  #40 Present_state = Reg_load3a; 
			Reg_load3a  :  #40 Present_state = Reg_load3b; 
			Reg_load3b  :  #40 Present_state = T0; 
			T0    :  #40 Present_state = T1; 
			T1    :  #40 Present_state = T2; 
			T2    :  #40 Present_state = T3; 
			T3    :  #40 Present_state = T4; 
			T4    :  #40 Present_state = T5; 
			  
       endcase 
   end   
                                                          
always @(Present_state)  // do the required job in each state 
   begin 
      case (Present_state)               // assert the required signals in each clock cycle 
			Default: begin 
				PCout <= 0; Zlowout <= 0; MDRout <= 0;          // initialize the signals 
				R2out <= 0; R4out <= 0; MARin <= 0;   
				Zin <= 0; PCin <=0; MDRin <= 0;   
				IRin  <= 0; Yin <= 0; IncPC <= 0;   
				Read <= 0; SHR <= 0; R5in <= 0; 
				R2in <= 0; R4in <= 0; R1in <= 0;
				R3in <= 0; R6in <= 0; R7in <= 0;
				R8in <= 0; R9in <= 0; R10in <= 0;
				R11in <= 0; R12in <= 0; R13in <= 0;
				R14in <= 0; R15in <= 0; Cin <= 0;
				Zhighout <= 0;LOin <= 0; HIin <= 0;
				Mdatain <= 32'h00000000; 
			end
			
			Reg_load1a: begin   
				Mdatain <= 32'h00000022; 
				Read <= 0; MDRin <= 0;                   // the first zero is there for completeness 
				#10 Read <= 1; MDRin <= 1;
				#15 Read <= 0; MDRin <= 0;    
			end 
			
			Reg_load1b: begin  
				#10 MDRout <= 1; R2in <= 1;   
				#15 MDRout <= 0; R2in <= 0;     // initialize R2 with the value $22           
			end
			
			Reg_load2a: begin   
				Mdatain <= 32'h00000002; 
				#10 Read <= 1; MDRin <= 1;    
				#15 Read <= 0; MDRin <= 0;      
			end
			
			Reg_load2b: begin  
				#10 MDRout <= 1; R4in <= 1;   
				#15 MDRout <= 0; R4in <= 0;  // initialize R4 with the value $24           
			end
			
			Reg_load3a: begin   
				Mdatain <= 32'h00000026; 
				#10 Read <= 1; MDRin <= 1;   
				#15 Read <= 0; MDRin <= 0; 
			end
			
			Reg_load3b: begin  
				#10 MDRout <= 1; R5in <= 1;   
				#15 MDRout <= 0; R5in <= 0;  // initialize R5 with the value $26           
			end 
 
			T0: begin                            // see if you need to de-assert these signals 
				PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
				PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;	
			end
			
			T1: begin 
				Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
				//Mdatain <= 32'h4A920000; 
				#10 Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;					// opcode for “and R5, R2, R4” 
			end
			
			T2: begin 
				 MDRout <= 1; IRin <= 1;
				#10 MDRout <= 0; IRin <= 0;	
			end 
 
			T3: begin 
				#10 R2out <= 1; Yin <= 1;
				#15 R2out <= 0; Yin <= 0;	
			end
			
			T4: begin 
				R4out <= 1;SHR <= 5'b00101; Zin <= 1;
				#25 R4out <= 0; Zin <= 0;	
			end
			
			T5: begin 
				 Zlowout <= 1; R5in <= 1;
				#30 Zlowout <= 0; R5in <= 0;
			end 
		endcase 
    end 
endmodule