class chi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(chi_scoreboard)

  bit [31:0] mem [bit [31:0]];
  chi_driver resp_drv;

  uvm_analysis_imp #(chi_sequence_item, chi_scoreboard) analysis_export;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
  endfunction

  function void write(chi_sequence_item tr);
    case (tr.opcode)
      WriteUnique, WriteBack: begin
        mem[tr.address] = tr.data;
        `uvm_info("SCOREBOARD", $sformatf("Write Addr=0x%08h Data=0x%08h",
                                          tr.address, tr.data), UVM_LOW)
      end

      ReadShared: begin
        bit [31:0] rdata = mem.exists(tr.address) ? mem[tr.address] : 32'h0;
        send_read_response(tr, rdata);
      end
    endcase
  endfunction

  task send_read_response(chi_sequence_item tr, bit [31:0] data);
    chi_sequence_item resp;
    resp = chi_sequence_item::type_id::create("resp");
    resp.FT      = FLIT_RSP;
    resp.opcode  = ReadShared;
    resp.address = tr.address;
    resp.txn_id  = tr.txn_id;
    resp.src_id  = tr.tgt_id;
    resp.tgt_id  = tr.src_id;
    resp.data    = data;

    `uvm_info("MEM_RESP", $sformatf("ReadResp Addr=0x%08h Data=0x%08h",
                 tr.address, data), UVM_LOW)

    resp_drv.seq_item_port.put(resp);
  endtask

  function void connect_driver(chi_driver drv);
    resp_drv = drv;
  endfunction
endclass