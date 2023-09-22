// ENGR_190 James Hicks 03/16/2023

module clock2_top
  (
    input        CLOCK_50,
    input  [0:0] KEY,
    input  [17:0]SW,
    output [6:0] HEX7,
    output [6:0] HEX6,
    output [6:0] HEX5,
    output [6:0] HEX4,
    output [6:0] HEX3,
    output [6:0] HEX2
  );

  // Hook the clock2 into the board
  clock2
  #(.secs_tc_p(9))
  myClock2
  (
    .clk_i           (CLOCK_50),
    .nLoadNow_i      (KEY),
    .manageZeroHour_i(SW[1]),
    .useBlanker_i    (SW[0]),
    .switch_i        (SW[17:2]),
    .hrs_msb_o       (HEX7),
    .hrs_lsb_o       (HEX6),
    .mins_msb_o      (HEX5),
    .mins_lsb_o      (HEX4),
    .secs_msb_o      (HEX3),
    .secs_lsb_o      (HEX2)
  );

endmodule