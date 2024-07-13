
module tb;
    reg clk;
    wire clk_out_25Mhz;
    wire clk_out_434Khz;
    wire clk_out_625Khz;
    wire clk_out_596Khz;
    One100Mhz_to_25Mhz u0 ( .clk(clk), .clk_out(clk_out_25Mhz));
    Two100Mhz_to_434Khz u1 (.clk(clk), .clk_out(clk_out_434Khz));
    Three100Mhz_to_625Khz u2 (.clk(clk), .clk_out(clk_out_625Khz));
    Four100Mhz_to_596Khz u3 (.clk(clk), .clk_out(clk_out_596Khz));
    initial begin
        clk <= 0;
    end
    initial begin
        $dumpfile("hzchange.vcd");
        $dumpvars(0, tb);
    clk = 0;
    repeat(50000) begin
        #1 clk = clk + 1'b1;
        $display("100Mhz to 25 Mhz clk = %b, Time = %0t, clk_out = %b", clk, $time, clk_out_25Mhz);
        $display("100Mhz to 434Khz clk = %b, Time = %0t, clk_out = %b", clk, $time, clk_out_434Khz);
        $display("100Mhz to .625Mhz clk = %b, Time = %0t, clk_out = %b", clk, $time, clk_out_625Khz);
        $display("100Mhz to 596Khz clk = %b, Time = %0t, clk_out = %b", clk, $time, clk_out_596Khz);
    end
    $finish;
    end
endmodule

