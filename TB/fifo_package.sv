//import uvm_pkg::*;
//`include "uvm_macros.svh"

package fifo_package;
        timeunit 1ns;
	timeprecision 1ns;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	parameter ASIZE=4, DSIZE=8;
	
	typedef class seq_item;
	typedef class seq_item2;
	typedef class base_sequence;
	typedef class read_sequence;
	typedef class write_sequence;
	typedef class sequencer;
	typedef class driver;
	typedef class monitor;
	typedef class agent;
	typedef class scoreboard;
	typedef class environment;
	typedef class test;
	typedef class coverage;

	`include "seq_item.sv"
        `include "sequence.sv"
	`include "sequencer.sv"
	`include "driver.sv"
	`include "monitor.sv"	
        `include "agent.sv"
	`include "scoreboard.sv"
	`include "coverage.sv"
	`include "environment.sv"
	`include "test.sv"

endpackage
