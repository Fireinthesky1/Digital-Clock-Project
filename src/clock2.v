// ENGR_190 James Hicks 03/16/2023
// Takes in binary load and outputs bcd
// Binary in bcd out

module clock2
  #(parameter    hrs_tc_p  = 11,
                 mins_tc_p = 59,
                 secs_tc_p = 59,
                 clk_tc_p  = 49999999)
  (
    input        clk_i,
    input        nLoadNow_i,
    input        manageZeroHour_i,
    input        useBlanker_i,
    input  [17:2]switch_i,
    output [6:0] hrs_msb_o,
    output [6:0] hrs_lsb_o,
    output [6:0] mins_msb_o,
    output [6:0] mins_lsb_o,
    output [6:0] secs_msb_o,
    output [6:0] secs_lsb_o 
  );

    // load input wires for clock 1
    wire   [6:0] loadHrs_w;
    wire   [6:0] loadMins_w;

    // wire used as input for the  zero hour output manager
    wire   [6:0] zeroHourOutputManager_w;

    // wire used as input for the zero hour input manager
    wire   [6:0] zeroHourInputManager_w;

    // wires used as input to clock 1
    wire   [6:0] hrs_binary_w;
    wire   [6:0] mins_binary_w;
    wire   [6:0] secs_binary_w;

    // wires used as inputs to the hex7segs
    wire   [3:0] bcd_hrs_msb_w;
    wire   [3:0] bcd_hrs_lsb_w;
    wire   [3:0] bcd_mins_msb_w;
    wire   [3:0] bcd_mins_lsb_w;
    wire   [3:0] bcd_secs_msb_w;
    wire   [3:0] bcd_secs_lsb_w;

    // wire used as the input of the blanker
    wire   [6:0] hrs_to_blanker_w;

    // Take inputs off the switches and turn them into binary
    bcd2bin hrsBcd2Bin
  (
    .msb_i         (switch_i[17:14]),
    .lsb_i         (switch_i[13:10]),
    .bin_o         (loadHrs_w)
  );

  // Take the binary output of hrsBcd2Bin and manage the zero hour
  zeroHourManager
  #(.cntr_tc_p(hrs_tc_p))
  myZeroHourInputManager
  (
    .manageZeroHour_i(manageZeroHour_i),
    .hrs_unmanaged_i (loadHrs_w),
    .hrs_managed_o   (zeroHourInputManager_w)
  );

  bcd2bin minsBcd2Bin
  (
    .msb_i         (switch_i[9:6]),
    .lsb_i         (switch_i[5:2]),
    .bin_o         (loadMins_w)
  );

  //instantiate the clock
  clock1
  #(.hrs_tc_p (hrs_tc_p),   .mins_tc_p(mins_tc_p),
    .secs_tc_p(secs_tc_p),  .clk_tc_p (clk_tc_p))
  myClock1
  (
    .clk_i        (clk_i),
    .nLoadNow_i   (nLoadNow_i),
    .loadHrs_i    (zeroHourInputManager_w),  //loadHrs_w
    .loadMins_i   (loadMins_w),
    .hrs_o        (zeroHourOutputManager_w),
    .mins_o       (mins_binary_w),
    .secs_o       (secs_binary_w)
  );

  // Manage the binary hours output for the zero hour
  zeroHourManager
  #(.cntr_tc_p(hrs_tc_p))
  myZeroHourOutputManager
  (
    .manageZeroHour_i(manageZeroHour_i),
    .hrs_unmanaged_i (zeroHourOutputManager_w),
    .hrs_managed_o   (hrs_binary_w)
  );

  // turn the binaries to bcd to be input to the hex7segs
  bin2bcd hrsBin2Bcd
  (
    .bin_i        (hrs_binary_w),
    .msb_o        (bcd_hrs_msb_w),
    .lsb_o        (bcd_hrs_lsb_w)
  );

  bin2bcd minsBin2Bcd
  (
    .bin_i        (mins_binary_w),
    .msb_o        (bcd_mins_msb_w),
    .lsb_o        (bcd_mins_lsb_w)
  );

   bin2bcd secsBin2Bcd
  (
    .bin_i        (secs_binary_w),
    .msb_o        (bcd_secs_msb_w),
    .lsb_o        (bcd_secs_lsb_w)
  );

  // Send the bcd's to the hex 7 segs
   hex7seg hrs_msb
  (
    .c_i           (bcd_hrs_msb_w),
    .disp_o        (hrs_to_blanker_w)
  );

  //send the hex7seg output for the hrs hex7seg to the zeroblanker
  zeroBlanker myZeroBlanker
  (
    .useBlanker_i    (useBlanker_i),
    .displayToBlank_i(hrs_to_blanker_w),
    .blankedDisplay_o(hrs_msb_o)
  );

    hex7seg hrs_lsb
  (
    .c_i           (bcd_hrs_lsb_w),
    .disp_o        (hrs_lsb_o)
  );

  hex7seg mins_msb
  (
    .c_i           (bcd_mins_msb_w),
    .disp_o        (mins_msb_o)
  );

  hex7seg mins_lsb
  (
    .c_i           (bcd_mins_lsb_w),
    .disp_o        (mins_lsb_o)
  );

  hex7seg secs_msb
  (
    .c_i           (bcd_secs_msb_w),
    .disp_o        (secs_msb_o)
  );

  hex7seg secs_lsb
  (
    .c_i           (bcd_secs_lsb_w),
    .disp_o        (secs_lsb_o)
  );

endmodule