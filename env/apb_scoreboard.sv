`ifndef APB_SCOREBOARD
`define APB_SCOREBOARD
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard);
  uvm_analysis_imp#(apb_seq_item, apb_scoreboard)sb_imp;
  virtual apb_interface vif;
  bit [15:0] mem [0:255];  //reference memory
  function new(string name = "apb_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    if(!(uvm_config)db#(virtual apb_interface)::get(this,"","vif",vif);
       `uvm_fatal("SCB","vif not set")
  endfunction
  function void write(apb_seq_item pkt);
    if(!vif.presetn)begin
      foreach(mem[i])
        mem[i] = i;
      `uvm_info("SCB","Memory reset",UVM_LOW)
    end
    if(pkt.pslverr)
      `uvm_warning("SCB","PSLVERR detected")
    if(pkt.pwrite)begin
      mem[pkt.paddr[7:0]] = pkt.pwdata;
      `uvm_info("SCB",$sformatf("WRITE: ADDR = %0d, DATA = %0d",pkt.paddr,pkt.pwdata),UVM_MEDIUM)
    end
    else begin
      if(pkt.prdata == mem[pkt.paddr[7:0]])
        `uvm_info("SCB","=====Scoreboard_PASS======",UVM_MEDIUM)
      else
        `uvm_error("SCB","=====Scoreboard_FAIL======",UVM_MEDIUM)
    end
  endfunction
endclass
`endif
