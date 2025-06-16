vlog -f run.f +define+UVM_REPORT_DISABLE_FILE 
vopt top -o top_opt -designfile design.bin -debug
vsim -c top_opt -qwavedb=+signal+wavefile=qwave.db
