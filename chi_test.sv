    
class chi_test extends uvm_test;
  
  `uvm_component_utils (chi_test)
  
  function new(string name ="chi_test", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  chi_env env;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env = chi_env::type_id::create("env",this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    $display("TEST","End Of Elabration Phase");
  endfunction
  
  function void end_of_simulation_phase(uvm_phase);
    $display ("TEST","End Of Simulation Phase");
    set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY);
    set_report_verbosity_level_hier(UVM_MEDIUM);
  endfunction
  
  task run_phase (uvm_phase phase);
    
    chi_sequence seq1;
    
    phase.raise_objection(this);
    
    seq1 = chi_sequence::type_id::create("seq1",this);
    seq1.start(env.agt.seq);
    
    #1000;
    
    phase.drop_objection(this);
  endtask
  
endclass