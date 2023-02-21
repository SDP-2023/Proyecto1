`include "./practica1.sv"
`timescale 1ns/100ps // Cuanto es el paso de la simulación (siempre igual)

module tb_top();

    localparam T = 20;
	
	// DUV instance

	reg CLK, RSTn, ENABLE;
	wire [3:0] OUTPUT;

	// Instanciamos las variables del contador en el propio testbench para hacer la correlación
	practica1 #(
		.modulo_contador(10)
	) duv (
		.CLK(CLK),
		.ENABLE(ENABLE),
		.RSTn(RSTn),
        .OUTPUT(OUTPUT)
	);

	// Generamos el clock -->

	always
	begin
		#(T/2) CLK = ~CLK ; // Cada medio periodo cambiamos clk de 1 a 0 y vicev
	end

	// Test procedure (Lo que vamos ha hacer para probarlo)
	initial
	begin
		CLK = 0;
		RSTn = 0;
		ENABLE = 0;
		
		#(T*2)
		
		RSTn = 1;
		
		#(T*2)
		
		ENABLE = 1;
		
		#(T*14);

		#(T*4)

        ENABLE = 0 ;
		
		$display("Test finished") ;
		$stop ;
	end

endmodule
