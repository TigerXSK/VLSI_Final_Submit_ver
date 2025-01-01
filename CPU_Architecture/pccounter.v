module pcounter_v1 (PCounter, B, jump, PCadd);
input [11:0] PCounter, B;
input jump;
output [11:0] PCadd;
reg [11:0] PCadd;

always @(jump or B)
begin
    if (jump == 0)
        PCadd = PCounter + 1;
    else
        PCadd = PCounter + B;
end

endmodule
