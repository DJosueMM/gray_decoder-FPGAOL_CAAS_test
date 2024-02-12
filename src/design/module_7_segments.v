module module_7_segments # (

    parameter DISPLAY_REFRESH = 27000
)(

    input clk_i,
    input rst_i,

    input [7 : 0] bcd_i,

    output reg [1 : 0] anodo_o,
    output reg [6 : 0] catodo_o
);

    localparam WIDTH_DISPLAY_COUNTER = $clog2(DISPLAY_REFRESH);
    reg [WIDTH_DISPLAY_COUNTER - 1 : 0] cuenta_salida;

    reg [3 : 0] digito_o;

    reg en_conmutador;
    reg decena_unidad;

    //Output refresh counter
    always @ (posedge clk_i) begin
        
        if(!rst_i) begin
        
            cuenta_salida <= DISPLAY_REFRESH - 1;
            en_conmutador <= 0;
        end

        else begin 

            if(cuenta_salida == 0) begin
                
                cuenta_salida <= DISPLAY_REFRESH - 1;
                en_conmutador <= 1;
            end

            else begin

                cuenta_salida <= cuenta_salida - 1'b1;
                en_conmutador <= 0;
            end
        end
    end

    //1 bit counter
    always @ (posedge clk_i) begin
        
        if(!rst_i) begin
        
            decena_unidad <= 0;
        end

        else begin 

            if(en_conmutador == 1'b1) begin
                
                decena_unidad <= decena_unidad + 1'b1;
            end

            else begin

                decena_unidad <= decena_unidad;
            end
        end
    end

     //Multiplexed digits
    always @(decena_unidad) begin

        digito_o = 0;
        anodo_o = 2'b11;
        
        case(decena_unidad) 
            
            1'b0 : begin
                
                anodo_o  = 2'b10;
                digito_o = bcd_i [3 : 0];
            end

            1'b1 : begin
                
                anodo_o  = 2'b01;
                digito_o = bcd_i [7 : 4]; 
            end

            default: begin
                
                anodo_o  = 2'b11;
                digito_o = 0;
            end
        endcase
    end

    //BCD to 7 segments
    always @ (digito_o) begin

        catodo_o  = 7'b1111111;
            
        case(digito_o)

                4'd0: catodo_o  = 7'b1000000;
                4'd1: catodo_o  = 7'b1111001;
                4'd2: catodo_o  = 7'b0100100;
                4'd3: catodo_o  = 7'b0110000;
                4'd4: catodo_o  = 7'b0011001;
                4'd5: catodo_o  = 7'b0010010;
                4'd6: catodo_o  = 7'b0000010;
                4'd7: catodo_o  = 7'b1111000;
                4'd8: catodo_o  = 7'b0000000;
                4'd9: catodo_o  = 7'b0010000;
                default: catodo_o  = 7'b1111111;

        endcase
    end
endmodule