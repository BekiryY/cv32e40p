module shadow_ram_model_SP #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32,
    parameter ADDR_DEPTH = 1 << ADDR_WIDTH
)
 (
    input clk,
    
    input [ADDR_WIDTH-1:0] ad,
    output [DATA_WIDTH-1:0] dout,
    
    input wre,
    input [DATA_WIDTH-1:0] di
);
    // -------------------------------------------------------------------------
    // Internal Memory Storage
    // -------------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] ram_memory [0:ADDR_DEPTH-1];

    // -------------------------------------------------------------------------
    // Initialization
    // -------------------------------------------------------------------------
    initial begin
        // Initialize memory to zero
        for (int i = 0; i < ADDR_DEPTH; i++) begin
            ram_memory[i] = '0;
        end
        // Uncomment below to load from hex file:
        // $readmemh("path/to/file.hex", ram_memory);
    end

    // -------------------------------------------------------------------------
    // Synchronous Write Logic
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (wre) begin
            ram_memory[ad] <= di;
        end
    end

    // -------------------------------------------------------------------------
    // Combinational Read Logic
    // -------------------------------------------------------------------------

    assign dout = ram_memory[ad];


endmodule