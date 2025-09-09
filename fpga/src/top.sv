/// Author: Erin Wang
/// Email: erinwang@g.hmc.edu
/// Date: 09/08/2025

// top module takes input from two 4 DIP switches
// and outputs the sum of the inputs onto 5 LEDs,
// the segments for both digits of a dual common-anode 7-segment display,
// and the signal for the base of two transistors that turn the digits of the dual display ON/OFF

module top( input	logic reset,
			input	logic [3:0] s0, 
			input	logic [3:0] s1,
			output	logic [4:0] led,
			output	logic [6:0] seg,
			output	logic  trans0, 
			output	logic  trans1);
			
	logic int_osc;
		
	// Internal high-speed oscillator
	HSOSC #(.CLKHF_DIV(2'b01))
		  hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
			
	// logic for selecting input into sevseg and which segment to turn on
	logic [3:0] s;
	logic sel;
	mpx mpx(.clk(int_osc), .reset(reset), .select(sel), .trans0(trans0), .trans1(trans1));
	
	assign s = sel ? s1:s0;

	// logic for what hexadecimal digit to display	
	sevseg sevseg(.in(s), .seg(seg));
	
	//output logic for displaying the sum of the 2 inputs on the LED
	assign led = s0+s1;
endmodule
	
