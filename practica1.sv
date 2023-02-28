/**
    Creación del módulo própio de instancición del contador y del registro de desplazamiento
    mediante el TC del count al ENABLE del shifter.
    Tendrémos en cuenta que siempre que cambie la salida del shifter (OUT), se le cambiará el signo
    y aparecerá como entrada
**/
`include "./count.v"
`include "./shift_register.sv"

module practica1(
    input CLK, RSTn, ENABLE,
    output [7:0] OUTPUT,
    output reg [7:0] LEDS
);
parameter modulo_contador = 1250000;

// Cable de unión entre el TC y El enable del registro de desplazamiento
wire CLK_REG;
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
    .TC(CLK_REG)
);

// Instanciación del módulo del registro de desplazamiento con tamaño '10'
shift_register #(
    .width(10)
) shifter (
    .CLK(CLK_REG),
    .RSTn(RSTn),
    .ENABLE(1'b1),
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
		8'b00000000: LEDS <= 8'b10000000;
		8'b10000000: LEDS <= 8'b01000000;
		8'b11000000: LEDS <= 8'b00100000;
		8'b11100000: LEDS <= 8'b00010000;
		8'b11110000: LEDS <= 8'b00001000;
		8'b11111000: LEDS <= 8'b00000100;
		8'b11111100: LEDS <= 8'b00000010;
		8'b11111110: LEDS <= 8'b00000001;
		8'b01111111: LEDS <= 8'b00000010;
		8'b00111111: LEDS <= 8'b00000100;
		8'b00011111: LEDS <= 8'b00001000;
		8'b00001111: LEDS <= 8'b00010000;
		8'b00000111: LEDS <= 8'b00100000;
		8'b00000011: LEDS <= 8'b01000000;
		8'b00000001: LEDS <= 8'b10000000;
	endcase
 end


endmodule
