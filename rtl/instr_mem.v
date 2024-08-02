
//! instr_mem.v - instruction memory for single-cycle RISC-V CPU

module instr_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 512) (
    input       [ADDR_WIDTH-1:0] instr_addr,
    output      [DATA_WIDTH-1:0] instr
);

//! array of 64 32-bit words or instructions
reg [DATA_WIDTH-1:0] instr_ram [0:MEM_SIZE-1];
parameter HEX_PATH = "/home/shrivishakh/ApexCore/ApexCore.sim/sim_1/behav/xsim";  // Set to local dir
initial $readmemh({HEX_PATH,"/program_dump.hex"}, instr_ram);

//! word-aligned memory access
//! combinational read logic
assign instr = instr_ram[instr_addr[31:2]];

endmodule
