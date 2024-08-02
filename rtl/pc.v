module PC(
   input clk,
   input reset,
   input j_signal,
   input [31:0] jump,
   output[31:0] out_sign
);
   reg [31:0] next_pc = 32'd0;
   
   always @ (posedge clk) begin
		if(reset)
			next_pc <= 32'b0;
		else if(j_signal) begin
			next_pc <= jump;
		end
		else begin
			next_pc <= next_pc + 32'd4;
		end
   end
	
	assign out_sign = next_pc;
endmodule 