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

always @(SHIFT_OUT) SHIFT_IN = ~SHIFT_OUT;

endmodule
