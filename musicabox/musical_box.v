module musical_box (
    input wire clk,          // Clock de 12 MHz
    output reg speaker       // Salida al parlante
);

// Declaración de frecuencias para cada nota
parameter C_freq  = 262;
parameter D_freq  = 294;
parameter E_freq  = 330;
parameter F_freq  = 349;
parameter G_freq  = 392;
parameter A_freq  = 440;
parameter B_freq  = 494;
parameter A_sharp_freq = 466;
parameter C_high_freq = 523;

// Duración de las notas (en ciclos de clock)
parameter NOTE_DURATION = 12000000;  // Ajustar según sea necesario

// Estados para la FSM
parameter S_C1 = 4'b0000, S_C2 = 4'b0001, S_D1 = 4'b0010, S_C3 = 4'b0011, S_F1 = 4'b0100, S_E1 = 4'b0101,
          S_C4 = 4'b0110, S_C5 = 4'b0111, S_D2 = 4'b1000, S_C6 = 4'b1001, S_G1 = 4'b1010, S_F2 = 4'b1011,
          S_C7 = 4'b1100, S_C8 = 4'b1101, S_C9 = 4'b1110, S_A1 = 4'b1111, S_F3 = 5'b10000, S_E2 = 5'b10001, S_D3 = 5'b10010,
          S_A_SHARP1 = 5'b10011, S_A_SHARP2 = 5'b10100, S_A_SHARP3 = 5'b10101, S_F4 = 5'b10110, S_G2 = 5'b10111, S_F5 = 5'b11000;

reg [4:0] state, next_state;

// Contador de tiempo
reg [23:0] time_counter;

// Contador de frecuencia
reg [15:0] freq_counter;
reg freq_toggle;

// Asignación de frecuencia según el estado
reg [15:0] freq_divider;
always @(*) begin
    case (state)
        S_C1, S_C2, S_C3, S_C4, S_C5, S_C6, S_C7, S_C8:
            freq_divider = C_freq;
        S_C9:
            freq_divider = C_high_freq;
        S_D1, S_D2, S_D3:
            freq_divider = D_freq;
        S_E1, S_E2:
            freq_divider = E_freq;
        S_F1, S_F2, S_F3, S_F4, S_F5:
            freq_divider = F_freq;
        S_G1, S_G2:
            freq_divider = G_freq;
        S_A1:
            freq_divider = A_freq;
        S_A_SHARP1, S_A_SHARP2, S_A_SHARP3:
            freq_divider = A_sharp_freq;
        default:
            freq_divider = C_freq;  // Valor por defecto
    endcase
end

// Generación de la señal cuadrada
always @(posedge clk) begin
    if (freq_counter >= (12000000 / (2 * freq_divider))) begin
        freq_counter <= 0;
        freq_toggle <= ~freq_toggle;
    end else begin
        freq_counter <= freq_counter + 1;
    end
    speaker <= freq_toggle;
end

// Control del tiempo y FSM
always @(posedge clk) begin
    if (time_counter >= NOTE_DURATION) begin
        time_counter <= 0;
        state <= next_state;
    end else begin
        time_counter <= time_counter + 1;
    end
end

// Transición de estados
always @(*) begin
    case (state)
        S_C1: next_state = S_C2;
        S_C2: next_state = S_D1;
        S_D1: next_state = S_C3;
        S_C3: next_state = S_F1;
        S_F1: next_state = S_E1;
        S_E1: next_state = S_C4;
        S_C4: next_state = S_C5;
        S_C5: next_state = S_D2;
        S_D2: next_state = S_C6;
        S_C6: next_state = S_G1;
        S_G1: next_state = S_F2;
        S_F2: next_state = S_C7;
        S_C7: next_state = S_C8;
        S_C8: next_state = S_C9;
        S_C9: next_state = S_A1;
        S_A1: next_state = S_F3;
        S_F3: next_state = S_E2;
        S_E2: next_state = S_D3;
        S_D3: next_state = S_A_SHARP1;
        S_A_SHARP1: next_state = S_A_SHARP2;
        S_A_SHARP2: next_state = S_A_SHARP3;
        S_A_SHARP3: next_state = S_F4;
        S_F4: next_state = S_G2;
        S_G2: next_state = S_F5;
        S_F5: next_state = S_C1;  // Vuelve al inicio
        default: next_state = S_C1;
    endcase
end

// Inicialización de estados
initial begin
    state = S_C1;
    next_state = S_C1;
    time_counter = 0;
    freq_counter = 0;
    freq_toggle = 0;
end

endmodule