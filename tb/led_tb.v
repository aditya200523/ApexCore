module led_tb;
reg clk;
reg [7:0] led;
wire led1, led2, led3, led4, led5, led6, led7, led8;

led led1 (.led(led), .led(led), .led1(led1));
endmodule