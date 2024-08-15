
module csr 
(
    input wire clk,                             //clock
    input wire rst,                             //reset
    input wire [11:0] addr,                     
    input wire [31:0] wr_data,                  //write data to CSR
    input wire csr_we,                          // CSR write enable
    input wire csr_re,                          // CSR read enable
    input wire out_signal                       //To indicate operation type. Coming from decoder
    
    //EXCEPTIONS : EVENTS AFFECTING PROCESSOR FROM WITHIN
    input wire i_is_inst_illegal,              //illegal instruction
    input wire i_is_ecall,                      //ecall instruction
    input wire i_is_ebreak,                     //ebreak instruction
    input wire i_is_mret,                       //mret (return from trap) instruction   

    //Control and Status Registers : CSRRW, CSSRS, CSRRC, CSRRWI, CSRRSI, CSRRCI
    input wire[31:0] imm,                     //unsigned immediate for immediate type of CSR instruction (new value to be stored to CSR)
    input wire[31:0] rs1,                     //Source register 1 value (new value to be stored to CSR)
    output reg[31:0] rdata,                   //CSR value to be loaded     
);

 reg [31:0] csr_data [0:4095];                // 12-bit addressable CSR space (4 KB)
 case(out_signal)  //To indicate operation type. Coming from decoder
          case(out_signal)
			54'h200000000000000:  if (addr != 12'h0)  begin 
                            // Read old value and store in rdata
                            rdata <= csr_data[addr];
                            // Write new value to CSR
                            csr_data[addr] <= rs1;
                        end
           54'h4000000000000000:  if (addr != 12'h0) begin
                            // Read old value and store in rdata
                            rdata <= csr_data[addr];
                            // Set bits in CSR
                            csr_data[addr] <= csr_data[addr] | rs1;
                        end
           54'h8000000000000000:  if (addr != 12'h0) begin
                            // Read old value and store in rdata
                            rdata <= csr_data[addr];
                            // Clear bits in CSR
                            csr_data[addr] <= csr_data[addr] & ~rs1;
                        end
           54'h10000000000000000: if (addr != 12'h0) begin
                            // Read old value and store in rdata
                            rdata <= csr_data[addr];
                            // Write immediate value to CSR
                            csr_data[addr] <= imm;
                        end
           54'h20000000000000000:  if (addr != 12'h0) begin
                            // Read old value and store in rdata
                            rdata <= csr_data[addr];
                            // Set bits in CSR with immediate value
                            csr_data[addr] <= csr_data[addr] | imm;
                        end
           54'h40000000000000000: if (addr != 12'h0) begin
                            // Read old value and store in rdata
                            rdata <= csr_data[addr];
                            // Clear bits in CSR with immediate value
                            csr_data[addr] <= csr_data[addr] & ~imm;
                        end
			endcase 
     
 endcase 
endmodule 
   
  //  localparam XLEN = 32;

  //  reg [XLEN-1:0] control_status_register [XLEN-1:0];


  //  initial begin
        // Initialize control status registers
      //  control_status_register[0] = 0;  // CSR index 0
        //control_status_register[1] = 0;  // CSR index 1
        //control_status_register[2] = 0;  // CSR index 2
        //control_status_register[3] = 0;  // CSR index 3
        //control_status_register[4] = 0;  //mstatus

 //   end 

    


