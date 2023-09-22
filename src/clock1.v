// ENGR_190 clock1 James Hicks 03/07/2023

module clock1 
  #(parameter hrs_tc_p  = 11,
              mins_tc_p = 59,
              secs_tc_p = 59,
              clk_tc_p  = 49999999)
  (
    input        clk_i,
    input        nLoadNow_i,
    input  [6:0] loadHrs_i,
    input  [6:0] loadMins_i,
    output [6:0] hrs_o,
    output [6:0] mins_o,
    output [6:0] secs_o
  );

  wire stage1_en_w;
  wire stage2_en_w;
  wire stage3_en_w;

  cntrStage
  #(.cntr_tc_p (clk_tc_p))
  stage0
  (
    .clk_i      (clk_i),
    .nLoadNow_i (nLoadNow_i),
    .load_i     (26'b0),        // (see if this will work)
    .enable_i   (1'b1),
    .term_cnt_o (stage1_en_w),
    .count_o    ()             // no connect
  );

  cntrStage
  #(.cntr_tc_p (secs_tc_p))
  stage1
  (
    .clk_i      (clk_i),
    .nLoadNow_i (nLoadNow_i),
    .load_i     (7'b0000000), // Hard code seconds load to 0
    .enable_i   (stage1_en_w),
    .term_cnt_o (stage2_en_w),
    .count_o    (secs_o)
  );

  cntrStage
  #(.cntr_tc_p (mins_tc_p))
  stage2
  (
    .clk_i      (clk_i),
    .nLoadNow_i (nLoadNow_i),
    .load_i     (loadMins_i),
    .enable_i   (stage1_en_w && stage2_en_w),
    .term_cnt_o (stage3_en_w),
    .count_o    (mins_o)
  );

  cntrStage
  #(.cntr_tc_p (hrs_tc_p))
  stage3
  (
    .clk_i      (clk_i),
    .nLoadNow_i (nLoadNow_i),
    .load_i     (loadHrs_i),
    .enable_i   (stage1_en_w && stage2_en_w && stage3_en_w),
    .term_cnt_o (),             // no connect
    .count_o    (hrs_o)
  );

endmodule