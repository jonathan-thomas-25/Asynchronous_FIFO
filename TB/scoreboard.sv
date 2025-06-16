class scoreboard extends uvm_test;

	`uvm_component_utils(scoreboard)

	//seq_item packet;

	seq_item actual_q[$];
	bit [7:0] wdata_q[$:7];
	bit [7:0] popped;

	uvm_analysis_imp #(seq_item,scoreboard) scb_port;

	function new(string name="scoreboard",uvm_component parent);
		super.new(name,parent);
		scb_port=new("scb_port",this);
	endfunction

	function void write(seq_item pkt);
		`uvm_info("[SCOREBOARD DEBUG]",$sformatf("pkt.winc=%d, pkt.wdata=%d",pkt.winc,pkt.wdata), UVM_LOW)
		actual_q.push_front(pkt);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			seq_item pkt=new();
			wait(actual_q.size()>0);
			pkt=actual_q.pop_back();
			if(pkt.winc && !pkt.wfull)begin
				wdata_q.push_front(pkt.wdata);
			end

			if(pkt.rinc && !pkt.rempty)begin
				popped=wdata_q.pop_back();
				if(pkt.rdata!==popped)begin
					`uvm_error("[SCOREBOARD MATCH FAILED]","JON IS HERE");
					`uvm_info(get_type_name, $sformatf("wdata=%d, rdata=%d",popped,pkt.rdata), UVM_LOW);
				end
				else `uvm_info(get_type_name(), $sformatf("[SCOREBOARD] MATCH SUCCESSFULL - wdata=%d, rdata=%d", popped,pkt.rdata), UVM_LOW);
			end
		end
	endtask
endclass
