module module_input_deco_gray # (

    parameter WIDTH = 4,
    parameter INPUT_REFRESH = 2700000

)(
    input                  clk_i,
    input                  rst_i,
    input [WIDTH - 1 : 0]  codigo_gray_i,

    output reg [WIDTH - 1 : 0]  codigo_bin_o
);

    //parameters
    localparam WIDTH_INPUT_COUNTER = $clog2(INPUT_REFRESH);

    //Internal signals
    reg [WIDTH - 1 : 0]               codigo_gray_sync_r;
    reg [WIDTH_INPUT_COUNTER - 1 : 0] cuenta_entrada;

    reg en_lectura;

    //Input refresh counter
    always @ (posedge clk_i) begin
        
        if(!rst_i) begin
        
            cuenta_entrada <= INPUT_REFRESH - 1;
            en_lectura <= 0;
        end

        else begin 

            if (cuenta_entrada == 0) begin
                
                cuenta_entrada <= INPUT_REFRESH - 1;
                en_lectura <= 1;
            end

            else begin

                cuenta_entrada <= cuenta_entrada - 1'b1;
                en_lectura <= 0;
            end
        end
    end

    //Input sync
    always @(posedge clk_i) begin

        if(!rst_i) begin
        
            codigo_gray_sync_r <= 0;
        end

        else begin 

            if(en_lectura) begin

                codigo_gray_sync_r <= codigo_gray_i;
            end

            else begin
                
                codigo_gray_sync_r <= codigo_gray_sync_r;
            end
        end  
    end

    //Gray decoder
    always @(codigo_gray_sync_r) begin
        
        codigo_bin_o = 0;

        case (codigo_gray_sync_r) 

            4'b0000: codigo_bin_o = 4'b0000; //0
            4'b0001: codigo_bin_o = 4'b0001; //1
            4'b0011: codigo_bin_o = 4'b0010; //2
            4'b0010: codigo_bin_o = 4'b0011; //3
            4'b0110: codigo_bin_o = 4'b0100; //4
            4'b0111: codigo_bin_o = 4'b0101; //5
            4'b0101: codigo_bin_o = 4'b0110; //6
            4'b0100: codigo_bin_o = 4'b0111; //7
            4'b1100: codigo_bin_o = 4'b1000; //8
            4'b1101: codigo_bin_o = 4'b1001; //9
            4'b1111: codigo_bin_o = 4'b1010; //10
            4'b1110: codigo_bin_o = 4'b1011; //11
            4'b1010: codigo_bin_o = 4'b1100; //12
            4'b1011: codigo_bin_o = 4'b1101; //13
            4'b1001: codigo_bin_o = 4'b1110; //14
            4'b1000: codigo_bin_o = 4'b1111; //15
            
            default: codigo_bin_o = 4'b0000;
        endcase
    end
endmodule