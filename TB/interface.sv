interface intf(input bit wclk, rclk);

	parameter ASIZE=4, DSIZE=8;
	logic wrst_n, rrst_n;
	logic winc,rinc;
	bit wfull, rempty;
	logic [7:0] wdata, rdata;
		
endinterface
