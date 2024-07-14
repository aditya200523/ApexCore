




1. Conversion of 100MHz to 25Mhz

VERILOG CODE 
```
//QUESTION 1
module freqdiv (newclk, clk);
  input clk;
  output reg newclk;
 

  reg [1:0] count = 2'b0;


  always @(posedge clk) begin
   count <= count + 1;
   newclk = count[1];
  end 
endmodule 
```

TESTBENCH 
```
module tb_freqdiv(
  
  
  
);
  
  reg clk;
  wire newclk;
  
  freqdiv uut (
    .clk(clk),
    .newclk(newclk));
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    
    #100 $finish;
  end 
  
  always #5 clk = ~clk;
endmodule
```

WAVEFORM
![[Pasted image 20240714112940.png]]

2.  Conversion of 100MHz to 434Khz
VERILOG CODE
```
//QUESTION 2
module freqdiv (newclk, clk);
  input clk;
  output reg newclk;
 

  reg [6:0] count = 7'b0;
  initial begin 
    newclk = 0;
  end 


  always @(posedge clk) begin
    if (count == 7'b1110010)
        begin 
          count <= 7'b0;
          newclk <= ~newclk;
        end else begin 
          count <= count + 1;
        end 
    end  
endmodule 
  
 
```

TESTBENCH
```
 module tb_freqdiv(
  
  
  
);
  
  reg clk;
  wire newclk;
  
  freqdiv uut (
    .clk(clk),
    .newclk(newclk));
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    
    #10000 $finish;
  end 
  
  always #5 clk = ~clk;
endmodule
```



WAVEFORM 
![[Pasted image 20240714110426.png]]

3. Conversion of 100MHz to 0.625 MHz
VERILOG CODE 

```
//QUESTION 3
module freqdiv (newclk, clk);
  input clk;
  output reg newclk;
 

  reg [6:0] count = 7'b0;
  initial begin 
    newclk = 0;
  end 


  always @(posedge clk) begin
    if (count == 7'b1001111)
        begin 
          count <= 7'b0;
          newclk <= ~newclk;
        end else begin 
          count <= count + 1;
        end 
    end  
endmodule 
  
```
 TESTBENCH
```
module tb_freqdiv(
  
  
  
);
  
  reg clk;
  wire newclk;
  
  freqdiv uut (
    .clk(clk),
    .newclk(newclk));
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    
    #10000 $finish;
  end 
  
  always #5 clk = ~clk;
endmodule
```

WAVEFORM

![[Pasted image 20240714114344.png]]

4. Conversion of 100MHz to 596 KHz
VERILOG CODE
```
//QUESTION 4
module freqdiv (newclk, clk);
  input clk;
  output reg newclk;
 

  reg [6:0] count = 7'b0;
  initial begin 
    newclk = 0;
  end 


  always @(posedge clk) begin
    if (count == 7'b1010011)
        begin 
          count <= 7'b0;
          newclk <= ~newclk;
        end else begin 
          count <= count + 1;
        end 
    end  
endmodule 
 
```

TESTBENCH
```
module tb_freqdiv(
  
  
  
);
  
  reg clk;
  wire newclk;
  
  freqdiv uut (
    .clk(clk),
    .newclk(newclk));
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    clk = 0;
    
    #10000 $finish;
  end 
  
  always #5 clk = ~clk;
endmodule
```

WAVEFORM 
![[Pasted image 20240714114755.png]]
