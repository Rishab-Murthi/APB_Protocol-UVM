`ifndef APB_AGENT
`define APB_AGENT
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)
  apb_sequence seq;
  apb_sequencer seqr;
  apb_driver drv;
  apb_monitor mon;
  apb_coverage cov;
  virtual apb_interface vif;
  function new(string name = "apb_agent", uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","vif",vif))
      `uvm_fatal("AGENT","vif not set")
    seq = apb_sequnece::type_id::create("seq");
    seqr = apb_sequnecer::type_id::create("seq",this);
    drv = apb_driver::type_id::create("drv",this);
    mon = apb_monitor::type_id::create("mon",this);
    cov = apb_coverage::type_id::create("cov",this);
    uvm_config_db#(virtual apb_interface)::set(this,"drv","vif",vif);
    uvm_config_db#(virtual apb_interface)::set(this,"mon","vif",vif);
    uvm_config_db#(virtual apb_interface)::set(this,"cov","vif",vif);
  endfunction
  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
    mon.mon_ap.connect(cov.analysis_export);
  endfunction
endclass
`endif
