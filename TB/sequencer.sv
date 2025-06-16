class sequencer extends uvm_sequencer#(seq_item);

	`uvm_component_utils(sequencer)

	function new(string name="sequencer", uvm_component parent=null);
		super.new(name,parent);	
	endfunction

endclass


/*class write_sequencer extends uvm_sequencer #(seq_item);

	`uvm_component_utils(write_sequencer)

	function new(string name="write_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction

endclass

class read_sequencer extends uvm_sequencer #(seq_item);

	`uvm_component_utils(read_sequencer)

	function new(string name="read_sequencer", uvm_component parent);
		super.new(name,parent);
	endfunction

endclass*/
