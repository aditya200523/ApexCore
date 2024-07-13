module tb;  
  parameter N = 4;  
  
  
  reg clk;  
  reg rstn;  
  wire [1:0] out;  
  
  modN_ctr u0  (    .clk(clk),  
                    .rstn(rstn),  
                    .out(out));  
  
  always #10 clk = ~clk;  
  
  initial begin  
    $dumpfile("dump.vcd");
    $dumpvars(1);
    {clk, rstn} <= 0;  
  
    $monitor ("T=%0t rstn=%0b out=0x%0h", $time, rstn, out);  
    repeat(2) @ (posedge clk);  
    rstn <= 1;  
  
    repeat(20) @ (posedge clk);  
    $finish;  
  end  
endmodule  
                    .out(out));  



					
(1) BASICS 
1. WIRE : Directional in verilog. Information flows only in one direction.  assign left_side=right_side; the value of signal on right side is driven onto the left_side. 

Create a module with one input and output behaving as a wire. 
```
module top_module( input in, output out)
	assign out=in
endmodule 
```

Create a module with 3 inputs and 4 outputs that behaves like wires that makes these connections:
a -> w
b -> x
b -> y
c -> z
```
module top_module( 
    input a,b,c,
    output w,x,y,z );
    assign w = a ;
    assign x = b ;
    assign y = b ;
    assign z = c ;

endmodule
```
If we know the width of each signal we can use concatenation operator :
```
assign (w,x,y,z) = (a,b,b,c) ;

```

2. NOT GATE : 
```
module top_module (input a , output b)
	assign b = ~a;
endmodule 
```

3. AND GATE :
```
module top_module (
		input a,
		input b,
		output out);
		assign out = a && b;
endmodule
```

4. NOR GATE :
```
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ~(a||b);

endmodule
```

5. XNOR GATE :
```
module top_module( 
    input a, 
    input b, 
    output out );
    assign out = ((a && b) + (~a && ~b));

endmodule
```

6. Implement :![[Pasted image 20240707120020.png]]
```
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire andab;
    wire andcd;
    assign andab = a && b;
    assign andcd = c && d;
    assign out = (andab || andcd);
    assign out_n = ~(andab || andcd);
endmodule

```

7. ![[Pasted image 20240707120825.png]]
```
module top_module (
		input p1a, p2a, p2b, p2c, p2d,
		output p2y,
		input p1c, p1b, p1f, p1e, p1d, p1y,
		output p1y);
	wire w1, w2, w3, w4;
	assign w1 = p2a && p2b;
	assign w2 = p2c && p2d;
	assign p2y = w1 || w2;
	assign w3 = p1c && p1b && p1a;
	assign w4 = p1f && p1e && p1d;
	assign p1y = w3 || w4;
endmodule

```


(2) PROCEDURES : ALWAYS BLOCKS (COMBINATIONAL)
Always block is an example for procedure. Teo types of always block :
Always block works for loop kind of scenarios where the assign does not work 
In assign it is a net type i.e. a wire whereas in always it is a variable-type i.e.  a reg.
1. combinational always @(*)

AND GATE USING always @(*) and assign  
```
module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);
    assign out_assign = a && b;
    always @(*) out_alwaysblock = a && b;

endmodule
```

2. clocked : always @(posedge clk)
![[Pasted image 20240707142910.png]]

In blocking first statement blocks the execution of the second statement till it is done. 
Line blocked only the one that is inside that particular procedural block 
In non-blocking all statements are executed con-currently. 

XOR GATE IN ASSIGN AND THE TWO TYPES OF ALWAYS 
```
module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );
    assign out_assign = (a && ~b) + (~a && b);
    always @(*) out_always_comb = (a && ~b) + (~a && b);
    always @(posedge clk) out_always_ff = (a && ~b) + (~a && b);

endmodule
```


(3) PROCEDURE : ALWAYS (CLOCKED)

1. ALWAYS IF : If statement is used for creating a 2x1 multiplexer, selecting one input if the condition is true and other if false. 
![[Pasted image 20240707145412.png]]
WAY 1 : 
![[Pasted image 20240707145437.png]]
WAY 2 : 
![[Pasted image 20240707145458.png]]

Implement a MUX :
![[Pasted image 20240707150347.png]]
```
module top_module(
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output wire out_assign,
    output reg out_always   ); 
    assign out_assign = (sel_b1 && sel_b2) ? b : a;
    always @(*) begin 
        if (sel_b1 && sel_b2) begin
            out_always = b;
        end 
        else begin 
            out_always = a;
        end 
    end 

endmodule
```

2. ALWAYS CASE : Useful when MUX has many input lines. Never forget putting default as it can lead to formation of a latch and convert combinational to sequential circuit 
6 x 1 MUX  (Necessary to put default as two lines are not useful bcoz of three select lines)
```
module top_module ( 
    input [2:0] sel, 
    input [3:0] data0,
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    output reg [3:0] out   );//

    always@(*) begin  // This is a combinational circuit
        case(sel)
              3'b000 : out = data0;
              3'b001 : out = data1;
              3'b010 : out = data2;
              3'b100 : out = data3;
              3'b101 : out = data4; 
              3'b110 : out = data5;
              default : out = 3'b000;
        endcase
    end 

endmodule
```

