
class chi_sequence extends uvm_sequence #(chi_sequence_item);

  `uvm_object_utils(chi_sequence)

  int count = 100;      
  typedef enum {MODE_WRITE, MODE_READ, MODE_BACK} mode_t;
  mode_t mode = MODE_WRITE;


  logic [31:0] last_write_addr;
  logic [31:0] last_write_data;
  logic has_write = 0; 

  function new(string name = "chi_sequence");
    super.new(name);
  endfunction

  task body();
    chi_sequence_item txn;

    repeat (count) begin
      txn = chi_sequence_item::type_id::create("txn");

      
      assert(txn.randomize() with {
        address inside {[32'h0 : 32'h3FF]};
        address[1:0] == 2'b00;
        src_id == 4'd1;
        tgt_id == 4'd0;
      });
      txn.data = $urandom;
      txn.FT   = FLIT_REQ;

      case (mode)
       
        MODE_WRITE: begin
          txn.opcode = WriteUnique;

          last_write_addr = txn.address;
          last_write_data = txn.data;
          has_write = 1;
          mode = MODE_READ;
        end
        MODE_READ: begin
          
          if (has_write)
            txn.address = last_write_addr;
            txn.data = last_write_data;

          txn.opcode = ReadShared;        
          mode = MODE_BACK;
        end
        MODE_BACK: begin
          if (has_write)
            txn.address = last_write_addr;
          txn.opcode = WriteBack;
          mode = MODE_WRITE;
        end
      endcase

      `uvm_info("SEQ", txn.convert2string(), UVM_LOW)

      start_item(txn);
      finish_item(txn);
    end
  endtask

endclass
