## Comments
```
	// One-liner
	/* Multiple Lines
```

## Numeric Constants
```
	// All these represent a 4-bit decimal 4;
	4;b0100; //binary
	4'o4; //octal
	4'h4; //hex
	4'd4; //decimal
```

## Nets and Variables
```
	wire w;
	wire [MSB - 1: LSB] w; //Assign used outside always blocks
	reg [MSB - 1 : LSB] r; //Assign used inside always blocks
	reg [MSB - 1: LSB]mem[31: 0];

	integer j; //used when compiling and simulation
	genvar k; //generating a variable
```

## Parameter
```
	parameter N = 8;
	localparam State = 2'd3;
```

## Assignments
```
	assign Output = A * B;
	assign {C ,D} = {Instr[4], {24{Instr[7]}}, E};
```

## Operators
```
	//These are the order of precendence
	1. select
		A[N] or A [N:M]
	2. Reduction of Gates
	 	&A or ~&A or |A or ~|A or ^A or ~^A
	3. Compliment
		!A or ~A
	4. Unary
		+A or -A
	5. Concatenate
		{A, ... , B}
	6. Replicate
		{N{A}} // The two brackets are necessary 
	7. Arithmetic
		A*B or A/B or A%B or A+B or A-B
	8. Shift
		A<<B //shift B bits to right
		A>>B //shift B bits to left
	9. Relational
		A>B A<B A>=B A<=B A==B A!=B
	10. Bit-Wise
		A&B //bit-wise AND
		A^B A~^B //bit-wise XOR and XNOR
		A|B //bit-wise OR
	11. Logical
		A&&B //AND
		A||B //OR
	12. Conditional
		A ? B : C
```

## Module
``` 
	module ModuleName
		#(parameter N = 8) //Optional
		 (input a, b, c,
		 output [N-1:0] Output);

		 //Module Implementation
	endmodule
```

## Module Instantiation
```
	//Override default parameter : setting N = 12
	ModuleName #(12) Instantiation1 (a,b,c, Output);
```

## Case
```
	always @ (*) begin
	   case(Mux)
	      2'd0 : A = 8'd4;
	      2'd1,
	      2'd2 : A = 8'd3;
	      2'd3 : A = 8'd1;
	      default:;
	   endcase
	end
```

```
	always @ (*) begin
		casex(Decoding)
		   4'b1xxx : Encoded = 2'd0;
		   4'b01xx : Encoded = 2'd1;
		   4'b011x : Encoded = 2'd2;
		   4'b0001 : Encoded = 2'd3;
		   default : Encoded = 2'd4;
		endcase
	end
```

## Sequential Circuit logic
```
	always @ (posedge clk) begin
		if reset <= 0;
		else A <= A + 1'd1;
	end
```

## Loop
``` 
	always @(*) begin
		Count = 0;
		for(j = 0; j < 8; j = j + 1)
			Count = Count + Input[j];
	end
```

## Function
```
	function [6:0]F;
		input [3:0]A;
		input [2:0]B;
		begin
		 F = {A+1'b1, B+2'd2};
		end
	endfunction
```

## Generate
```
	genvar j;
	
	generate
		for (j = 0; j < 8; j = j + 1) begin
			ModuleName #(j) Inst1 (a, b, c, Output);
		end
	endgenerate
```

