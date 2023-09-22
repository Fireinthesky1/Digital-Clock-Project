// ENGR 190 clock1_tb James Hicks 03/07/2023

// Currently testing bcd2bin

`timescale 1s/10ms

module clock2_tb;

reg        clk_r;
reg        manageZeroHour_r;
reg        useBlanker_r;
reg        nLoadNow_r;
reg  [17:2]switchInputs_r;
wire [6:0] hrsMsb_w;
wire [6:0] hrsLsb_w;
wire [6:0] minsMsb_w;
wire [6:0] minsLsb_w;
wire [6:0] secsMsb_w;
wire [6:0] secsLsb_w;

  always
    #0.250 clk_r = ~clk_r;

  initial begin
    $dumpfile("a.vcd");
    $dumpvars;
    $display("clk  time  HMSB  HLSB  MMSB  MLSB  SMSB  SLSB");
    $monitor("%3d  %4d  %4d  %4d  %4d  %4d  %4d  %4d", clk_r, $time,
    hrsMsb_w, hrsLsb_w, minsMsb_w, minsLsb_w, secsMsb_w, secsLsb_w);

    // T=0 initial conditions
    clk_r            = 1'b1;
    manageZeroHour_r = 1'b1;
    useBlanker_r     = 1'b1;
    nLoadNow_r       = 1'b1;
    switchInputs_r   = 16'b0001001001011001;
    #0.250
    nLoadNow_r       = 1'b0;
    #1
    nLoadNow_r       = 1'b1;
    #4.250
    $finish;
  end

    clock2
    #(.hrs_tc_p(11), .mins_tc_p(59),
      .secs_tc_p(1), .clk_tc_p(1))
    myClock2
  (
    .clk_i           (clk_r),
    .nLoadNow_i      (nLoadNow_r),
    .manageZeroHour_i(manageZeroHour_r),
    .useBlanker_i    (useBlanker_r),
    .switch_i        (switchInputs_r),
    .hrs_msb_o       (hrsMsb_w),
    .hrs_lsb_o       (hrsLsb_w),
    .mins_msb_o      (minsMsb_w),
    .mins_lsb_o      (minsLsb_w),
    .secs_msb_o      (secsMsb_w),
    .secs_lsb_o      (secsLsb_w)
  );

endmodule