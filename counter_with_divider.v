
/**Crearemos entonces, un contador que también actúe como divisor de frecuencia.
	Tenemos un contador parametrizable ya realizado anteriormente, entonces, usaremos
	ese mismo y lo instanciaremos dos veces aquí **/
	
module counter_with_divider(CLK,RSTn,COUNT);

	input CLK, RSTn ;
	output [3:0] COUNT ;
	
	wire cnt_en ;
	
	// Instanciamos el contador que actúa como divisor de frecuencia
	counter #(.modulus(25000000)) freq_divider(
		.CLK(CLK),
		.RSTn(RSTn),
		.ENABLE(1'b1),
		.COUNT(),
		.TC(cnt_en)
		
	);
	
	// Instanciamos el contador que actúa como el de final de cuenta
	counter #(.modulus(10)) final_counter(
		.CLK(CLK),
		.RSTn(RSTn),
		.ENABLE(cnt_en),
		.COUNT(COUNT),
		.TC()
		
	);

endmodule 