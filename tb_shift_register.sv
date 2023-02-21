
`include "./shift_register.sv"

`timescale 1ns/100ps // Cuanto es el paso de la simulación (siempre igual)

module tb_shift_register();

	localparam T = 20 ;

	reg CLK, RSTn, ENABLE, SHIFT_IN;
    wire SHIFT_OUT;
    wire [3:0] OUT_P;

    // Instanciamos el modulo del shift register
    shift_register #(
        .width(10)
    ) register(
        .CLK(CLK),
        .RSTn(RSTn),
        .ENABLE(ENABLE),
        .SHIFT_IN(SHIFT_IN),
        .SHIFT_OUT(SHIFT_OUT),
        .OUT_P(OUT_P)
    );

	// Generamos el clock -->
	
	always
	begin
		#(T/2) CLK = ~CLK ; // Cada medio periodo cambiamos clk de 1 a 0 y vicev
	end

    // Test procedure (Lo que vamos ha hacer para probarlo)
	initial
	begin
        // Empezamos reiniciando
		CLK = 0;
		RSTn = 0;
		ENABLE = 0;
        SHIFT_IN = 0;

        #(T*2)
		RSTn = 1;
		#(T*2)
		ENABLE = 1;
        SHIFT_IN = 1;

		#(T*8) SHIFT_IN = ~SHIFT_IN;

        #(T*4) ENABLE = 0 ;

		$display("Test finished") ;
		$stop ;
    end

endmodule
