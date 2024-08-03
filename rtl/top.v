module top (
    input clk, reset,
    //input Ext_MemWrite,
    //input [31:0] Ext_WriteData, Ext_DataAdr,
    //output MemWrite,
    //output [31:0] WriteData, DataAdr, ReadData,
    //output [31:0] ProgramCounter
    output led1, led2, led3, led4, led5, led6, led7, led8
);

//! wire lines from other modules
wire [7:0] led;
wire [31:0] PC;
assign ProgramCounter = PC;
wire [31:0] Instr;
wire MemWrite_rv32;
wire [31:0] DataAdr_rv32, WriteData_rv32;
wire [31:0] ReadData;

//! instantiate processor and memories
riscv_cpu rvsingle (clk, reset, PC, Instr, MemWrite_rv32, DataAdr_rv32, WriteData_rv32, ReadData);
instr_mem imem (PC, Instr);
data_mem dmem (clk, MemWrite_rv32, DataAdr_rv32, WriteData_rv32, ReadData);

//! output assignments
//assign MemWrite = (Ext_MemWrite && reset) ? 1 : MemWrite_rv32;
//assign WriteData = (Ext_MemWrite && reset) ? Ext_WriteData : WriteData_rv32;
//assign DataAdr = (reset) ? Ext_DataAdr : DataAdr_rv32;
assign led [7:0] = WriteData_rv32 [7:0];
led led_0 (clk, led, led1, led2, led3, led4, led5 ,led6, led7, led8);

endmodule