3. PRIORITY ENCODER: Used for deciding priority when two or more input lines ae selected. 
4-bit Priority encoder
```
// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*)
    	case (in)
         4'd0: pos = 2'd0;
         4'd1: pos = 2'd0;
         4'd2: pos = 2'd1;
         4'd3: pos = 2'd0;
         4'd4: pos = 2'd2; 
         4'd5: pos = 2'd0;
         4'd6: pos = 2'd1;
         4'd7: pos = 2'd0;
         4'd8: pos = 2'd3;
         4'd9: pos = 2'd0;
         4'd10: pos = 2'd1;
         4'd11: pos = 2'd0;
         4'd12: pos = 2'd2;
         4'd13: pos = 2'd0;
         4'd14: pos = 2'd1;
         4'd15: pos = 2'd0;
   	    endcase
     
endmodule
```

8-bit priority encoder using CASEZ
```
module top_module (
    input [7:0] in,
    output reg [2:0] pos );
    always @(*)
        casez(in)
            default : pos = 3'b000;
            8'bzzzzzzz1 : pos = 3'b000;
            8'bzzzzzz10 : pos = 3'b001;
            8'bzzzzz100 : pos = 3'b010;
            8'bzzzz1000 : pos = 3'b011;
            8'bzzz10000 : pos = 3'b100;
            8'bzz100000 : pos = 3'b101;
            8'bz1000000 : pos = 3'b110;
            8'b10000000 : pos = 3'b111;
        endcase 
           
            

endmodule
```

ARROW BASED ON HEXA KEY PRESSED : AVOIDING LATCHES
```
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    always @ (*) begin 
        left = 1'b0;  down = 1'b0 ; right = 1'b0 ; up = 1'b0;
        case(scancode)
           16'he06b : left = 1'b1;
           16'he072 : down = 1'b1;
           16'he074 : right = 1'b1;
           16'he075 : up= 1'b1;
        endcase
    end 
endmodule
```


(3) D FLIP FLOP (DFF)
1. Code for DFF
```
module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );
    always @(posedge clk) begin 
        q <= d;
    end 
endmodule
```

2. 8 DFF in high synchronous reset, triggered by positive edge of clock 
```
module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q);
    always @(posedge clk) begin 
        if(reset==1'b1) begin
            q = 3'b000;
        end
        else begin
            q <= d;
        end 
    end 
endmodule
```

3. 8 DFF in high synchronous reset. Reset to 0x34 and triggered by negative edge of clk
```
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin 
        if(reset == 1'b1    ) begin 
            q <= 8'h34;
        end 
        else begin 
            q<=d;
        end 
    end 

endmodule

```

4. 8 DFF in high asynchronous reset.
```
module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin 
        if (areset == 1'b0) begin 
            q = d;
        end 
        else begin 
            q = 3'b000;
        end 
    end 

endmodule

```



(4) FINITE STATE MACHINE 
It consist of combinational, sequential and output circuit. Combinational is used to decide the next state, sequential is used to store current state and output gives mixture of both. 
![[Pasted image 20240709100517.png]]
There ae two types pf machine :
Mealy state machine : Output depends upon current state and current input
Moore state machine : Output depends only on current state only. 

Example :
With req_0 asserted : gnt_0 is ON while with req_1 , gnt_1 is ON and when both are asserted, priority given to gnt_0
![[Pasted image 20240709100844.png]]
Conversion to FSM:
![[Pasted image 20240709101027.png]]

1. ![[Pasted image 20240709104154.png]]
```
module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case(state)
            A : next_state = (in==1) ? A : B;
            B : next_state = (in==1) ? B : A;
        endcase 
            
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset) 
            state <=B;
        else 
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state == B);

endmodule
```

2. ![[Pasted image 20240709193711.png]]
```
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
    parameter A =0 , B = 1;
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            // Fill in reset logic
            present_state <= B; 
        end 
        else begin
            present_state <= next_state;
        end
    end 
    always@(*) begin 
       
            case (present_state)
               B : next_state <= (in == 1) ? B : A;
               A : next_state <= (in == 1) ? A : B;
            endcase 
    end 
    assign out = (present_state == B);
endmodule

```

3.  
![[Pasted image 20240709194241.png]]

```
module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        case(state)
            OFF : next_state = (j==1) ? ON : OFF;
            ON : next_state = (k==1) ? OFF : ON;
        endcase       
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= OFF;
        else 
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state == ON );

endmodule

```

4. 
![[Pasted image 20240709200842.png]]

```
module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
         case(state)
            OFF : next_state = (j == 1) ? ON : OFF;
            ON : next_state = (k == 1) ? OFF : ON;
        endcase
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if(reset)
            state <= OFF;
        else 
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state == ON);

endmodule


```

5.  ![[Pasted image 20240710115927.png]]
```
module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    
    always @(*) begin 
        case(state)
        A : next_state = (in ==1 ) ? B : A;
        B : next_state = (in == 1) ? B : C;
        C : next_state = (in == 1) ? D : A;
        D : next_state = (in == 1) ? B : C;
        endcase 
    end
    assign out = (state == D);
        

    // Output logic:  out = f(state) for a Moore state machine
endmodule

```

module tb;  
  parameter N = 4;  
  
  
  reg clk;  
  reg rstn;  
  wire [1:0] out;  
  
  modN_ctr u0  (    .clk(clk),  
                    .rstn(rstn),  
                    .out(out));  
  
  always #10 clk = ~clk;  
  
  initial begin  
    $dumpfile("dump.vcd");
    $dumpvars(1);
    {clk, rstn} <= 0;  
  
    $monitor ("T=%0t rstn=%0b out=0x%0h", $time, rstn, out);  
    repeat(2) @ (posedge clk);  
    rstn <= 1;  
  
    repeat(20) @ (posedge clk);  
    $finish;  
  end  
endmodule  




