//==============================================//
//      ioi_v1_tb_n.v testbench by 徐聖凱        //
//==============================================//
`define CYCLE_TIME 10

module IO_PATTERN(
    //Output Port
    clk,
    rst_n,
    D,
    B1,
    B2,
    addr,
    cha,
    chb,
    WE,
    //Input Port
    B0,
    B3,
    Da,
    Db
);
//==============================================//
//          Input & Output Declaration          //
//==============================================//
output reg clk, rst_n;
output reg [7:0] D;
output reg [7:0] B1, B2;
output reg [1:0] addr, cha, chb;
output reg WE;

input [7:0] B0, B3, Da, Db;

io_v1 u_io_v1 (
    .D(D),
    .B1(B1),
    .B2(B2),
    .addr(addr),
    .cha(cha),
    .chb(chb),
    .clk(clk),
    .WE(WE),
    .B0(B0),
    .B3(B3),
    .Da(Da),
    .Db(Db)
);

//==============================================//
//               Parameter & Integer            //
//==============================================//
integer CYCLE = `CYCLE_TIME;
integer i;

//==============================================//
//                 Main Function                //
//==============================================//
initial begin
    reset_task;

    // Start test cases
    test_case_1; // Q0(0)=1, Q0(1)=1
    test_case_2; // Q0(0)=0, Q0(1)=0
    test_case_3; // Q0(0)=1, Q0(1)=0
    test_case_4; // Q0(0)=0, Q0(1)=1

    pass_task;
end

//==============================================//
//            Clock and Reset Function          //
//==============================================//
// clock
always #(CYCLE/2) clk = ~clk;

task reset_task; begin
    clk = 0;
    rst_n = 1;
    WE = 0;
    D = 8'h00;
    B1 = 8'h00;
    B2 = 8'h00;
    addr = 2'b00;
    cha = 2'b00;
    chb = 2'b00;

    force clk = 0;
    #(CYCLE * 3);

    rst_n = 0;
    #(CYCLE * 4);

    rst_n = 1;
    #(CYCLE * 3);
    release clk;

    // 設定 Q0, Q1, Q2, Q3 為 A0, B0, C0, D0
    WE = 1; // 啟用寫入
    // Q0 = A0
    addr = 2'b00;
    D = 8'hA0;
    @(posedge clk);
    @(posedge clk);

    // Q1 = B0
    addr = 2'b01;
    D = 8'hB0;
    @(posedge clk);
    @(posedge clk);

    // Q2 = C0
    addr = 2'b10;
    D = 8'hC0;
    @(posedge clk);
    @(posedge clk);

    // Q3 = D0
    addr = 2'b11;
    D = 8'hD0;
    @(posedge clk);
    @(posedge clk);

    WE = 0; // 停止寫入
    D = 8'h00;
    addr = 2'b00;

    repeat(5) @(negedge clk);
end endtask

//==============================================//
//               Test Cases                     //
//==============================================//

