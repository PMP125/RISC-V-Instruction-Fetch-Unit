module tb_instruction_fetch_unit;

    reg clk;
    reg reset;
    reg pc_enable;
    wire [31:0] pc;
    wire [31:0] instruction;

    instruction_fetch_unit uut (
        .clk(clk),
        .reset(reset),
        .pc_enable(pc_enable),
        .pc(pc),
        .instruction(instruction)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_instruction_fetch_unit);

        clk = 0;
        reset = 1;
        pc_enable = 1;

        #10 reset = 0;

        #30 pc_enable = 0;  // Stall PC
        #20 pc_enable = 1;  // Resume

        #100;
        $finish;
    end

endmodule
