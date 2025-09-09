/// Author: Erin Wang
/// Email: eringwang@g.hmc.edu
/// Date: 08/31/2025

// tb_top module tests the top module 
// It applies inputs to top module and checks if outputs are as expected. 
// User provides patterns of inputs & desired outputs called testvectors. 

// Modelsim-ASE requires a timescale directive
`timescale 1 ns / 1 ns

module tb_mpx(); 
    logic   clk, reset; 
    
    logic   select;           // output
    logic   trans0, trans1;  // output

	//// Instantiate device under test (DUT). 
	// Inputs: s Outputs: sel, trans0, trans1
	mpx dut(.clk(clk), .reset(reset), .select(sel), .trans0(trans0), .trans1(trans1)); 

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
			
		//// Check that select flip flops
		#22
		assert (sel == 0) else $display(" sel = %b (0 expected)", sel);
		assert (trans0 == 0) else $display(" trans0 = %b (0 expected)", trans0);	
		assert (trans1 == 1) else $display(" trans1 = %b (1 expected)", trans1);	
			
		/// Wait 2000000 time units (200000 cycles)
		#2000000
		assert (sel == 1) else $display(" sel = %b (1 expected)", sel);
		assert (trans0 == 1) else $display(" trans0 = %b (1 expected)", trans0);	
		assert (trans1 == 0) else $display(" trans1 = %b (0 expected)", trans1);
	end 

endmodule