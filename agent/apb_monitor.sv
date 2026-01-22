`ifndef APB_MONITOR
`define APB_MONITOR
`include "uvm_macros.svh"
import uvm_pkg::*;
class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)
  virtual apb_interface vif;
  uvm_analysis_port#(apb_seq_item)mon_ap;
  apb_seq_item pkt;
  function new(string name = "apb_monitor", uvm_component parent);
    super.new(name,parent);
    mon_ap = new("mon_ap",this);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apb_interface)::get(this,"","vif",vif))
      `uvm_fatal("MON","vif not set")
  endfunction
  task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.pclk);
      if(vif.cb_monitor.psel)begin
        @(posedge vif.pclk);
        if(vif.cb_monitor.psel && vif.cb_monitor.penable)begin
          wait(vif.cb_monitor.pready == 1);
          if(vif.cb_monitor.psel && vif.cb_monitor.penable && vif.cb_monitor.pready)begin
            pkt = apb_seq_item::type_id::create("pkt");
            pkt.paddr = vif.cb_monitor.paddr;
            pkt.pwdata = vif.cb_monitor.pwdata;
            pkt.pwrite = vif.cb_monitor.pwrite;
            pkt.prdata = vif.cb_monitor.prdata;
            mon_ap.write(pkt);
            $display("from monitor: %p", pkt);
          end
        end
      end
    end
  endtask
  endclass
  `endif
