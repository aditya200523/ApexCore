#VERILOG
(1) Introduction 

A Hardware description language used to describe digital systems and circuits. Developed by Gateway Design Automation. 
It supports :
1. ASIC and FPGAs
2. Design and verification of digital and mixed-signal systems.
3. Range of abstractions : Behavioral and Structural.
4. Simulation and Synthesis-based design.
5. Range of modeling techniques : Gate-level, RTL-level and behavioral-level.

Hardware Synthesis
A diagram that shows how the combinational gates ae connected to get the output. If we know the configuration of input to achieve an output of 1, the entire circuit can be considered as a black box and we will be concerned about input and output terminals.

Hardware Description Language 
Used to describe how the black box is going to work and let the tools convert the behavior into actual hardware schematic.

Verification 
Different methods used to see whether the hardware described follows the intended task by using a set of input stimuli. This is done in EDA (Electronic Design Automation) and the Verilog RTL design placed in Testbench.

Template of Verilog 
1. Module definition and port declaration
2. Input and output ports
3. Declaration of signals using datatypes 
4. Other module instantiations if required
5. Behavioral code 
6. Endmodule 

DFF code in Verilog :
![[Pasted image 20240705084753.png]]

Testbench for above code:
![[Pasted image 20240705085432.png]]

Chip Design Flow:

VLSI (Very Large System Integration) is a technology used to create Integrated Circuits (ICs) using transistors. 
ASIC is a type of IC that is made for a custom requirement. 

![[Pasted image 20240705085812.png]]

1. Requirements : This comes from the buyer about what the chip is being made for and information about the market value.
2. Specifications : Describes the functionality, interfaces and the architecture 
3. Architecture : System-level view of the chip
4. Digital design : Not possible to code the system from the level of gates. Modules ae used for this purpose that are concerned about input, output, power, functionality and performance using Verilog.
5. Verification : Happens after RTL design is ready.
6. Logic Synthesis : Generation of a netlist indicating gates and connections between them. Conversion of RTL to HDL Schematic and then to a Netlist.
7. Logic Equivalence : Gate-level verification to establish equivalence with RTL
8. Placement and Routing : Establish physical design flow using Cadence and Synopsis tools. Layout generated sent for fabrication.
9. Validation : Verification of the final chip by a foundry.

Layers of Abstraction

System Architecture 
Defines the sub-blocks, groups based on functionality. In case of processor, cache blocks, cores are encapsulated into single block with input and output signals.
Sub-block description using Verilog to define functionality.
HDLs then converted into a gate-level design.
Last step is the layout of transistors using EDA tools.

Top-Down and  Bottom-Up Approach both are used  design all the layers. Top-Down till architecture declaration and Bottom-Up from physical layout to gate-level design. 

(2) Verilog Syntax
1. COMMMENTS  :  ![[Pasted image 20240705113646.png]]

2. WHITESPACE  : Ignored by Verilog but used for separation of tokens. Spaces are not ignored in strings ![[Pasted image 20240705113904.png]]
3. OPERATORS : Three types : unary, binary and conditional (ternary) ![[Pasted image 20240705114059.png]]
4. NUMBERS : Represented as decimal, binary and hexadecimal
     1. SIZED :
     ![[Pasted image 20240705171151.png]]
	     size : written in decimal to specify the number of bits
	     base_format : can be either  decimal or hexa and octal 
	     number : any consecutive digit in decimal or hexa
	2. UNSIZED 
	3. NEGATIVE 
5. STRINGS :Cannot be multi line, enclosed in " "

6. IDENTIFIERS : Made up of alphanumeric characters, underscore and dollar. Cannot start with dollar or a digit. 

7.  KEYWORDS : Pre-defined identifiers ![[Pasted image 20240705172053.png]]

(3) VERILOG DATATYPES 

Intent of datatypes is to represent data-storage elements like bits in flip-flop and transmission wires that connect logic gates and sequential structures. 
4 values any datatype can hold except for (real) and (event) : ![[Pasted image 20240705172548.png]]
Standard rule in waveform :
![[Pasted image 20240705172705.png]]

Value of 1 represents a voltage between 0.8V to 3V based on fabrication technology 
Value of 0 represents ground where the voltage is 0
Value X represents that there is uncertainty between 0 and 1. Different from no-care condition 
Value Z represents that wire is not connected to anything leading to a higher impedance 

Two parts :
1. NETS : Used to connect hardware entities like gates and cannot store any value on its own. Wire is a NET-type datatype that connects elements and two different nets that are driven by continuous assignment. Multiple nets combined together to form wire and this is called Vector. ![[Pasted image 20240705174137.png]]
2. VARIABLES : Used to store the data. (reg) is used to hold values between assignments. 

DATATYPES : 
1. integer : 32-bit wide to store the integer value
2. time : unsigned, 64 bits wide, used to store simulation time quantities for debugging purposes 
3. realtime : store time as a floating-point quantity 
4. real : store floating point value 
Strings are stored in (reg) and the size should be large enough to hold it :![[Pasted image 20240705175149.png]]

