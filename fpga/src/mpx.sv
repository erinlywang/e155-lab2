/// Author: Erin Wang
/// Email: eringwang@g.hmc.edu
/// Date: 09/08/2025

// mpx module takes a a clk and reset input
// and outputs a select logic for the multiplexer logic to choose switch inputs
// and outputs for turning the transistors (digits on the 7-seg module) ON/OFF

module mpx( input	clk,
			input	reset,
			output	logic select,
			output	logic trans0,
			output	logic trans1);
	logic [23:0] counter;
	logic counter_output;
	
	// Counter
	always_ff @(posedge clk) begin
		if (reset==0)		begin
			counter <= 24'b0;
			counter_output <= 1'b0;
		end
		else if (counter == 24'd200000)	begin
			counter <= 24'b0;
			counter_output <= ~counter_output;
		end
		else				counter <= counter + 24'b1;
	end
	
	assign select = counter_output;
	assign trans0 =  select;
	assign trans1 = ~select;
	
endmodule
