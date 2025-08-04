`include "uvm_macros.svh"
`include "chi_pkg.sv"
`include "chi_requester_node.sv"
`include "chi_home_node.sv"
`include "chi_intf.sv"


module top;
  logic clk;
  chi_intf chi_if(clk);
  
  chi_requester_node #((4'd1),(4'd0))
  requester (.clk (clk),.rst (chi_if.rst),.tb_valid (chi_if.valid),.flit_in_valid(1'b0),              .flit_ready   (1'b1),.tb_flit (chi_if.flit),.flit_in ('0),
             .tb_ready (),.flit_valid (),.flit_out());
  
   chi_home_node #((4'd0))
  home (.clk (clk),.rst (chi_if.rst),.flit_valid (1'b0),.flit_ready_out (1'b1),       
        .flit_in ('0),.flit_ready(),.flit_valid_out (),.flit_out());
  
  initial begin 
    clk = 0;
    forever #10 clk = ~clk;
  end
  
  initial begin 
    uvm_config_db#(virtual chi_intf)::set(uvm_root::get(),"","vir_intf",chi_if);
  end
  
  initial begin
    run_test("chi_test");
  end
  
  initial begin
    $dumpfile ("wave.vcd");
    $dumpvars(0,top);
  end
  
endmodule
    