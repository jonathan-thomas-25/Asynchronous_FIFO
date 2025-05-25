module fifomem #(parameter DATASIZE=8, ADDRSIZE=4) (
	
	input [ADDRSIZE-1:0] waddr,
	input [ADDRSIZE-1:0] raddr,
	input [DATASIZE-1:0] wdata,
	input wclken, 
	input wfull, 
	input wclk
);

localparam DEPTH=1<<ADDRSIZE;

logic [DATASIZE-1:0] mem [0:DEPTH-1];

assign rdata=mem[raddr];

always @(posedge wclk)begin
	if(wclken && !wfull) mem[waddr]<=wdata;
end

endmodule
