
`include "uvm_macros.svh"
//`include "test.sv"

module top;


import uvm_pkg::*;
import fifo_package::*;

bit wclk, rclk;

intf intf1(.wclk(wclk),.rclk(rclk));

asynchronous_fifo #(.DSIZE(DSIZE), .ASIZE(ASIZE)) fifo1 (.i1(intf1));

initial begin
	 uvm_config_db #(virtual intf)::set(null,"*","vif",intf1);
	 run_test("test");
end

//initial begin
//	run_test("test");
//end

always #5 rclk=~rclk;
always #2 wclk=~wclk;

initial begin
	intf1.wrst_n=0;
	intf1.rrst_n=0;

	#15 intf1.wrst_n=1'b1;
	#15 intf1.rrst_n=1'b1;

end

initial begin
	#10000;
	$display("Sorry ran out of clock cycles");
	$finish;	
end

//initial begin
//	uvm_default_report_server.set_file("uvm_log.txt");
//end

endmodule
