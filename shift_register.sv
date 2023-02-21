module shift_register(CLK, RSTn, ENABLE, SHIFT_IN, SHIFT_OUT, OUT_P);

// Parámetro de ancho en bits
parameter width = 10;
// Calculamos el tamanyo de bus
localparam n = $clog2(width-1);

// Entradas del módulo
input CLK, RSTn, ENABLE, SHIFT_IN;

// Salidas del módulo
output reg SHIFT_OUT;
output reg [n-1:0] OUT_P;

// La memoria del modulo
reg [n-1:0] mem;

always @(posedge CLK or negedge RSTn) begin
if (~RSTn) begin
    // Reiniciamos la memoria
    mem <= 0;
    // Establecemos las salidas a 0
    OUT_P = 0;
    SHIFT_OUT = 0;
end
else if (ENABLE) begin
    // Damos la salida del bit que se va a perder
    SHIFT_OUT <= mem[n-1];
    // Desplazamos un bit a izquierdas
    mem <= mem << 1;
    // Establecemos el primer bit al valor introducido
    mem[0] <= SHIFT_IN;
    // Actualizamos la salida de bus
    OUT_P <= mem;
end
end

endmodule
