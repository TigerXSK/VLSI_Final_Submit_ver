module sp_v1 (Clk, pop, push, sp,sp_in);
input Clk, pop, push;
input [1:0] sp_in;
output [1:0] sp;
reg [1:0] sp;

always @(posedge Clk)
begin
    if (pop)
        sp <= sp_in + 1;
    else if (push)
        sp <= sp_in - 1;
    else sp<= sp_in;
end

endmodule
