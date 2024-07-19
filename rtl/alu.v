
module alu(
input [31:0] v1,
input [31:0] v2,
input [9:0] instructions,
output reg [31:0] ALUoutput
);
	initial begin
		ALUoutput = 0;
	end	
	
	always@(*) begin
	
    case(instructions) 
		   10'd1: ALUoutput <= v1 + v2;     	//add                                 
         10'd2: ALUoutput <= v1 - v2;        //sub                      
         10'd4: ALUoutput <= v1 ^ v2;        //xor                      
         10'd8: ALUoutput <= v1 | v2;        //or                               
         10'd16: ALUoutput <= v1 & v2;       //and                          
         10'd32: ALUoutput <= v1 << v2[4:0]; //sll                            
         10'd64: ALUoutput <= v1 >> v2[4:0]; //srl                            
         10'd128: ALUoutput <= v1 >>> v2[4:0];  //sra                           
         10'd256: ALUoutput <= (v1 < v2);    //slt                              
         10'd512: ALUoutput <= (v1 < v2);    //sltu                               
         default : ALUoutput <= 0;
        
		
	endcase  
end	
endmodule 
