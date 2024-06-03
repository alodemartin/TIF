module secuencia_notas(
    input wire clk, reset,
    output reg [31:0] parametro_actual
);

    //Parametros de frecuencia, valores de divisor (12mHz / 2(frecuencia_nota))
    parameter _plusDo   = 11472;    //al pedo
    parameter _plusC    = 11472;
    parameter _Do       = 22900;    //al pedo
    parameter _C        = 22900;    
    parameter _Re       = 20408;    //al pedo
    parameter _D        = 20408;
    parameter _Mi       = 18182;    //al pedo
    parameter _E        = 18182;
    parameter _Fa       = 17192;    //al pedo
    parameter _F        = 17192;
    parameter _Sol      = 15306;    //al pedo
    parameter _G        = 15306;
    parameter _La       = 13636;    //al pedo
    parameter _A        = 13636;
    parameter _Si       = 12146;    //al pedo
    parameter _B        = 12146;    //al pedo
    parameter _La_sharp = 12876;    //al pedo
    parameter _A_sharp  = 12876;

   //Secuencia de notas
    reg [31:0] secuencia [0:24];

    //Inicializacion del array
    initial 
    begin
        secuencia[0] = _C;      secuencia[1] = _C;          secuencia[2] = _D;  
        secuencia[3] = _C;      secuencia[4] = _F;          secuencia[5] = _E;  
        secuencia[6] = _C;      secuencia[7] = _C;          secuencia[8] = _D;  
        secuencia[9] = _C;      secuencia[10] = _G;         secuencia[11] = _F;
        secuencia[12] = _C;     secuencia[13] = _C;         secuencia[14] = _plusC;   
        secuencia[15] = _A;     secuencia[16] = _F;         secuencia[17] = _E;    
        secuencia[18] = _D;     secuencia[19] =  _A_sharp;  secuencia[20] =  _A_sharp; 
        secuencia[21] = _A;     secuencia[22] = _F;         secuencia[23] = _G;
        secuencia[24] = _F;   
    end

    reg [4:0] nota_actual, nota_siguiente; //para representar las 25 notas de la secuencia
    always @(posedge clk, posedge reset) 
    begin
        if(reset)
            nota_actual <= 0; //reinicia la secuencia al resetear
        else 
            ////avanza a la siguiente nota y reinicia al final
            nota_actual <= (nota_actual == 24) ? 0 : nota_actual + 1; 
            
        parametro_actual <= secuencia[nota_actual]; //actualiza el divisor segun la nota actual
    end

endmodule
