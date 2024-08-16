/**
 * @module PC
 * @brief Program Counter module.
 * 
 * This module implements the program counter (PC) for a CPU, updating the PC value
 * based on clock cycles, reset signal, and jump signal.
 * 
 * @input clk      Clock input signal.
 * @input reset    Reset signal to initialize the program counter.
 * @input j_signal Jump signal indicating a branch or jump instruction.
 * @input jump     32-bit jump address to be loaded into the program counter on a jump.
 * 
 * @return out_sign Current value of the program counter.
 */


//The address of the interrupt is stored in the mtvec 
//mret is the signal confirming return from interrupt 
//mepc is the one where the address after interrupt is stored




module PC(
    input clk,
    input reset,
    input j_signal,
    input [31:0] jump,
    input trap_detected,       	   // Signal indicating an interrupt 
    input [31:0] mtvec,            // Interrupt vector base address
    input mret,                    // Signal for returning from interrupt
    input [31:0] mepc,             // Address to return to after interrupt
    
    output reg [31:0] out_sign     // Program Counter output
);
    reg [31:0] next_pc = 32'd0;

    always @ (posedge clk) begin
        if (reset) begin
            next_pc <= 32'b0;
        end else if (trap_detected) begin
            next_pc <= mtvec;        // Redirect PC to interrupt handler
        end else if (mret) begin
            next_pc <= mepc;         // Return from interrupt
        end else if (j_signal) begin
            next_pc <= jump;         // Handle jump instructions
        end else begin
            next_pc <= next_pc + 32'h4; // Increment PC for normal execution
        end
    end

    always @ (posedge clk) begin
        if (!reset) begin
            out_sign <= next_pc;    // Output the current PC value
        end
    end
endmodule
