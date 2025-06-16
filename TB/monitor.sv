class monitor extends uvm_monitor;

	`uvm_component_utils(monitor)
	
	seq_item pkt;
	virtual intf vif;
	uvm_analysis_port #(seq_item) monitor_port;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("MONITOR BUILD PHASE","",UVM_LOW)
		monitor_port=new("monitor_port",this);
		if(!(uvm_config_db#(virtual intf)::get(this,"*","vif",vif)))
			`uvm_error("MONITOR", "Failed to get the interface from the config database");	
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("MONITOR RUN PHASE","",UVM_LOW)
		forever begin
			pkt=seq_item#(DSIZE)::type_id::create("pkt");
			wait(vif.wrst_n && vif.rrst_n);
			if(vif.winc && !vif.rinc)begin
				//@(posedge vif.wclk);
				pkt.winc<=vif.winc;
				pkt.rinc<=vif.rinc;
				pkt.wdata<=vif.wdata;
				pkt.wfull<=vif.wfull;
				pkt.rempty<=vif.rempty;
				@(posedge vif.wclk);
				`uvm_info("MONITOR DETECTED WRITE",$sformatf("Burst Details: time=%t, winc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc,vif.wdata,vif.wfull,vif.rempty),UVM_LOW)	
			end
			if(vif.rinc && !vif.winc)begin
				//@(posedge vif.rclk);
				pkt.winc<=vif.winc;
				pkt.rinc<=vif.rinc;
				pkt.rdata<=vif.rdata;
				pkt.wfull<=vif.wfull;
				pkt.rempty<=vif.rempty;
				@(posedge vif.rclk);
				`uvm_info("MONITOR DETECTED READ",$sformatf("Burst Details: time=%t, winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc, vif.rinc, vif.wdata,vif.wfull,vif.rempty),UVM_LOW)
			end
			//$display("[JON MONITOR] pkt.winc=%d, pkt.wdata=%d",pkt.winc,pkt.wdata);
			monitor_port.write(pkt);

		end	
	endtask

endclass

/*class write_monitor extends uvm_moitor;

	`uvm_component_utils(write_monitor)
	uvm_analysis_port #(seq_item) monitor_port;	
	seq_item pkt;

	virtual intf vif;
	
	
	function new(string name="write_monitor", uvm_component parent);
		super.new(name,parent);
		monitor_port=new("monitor_port",this);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db#(virtual intf)::get(this,"*","vif",vif) ))
			`uvm_fatal("[WRITE MONITOR]","Failed to retrieve the interface handle from the config db")
	endfunction

	task run_phase(uvm_phase phase);
		super.build_phase(phase);
		pkt=seq_item#(DSIZE)::type_id::create("pkt");
		forever begin
			if(vif.winc && !vif.rinc)begin
				pkt.winc<=vif.winc;
				pkt.wdata<=vif.wdata;
				pkt.rinc<=vif.rinc;
				pkt.rdata<=vif.rdata;
				pkt.rempty<=vif.rempty;
				pkt.wfull<=vif.wfull;
				pkt.rempty<=vif.rempty;
				@(posedge vif.wclk);
				`uvm_info("MONITOR DETECTED READ",$sformatf("Burst Details: time=%t, winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc, vif.rinc, vif.wdata,vif.wfull,vif.rempty),UVM_LOW)
			end
			monitor_port.write(pkt);
		end
	endtask


endclass


class read_monitor extends uvm_moitor;

	`uvm_component_utils(read_monitor)
	uvm_analysis_port #(seq_item) monitor_port;	
	seq_item pkt;

	virtual intf vif;
	
	
	function new(string name="read_monitor", uvm_component parent);
		super.new(name,parent);
		monitor_port=new("monitor_port",this);
	endfunction	

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!(uvm_config_db#(virtual intf)::get(this,"*","vif",vif) ))
			`uvm_fatal("[WRITE MONITOR]","Failed to retrieve the interface handle from the config db")
	endfunction

	task run_phase(uvm_phase phase);
		super.build_phase(phase);
		pkt=seq_item#(DSIZE)::type_id::create("pkt");
		forever begin
			if(!vif.winc && vif.rinc)begin
				pkt.winc<=vif.winc;
				pkt.wdata<=vif.wdata;
				pkt.rinc<=vif.rinc;
				pkt.rdata<=vif.rdata;
				pkt.rempty<=vif.rempty;
				pkt.wfull<=vif.wfull;
				pkt.rempty<=vif.rempty;
				@(posedge vif.rclk);
				`uvm_info("MONITOR DETECTED READ",$sformatf("Burst Details: time=%t, winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,vif.winc, vif.rinc, vif.wdata,vif.wfull,vif.rempty),UVM_LOW)
			end
			monitor_port.write(pkt);
		end
	endtask


endclass*/
