module csr (
    input wire clk,
    input wire rst,
    input wire [11:0] addr,
    input wire [31:0] wr_data,
    input wire csr_we,
    input wire csr_re,
    output reg  [31:0] rdata
);


reg [31:0] mstatus;
reg [31:0] mtvec;
reg [31:0] mepc;
reg [31:0] mcause;

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        mstatus <= 32'b0;
        mtvec <= 32'b0;
        mepc <= 32'b0;
        mcause <= 32'b0;
        rdata <= 32'b0;
    end else begin
        if (csr_we) begin
            case (addr)
            12'h300 : mstatus <= wr_data;
            12'h305 : mtvec <= wr_data;
            12'h341 : mepc <= wr_data;
            12'h342 : mcause <= wr_data;
            endcase
        end
        if (csr_re) begin
            case (addr)
            12'h300 : rdata <= mstatus;
            12'h305 : rdata <= mtvec;
            12'h341 : rdata <= mepc;
            12'h342 : rdata <= mcause;
            endcase
        end
    end
end

endmodule