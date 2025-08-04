
class chi_driver extends uvm_driver#(chi_sequence_item);
  
  `uvm_component_utils(chi_driver)
  
  function new (string name ="chi_driver", uvm_component parent);
    super.new(name , parent);
  endfunction
  
  virtual interface  chi_intf vir_intf;
  
    function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      if(!(uvm_config_db#(virtual chi_intf)::get(this,"","vir_intf",vir_intf)))
        begin
          `uvm_fatal("DRIVER","No Interface connection ");
        end
    endfunction
    
    task run_phase (uvm_phase phase);
      chi_sequence_item txn;
      forever begin
        seq_item_port.get_next_item(txn);
        @(posedge vir_intf.clk);
        vir_intf.rst = txn.rst;
        vir_intf.FT = txn.FT;
        vir_intf.opcode = txn.opcode;
        vir_intf.address = txn.address;
        vir_intf.txn_id = txn.txn_id;
        vir_intf.data = txn.data;
        vir_intf.src_id = txn.src_id;
        vir_intf.tgt_id = txn.tgt_id;
        seq_item_port.item_done();
      end
    endtask
    
endclass
