# APEXCORE - A RISC-V BASED CPU CORE : EKLAVYA'24
---

#### The RISC-V CPU will be implemented with Multiplication and Atomic Extension. Implementation of Control and Status Registers along with memory segmentation in Data Memory for Input-Ouput capability.

---
### Introduction

RISC-V  is an instruction set architecture like ARM based on RISC (Reduced Instruction Set Architecture) principles. What sets RISC-V ISA different from others ISAs is its completely open source and free to use.

Due to being open-source in nature, RISC-V provides a vital step in designing, building and testing new hardware without paying any license fees or royalties

---
### How to flash the code on FPGA

To flash the code in your FPGA, you must have first have yosys suite installed. Installations can be done from [here](https://github.com/YosysHQ/yosys)

After installation, navigate to your cloned repository and into the code folder
```
$ cd RISC-V-Eklavya-24/code
```

and run following command 
```
$ make flash
```

This will create binary file for flashing on FPGA, make sure that your FPGA is connected to your device before running above command

---
## Workflow
This a 2-stage processor. In the first stage, 
- The instructions are fetched and decoded.
- Values are read from register file.
- Determination of instruction type. 
- Sending necessary parameters to ALU if needed.
- Writing in DMem and sending read signals. 
- Send jump to PC. 

And in 2nd stage,
- Get ALU output
- Read Data from DMem.
- Control Unit writes to register file 
- PC executes jump instruction 
- Show output on seven segment display.

Following is the block diagram and workflow in simple terms of our CPU:-
![image.png](https://hackmd.io/_uploads/rJScfOEXT.png)


![image.png](https://hackmd.io/_uploads/rk-YYoMXp.png)

---

### Tech Stack

- Verilog
- Xilinx Vivado 
---
### Future Work
- [ ] Interrupt handling.
- [ ] UART implmentation.
- [ ] Implementation of remaining extensions.
---
## Contributors

- [Saish Karole](https://github.com/NachtSpyder04)
- [Atharva Kashalkar](https://github.com/RapidRoger18)
- [Aditya Mahajan](https://github.com/aditya200523)
- [Shri Vishakh Devanand](https://github.com/LOuLOu-THEKing)
  


---
### Acknowledgements and Resources

- [SRA VJTI Eklavya 2024](https://sravjti.in/)
  
  
---
