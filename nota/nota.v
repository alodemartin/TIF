module nota(
    input wire clk,
    output reg out
);

    parameter integer freq_nota = 261.63;
    parameter integer freq_clk = 12000000;
    parameter integer maximo = (freq_clk / (freq_nota *2));

    reg [31:0] counter = 0;

    initial begin
        out = 0;
        $display("COUNT_MAX = %d", maximo);
    end

    always @(posedge clk) begin
        if (counter >= maximo) begin
            counter <= 0;
            out <= ~out;
             $display("Toggle note_out: %b at time %t", out, $time);
        end else begin
            counter <= counter + 1;
        end
    end
endmodule