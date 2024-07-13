`timescale 1ns / 1ps

module One100Mhz_to_25Mhz (input clk, output reg clk_out);
    reg [1:0] counter; // 2-bit counter to count 4 clock cycles

    initial begin
        counter = 2'b00;
        clk_out = 0;
    end

    always @ (posedge clk) begin
        counter <= counter + 2'b01;
        if (counter == 2'b11) begin
            clk_out <= ~clk_out; // Toggle the output clock
        end
    end
endmodule

module Two100Mhz_to_434Khz (input clk, output reg clk_out);
    parameter DIV_FACTOR = 230;
    reg [7:0] counter = 0;

    initial begin
        counter = 0;
        clk_out = 0;
    end

    always @ (posedge clk) begin 
        if (counter == DIV_FACTOR / 2 - 1) begin
            clk_out <= ~clk_out;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule

module Three100Mhz_to_625Khz (input clk, output reg clk_out);
    parameter DIV_FACTOR = 160;
    reg [7:0] counter = 0;

    initial begin
        counter = 0;
        clk_out = 0;
    end

    always @ (posedge clk) begin
        if (counter == DIV_FACTOR / 2 ) begin 
            clk_out <= ~clk_out;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule

module Four100Mhz_to_596Khz (input clk, output reg clk_out);
    parameter DIV_FACTOR = 168;
    reg [7:0] counter = 0;

    initial begin
        counter = 0;
        clk_out = 0;
    end
    always @ (posedge clk) begin
        if (counter == DIV_FACTOR/2 - 1) begin
            clk_out <= ~clk_out;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
