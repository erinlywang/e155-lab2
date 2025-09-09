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