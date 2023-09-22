// ENGR_190 bin2bcd James Hicks 03/07/2023

module bin2bcd
  (
    input  [6:0] bin_i,
    output [3:0] msb_o,
    output [3:0] lsb_o
  );
  assign msb_o = bin_i / 10;
  assign lsb_o = bin_i % 10;
endmodule