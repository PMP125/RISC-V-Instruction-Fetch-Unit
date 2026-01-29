// Code your design here
module program_counter (
    input  wire        clk,
    input  wire        reset,
    input  wire        pc_enable,
    output reg  [31:0] pc_out
);

    always @(posedge clk) begin
        if (reset) begin
            pc_out <= 32'b0;
        end else if (pc_enable) begin
            pc_out <= pc_out + 4;
        end else begin
            pc_out <= pc_out;   // Hold PC (stall)
        end
    end

endmodule


module instruction_memory (
    input  wire [31:0] pc,
    output reg  [31:0] instruction
);

    // Simple instruction memory (ROM)
    reg [31:0] memory [0:31];   // 32 instructions max

    initial begin
        // Dummy instructions (just for testing)
        memory[0] = 32'h00000013; // NOP (addi x0, x0, 0)
        memory[1] = 32'h00100093; // addi x1, x0, 1
        memory[2] = 32'h00200113; // addi x2, x0, 2
        memory[3] = 32'h00308193; // addi x3, x1, 3
        memory[4] = 32'h00408213; // addi x4, x1, 4
    end

    always @(*) begin
        instruction = memory[pc[31:2]];
    end

endmodule

module instruction_fetch_unit (
    input  wire        clk,
    input  wire        reset,
    input  wire        pc_enable,
    output wire [31:0] pc,
    output wire [31:0] instruction
);

    program_counter pc_unit (
        .clk(clk),
        .reset(reset),
        .pc_enable(pc_enable),
        .pc_out(pc)
    );

    instruction_memory imem (
        .pc(pc),
        .instruction(instruction)
    );

endmodule
