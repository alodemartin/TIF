`default_nettype none
`define DUMPSTR(x) `"x.vcd`"

module nota_tb;

    // Reloj simulado de 12 MHz
    reg clk;
    // Salida de la señal cuadrada
    wire out;

    // Instancia del módulo note_generator
    nota ng (
        .clk(clk),
        .out(out)
    );

    // Generación del reloj simulado
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, nota_tb);

        clk = 0;
        forever #41.67 clk = ~clk; // Periodo de 12 MHz (1 / 12e6) es 83.33 ns, medio periodo es 41.67 ns
    end

    // Simulación
    initial begin
        $display("Iniciando simulación");
        // Termina la simulación después de un tiempo determinado
        #100000000  $finish;
    end

endmodule
