module direct_v1 (Da, Db, romx, clk, direct, dataa, datab);
input [7:0] Da, Db, romx;
input clk, direct;
output [7:0] dataa, datab;
reg [7:0] dataa, datab;

always @(posedge clk)
begin
    dataa <= Da;
end

always @(posedge clk)
begin
    case (direct)
        0: datab <= Db;
        1: datab <= romx;
    endcase
end

endmodule
