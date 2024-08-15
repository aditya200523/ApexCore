
module csr #(parameter TRAP_ADDRESS = 0)
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

    //Trap Handler
    output reg trap_detected                  //high before going to trap (if exception/interrupt detected)
);

 reg [31:0] csr_data [0:4095];                // 12-bit addressable CSR space (4 KB)         //current value at address
 reg go_to_trap;                              //high before going to trap (if exception/interrupt detected)
 reg return_from_trap;                        //high before returning from trap (via mret)


 reg mstatus_mie;                             //Machine Interrupt Enable
 reg mstatus_mpie;                            //Machine Previous Interrupt Enable
 reg[1:0] mstatus_mpp;                        
 reg mie_meie;                                //machine external interrupt enable
 reg mie_mtie;                                //machine timer interrupt enable
 reg mie_msie;                                //machine software interrupt enable
 reg[29:0] mtvec_base;                        //base field
 reg[1:0] mtvec_mode;                         //mode field
 reg mcause_bit;                              //interrupt(1) or exception(0)
 reg[3:0] mcause_event;                       //indicates event that caused the trap
 
 
 localparam    MVENDORID = 12'hF11,  
               MARCHID = 12'hF12,
               MIMPID = 12'hF13,
               MHARTID = 12'hF14,
               
               //machine trap setup
               MSTATUS = 12'h300, 
               MISA = 12'h301,
               MIE = 12'h304,
               MTVEC = 12'h305,
               
               //machine trap handling
               MSCRATCH = 12'h340, 
               MEPC = 12'h341,
               MCAUSE = 12'h342,
               MTVAL = 12'h343,
               MIP = 12'h344,
                
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


 //control logic for writing to CSRs
    
initial begin 
    trap_detected <= 0;       
    mstatus_mie <= 0;
    mstatus_mpie <= 0;
    mstatus_mpp <= 2'b11;
    mie_meie <= 0;
    mie_mtie <= 0;
    mie_msie <= 0;
    mtvec_base <= TRAP_ADDRESS[31:2];
    mtvec_mode <= TRAP_ADDRESS[1:0];
    mcause_bit <= 0;
    mcause_event <= 0;
end 
        
    

case(csr_register)
            //machine info
               MVENDORID: csr_data = 32'h0;  
                 MARCHID: csr_data = 32'h0; 
                  MIMPID: csr_data = 32'h0; 
                 MHARTID: csr_data = 32'h0;              
            
            //machine trap setup  
                 MSTATUS: begin                             //MSTATUS (controls hart's current operating state)
                        csr_data[3] = mstatus_mie;
                        csr_data[7] = mstatus_mpie;
                        csr_data[12:11] = mstatus_mpp; 
                       end
                       
                    MISA: begin                             //MISA (control and monitor hart's current operating state)
                        csr_data[8] = 1'b1;
                        csr_data[31:30] = 2'b01; 
                       end
                       
                     MIE: begin                             //MIE (interrupt enable bits)
                        csr_data[3] = mie_msie;
                        csr_data[7] = mie_mtie;
                        csr_data[11] = mie_meie;
                       end

                  MCAUSE: begin                             //MCAUSE (indicates cause of trap(either interrupt or exception))
                        csr_data[31] = mcause_intbit; 
                        csr_data[3:0] = mcause_code;
                       end
endcase 

  //MSTATUS (controls hart's current operating state )
            if(csr_register == MSTATUS) begin                                          
                mstatus_mie <= rdata[3];
                mstatus_mpie <= rdata[7];
                mstatus_mpp <= rdata[12:11];
            end 
            else begin
                if(go_to_trap && !trap_detected) begin
                    /* Volume 2 pg. 21: xPIE holds the value of the interrupt-enable bit active prior to the trap. 
                    When a trap is taken from privilege mode y into privilege mode x,xPIE is set to the value of x IE;
                    x IE is set to 0; and xPP is set to y. */
                    mstatus_mie <= 0; //no nested interrupt allowed 
                    mstatus_mpie <= mstatus_mie; 
                    mstatus_mpp <= 2'b11;
                end
                else if(return_from_trap) begin
                    /* Volume 2 pg. 21: An MRET or SRET instruction is used to return from a trap in M-mode or S-mode respectively. 
                    When executing an xRET instruction, supposing xPP holds the value y, xIE is set to xPIE; the
                    privilege mode is changed to y; xPIE is set to 1; */
                    mstatus_mie <= mstatus_mpie; 
                    mstatus_mpie <= 1;
                    mstatus_mpp <= 2'b11;
                end
            end
  //MIE (interrupt enable bits)
            
            if(csr_register == MIE) begin   
                mie_msie <= rdata[3]; 
                mie_mtie <= rdata[7]; 
                mie_meie <= rdata[11]; 
            end  
  //MTVEC (trap vector configuration (base+mode))
            if(csr_register == MTVEC) begin
                mtvec_base <= rdata[31:2];
                mtvec_mode <= rdata[1:0]; 
            end
  //MCAUSE (indicates cause of trap(either interrupt or exception))
            
            if(i_csr_index == MCAUSE) begin
               mcause_bit <= rdata[31];
               mcause_event<= rdata[3:0];         
            end











endmodule 



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
