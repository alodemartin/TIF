`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module caja_musical_tb;

reg clk;
wire speaker;

// Instancia de caja_musical
caja_musical uut (
    .clk(clk),
    .speaker(speaker)
);

// Generación de un clock de 12 MHz
always #41.67 clk = ~clk;  // 1 / (12 MHz) = 83.34 ns, medio-periodo = 41.67 ns (revisar)

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, caja_musical_tb);

    // Inicialización
    clk = 0;
    // Simulación por un tiempo suficiente para cubrir la secuencia completa
    #1200000000;  // Ajustar según sea necesario
    $stop;
end

endmodule