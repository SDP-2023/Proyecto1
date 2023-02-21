/**
    Creación del módulo própio de instancición del contador y del registro de desplazamiento
    mediante el TC del count al ENABLE del shifter.
    Tendrémos en cuenta que siempre que cambie la salida del shifter (OUT), se le cambiará el signo
    y aparecerá como entrada
**/

module practica1(
    input CLK, RSTn, ENABLE,
    output [9:0] OUTPUT
);

wire ENABLE_REG;

reg SHIFT, SHIFT_OUT;

count #(
    .modulo(10)
) contador (
    .CLK(CLK),
    .RSTn(RSTn),
    .ENABLE(ENABLE),
    .UP_DOWN(1),
    .COUNT(),
    .TC(ENABLE_REG)
);

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

always @(SHIFT_OUT) SHIFT = ~SHIFT_OUT;

endmodule
