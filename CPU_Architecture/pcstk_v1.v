module pcstk_v1 (clk, jump, ret, jnumber, stko, pc,pc_in);
input [11:0] jnumber, stko, pc_in;
input clk, jump, ret;
output reg [11:0] pc;

always @(posedge clk)
begin
    case (ret)
        0: begin
            if (jump == 0)
                pc <= pc_in + 1;
            else
                pc <= pc_in+ jnumber;
        end
        1: pc <= stko;
    endcase
end

endmodule
