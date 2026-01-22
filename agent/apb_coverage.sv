`ifndef APB_COVERAGE
`define APB_COVERAGE
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_coverage extends uvm_subscriber #(apb_seq_item);
  `uvm_component_utils(apb_coverage)
  virtual apb_interface vif;
  apb_seq_item pkt;
  covergroup cg_apb;
    psel_cov: coverpoint vif.paddr{bins lowrange_addr = {[0:50]};
                                   bins midrange_addr = {[51:150]};
                                   bins highrange_addr = {[151:255]};}
    pwrite_cov: coverpoint vif.pwrite{bins pwrite0 = {0}; bins pwrite1 = {1};}
    pwdata_cov: coverpoint vif.pwdata{bins lowrange_pwdata = {[1:10]};
                                      bins midrange_pwdata = {[11:20]};
                                      bins highrange_pwdata = {[21:30]};}
    prdata_cov: coverpoint vif.prdata{bins lowrange_prdata = {[1:10]};
                                      bins midrange_prdata = {[11:20]};
                                      bins highrange_prdata = {[21:30]};}
  endgroup
  function new(string name = "apb_coverage", uvm_component parent);
    super.new(name,parent);
    cg_apb = new();
  endfunction
  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","vif",vif))
      `uvm_fatal("COV","vif not set")
  endfunction
  function void write(apb_seq_item t);
    pkt = t;
    cg_apb.sample();
    `uvm_info("COV","coverage sampled", UVM_LOW)
  endfunction
endclass
`endif
