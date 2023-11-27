#include <cstdlib>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <assert.h>
#include <memory.h>
#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char **argv) {
  const std::unique_ptr<VerilatedContext> contextp(new VerilatedContext);
  contextp->commandArgs(argc, argv);
  const std::unique_ptr<Vtop>top (new Vtop{contextp.get()});
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace(tfp, 99); // Trace 99 levels of hierarchy (or see below)
  // tfp->dumpvars(1, "t"); // trace 1 level under "t"
  tfp->open("obj_dir/top.vcd");
  while (!contextp->gotFinish()) {
    contextp->timeInc(1);
    int a = rand() & 1;
    int b = rand() & 1;
    top->a = a;
    top->b = b;
    top->eval();
    tfp->dump(contextp->time());
    printf("a = %d, b = %d, f = %d\n", a, b, top->f);
    assert(top->f == (a ^ b));
  }
  tfp->close();
  return 0;
}
