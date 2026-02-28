module block_rom_model #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_DEPTH = 2048,
    parameter PIPELINE = 1
)
(
    output logic [DATA_WIDTH-1:0] dout,
    input  logic         clk,
    input  logic         oce,
    input  logic         ce,
    input  logic         reset,
    input  logic [$clog2(ADDR_DEPTH)-1:0]   ad
);

    // -------------------------------------------------------------------------
    // Memory Array
    // Depth: 32
    // Width: 160 bits
    // -------------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] rom_memory [0:ADDR_DEPTH-1];
    logic [DATA_WIDTH-1:0] dout_q;

    // -------------------------------------------------------------------------
    // Initialization
    // -------------------------------------------------------------------------
    initial begin
        // Reads hex file into memory. 
        // Note: 'first_weights_read.hex' must be reachable by the simulator.
        // If simulation fails to find the file, provide the absolute path.
        $readmemh("c:/Users/BEK/repos/silicore_teknofest_mcu_2026/verification/dummy_modules/first_weights_read.hex", rom_memory);
    end

    // -------------------------------------------------------------------------
    // Synchronous Read Logic
    // -------------------------------------------------------------------------
generate
    if (PIPELINE == 0) begin : no_pipeline
        always_ff @(posedge clk) begin
            if (reset) begin
                dout <= 'd0;
            end else if (ce) begin
                dout <= rom_memory[ad];
            end
        end
    end else begin : with_pipeline
        always_ff @(posedge clk) begin
            if (reset) begin
                dout_q <= 'd0;
                dout <= 'd0;
            end else if (ce) begin
                dout_q <= rom_memory[ad];
                dout <= dout_q;
            end
        end
    end
endgenerate

endmodule