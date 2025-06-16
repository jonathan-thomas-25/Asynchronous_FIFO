class agent extends uvm_agent;

	`uvm_component_utils(agent)

	driver drv;
	monitor mon;
	//scoreboard scb;
	sequencer seq;

	function new(string name="agent", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv=driver::type_id::create("drv",this);
		mon=monitor::type_id::create("mon",this);
	//	scb=scoreboard::type_id::create("scb",this);
		seq=sequencer::type_id::create("seq",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(seq.seq_item_export);
	endfunction

endclass

/*class write_agent extends uvm_agent;

	`uvm_component_utils(write_agent)

	write_driver drv;
	write_monitor mon;
	write_sequencer seq;

	function new(string name="agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.new(phase);
		drv=write_driver::type_id::create("drv",this);
		mon=write_monitor::type_id::create("mon",this);
		seq=write_sequencer::type_id::create("seq",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv_seq_item_port.connect(seq.seq_item.export);
	endfunction	

endclass


class read_agent extends uvm_agent;

	`uvm_component_utils(read_agent)

	read_driver drv;
	read_monitor mon;
	read_sequencer seq;

	function new(string name="agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.new(phase);
		drv=read_driver::type_id::create("drv",this);
		mon=read_monitor::type_id::create("mon",this);
		seq=read_sequencer::type_id::create("seq",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv_seq_item_port.connect(seq.seq_item.export);
	endfunction	

endclass*/
