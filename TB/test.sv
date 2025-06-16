class test extends uvm_test;

	`uvm_component_utils(test)

	environment e1;
	base_sequence reset_seq;
	write_sequence write_seq;
	read_sequence read_seq;

	function new(string name="test", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		//super.build_phase(phase);
		//e1=environment::type_id::create("e1",this);
		uvm_factory factory = uvm_factory::get;
		super.build_phase(phase);
		factory.print();
		set_type_override_by_type(seq_item#(DSIZE)::get_type(), seq_item2#(DSIZE)::get_type());
		e1=environment::type_id::create("e1",this);
	//	e1.a1.drv.set_report_verbosity_level(UVM_FULL);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("TEST CLASS", "INSIDE RUN PHASE", UVM_HIGH)
		phase.raise_objection(this);

			reset_seq = base_sequence::type_id::create("reset_seq");
			reset_seq.start(e1.a1.seq);	

			#10;

			write_seq= write_sequence::type_id::create("write_seq");
			write_seq.start(e1.a1.seq);

			#10;

			read_seq= read_sequence::type_id::create("read_seq");
			read_seq.start(e1.a1.seq);

			#10;

		phase.drop_objection(this);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		int output_file=$fopen("output.log","w");
		super.end_of_elaboration_phase(phase);
		uvm_root::get().print_topology();
		uvm_top.set_report_default_file_hier(output_file);
		uvm_top.set_report_severity_action_hier(UVM_INFO, UVM_LOG);
	endfunction

endclass
