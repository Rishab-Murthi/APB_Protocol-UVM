`ifndef APB_SEQ_ITEM
`define APB_SEQ_ITEM
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_seq_item extends uvm_sequence_item;
  bit             psel,penable,pready;
  rand bit [31:0] paddr;
  rand bit        pwrite;
  rand bit [15:0] pwdata;
  bit [15:0]      prdata;
  bit             pslverr;
  `uvm_object_utils_begin(apb_seq_item)
  `uvm_field_int(psel, UVM_ALL_ON)
  `uvm_field_int(penable, UVM_ALL_ON)
  `uvm_field_int(pready, UVM_ALL_ON)
  `uvm_field_int(paddr, UVM_ALL_ON)
  `uvm_field_int(pwrite, UVM_ALL_ON)
  `uvm_field_int(pwdata, UVM_ALL_ON)
  `uvm_field_int(prdata, UVM_ALL_ON)
  `uvm_field_int(pslverr, UVM_ALL_ON)
  `uvm_object_utils_end
  function new(string name = "apb_seq_item");
    super.new(name);
  endfunction
endclass
`endif
