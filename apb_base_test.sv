`ifndef APB_BASE_TEST
`define APB_BASE_TEST
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_base_test extends uvm_test;
  `uvm_component_utils(apb_base_test)
  apb_env env;
  virtual apb_interface vif;
  function new(string name = "apb_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","vif",vif))
      `uvm_fatal("BASE_TEST","VIRTUAL INTF NOT SET")
    uvm_config_db#(virtual apb_interface)::set(this,"env.agt.*","vif",vif);
    env = apb_env::type_id::create("env",this);
  endfunction
endclass
`endif
