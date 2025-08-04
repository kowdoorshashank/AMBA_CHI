
class chi_sequence_item extends uvm_sequence_item;
  logic rst;
  rand flit_type FT;
  rand chi_req_opcode opcode;
  rand logic [31:0] address;
  rand logic [7:0] txn_id;
  rand logic [31:0] data;
  rand logic [3:0] src_id;
  rand logic [3:0] tgt_id;
  
  constraint addr { address[1:0] == 0;}
  constraint FT_C { FT == FLIT_REQ;}
  
  `uvm_object_utils_begin (chi_sequence_item)
  `uvm_field_int (rst,UVM_ALL_ON)
  `uvm_field_enum (flit_type,FT,UVM_ALL_ON)
  `uvm_field_enum (chi_req_opcode,opcode,UVM_ALL_ON)
  `uvm_field_int (address,UVM_ALL_ON)
  `uvm_field_int (txn_id,UVM_ALL_ON)
  `uvm_field_int (data,UVM_ALL_ON)
  `uvm_field_int (src_id,UVM_ALL_ON)
  `uvm_field_int (tgt_id,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new ( string name = "chi_sequence_item");
    super.new(name);
  endfunction
  

  function string convert2string();
    return $sformatf("FT=%s Opcode=%s Addr=0x%08h TxnID=%0d SrcID=%0d TgtID=%0d data = %08h",
                     FT.name(), opcode.name(), address, txn_id, src_id, tgt_id,data);
  endfunction

  
endclass