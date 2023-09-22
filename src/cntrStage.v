// ENGR_190 example Verilog, general-purpose cascadable counter stage
// Rick Nungester 2/28/17
// Updated by James Hicks (added load function)
// 03/07/23

module cntrStage
  #(parameter cntr_tc_p = 9) (
  input                    clk_i,
  input                    nLoadNow_i,  //boolean flag to tell us to load
  input  [cntr_bits_p-1:0] load_i,      //the value we are actually loading
  input                    enable_i,
  output                   term_cnt_o,
  output [cntr_bits_p-1:0] count_o );

  localparam cntr_bits_p = $clog2(cntr_tc_p + 1);

  reg [cntr_bits_p-1:0] count_r = 0;

  always @(posedge clk_i) begin
    if (~nLoadNow_i)
      count_r <= load_i;            // if loadNow_i then count_r = load_i
    else if (enable_i) begin
      if (count_r == cntr_tc_p[cntr_bits_p-1:0])
        count_r <= 1'b0;            // enabled & at tc, wrap to 0
      else
        count_r <= count_r + 1'b1;  // enabled & not TC, so increment
    end
  end

  // set outputs from registers used in the always block
  assign count_o = count_r;
  assign term_cnt_o = (count_r == cntr_tc_p[cntr_bits_p-1:0]);

endmodule
