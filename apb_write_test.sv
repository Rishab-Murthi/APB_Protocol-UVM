`ifndef APB_WRITE_TEST
`define APB_WRITE_TEST
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_write_test extends apb_base_test;
  `uvm_component_utils(apb_write_test)
  function new(string name = "apb_write_test", uvm_component parent);
    super.new(name,parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.agt.seq.opt = write;
    env.agt.seq.count = 10;
    env.agt.seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
`endif
