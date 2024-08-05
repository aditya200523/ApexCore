/**
 * @file alu.v
 *
 * This module implements the simple arithmetics with the values given from control unit.
 * 
 * @input in1           Inputs the first sourced value (unsigned only).
 * @input in2           Inputs the second sourced value (unsigned only).
 * @input instructions  Inputs the selection line for which process to work.
 *
 * @return ALUoutput    Outputs the value calculated.
*/


module alu(
input [31:0] in1,
input [31:0] in2,
input [12:0] instructions,
output reg [63:0] ALUoutput
);
initial begin
  ALUoutput <= 0;
end	
	
always@(*) begin

  case(instructions) 
  13'd1: ALUoutput <= in1 + in2;     	//!add                                 
      13'd2: ALUoutput <= in1 - in2;        //!sub                      
      13'd4: ALUoutput <= in1 ^ in2;        //!xor                      
      13'd8: ALUoutput <= in1 | in2;        //!or                               
      13'd16: ALUoutput <= in1 & in2;       //!and                          
      13'd32: ALUoutput <= in1 << in2[4:0]; //!sll                            
      13'd64: ALUoutput <= in1 >> in2[4:0]; //!srl                            
      13'd128: ALUoutput <= in1 >>> in2[4:0];  //!sra                           
      13'd256: ALUoutput <= (in1 < in2);    //!slt                              
      13'd512: ALUoutput <= (in1 < in2);    //!sltu
      13'd1024: ALUoutput <= (in1 * in2);   //!mul
      13'd2048: ALUoutput <= (in1 / in2);     //!div
      13'd4096: ALUoutput <= (in1 % in2);   //!rem                          
      default : ALUoutput <= 0;
endcase  
end	
endmodule 
