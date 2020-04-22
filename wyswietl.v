module wyswietl (input clk_i,
                 input hr1,
                 input hr2,
                 input min1,
                 input min2,
                 input reg [1:0]odswiezanie,
                 output reg [7:0] seg_o,
                 output reg [7:0] an_o
                 );
    reg [3:0]LED_KONW;
    always @(*)
    begin
        case(odswiezanie)
        2'b00: begin
            an_o = 8'b00000111; 
            LED_KONW = hr2;
            end
        2'b01: begin
            an_o = 8'b00001011; 
            LED_KONW = hr1;
            end
        2'b10: begin
            an_o = 8'b00001101; 
            LED_KONW = min2;
            end
        2'b11: begin
            an_o = 8'b00001110; 
            LED_KONW = min1;
            end   
        default:begin
            an_o = 8'b00000111; 
            LED_KONW = hr2;
            end
        endcase
    end
    always @(*)
    begin
        case(LED_KONW)
            4'b0000: seg_o = 7'b0000001; // "0"  
            4'b0001: seg_o = 7'b1001111; // "1" 
            4'b0010: seg_o = 7'b0010010; // "2" 
            4'b0011: seg_o = 7'b0000110; // "3" 
            4'b0100: seg_o = 7'b1001100; // "4" 
            4'b0101: seg_o = 7'b0100100; // "5" 
            4'b0110: seg_o = 7'b0100000; // "6" 
            4'b0111: seg_o = 7'b0001111; // "7" 
            4'b1000: seg_o = 7'b0000000; // "8"  
            4'b1001: seg_o = 7'b0000100; // "9" 
            default: seg_o = 7'b0000001; // "0"
        endcase
    end
endmodule