task test_case_1; begin // Q0(0)=1, Q0(1)=1 (Q0 = AF)
    // $display("Starting Test Case 1: Q0(0)=1, Q0(1)=1");

    WE = 1;
    addr = 2'b00;   
    D = 8'hAF;  //  Q0 = AF
    @(posedge clk);
    @(posedge clk);
    WE = 0;

    cha = 2'b00; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAF || Db !== 8'hAF) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (0, 0)", {8'hAF, 8'hAF}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAF || Db !== 8'hB0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (0, 1)", {8'hAF, 8'hB0}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAF || Db !== 8'hC0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (0, 2)", {8'hAF, 8'hC0}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAF || Db !== 8'hD0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (0, 3)", {8'hAF, 8'hD0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hAF) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (1, 0)", {8'hB0, 8'hAF}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hB0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (1, 1)", {8'hB0, 8'hB0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hC0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (1, 2)", {8'hB0, 8'hC0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hD0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (1, 3)", {8'hB0, 8'hD0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hAF) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (2, 0)", {8'hC0, 8'hAF}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hB0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (2, 1)", {8'hC0, 8'hB0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hC0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (2, 2)", {8'hC0, 8'hC0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hD0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (2, 3)", {8'hC0, 8'hD0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hAF) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (3, 0)", {8'hD0, 8'hAF}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hB0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (3, 1)", {8'hD0, 8'hB0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hC0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (3, 2)", {8'hD0, 8'hC0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hD0) begin
        fail_task("Test Case 1 Failed", "Da/Db when (cha, chb) = (3, 3)", {8'hD0, 8'hD0}, {Da, Db});
    end
    $display("=> Test Case 1 Passed!");
end endtask

task test_case_2; begin // Q0(0)=0, Q0(1)=0 (Q0 = A0)
    // $display("Starting Test Case 2: Q0(0)=0, Q0(1)=0");

    WE = 1;
    addr = 2'b00;   
    D = 8'hA0;  //  Q0 = A0
    @(posedge clk);
    @(posedge clk);
    WE = 0;

    cha = 2'b00; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hA0 || Db !== 8'hA0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (0, 0)", {8'hA0, 8'hA0}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hA0 || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (0, 1)", {8'hA0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hA0 || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (0, 2)", {8'hA0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hA0 || Db !== 8'hD0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (0, 3)", {8'hA0, 8'hD0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hA0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (1, 0)", {8'hZZ, 8'hA0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (1, 1)", {8'hZZ, 8'hZZ}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (1, 2)", {8'hZZ, 8'hZZ}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hD0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (1, 3)", {8'hZZ, 8'hD0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hA0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (2, 0)", {8'hZZ, 8'hA0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (2, 1)", {8'hZZ, 8'hZZ}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (2, 2)", {8'hZZ, 8'hZZ}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hD0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (2, 3)", {8'hZZ, 8'hD0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hA0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (3, 0)", {8'hD0, 8'hA0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (3, 1)", {8'hD0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hZZ) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (3, 2)", {8'hD0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hD0) begin
        fail_task("Test Case 2 Failed", "Da/Db when (cha, chb) = (3, 3)", {8'hD0, 8'hD0}, {Da, Db});
    end

    $display("=> Test Case 2 Passed!");
end endtask

task test_case_3; begin // Q0(0)=1, Q0(1)=0 (Q0 = AD)
    // $display("Starting Test Case 3: Q0(0)=1, Q0(1)=0");

    WE = 1;
    addr = 2'b00;   
    D = 8'hAD;  //  Q0 = AD
    @(posedge clk);
    @(posedge clk);
    WE = 0;

    cha = 2'b00; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAD || Db !== 8'hAD) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (0, 0)", {8'hAD, 8'hAD}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAD || Db !== 8'hB0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (0, 1)", {8'hAD, 8'hB0}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAD || Db !== 8'hZZ) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (0, 2)", {8'hAD, 8'hZZ}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAD || Db !== 8'hD0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (0, 3)", {8'hAD, 8'hD0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hAD) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (1, 0)", {8'hB0, 8'hAD}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hB0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (1, 1)", {8'hB0, 8'hB0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hZZ) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (1, 2)", {8'hB0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hB0 || Db !== 8'hD0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (1, 3)", {8'hB0, 8'hD0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hAD) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (2, 0)", {8'hZZ, 8'hAD}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hB0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (2, 1)", {8'hZZ, 8'hB0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hZZ) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (2, 2)", {8'hZZ, 8'hZZ}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hD0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (2, 3)", {8'hZZ, 8'hD0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hAD) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (3, 0)", {8'hD0, 8'hAD}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hB0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (3, 1)", {8'hD0, 8'hB0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hZZ) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (3, 2)", {8'hD0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hD0) begin
        fail_task("Test Case 3 Failed", "Da/Db when (cha, chb) = (3, 3)", {8'hD0, 8'hD0}, {Da, Db});
    end

    $display("=> Test Case 3 Passed!");
end endtask

task test_case_4; begin // Q0(0)=0, Q0(1)=1 (Q0 = AE)
    // $display("Starting Test Case 4: Q0(0)=0, Q0(1)=1");
    WE = 1;
    addr = 2'b00;   
    D = 8'hAE;  //  Q0 = AE
    @(posedge clk);
    @(posedge clk);
    WE = 0;

    cha = 2'b00; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAE || Db !== 8'hAE) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (0, 0)", {8'hAE, 8'hAE}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAE || Db !== 8'hZZ) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (0, 1)", {8'hAE, 8'hZZ}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAE || Db !== 8'hC0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (0, 2)", {8'hAE, 8'hC0}, {Da, Db});
    end

    cha = 2'b00; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hAE || Db !== 8'hD0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (0, 3)", {8'hAE, 8'hD0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hAE) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (1, 0)", {8'hZZ, 8'hAE}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hZZ) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (1, 1)", {8'hZZ, 8'hZZ}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hC0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (1, 2)", {8'hZZ, 8'hC0}, {Da, Db});
    end

    cha = 2'b01; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hZZ || Db !== 8'hD0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (1, 3)", {8'hZZ, 8'hD0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hAE) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (2, 0)", {8'hC0, 8'hAE}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hZZ) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (2, 1)", {8'hC0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hC0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (2, 2)", {8'hC0, 8'hC0}, {Da, Db});
    end

    cha = 2'b10; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hC0 || Db !== 8'hD0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (2, 3)", {8'hC0, 8'hD0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b00; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hAE) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (3, 0)", {8'hD0, 8'hAE}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b01; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hZZ) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (3, 1)", {8'hD0, 8'hZZ}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b10; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hC0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (3, 2)", {8'hD0, 8'hC0}, {Da, Db});
    end

    cha = 2'b11; chb = 2'b11; @(posedge clk); @(posedge clk);
    if (Da !== 8'hD0 || Db !== 8'hD0) begin
        fail_task("Test Case 4 Failed", "Da/Db when (cha, chb) = (3, 3)", {8'hD0, 8'hD0}, {Da, Db});
    end
    $display("=> Test Case 4 Passed!");
end endtask

//==============================================//
//           Fail and Pass Functions            //
//==============================================//
task fail_task(input [255:0] msg, input [255:0] sig, input [15:0] expected, input [15:0] actual); begin
    $display("================================================================");
    $display("                             FAIL                               ");
    $display("  %s: %s | Expected = %h, Actual = %h", msg, sig, expected, actual);
    $display("================================================================");
    $finish;
end endtask

task pass_task; begin
    $display("========================================================");
    $display("                      Congratulations!!");
    $display("                     All Test Cases Pass");
    $display("========================================================");
    $finish;
end endtask

endmodule
