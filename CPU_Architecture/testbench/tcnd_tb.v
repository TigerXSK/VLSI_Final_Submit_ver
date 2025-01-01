`timescale 1ns/1ps

module top_module();
    reg [3:0] contl;
    reg [8:0] aluo;
    wire tcnd;


    tcnd_v1 uut (
        .contl (contl),
        .aluo (aluo),
        .tcnd (tcnd) 
    );

    initial begin
        contl = 0;
        repeat(15) begin
            aluo = 9'd10;
            #1;
            if (contl <=3 && contl >0) begin
                if (tcnd == 1'b1) begin
                    $display ("Passed! case %d", contl) ;
                end
                else $display ("Failed!, contl = %d ,tcnd = %d", contl,tcnd);
            end 
            else if (contl == 'd4) begin
                if (tcnd ==  ~|aluo[7:0]) $display ("Passed! case 4 ") ;
                else $display ("Failed!, contl = %d ,tcnd = %d", contl,tcnd);
            end
            else if (contl == 'd5) begin
                if (tcnd ==  |aluo[7:0]) $display ("Passed! case 5 ") ;
                else $display ("Failed!, contl = %d ,tcnd = %d", contl,tcnd);
            end
            else if (contl == 'd6) begin
                if (tcnd ==  aluo[8]) $display ("Passed! case 6 ") ;
                else $display ("Failed!, contl = %d ,tcnd = %d", contl,tcnd);
            end
            else if (contl == 'd7) begin
                if (tcnd ==  ~aluo[8]) $display ("Passed! case 7") ;
                else $display ("Failed!, contl = %d ,tcnd = %d", contl,tcnd);
            end
            else begin
                if(tcnd == 0) $display ("Passed! case %d",contl) ;
                else $display ("failed!, contl = %d ,tcnd = %d", contl,tcnd);
            end
            contl = contl +1 ;
    end
    $finish;
    end

   

endmodule