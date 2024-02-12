module module_bin_to_bcd # (

    parameter WIDTH = 4

)(

    input clk_i,
    input rst_i,

    input [WIDTH - 1 : 0] bin_i,

    output reg [7 : 0] bcd_o
);
    
    //Internal signals

    reg [11 : 0] double_dabble_r;
    reg [1 : 0]  shift_count;
    reg          ready;


    //FSM  double-dabble algoritm
    reg [2 : 0] state;

    localparam IDLE          = 0;
    localparam SUMA_DECENAS  = 1;
    localparam SUMA_UNIDADES = 2;
    localparam SHIFT         = 3;
    localparam FIN           = 4;

    always @ (posedge clk_i) begin

        if (!rst_i) begin
            
            state           <= IDLE;
            double_dabble_r <= 0;
            shift_count     <= 3;
            ready           <= 0;
        end

        else begin

            case (state)

                IDLE: begin

                    double_dabble_r [3 : 0]  <= bin_i;
                    double_dabble_r [11 : 4] <= 0;
                    shift_count              <= 3;
                    ready                    <= 0;
                    state                    <= SUMA_DECENAS;
                    
                end

                SUMA_DECENAS: begin

                    if (double_dabble_r [11 : 8] > 4) begin

                        double_dabble_r [11 : 8] <= double_dabble_r [11 : 8] + 3;
                        double_dabble_r [7 : 0]  <= double_dabble_r [7 : 0];
                        shift_count              <= shift_count;
                        ready                    <= 0;
                        state                    <= SUMA_UNIDADES;
                    end

                    else begin

                        double_dabble_r   <= double_dabble_r;
                        shift_count       <= shift_count;
                        ready             <= 0;
                        state             <= SUMA_UNIDADES;
                    end
                    
                end

                SUMA_UNIDADES: begin

                    if (double_dabble_r [7 : 4] > 4) begin

                        double_dabble_r [7 : 4]  <= double_dabble_r [7 : 4] + 3;
                        double_dabble_r [3 : 0]  <= double_dabble_r [3 : 0];
                        double_dabble_r [11 : 8] <= double_dabble_r [11 : 8];
                        shift_count              <= shift_count;
                        ready                    <= 0;
                        state                    <= SHIFT;
                    end

                    else begin

                        double_dabble_r   <= double_dabble_r;
                        shift_count       <= shift_count;
                        ready             <= 0;
                        state             <= SHIFT;
                    end
                    
                end

                SHIFT: begin

                    if (shift_count == 0) begin

                        double_dabble_r  <= double_dabble_r << 1;
                        shift_count      <= shift_count - 1;
                        ready            <= 0;
                        state            <= FIN;
                    end

                    else begin

                        double_dabble_r  <= double_dabble_r << 1;
                        shift_count      <= shift_count - 1;
                        ready            <= 0;
                        state            <= SUMA_DECENAS;
                    end
                    
                end

                FIN: begin

                    double_dabble_r  <= double_dabble_r;
                    shift_count      <= shift_count;
                    ready            <= 1;
                    state            <= IDLE;  
                end

                default: begin
                    
                    state           <= IDLE;
                    double_dabble_r <= 0;
                    shift_count     <= 3;
                    ready           <= 0;
                end

            endcase
        end
    end
    
    always @ (posedge clk_i) begin

        if (!rst_i) begin
            
            bcd_o <= 0;
        end

        else begin
            
            if(ready) begin

                bcd_o [3 : 0] <= double_dabble_r [7 : 4];
                bcd_o [7 : 4] <= double_dabble_r [11 : 8];
            end

            else begin
                
                bcd_o <= bcd_o;
            end
        end   
    end
endmodule