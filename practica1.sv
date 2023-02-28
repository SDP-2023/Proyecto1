/**
    Creación del módulo própio de instancición del contador y del registro de desplazamiento
    mediante el TC del count al ENABLE del shifter.
    Tendrémos en cuenta que siempre que cambie la salida del shifter (OUT), se le cambiará el signo
    y aparecerá como entrada
**/

module practica1(
    input CLK, RSTn, ENABLE,
    output [7:0] OUTPUT
);
parameter modulo_contador = 1250000;

// Cable de unión entre el TC y El enable del registro de desplazamiento
wire ENABLE_REG;
// Entrada y salida del propio registro de desplazamiento
reg SHIFT, SHIFT_OUT;

// Instanciación del módulo del contador con tamaño de cuenta '10'
count #(
    .modulo(modulo_contador)
) contador (
    .CLK(CLK),
    .RSTn(RSTn),
    .ENABLE(ENABLE),
    .UP_DOWN(1),
    .COUNT(),
    .TC(ENABLE_REG)
);

// Instanciación del módulo del registro de desplazamiento con tamaño '10'
shift_register #(
    .width(10)
) shifter (
    .CLK(CLK),
    .RSTn(RSTn),
    .ENABLE(ENABLE_REG),
    .SHIFT_IN(SHIFT),
    .SHIFT_OUT(SHIFT_OUT),
    .OUT_P(OUTPUT)
);

// Siempre que cambie la salida del registro, lo pasamos a su entrada con signo cambiado (~)
always @(SHIFT_OUT) SHIFT = ~SHIFT_OUT;

// Declaramos un DECODIFICADOR para la asignación de los LEDs dependiendo de los bits
always @ (OUTPUT)
begin
	case (OUTPUT)
		7'b0000000: LEDS <= 8'b10000000;
		7'b1000000: LEDS <= 8'b01000000;
		7'b1100000: LEDS <= 8'b00100000;
		7'b1110000: LEDS <= 8'b00010000;
		7'b1111000: LEDS <= 8'b00001000;
		7'b1111100: LEDS <= 8'b00000100;
		7'b1111110: LEDS <= 8'b00000010;
		7'b1111111: LEDS <= 8'b00000001;
		7'b0111111: LEDS <= 8'b00000010;
		7'b0011111: LEDS <= 8'b00000100;
		7'b0001111: LEDS <= 8'b00001000;
		7'b0000111: LEDS <= 8'b00010000;
		7'b0000011: LEDS <= 8'b00100000;
		7'b0000001: LEDS <= 8'b01000000;
	endcase
 end


endmodule