(4) SCALAR AND VECTOR
A net or reg without range specification is called scalar and the one with such specification is called vector. Range gives the ability to address individual bits. MSB specified on left and LSB on right 

Bit Select : Any bit in a vector can be individually selected and assigned a new value 
Part Select : A range of bits can be selected : constant part select and indexed part select 

(5) ARRAYS 
Declaration of an array can be scalar or vector. Allowed for (reg), (wire), (integer), (real).
Assignment :![[Pasted image 20240705182130.png]]

Memory : These are storage elements using one-dimensional array i.e. reg. E ach element represents a word. 
syntax :  reg[7:0] mem[256]  : width is 8bits and 0-255 indexed.

(6) VERILOG MODULE 
A block in Verilog that implements certain functionality. ![[Pasted image 20240705184440.png]]
Top-level modules are those that contain all other sub-modules that can have nested modules in them. 
Test-bench is a top-level module as a design is instantiated in it. 
Hierarchical names : Top-level module is called the root. A hierarchical name is created by a list of these identifiers separated by dots for each level. 

(7)VERILOG PORTS
Ports ae set of signals that act as input and output to the module.![[Pasted image 20240705190219.png]]
Syntax:![[Pasted image 20240705190322.png]]
Signed ports attached to port declaration o net/reg declaration. By default, unsigned. 
If either net/reg has signed attribute, then other also considered signed. 

(8) MODULE INSTATIATION 
Port Connections by list![[Pasted image 20240705194146.png]]

Port connection by name 
![[Pasted image 20240705194439.png]]

Ports not connected to any wire will have a high impedance 
Output ports that need to store data ae declared as (reg) and used in procedural blocks like always and initial 
Input and inout ports cannot be declared as reg because they ae driven from outside and do not store data.
It is possible to connect two ports of different size. The one with lower size prevails and remaining bits from higher one are ignored.

(9) VERILOG ASSIGN 
Assign used in case of wire datatype where continuous assignment is required.![[Pasted image 20240705201131.png]]
drive_strength and delay ae optional. Delays are given to gates for time optimization.
RULES :
- LHS should always be a scalar or vector net or a concatenation of scalar or vector nets and never a scalar or vector register.
- RHS can contain scalar or vector registers and function calls.
- Whenever any operand on the RHS changes in value, LHS will be updated with the new value.
- Assign statements are also called continuous assignments and are always active.
Assign statements can be used in combinational circuits 

(10) VERILOG OPERATORS 
1. Arithmetic Operators ![[Pasted image 20240705210149.png]]
2. Relational Operators ![[Pasted image 20240705210234.png]]
3. Equality Operators ![[Pasted image 20240705210414.png]]
4. Logical Operators ![[Pasted image 20240705211516.png]]
5. Bitwise Operators ![[Pasted image 20240705211810.png]]
6. Shift Operators ![[Pasted image 20240705211857.png]]

(11) CONCATENATION 
Multi-bit wires and variables can be clubbed together to form a bigger multi-net wire using concatenation operator separated by comma.

Replication Operator: When same expression has to be repeated several times, replication constant is used which is non-negative and cannot be X,Z or any variable. The number is enclosed within braces.
This expression cannot be appear left to the assignment and cannot be connected to the inout and output. 

Nested Replication : used inside concatenation ![[Pasted image 20240705213621.png]]

Sign Extension : Extending a signed number with few bits to a wider signed number. ![[Pasted image 20240705213752.png]]


(12) ALWAYS BLOCK 
A procedural block and the contents in it are executed sequentially. Always block is executed at a particular event defined by Sensitivity List. 
Sensitivity List : Defines when the always block should be executed and is specified after the @ sign within parentheses (). 
Used in area of reset and clock in flip-flop and at input in case of combinational circuit. Sensitivity list has positive edge of clock signal to trigger it. ![[Pasted image 20240705214902.png]]

Simulation time is advanced by introducing delay statement within the always block to avoid the 
sensitivity list! 
![[Pasted image 20240705215229.png]]
Explicit delays are not synthesizable in gates
Necessary to follow following templates to be synthesizable ![[Pasted image 20240705224446.png]]


(13) VERILOG INITIAL BLOCK 
Another type of procedural block 
These are not synthesizable to hardware schematic so are not used frequently. Only used to initialize variables and drive design ports with specific value. The block gets executed only ones. 

(14) VERILOG GENERATE BLOCK 
Used when a module instance needs to be repeated multiple times or when the code is conditionally executed on given parameters. 
Contains : Port. parameter, specify blocks. It is coded within a module between keywords generate and endgenerate. 
They can have modules, continuous assignments, always or initial blocks and user-defined primitives. 
Two types of construct : 1. for loop    2. if else   3. case 





(15) VERILOG BLOCK STATEMENTS 








