`ifndef APB_DRIVER
`define APB_DRIVER
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_driver extends uvm_driver #(apb_seq_item);
  `uvm_component_utils(apb_driver)
  virtual apb_interface vif;
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Virtual interface not set for driver")
  endfunction
  task run_phase(uvm_phase phase);
    apb_seq_item req;
    forever begin
      seq_item_port.get_next_item(req);
      if(!vif.presetn)begin
        reset_logic();
        wait(vif.presetn);
      end
      driver_logic(req);
      seq_item_port.item_done();
    end
  endtask
  task reset_logic();
    vif.cb_driver.psel <= 1'b0;
    vif.cb_driver.penable <= 1'b0;
    vif.cb_driver.paddr <= 1'b0;
    vif.cb_driver.pwrite <= 1'b0;
    vif.cb_driver.pwdata <= 1'b0;
    `uvm_info("DRV","Reset applied",UVM_LOW)
  endtask
  task driver_logic(apb_seq_item pkt);
    //setup phase
    @(posedge vif.pclk);
    vif.cb_driver.psel <= 1'b1;
    vif.cb_driver.penable <= 1'b0;
    vif.cb_driver.paddr <= pkt.paddr;
    vif.cb_driver.pwrite <= pkt.pwrite;
    vif.cb_driver.pwdata <= pkt.pwdata;
    //access phase
    @(posedge vif.pclk);
    vif.cb_driver.psel <= 1'b1;
    vif.cb_driver.penable <= 1'b1;
    do @(vif.cb_driver); while(!vif.cb_driver.pready);
    //idle phase
    @(posedge vif.pclk);
    vif.cb_driver.psel <= 1'b0;
    vif.cb_driver.penable <= 1'b0;
    `uvm_info("DRV", $sformatf("WRITE = %0d, ADDR = %0d, DATA = %0d", pkt.pwrite, pkt.paddr, pkt.pwdata),UVM_MEDIUM)
  endtask
endclass
`endif
