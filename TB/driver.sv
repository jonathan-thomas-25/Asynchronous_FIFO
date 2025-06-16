class driver extends uvm_driver#(seq_item);

	`uvm_component_utils(driver)

	virtual intf vif;
	seq_item pkt;
	
	function new(string name, uvm_component parent=null);
		super.new(name,parent);	
	endfunction

	function void build_phase(uvm_phase phase);
		//super.build_phase(phase);
		`uvm_info("DRIVER BUILD FUNCTION","",UVM_LOW)
		
		if(!uvm_config_db#(virtual intf)::get(this,"*","vif",vif))begin
			`uvm_error("DRIVER BUILD FUNCTION", "Failed to get vif from the database")
		end

		//set_report_verbosity_level(UVM_LOW);

	endfunction	

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("DRIVER RUN PHASE", "", UVM_LOW)
		forever begin
			pkt=seq_item#(DSIZE)::type_id::create("pkt");
			seq_item_port.get_next_item(pkt);
			drive(pkt);
			seq_item_port.item_done();
		end
	endtask

	task drive(seq_item drvpkt);
		if(!drvpkt.wrst_n && !drvpkt.rrst_n)begin
			vif.wrst_n<= drvpkt.wrst_n;
			vif.rrst_n<=drvpkt.rrst_n;
			`uvm_info("#DRIVER WRITE- RESET PACKET#", $sformatf("BURST_DETAILS: time=%t, winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc,vif.rinc,vif.wdata,vif.wfull,vif.rempty), UVM_LOW)
		end
		else begin
			if(drvpkt.winc && !drvpkt.rinc)begin
				vif.wrst_n<=drvpkt.wrst_n;
				vif.rrst_n<=drvpkt.rrst_n;
				vif.winc<=drvpkt.winc;
				vif.wdata<=drvpkt.wdata;
				vif.rinc<=drvpkt.rinc;
				@(posedge vif.wclk);
				`uvm_info("#DRIVER WRITE#", $sformatf("BURST_DETAILS: time=%t, winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc,vif.rinc,vif.wdata,vif.wfull,vif.rempty), UVM_LOW)
				//@(posedge vif.wclk);
			end
			if(drvpkt.rinc && !drvpkt.winc)begin
				vif.wrst_n<=drvpkt.wrst_n;
				vif.rrst_n<=drvpkt.rrst_n;
				vif.winc<=drvpkt.winc;
				vif.wdata<=drvpkt.wdata;
				vif.rinc<=drvpkt.rinc;
				@(posedge vif.rclk);
			end
		end

	endtask

endclass

/*class write_driver extends uvm_driver#(seq_item);

	`uvm_component_utils(write_driver)

	virtual intf vif;
	seq_item pkt;

	function new(string name="write_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.new(phase);
		if(!uvm_config_db#(virtual intf)::get::(this,"*","vif",vif) )
			`uvm_fatal("[WRITE DRIVER BUILD PHASE]","Failed to get the interface handle")
	endfunction


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			pkt=seq_item#(DSIZE)::type_id::create("pkt");	
			start_item(pkt);
			drive(pkt);	
			finish_item(pkt);
		end
	endtask

	task drive(seq_item pkt);
		if(!pkt.wrst_n && !pkt.rrst_n)begin
			vif.wrst_n<=pkt.wrst_n;
			vif.rrst_n<=pkt.rrst_n;
		end
		if(pkt.winc && !pkt.rinc)begin
			vif.wrst_n<=pkt.wrst_n;
			vif.rrst_n<=pkt.rrst_n;
			vif.winc<=pkt.winc;
			vif.wdata<=pkt.wdata;
			vif.rinc<=pkt.rinc;
			@(posedge vif.wclk);
			`uvm_info("#DRIVER WRITE#", $sformatf("BURST_DETAILS: time=%t, winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc,vif.rinc,vif.wdata,vif.wfull,vif.rempty), UVM_LOW)	
		end
	endtask


endclass


class read_driver extends uvm_driver#(seq_item);

	`uvm_component_utils(read_driver)

	virtual intf vif;
	seq_item pkt;

	function new(string name="read_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.new(phase);
		if(!uvm_config_db#(virtual intf)::get::(this,"*","vif",vif) )
			`uvm_fatal("[READ DRIVER BUILD PHASE]","Failed to get the interface handle")
	endfunction


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			pkt=seq_item#(DSIZE)::type_id::create("pkt");	
			start_item(pkt);
			drive(pkt);	
			finish_item(pkt);
		end
	endtask

	task drive(seq_item pkt);
		if(!pkt.wrst_n && !pkt.rrst_n)begin
			vif.wrst_n<=pkt.wrst_n;
			vif.rrst_n<=pkt.rrst_n;
		end
		if(pkt.rinc && !pkt.winc)begin
			vif.wrst_n<=pkt.wrst_n;
			vif.rrst_n<=pkt.rrst_n;
			vif.winc<=pkt.winc;
			vif.wdata<=pkt.wdata;
			vif.rinc<=pkt.rinc;
			@(posedge vif.rclk);
			`uvm_info("#DRIVER READ#", $sformatf("BURST_DETAILS: time=%t, winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc,vif.rinc,vif.wdata,vif.wfull,vif.rempty), UVM_LOW)	
		end
	endtask


endclass*/
