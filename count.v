
/**Creación de un contador binario síncrono de módulo parametrizble
    ascendente/descendente **/ 

module count(CLK , RSTn , ENABLE , UP_DOWN , COUNT , TC);

	parameter modulo = 10 ; // modulo 
	parameter N = $clog2(modulo-1) ; // Número de bits necesarios

    // Declaración de Entradas -->
	input CLK, RSTn, ENABLE, UP_DOWN ; // CLK, activo a nivel alto, RST asíncrono actv a lvl bajo,
                                       // Enable a lvl alto y Señal de contador(1), restador(0)     
    // Declaración de Salidas -->
	output reg [N-1:0] COUNT ; // Contador de tamaño 'N' bits
	
	output TC ; // Terminal counter (El cual determina cuando la cuenta ha llegado a su fin)

// Bloque procedural always con sensibilidad de reloj a nivel alto y Reset a lvl bajo
always @(posedge CLK or negedge RSTn)
	begin
        // Si el reset se activa, ponemos el contador al inicio (coge el valor del primer bit)
		if(!RSTn)
			COUNT <= {N{1'b0}} ;
        // Si el ENABLE está activo para funcionar
		else if(ENABLE)
            begin
                // Si el contador ha llegado a su máximo, lo ponemos inicial
                if(COUNT == modulo-1)
                    COUNT <= {N{1'b0}} ;
                // Si no ha llegado a su máximo, incrementamos su valor en UNO si UP_DOWN == 1 .
                else if(UP_DOWN)
                    COUNT <= COUNT + 1'b1 ;
                // Si no ha llegado a su máximo, incrementamos su valor en UNO si UP_DOWN == 0 .
                else
                    COUNT <= COUNT - 1'b1 ;
            end
	end
	
    // TC cogerá el valor de UNO, en caso de que se halla finalizado la cuenta, y sino, cogerá valor CERO
	assign TC = (COUNT == modulo-1)? 1'b1 : 1'b0 ;

/** Este contador será instanciado, ya que se ha creado parametrizable, para cualquier uso **/

endmodule 