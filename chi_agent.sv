class chi_agent extends uvm_agent;
  
  `uvm_component_utils(chi_agent)
  
  function new(string name="chi_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  chi_sequencer seq;
  chi_driver drv;
  chi_monitor mon;
  
  function void build_phase ( uvm_phase phase);
    super.build_phase (phase);
    
    seq = chi_sequencer::type_id::create("seq",this);
    drv = chi_driver::type_id::create("drv",this);
    mon = chi_monitor::type_id::create("mon",this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    drv.seq_item_port.connect(seq.seq_item_export);
    
  endfunction
  
endclass
    