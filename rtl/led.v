module led (
    input clk,
    input [7:0] led,
    output reg led1, led2, led3, led4, led5, led6, led7, led8
);
initial begin
    led1 <= 0;
    led2 <= 0;
    led3 <= 0;
    led4 <= 0;
    led5 <= 0;
    led6 <= 0;
    led7 <= 0;
    led8 <= 0;
end
always @ (posedge clk) begin
    led1 <= led[0];
    led2 <= led[1];
    led3 <= led[2];
    led4 <= led[3];
    led5 <= led[4];
    led6 <= led[5];
    led7 <= led[6];
    led8 <= led[7];
end
endmodule
