/// Author: Erin Wang
/// Email: erinwang@g.hmc.edu
/// Date: 09/08/2025

// tb_top module tests the top module 
// It applies inputs to top module and checks if outputs are as expected through assert statements 

// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns

module tb_top(); 
    logic   clk, reset; 
    
    logic   [3:0] s0, s1;                 // input
    logic   [5:0] led, ledexpected;  // output
    logic   [6:0] seg, segexpected;   // output
	logic	trans0, trans1; //output
	logic	[7:0] i;
	logic sel;

	//// Instantiate device under test (DUT). 
	// Inputs: s Outputs: led, seg
	top dut(reset, s0, s1, led, seg, trans0, trans1); 

	//// Generate clock at 24 MHz
	always begin 
		clk=1; #5;  
		clk=0; #5; 
	end 

	//// Start of test.  
	initial begin 
		//// Pulse reset for 22 time units(2.2 cycles) so the reset signal falls after a clk edge. 
		reset=0; #22;  
		reset=1; 
		
		#10000 // wait for HSOSC to fire
			
		//// Check each LED sum
		for (i = 8'b00000000; i <= 8'b11111111; i++) begin
			#1
			s0 = i[3:0];
			s1 = i[7:4];
			ledexpected = s0+s1;
			#1
			assert (led == ledexpected) else $display(" led = %b (%b expected)", led, ledexpected);
		end
		
		$finish;
	end 

endmodule
