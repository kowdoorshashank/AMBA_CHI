interface chi_intf(input logic clk);
  logic rst;
  flit_type FT;
  chi_req_opcode opcode;
  logic [31:0] address;
  logic [7:0] txn_id;
  logic [31:0] data;
  logic [3:0] src_id;
  logic [3:0] tgt_id;
  logic valid;
  logic ready;
  
  chi_flit flit;
endinterface
