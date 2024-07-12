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



module tb;
    reg clk;
    wire clk_out;
    One100Mhz_to_25Mhz u0 ( .clk(clk), .clk_out(clk_out));
    initial begin
        clk <= 0;
    end
    initial begin
    clk = 0;
    repeat(25) begin
        #1 clk = clk + 1'b1;
        $display("100Mhz to 25 Mhz clk = %b, Time = %0t, clk_out = %b", clk, $time, clk_out);
        $display("100Mhz to 434Khz");
    end
    $finish;
    end
endmodule

