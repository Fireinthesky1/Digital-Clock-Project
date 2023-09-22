// ENGR 190 clock1_tb James Hicks 03/07/2023

// This testbench works for 

`timescale 1s/10ms

module clock1_tb;
reg clk_r;
reg  nLoadNow_r;
reg  [6:0] loadHrs_r;
reg  [6:0] loadMins_r;
wire [6:0] hrs_w;
wire [6:0] mins_w;
wire [6:0] secs_w;

  always
    #0.250 clk_r = ~clk_r;

  initial begin
    $dumpfile("a.vcd");
    $dumpvars;
    $display("time  hrs  mins  secs  loadNow  hrsLoadIn  minsLoadIn");
    $monitor("%4d  %3d  %4d  %4d  %7d  %9d  %9d", $time, hrs_w, mins_w, secs_w, nLoadNow_r, loadHrs_r, loadMins_r);

            clk_r      =  1'b1;
            loadHrs_r  = 7'b0000000;
            loadMins_r = 7'b0000000;
            nLoadNow_r = 1'b0;
            #1
            nLoadNow_r = 1'b1;
            #50
            loadHrs_r  = 7'b0000111;
            loadMins_r = 7'b0000111;
            nLoadNow_r = 1'b0;
            #1
            nLoadNow_r = 1'b1;
            #1000 $finish;
  end

  clock1 
  #(.clk_tc_p (1'b1), .secs_tc_p(10), .mins_tc_p(10), .hrs_tc_p(10))
    clock1(
      .clk_i     (clk_r),
      .nLoadNow_i(nLoadNow_r),
      .loadHrs_i (loadHrs_r),
      .loadMins_i(loadMins_r),
      .hrs_o     (hrs_w),
      .mins_o    (mins_w),
      .secs_o    (secs_w)
    );

endmodule