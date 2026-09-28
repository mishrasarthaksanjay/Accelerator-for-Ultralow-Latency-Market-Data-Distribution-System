`timescale 1ns/1ps
module tb_pmap;
    reg clk = 0, rst = 1, load = 0, pop = 0;
    reg [7:0] in_byte = 8'd0;
    wire flag_out;

    fast_pmap dut (.clk(clk), .rst(rst), .load(load), .pop(pop),
                   .in_byte(in_byte), .stop(flag_out));   // rename .stop if you rename the port

    always #5 clk = ~clk;

    task load_byte(input [7:0] b);
        begin
            in_byte = b; load = 1;
            @(negedge clk);
            load = 0;
        end
    endtask

    task do_pop;
        begin
            pop = 1;
            @(negedge clk);
            pop = 0;
        end
    endtask

    initial begin
        repeat (2) @(negedge clk);
        rst = 0;
        @(negedge clk);

        load_byte(8'hA0);
        $display("A0 load : %b", flag_out);   // expect 0
        do_pop;
        $display("A0 pop 1: %b", flag_out);   // expect 1
        do_pop;
        $display("A0 pop 2: %b", flag_out);   // expect 0

        load_byte(8'hE0);
        $display("E0 load : %b", flag_out);   // expect 1
        do_pop;
        $display("E0 pop 1: %b", flag_out);   // expect 1
        do_pop;
        $display("E0 pop 2: %b", flag_out);   // expect 0

        $finish;
    end
endmodule