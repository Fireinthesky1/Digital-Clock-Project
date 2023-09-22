// ENGR_190 James Hicks 3/16/2023

module zeroBlanker
  (
    input        useBlanker_i,
    input  [6:0] displayToBlank_i,
    output [6:0] blankedDisplay_o
  );

assign blankedDisplay_o=(useBlanker_i && (displayToBlank_i == 7'b1000000))
                             ? 7'b1111111 : displayToBlank_i;

endmodule