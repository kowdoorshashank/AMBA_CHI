class chi_env extends uvm_env;
  
  `uvm_component_utils(chi_env)
  
  function new(string name ="chi_env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  chi_agent agt;
  chi_scoreboard scr;
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    agt = chi_agent::type_id::create("agt",this);
    scr = chi_scoreboard::type_id::create("scr",this);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);

    agt.mon.port.connect(scr.analysis_export);
    scr.connect_driver(agt.drv);
      endfunction
endclass
  