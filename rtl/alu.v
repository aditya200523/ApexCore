
module alu(
input [31:0] in1,
input [31:0] in2,
input [19:0] instructions,
output reg [63:0] ALUoutput
);
initial begin
  ALUoutput <= 0;
end	
	
always@(*) begin

  case(instructions) 
      20'd1: ALUoutput <= in1 + in2;        //add                                 
      20'd2: ALUoutput <= in1 - in2;        //sub                      
      20'd4: ALUoutput <= in1 ^ in2;        //xor                      
      20'd8: ALUoutput <= in1 | in2;        //or                               
      20'd16: ALUoutput <= in1 & in2;       //and                          
      20'd32: ALUoutput <= in1 << in2[4:0]; //sll                            
      20'd64: ALUoutput <= in1 >> in2[4:0]; //srl                            
      20'd128: ALUoutput <= in1 >>> in2[4:0];  //sra                           
      20'd256: ALUoutput <= (in1 < in2);    //slt                              
      20'd512: ALUoutput <= (in1 < in2);    //sltu
      20'd1024: ALUoutput <= (in1 * in2);   //mul
      20'd2048: ALUoutput <= (in1 / in2);     //div
      20'd4096: ALUoutput <= (in1 % in2);   //rem 
      20'd8192: ALUoutput <= in2;  //AMOSWAP.W
      20'd16384: ALUoutput <= in1 + in2; //AMOADD.W
      20'd32768: ALUoutput <= in1 & in2;//AMOAND.W
      20'd65536: ALUoutput <= in1 | in2; //AMOOR.W
      20'd131072: ALUoutput <= in1 ^ in2; // AMOXOR.W
      20'd262144: ALUoutput <= (in1 > in2) ? in1 : in2; //AMOMAX.W
      20'd524288: ALUoutput <= (in1 < in2) ? in1 : in2; //AMOMIN.W
      default : ALUoutput <= 0;
endcase  
end	
endmodule 
