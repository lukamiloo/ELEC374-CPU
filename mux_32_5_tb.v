`timescale 1ns/10ps
module and_tb;       
    reg [31:0] BusMuxIn_R0,//general purpose registers R1-R15	
	reg [31:0] BusMuxIn_R1,	
	reg [31:0] BusMuxIn_R2,
	reg [31:0] BusMuxIn_R3,
	reg [31:0] BusMuxIn_R4,
	reg [31:0] BusMuxIn_R5,
	reg [31:0] BusMuxIn_R6,
	reg [31:0] BusMuxIn_R7,
	reg [31:0] BusMuxIn_R8,
	reg [31:0] BusMuxIn_R9,
	reg [31:0] BusMuxIn_R10,
	reg [31:0] BusMuxIn_R11,
	reg [31:0] BusMuxIn_R12,
	reg [31:0] BusMuxIn_R13,
	reg [31:0] BusMuxIn_R14,
	reg [31:0] BusMuxIn_R15,
	
	reg [31:0] BusMuxIn_HI,
	reg [31:0] BusMuxIn_LO,
	reg [31:0] BusMuxIn_Zhigh,
	reg [31:0] BusMuxIn_Zlow,
	reg [31:0] BusMuxIn_PC,
	reg [31:0] BusMuxIn_MDR,
	reg [31:0] BusMuxIn_InPort,
	reg [31:0] BusMuxIn_C_Sign_Extended,
	
	reg [4:0] signal_select
	 
	wire[31:0] BusMux_Out
	 //wire [15:0] enableR;
	 
	
	 
parameter   Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
				
reg   [3:0] Present_state = Default; 
 
mux_32_5 DUT(BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI,
 BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_InPort, BusMuxIn_C_Sign_Extended, signal_select, BuxMux_Out);
 
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
			Default   :  #40 Present_state = Reg_load1a; 
			Reg_load1a  : #40 Present_state = Reg_load1b; 
			Reg_load1b  : #40 Present_state = Reg_load2a; 
			Reg_load2a  : #40 Present_state = Reg_load2b; 
			Reg_load2b  : #40 Present_state = Reg_load3a; 
			Reg_load3a  : #40 Present_state = Reg_load3b; 
			Reg_load3b  : #40 Present_state = T0; 
			T0    : #40 Present_state = T1; 
			T1    : #40 Present_state = T2; 
			T2    : #40 Present_state = T3; 
			T3    : #40 Present_state = T4; 
			T4    : #40 Present_state = T5; 
			  
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
				Read <= 0; AND <= 0; R5in <= 0; 
				R2in <= 0; R4in <= 0; R1in <= 0;
				R3in <= 0; R6in <= 0; R7in <= 0;
				R8in <= 0; R9in <= 0; R10in <= 0;
				R11in <= 0; R12in <= 0; R13in <= 0;
				R14in <= 0; R15in <= 0; Cin <= 0;
				ZHighIn <= 0; ZLowIn <= 0;
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
				Mdatain <= 32'h00000024; 
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
			end
			
			T1: begin 
				Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;   
				Mdatain <= 32'h4A920000;       // opcode for “and R5, R2, R4” 
			end
			
			T2: begin 
				MDRout <= 1; IRin <= 1;    
			end 
 
			T3: begin 
				R2out <= 1; Yin <= 1;    
			end
			
			T4: begin 
				R4out <= 1; AND <= 1; Zin <= 1;    
			end
			
			T5: begin 
				Zlowout <= 1; R5in <= 1;    
			end 
		endcase 
    end 
endmodule