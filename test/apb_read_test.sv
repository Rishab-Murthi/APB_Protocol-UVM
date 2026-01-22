`ifndef APB_READ_TEST
`define APB_READ_TEST
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_read_test extends apb_base_test;
  `uvm_component_utils(apb_read_test)
  function new(string name = "apb_read_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    env.agt.seq.opt = read;
    env.agt.seq.count = 10;
    env.agt.seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
`endif
