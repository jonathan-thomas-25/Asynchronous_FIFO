module top;

	bit wclk, rclk;
	intf i1(.wclk(wclk), .rclk(rclk));

	asynchronous_fifo d1(.i1(i1));

	always #5 rclk=~rclk;
	always #2 wclk=~wclk;

	initial begin

		#20;	
		{i1.wrst_n,i1.rrst_n}='0;
		#20	
		{i1.wrst_n, i1.rrst_n}='1;

		`ifdef BOTH 
		for(int i=0; i<20; i++)begin
			if(i%2==0)begin
				@(posedge wclk);
				i1.winc<=1'b1;
				i1.rinc<=1'b0;
				i1.wdata=(i+1)*10;	
			end
			else if(i%3==0)begin
				@(posedge rclk);
				i1.rinc<=1'b1;
				i1.winc<=1'b0;
			end
			else begin
				i1.rinc<=1'b0;
				i1.winc<=1'b0;
			end
		//	$display("i=%d",i);
		//	$strobe("[%t][i=%d] winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,i, i1.winc,i1.rinc, i1.wdata, i1.wfull, i1.rempty);
			#1;
			$display("[%t][i=%d] winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,i, i1.winc,i1.rinc, i1.wdata, i1.wfull, i1.rempty);	
		end

		`endif




		`ifdef FULL

	for(int i=0; i<20; i++)begin
			if(i%2==0)begin
				@(posedge wclk);
				i1.winc<=1'b1;
				i1.rinc<=1'b0;
				i1.wdata=(i+1)*10;	
			end
			else if(i%5==0)begin
				@(posedge rclk);
				i1.rinc<=1'b1;
				i1.winc<=1'b0;
			end
			else begin
				i1.rinc<=1'b0;
				i1.winc<=1'b0;
			end
		//	$display("i=%d",i);
		//	$strobe("[%t][i=%d] winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,i, i1.winc,i1.rinc, i1.wdata, i1.wfull, i1.rempty);
			#1;
			$display("[%t][i=%d] winc=%d, rinc=%d, wdata=%d, full=%d, empty=%d",$time,i, i1.winc,i1.rinc, i1.wdata, i1.wfull, i1.rempty);	
		end
	
	
		`endif



		$finish;		

	end	

endmodule
