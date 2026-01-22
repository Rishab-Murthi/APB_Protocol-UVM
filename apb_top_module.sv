`ifndef APB_TOP_MODULE
`define APB_TOP_MODULE
module apb_top;
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import apb_test_pkg::*;
  logic pclk;
  logic presetn;
  //interface
  apb_interface apb_if(.pclk(pclk),.presetn(presetn));
  //dut instantiation
  apb_slave slave_inst(apb_if);
  always #5 pclk = ~pclk;
  //reset
  initial begin
    pclk = 0;
    presetn = 0;
    #30 presetn = 1;
  end
  //passing interface
  initial begin
    uvm_config_db#(virtual apb_interface)::set(null,"*","vif",apb_if);
    run_test("apb_wr_rd_test");
  end
endmodule
`endif
