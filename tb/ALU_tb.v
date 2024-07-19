`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2023 01:18:37
// Design Name: 
// Module Name: ALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ALU_tb;
    reg clk;
    reg [31:0] rs1;
    reg [31:0] rs2;
    reg [9:0] instructions; //subjected to change
    wire [31:0] ALUoutput; 

    alu ALU1( .v1(rs1), .v2(rs2), .instructions(instructions), .ALUoutput(ALUoutput));
    
    initial rs1 = 5'd5;
    initial rs2 = 5'd4;
    initial instructions = 10'b1;
    always #10 clk = ~clk;
    initial begin
        #50 
        instructions <= 10'h1;
    end
    
endmodule