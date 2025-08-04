class chi_sequencer extends uvm_sequencer#(chi_sequence_item);
  
 `uvm_component_utils(chi_sequencer)

  
  function new ( string name = "chi_sequencer", uvm_component parent);
    super.new(name,parent);
  endfunction
  
endclass 