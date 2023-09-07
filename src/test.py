import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_single_key(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 1, units="us")
    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("reset")
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    dut.ena.value = 1
    dut.ui_in.value = 1
    dut.uio_in.value = 7 << 4

    await ClockCycles(dut.clk, 1000)

    for note in range(12):
      dut.ui_in.value = 1 << note
      await ClockCycles(dut.clk, 1000)
      
