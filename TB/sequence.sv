class base_sequence extends uvm_sequence;

	`uvm_object_utils(base_sequence)

	function new(string name="base_sequence");
		super.new(name);
	endfunction

	seq_item pkt;

	task body;
		`uvm_info("##FIFO BASE SEQUENCE##","INSIDE TASK BODY", UVM_LOW)
		pkt= seq_item#(DSIZE)::type_id::create("pkt");
		start_item(pkt);
		pkt.fifo_reset.constraint_mode(0);
		assert(pkt.randomize() with {pkt.wrst_n=='0; pkt.rrst_n=='0;});
		`uvm_info("#SEQ#", $sformatf("Generated new item: %s",pkt.convert2str()),UVM_LOW)
		`uvm_info("---------------------------------------","",UVM_LOW)
		`uvm_info("---------------------------------------","",UVM_LOW)
		finish_item(pkt);
	endtask

endclass

class write_sequence extends base_sequence;

	`uvm_object_utils(write_sequence)

	seq_item pkt;
	int num=256;

	function new(string name="base_sequence");
		super.new(name);
	endfunction

	task body;
		for(int i=0; i<7; i++)begin
			`uvm_info("FIFO WRITE SEQUENCE", "INSIDE TASK BODY", UVM_LOW)
			pkt=seq_item#(DSIZE)::type_id::create("pkt");
			start_item(pkt);
				assert( pkt.randomize() with {winc==1;rinc==0;} );
				`uvm_info("#FIFO WRITE SEQ#", $sformatf("Generated new item: %s",pkt.convert2str()), UVM_LOW)
				`uvm_info("---------------------------------------","",UVM_LOW)
				`uvm_info("---------------------------------------","",UVM_LOW)	
			finish_item(pkt);
			`uvm_info("#SEQ#", $sformatf("Done Generating new item %d",i), UVM_LOW)
		end
	endtask

endclass


class read_sequence extends base_sequence;

	`uvm_object_utils(read_sequence)

	seq_item pkt;
	int num=256;

	function new(string name="base_sequence");
		super.new(name);
	endfunction

	task body;
		for(int i=0; i<7; i++)begin
			`uvm_info("FIFO READ SEQUENCE", "INSIDE TASK BODY", UVM_LOW)
			pkt=seq_item#(DSIZE)::type_id::create("pkt");
			start_item(pkt);
				assert( pkt.randomize() with {winc==0;rinc==1;} );
				`uvm_info("#FIFO READ SEQ#", $sformatf("Generated new item: %s",pkt.convert2str()), UVM_LOW)
				`uvm_info("---------------------------------------","",UVM_LOW)
				`uvm_info("---------------------------------------","",UVM_LOW)
			finish_item(pkt);
			`uvm_info("#SEQ#", $sformatf("Done Generating new item %d",i), UVM_LOW)
		end
	endtask

endclass


