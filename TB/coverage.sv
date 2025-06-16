class coverage extends uvm_test;

	`uvm_component_utils(coverage)

	uvm_analysis_imp#(seq_item,coverage) coverage_port;

	seq_item cov_pkt;

	virtual intf cov_if;
	real coverage_score1;
	real coverage_score2;

//	covergroup cov_mem with function sample(seq_item cov_pkt);
//		a1: coverpoint cov_pkt.waddr{
//			bins waddr[]={[0:255]};
//		}
//		a2: coverpoint cov_pkt.raddr{
//			bins raddr[]={[0:255]};
//		}
//		w_r_addr: cross a1,a2;
//	endgroup

	covergroup test_write with function sample(seq_item w_pkt);

		c0: coverpoint w_pkt.wrst_n{
			bins RESET_0 = {0};
			bins RESET_1 = {1};
		}

		c1: coverpoint w_pkt.rempty{
			bins fifo_empty_0={0};	
			bins fifo_empty_1={1};
		}

		c2: coverpoint w_pkt.wfull{
			bins fifo_full_0 = {0};
			bins fifo_full_1 = {1};
		}

		c3: coverpoint w_pkt.winc{
			bins winc_1={1};
			bins winc_0={0};
		}	

		c4: coverpoint w_pkt.rinc{
			bins rinc_1={1};
			bins rinc_0={0};
		}


	// cross coverpoints

	read_and_fifo_empty: cross c4,c1;
	read_write_fifo_empty: cross c3,c4,c1;
	write_and_clear: cross c3,c0;
	write_and_fifo_full: cross c3,c2;

	endgroup

	function new(string name="coverage",uvm_component parent);
		super.new(name,parent);
		//cov_mem=new();
		test_write=new();
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("[COVERAGE]", "Inside build phase of coverage class", UVM_HIGH)
		coverage_port=new("coverage_port",this);
	endfunction

	function void write(seq_item t);
//		cov_mem.sample(t);
		test_write.sample(t);
	endfunction

	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
	//	coverage_score1=cov_mem.get_coverage();
		coverage_score2=test_write.get_coverage();
	endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
	//	`uvm_info("****COVERAGE****",$sformatf("COVERAGE: %0f", coverage_score1),UVM_MEDIUM)
		`uvm_info("****COVERAGE****",$sformatf("COVERAGE: %0f", coverage_score2),UVM_MEDIUM)
	endfunction

endclass
