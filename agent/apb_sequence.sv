`ifndef APB_SEQUENCE
`define APB_SEQUENCE
`include "uvm_macros.svh"
import uvm_pkg::*;
typedef enum{write, read, both, err}option;
class apb_sequence extends uvm_sequence #(apb_seq_item);
  rand option opt;
  rand int count;
  `uvm_object_utils(apb_sequence)
  function new(string name = "apb_sequence");
    super.new(name);
  endfunction
  task body();
    apb_seq_item tr;
    repeat(count)begin
      tr = apb_seq_item::type_id::create("tr");
      case(opt)
        write: tr.randomize() with {pwrite == 1;};
        read: tr.randomize() with {pwrite == 0;};
        both: tr.randomize();
        err: tr.randomize() with {paddr == 8'hFF;};
      endcase
      start_item(tr);
      finish_item(tr);
      `uvm_info("SEQ",$sformatf("pwrite = %0d, paddr = %0d, pwdata = %0d", tr.pwrite, tr.paddr, tr.pwdata),UVM_MEDIUM)
    end
  endtask
endclass
`endif
