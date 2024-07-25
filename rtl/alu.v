
module alu(
input [31:0] v1,
input [31:0] v2,
input [12:0] instructions,
output reg [63:0] ALUoutput
);
	initial begin
		ALUoutput <= 0;
	end	
	
	always@(*) begin
	
    case(instructions) 
		13'd1: ALUoutput <= v1 + v2;     	//add                                 
        13'd2: ALUoutput <= v1 - v2;        //sub                      
        13'd4: ALUoutput <= v1 ^ v2;        //xor                      
        13'd8: ALUoutput <= v1 | v2;        //or                               
        13'd16: ALUoutput <= v1 & v2;       //and                          
        13'd32: ALUoutput <= v1 << v2[4:0]; //sll                            
        13'd64: ALUoutput <= v1 >> v2[4:0]; //srl                            
        13'd128: ALUoutput <= v1 >>> v2[4:0];  //sra                           
        13'd256: ALUoutput <= (v1 < v2);    //slt                              
        13'd512: ALUoutput <= (v1 < v2);    //sltu
        13'd1024: ALUoutput <= (v1 * v2);   //mul
        13'd2048: ALUoutput <= (v1 / v2);     //div
        13'd4096: ALUoutput <= (v1 % v2);   //rem                          
        default : ALUoutput <= 0;
	endcase  
end	
endmodule 
