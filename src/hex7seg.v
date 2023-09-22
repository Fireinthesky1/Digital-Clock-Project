// ENGR_190 Lab 7, hex 7 segment display
// James Hicks, 02/22/23

module hex7seg(

input   [3:0] c_i,      //3 bits input
output  [0:6] disp_o);  //7 bit output
//                                     7 seg   hexI   hexO
 assign disp_o =( (c_i == 4'h0) ? 7'b1000000 : // 0 | 40
                  (c_i == 4'h1) ? 7'b1111001 : // 1 | 79
                  (c_i == 4'h2) ? 7'b0100100 : // 2 | 24
                  (c_i == 4'h3) ? 7'b0110000 : // 3 | 30
                  (c_i == 4'h4) ? 7'b0011001 : // 4 | 19
                  (c_i == 4'h5) ? 7'b0010010 : // 5 | 12
                  (c_i == 4'h6) ? 7'b0000010 : // 6 | 02
                  (c_i == 4'h7) ? 7'b1111000 : // 7 | 78
                  (c_i == 4'h8) ? 7'b0000000 : // 8 | 00
                  (c_i == 4'h9) ? 7'b0010000 : // 9 | 10
                  (c_i == 4'ha) ? 7'b0001000 :
                  (c_i == 4'hb) ? 7'b0000011 :
                  (c_i == 4'hc) ? 7'b1000110 :
                  (c_i == 4'hd) ? 7'b0100001 :
                  (c_i == 4'he) ? 7'b0000110 :
                /*(c_i == 4'hf)*/ 7'b0001110);
endmodule