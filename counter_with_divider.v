
/**Crearemos entonces, un contadoor que también actúe como divisor de frecuencia.
	Tenemos un contador parametrizable ya realizado anteriormente, entonces, usaremos
	ese mismo y lo instanciaremos dos veces aquí **/
	
module counter_with_divider(CLK,RSTn,COUNT);
	// Declaramos las entradas necesarias
	input CLK, RSTn ;
	// Declaramos las salidas necesarias
	output [3:0] COUNT ; // Cuatro bits necesarios para el diseño
	
	wire cnt_en ;
	
	// Instanciamos el contador que actúa como divisor de frecuencia
	// Ponemos como módulo aquí 12.5(GHz) ya que queremos que vaya a 0.25segundos (12.5/50 = 0.25)
	count #(.modulo(12500000)) freq_divider(
		.CLK(CLK),
		.RSTn(RSTn),
		.ENABLE(1'b1),
		.COUNT(),
		.TC(cnt_en)
		
	);
	
	// Instanciamos el contador que actúa como el de final de cuenta
	count #(.modulo(10)) final_counter(
		.CLK(CLK),
		.RSTn(RSTn),
		.ENABLE(cnt_en),
		.COUNT(COUNT),
		.TC()
		
	);

endmodule 