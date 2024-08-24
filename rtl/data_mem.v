/**
 * @file data_mem.v
 * 
 * This module is a memory module with read and write capabilities.
 *
 * @param DATA_WIDTH The width of the data bus (default is 32).
 * @param ADDR_WIDTH The width of the address bus (default is 32).
 * @param MEM_SIZE   The number of memory locations (default is 64).
 *
 * @input clk        Inputs clock signal.
 * @input wr_en      Write enable signal.
 * @input wr_addr    Writes Address.
 * @input wr_data    Writes Data.
 * 
 * @return rd_data_mem Output read data.
*/


// data_mem.v - data memory for single-cycle RISC-V CPU

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64, GPIO = 100) (
    input       clk, wr_en,
    input       [ADDR_WIDTH-1:0] wr_addr, wr_data,
    output      [DATA_WIDTH-1:0] rd_data_mem,
    inout       [GPIO-1:0] gpio_pins
    
);

reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];
reg [DATA_WIDTH-1:0] instr_ram [0:511];
reg [GPIO -1 : 0] gpio_reg;

initial begin
    $readmemh("program_dump.hex", instr_ram);
end
// combinational read logic
// word-aligned memory access
//if address is greater than 0x02000000, then it is a data memory access
//if it is less than 0x, then it is an instruction memory access

assign gpio_pins = gpio_reg;

//assign rd_data_mem = (wr_en == 0) ? (wr_addr >= 32'h02000000) ? data_ram[wr_addr[DATA_WIDTH-1:2] % 64] : instr_ram[wr_addr[DATA_WIDTH-1:2]] : 0;


always @(*) begin 
    if(wr_en == 0) begin 
         if (wr_addr >= 32'h020000F0 && wr_addr < 32'h02000100) begin           //Accessing this GPIO
            
            rd_data_mem = gpio_reg[wr_addr[ADDR_WIDTH-1:2] % GPIO];

         end else if (wr_addr >= 32'h02000000 && wr_addr < 32'h02000000 + MEM_SIZE * 4) begin           //Accessing the Data memory
              
            rd_data_mem = data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE];

         end else if (wr_addr <= 32'h02000000) begin                            // Accessing the Instruction memory

            rd_data_mem = instr_ram[wr_addr[DATA_WIDTH-1:2]];
         
         end 
            

    end     
end 
// synchronous write logic
always @(posedge clk) begin
    //if (wr_en) data_ram[wr_addr[DATA_WIDTH-1:2] % 64] <= wr_data;
    if(wr_en == 1) begin

        if (wr_addr >= 32'h020000F0 && wr_addr < 32'h02000100) begin        //Write for GPIO

            gpio_reg[wr_addr[ADDR_WIDTH-1:2] % GPIO] <= wr_data;

        end else if (wr_addr >= 32'h02000000 && wr_addr < 32'h02000000 + MEM_SIZE * 4) begin    //Write for Data memory
        
            data_ram[wr_addr[DATA_WIDTH-1:2] % MEM_SIZE] <= wr_data;
        end 
    end 
end 

endmodule
