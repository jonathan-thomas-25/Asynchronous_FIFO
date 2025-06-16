/*module asynchronus_fifo #(parameter ASIZE=4, DSIZE=8) (

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

);*/

module asynchronous_fifo #(parameter ASIZE=4, DSIZE=8)(

	intf i1  

);

	wire [ASIZE:0] rptr,wq2_rptr,wptr, rq2_wptr;
	wire [ASIZE-1:0] waddr,raddr;

	sync_r2w syn_r2w_dut(.wclk(i1.wclk), .wrst_n(i1.wrst_n), .rptr(rptr), .wq2_rptr(wq2_rptr) );

	sync_w2r syn_w2r_dut(.rclk(i1.rclk), .rrst_n(i1.rrst_n), .wptr(wptr), .rq2_wptr(rq2_wptr) );

	fifo_mem #(DSIZE, ASIZE) fifo_mem_dut ( .waddr(waddr), .raddr(raddr), .wdata(i1.wdata), .rdata(i1.rdata),.wclken(i1.winc), .wfull(i1.wfull), .wclk(i1.wclk) );

	rptr_empty rptr_empty_dut ( .rclk(i1.rclk), .rrst_n(i1.rrst_n), .rinc(i1.rinc), .rq2_wptr(rq2_wptr), .rptr(rptr), .rempty(i1.rempty), .raddr(raddr) );

	wptr_full wptr_full_dut (.wclk(i1.wclk), .wrst_n(i1.wrst_n), .winc(i1.winc), .wq2_rptr(wq2_rptr), .wptr(wptr), .wfull(i1.wfull), .waddr(waddr) );

endmodule
