VERILATOR_FLAGS=--cc --exe --build -Wall --trace -j 0
VERILATOR_INPUTS=vsrc/top.v csrc/main.cpp
all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	verilator $(VERILATOR_FLAGS) $(VERILATOR_INPUTS)

include ../Makefile
