class seq_item #(parameter DSIZE=8) extends uvm_sequence_item;

	`uvm_object_utils(seq_item #(DSIZE))

	rand logic winc;
	rand logic rinc;
	rand logic rrst_n;
	rand logic wrst_n;
	rand logic [DSIZE-1:0] wdata;
	logic [DSIZE-1:0] rdata;
	logic wfull;
	logic rempty;

	function new(string name="seq_item");
		super.new(name);	
	endfunction

	function string convert2str();
		return $sformatf("winc=%0d, rinc=%0d, wdata=%0d, full=%0d, empty=%0d",winc,rinc,wdata,wfull, rempty);
	endfunction

	constraint fifo_reset{
		wrst_n==1 && rrst_n==1;
	}

endclass


class seq_item2 #(parameter DSIZE=8) extends seq_item;

	`uvm_object_utils(seq_item2#(DSIZE))

	function new(string name="seq_item2");
		super.new(name);
	endfunction

	constraint jon{
		wdata inside{[100:120]};
	}

endclass

class seq_item3 #(parameter DSIZE=8) extends uvm_sequence_item;

	`uvm_object_utils(seq_item2#(DSIZE))

	rand logic winc;
	rand logic rinc;
	rand logic rrst_n;
	rand logic wrst_n;
	rand logic [DSIZE-1:0] wdata;
	logic [DSIZE-1:0] rdata;
	logic wfull;
	logic rempty;

	function new(string name="seq_item3");
		super.new(name);
	endfunction

	constraint jon{
		wdata inside{[50:75]};
	}

endclass
