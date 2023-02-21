
/**
    Vamos a realizar ahora el testbench del propio contador (tb_count).
	Crearemos señales con un generador de señales para ver que funciona bien
**/
	
`timescale 1ns/100ps // Cuanto es el paso de la simulación (siempre igual)

module tb_count();
	
	localparam T = 20 ;
	
	// DUV instance
	
	reg CLK, RSTn, ENABLE, UP_DOWN ;
	wire TC ;
	wire [3:0] COUNT ; // Cuatro bits necesarios ya que contamos hasta N=10
	
	
	// Instanciamos las variables del contador en el propio testbench para hacer la correlación
	count #(
		.modulo(10)
	) duv (
		.CLK(CLK),
		.ENABLE(ENABLE),
		.RSTn(RSTn),
        .UP_DOWN(UP_DOWN),
		.COUNT(COUNT),
		.TC(TC)
	);
	
	// Generamos el clock -->
	
	always
	begin
		#(T/2) CLK = ~CLK ; // Cada medio periodo cambiamos clk de 1 a 0 y vicev
	end
	
	// Test procedure (Lo que vamos ha hacer para probarlo)
	initial
	begin
		CLK = 0 ;
		RSTn = 0 ;
		ENABLE = 0 ;
        UP_DOWN = 1 ;
		
		#(T*2)
		
		RSTn = 1 ;
		
		#(T*2)
		
		ENABLE = 1 ;
		
		#(T*14)
		
		UP_DOWN = 0 ;

		#(T*4)

        ENABLE = 0 ;
		
		$display("Test finished") ;
		$stop ;
	end
endmodule 