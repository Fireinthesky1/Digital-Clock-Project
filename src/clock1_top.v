// ENGR 190 count1_top
// James Hicks 3/2/2023

// 1 count1, 3 bin2bcd's, 7 hex7segs's

module clock1_top
  (
    input        CLOCK_50,
    input  [0:0] KEY,
    output [6:0] HEX7,
    output [6:0] HEX6,
    output [6:0] HEX5,
    output [6:0] HEX4,
    output [6:0] HEX3,
    output [6:0] HEX2
  );

    wire   [6:0] hrs_w;
    wire   [6:0] mins_w;
    wire   [6:0] secs_w;
    wire   [3:0] hrs_msb_w;
    wire   [3:0] hrs_lsb_w;
    wire   [3:0] mins_msb_w;
    wire   [3:0] mins_lsb_w;
    wire   [3:0] secs_msb_w;
    wire   [3:0] secs_lsb_w;

  clock1 
  #(.clk_tc_p(49999))
  timer
  (
    .clk_i      (CLOCK_50),
    .nLoadNow_i (KEY),
    .hrs_o      (hrs_w),
    .mins_o     (mins_w),
    .secs_o     (secs_w)
  );

  bin2bcd hrs
  (
    .bin_i (hrs_w),
    .msb_o (hrs_msb_w),
    .lsb_o (hrs_lsb_w)
  );

  bin2bcd mins
  (
    .bin_i (mins_w),
    .msb_o (mins_msb_w),
    .lsb_o (mins_lsb_w)
  );

  bin2bcd secs
  (
    .bin_i (secs_w),
    .msb_o (secs_msb_w),
    .lsb_o (secs_lsb_w)
  );

  hex7seg hrs_msb
  (
    .c_i    (hrs_msb_w),
    .disp_o (HEX7)
  );

  hex7seg hrs_lsb
  (
    .c_i    (hrs_lsb_w),
    .disp_o (HEX6)
  );

  hex7seg mins_msb
  (
    .c_i    (mins_msb_w),
    .disp_o (HEX5)
  );

  hex7seg mins_lsb
  (
    .c_i    (mins_lsb_w),
    .disp_o (HEX4)
  );

  hex7seg secs_msb
  (
    .c_i    (secs_msb_w),
    .disp_o (HEX3)
  );

  hex7seg secs_lsb
  (
    .c_i    (secs_lsb_w),
    .disp_o (HEX2)
  );

endmodule