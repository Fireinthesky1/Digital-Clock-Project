// ENGR_190 bcd2bin James Hicks 3/16/2023

module bcd2bin
  (
   input  [3:0] msb_i,
   input  [3:0] lsb_i,
   output [6:0] bin_o
  );

  wire [3:0] digit1, digit2;

  assign digit1 = (msb_i[3:0] > 9) ? 4'b0000 : msb_i[3:0];
  assign digit2 = (lsb_i[3:0] > 9) ? 4'b0000 : lsb_i[3:0];

  assign bin_o = (digit1 * 10) + digit2;

endmodule