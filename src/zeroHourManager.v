// ENGR_190 James Hicks 03/16/2023
// Manages the zero hour both on the input off the switches and on the
// output out of clock 1

module zeroHourManager
  #(parameter cntr_tc_p = 11)
  (
    input        manageZeroHour_i,
    input  [6:0] hrs_unmanaged_i,
    output [6:0] hrs_managed_o
  );

  assign hrs_managed_o = 
  (manageZeroHour_i && (hrs_unmanaged_i [6:0] == 7'b0)) ? cntr_tc_p + 1 :
  (manageZeroHour_i && (hrs_unmanaged_i [6:0] == cntr_tc_p + 1)) ? 7'b0 :
  hrs_unmanaged_i [6:0];

endmodule