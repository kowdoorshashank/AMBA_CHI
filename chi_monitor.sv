 class chi_monitor extends uvm_monitor#(chi_sequence_item);
  
  `uvm_component_utils (chi_monitor)
  
  function new ( string name ="chi_monitor", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual chi_intf vir_intf;
  
  chi_sequence_item txn;
  
  uvm_analysis_port#(chi_sequence_item) port;
  
  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    if(!(uvm_config_db#(virtual chi_intf)::get(this,"","vir_intf",vir_intf)))
      begin
        `uvm_fatal("MONITOR","Not Connected to Interface ");
      end
    port = new("port",this);
    txn = chi_sequence_item::type_id::create("txn",this);
  endfunction

  task run_phase (uvm_phase phase);
    forever begin
      @(posedge vir_intf.clk);
      vir_intf.rst = txn.rst;
        vir_intf.FT = txn.FT;
        vir_intf.opcode = txn.opcode;
        vir_intf.address = txn.address;
        vir_intf.txn_id = txn.txn_id;
        vir_intf.data = txn.data;
        vir_intf.src_id = txn.src_id;
        vir_intf.tgt_id = txn.tgt_id;
      port.write(txn);
    end
  endtask
endclass
