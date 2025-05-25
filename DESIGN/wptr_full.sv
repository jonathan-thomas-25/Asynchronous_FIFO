module wptr_full #(parameter ADDRSIZE=4) (

	input wclk,
	input wrst_n,
	input winc,
	input [ADDRSIZE:0] wq2_rptr,
	output reg wfull,
	output [ADDRSIZE-1:0] waddr,
	output reg [ADDRSIZE:0] wptr
);

logic [ADDRSIZE:0] wbin;
logic [ADDRSIZE:0] wgraynext, wbinnext;

always @(posedge wclk or negedge wrst_n)begin
	if(!wrst_n){wbin,wptr}<=0;
	else {wbin,wptr}<={wbinnext,wgraynext};
end

assign wbinnext = wbin+(winc&&~wfull);
assign wgraynext = (wbinnext >> 1)^wbinnext;

assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});

always @(posedge wclk or negedge wrst_n)begin
	if(!wrst_n) wfull<=1'b0;
	else wfull<=wfull_val;
end

endmodule
