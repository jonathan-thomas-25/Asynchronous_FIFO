module ref_fifo #(parameter DSIZE=8, ASIZE=4) (

	input winc,
	input rinc,
	input wclk,
	input rclk,
	input wrst_n,
	input rrst_n,
	input [DSIZE-1:0] wdata,
	output wfull,
	output rempty,
	output [DSIZE-1:0] rdata

);

	localparam MEMDEPTH=1<<ASIZE;

endmodule
