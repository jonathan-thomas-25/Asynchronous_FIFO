module asynchronus_fifo #(parameter ASIZE=4, DSIZE=8) (

	input winc,
	input wclk,
	input wrst_n,
	input rinc,
	input rclk,
	input rrst_n,
	input [DSIZE-1:0] wdata,
	output [DSIZE-1:0] rdata,
	output wfull,
	output rempty

);

	wire [ASIZE:0] rptr,wq2_rptr,wptr, rq2_wptr;
	wire [ASIZE-1:0] waddr,raddr;

	sync_r2w syn_r2w_dut(.wclk(wclk), .wrst_n(wrst_n), .rptr(rptr), .wq2_rptr(wq2_rptr) );

	sync_w2r syn_w2r_dut(.rclk(rclk), .rrst_n(rrst_n), .wptr(wptr), .rq2_wptr(rq2_wptr) );

	fifo_mem #(DSIZE, ASIZE) fifo_mem_dut ( .waddr(waddr), .raddr(raddr), .wdata(wdata), .wclken(winc), .wfull(wfull), .wclk(wclk) );

	rptr_empty rptr_empty_dut ( .rclk(rclk), .rrst_n(rrst_n), .rinc(rinc), .rq2_wptr(rq2_wptr), .rptr(rptr), .rempty(rempty), .raddr(raddr) );

	wptr_full wptr_full_dut (.wclk(wclk), .wrst_n(wrst_n), .winc(winc), .wq2_rptr(wq2_rptr), .wptr(wptr), .wfull(wfull), .waddr(waddr) );

endmodule
