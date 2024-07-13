


Conversion on 100MHz to 25MHz
VERILOG CODE
```
module task1  
  # (parameter N = 4)  
  (
    input   clk,  
    input   rstn,  
    output  reg [1:0] out,
    output  reg q
    
   );  
  
  wire msb = out[1];
 
  
  always @ (posedge clk) begin  
    if (!rstn) begin  
      out <= 0;  
    end else begin  
      if (out == N-1)  
        out <= 0;  
      else  
        out <= out + 1;  
    end  
  end  
  
  always @ (negedge clk) begin
    q <= msb;
  end 
  
 
endmodule
```



TESTBENCH
```
module tb_task1;
  
    parameter N = 4;
    reg clk;
    reg rstn;
    wire [1:0] out;
    wire q;
    
    task1 #(N) uut (
        .clk(clk),
        .rstn(rstn),
        .out(out),
        .q(q) );

    // Clock generation
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
        clk = 0;
        forever #5 clk = ~clk;  
    end

    // Test sequence
    initial begin
       
        rstn = 0;
        #10 rstn = 1;

        // Monitor the outputs
        $monitor("Time = %0t, out = %0d, q = %b", $time, out, q);

        #100 $finish;
    end

endmodule


```

WAVEFORM 
![[Pasted image 20240713080454.png]]
