
/**Crearemos ahora el testbench del contador con el divisor de frecuencia **/

`timescale 1ns/100ps

module tb_counter_with_divider();
	
	localparam T = 20 ;
	
	// DUV instance
	
	reg CLK, RSTn ;
	wire [3:0] COUNT ;
	
	counter_with_divider duv (
		.CLK(CLK),
		.RSTn(RSTn),
		.COUNT(COUNT)
	);
	
	//CLOCK GENERATION
	
	always
	begin
		#(T/2) CLK = ~CLK ;
	end
	
	// TEST PROCEDURE
	
	initial
	begin
		CLK = 0 ;
		RSTn = 0 ;
		
		#(T*2)
		
		RSTn = 1 ;
		#10000000 ; // 10ms
		
		$display("Test Finished") ;
		$stop ;
		
	end

endmodule 