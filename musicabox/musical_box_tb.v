`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module musical_box_tb;

reg clk;
wire speaker;

// Instancia del módulo musical_box
musical_box uut (
    .clk(clk),
    .speaker(speaker)
);

// Generación de un clock de 12 MHz
always #41.67 clk = ~clk;  // 1 / (12 MHz) = 83.34 ns, medio-periodo = 41.67 ns

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0,musical_box_tb);

    // Inicialización
    clk = 0;
    // Simulación por un tiempo suficiente para cubrir la secuencia completa
    #1200000000;  // Ajustar según sea necesario
    $stop;
end

endmodule