module block_ram_model_DP #
(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8,
    parameter ADDR_DEPTH = 1 << ADDR_WIDTH,
    parameter PIPELINE = 1
)
(
    //PORT A READ
    input clka,
    input reseta,
    input cea,
    input [ADDR_WIDTH-1:0] ada,
    output logic [DATA_WIDTH-1:0] dout,

    //PORT B WRITE
    input clkb,
    input resetb,
    input ceb,
    input oce,
    input [ADDR_WIDTH-1:0] adb,
    input [DATA_WIDTH-1:0] din
);

    logic [DATA_WIDTH-1:0] ram_memory [0:ADDR_DEPTH-1];
    logic [DATA_WIDTH-1:0] dout_q;

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
    // Port B: Synchronous Write Logic
    // -------------------------------------------------------------------------
    always_ff @(posedge clkb) begin
        if (ceb) begin
            ram_memory[adb] <= din;
        end
    end

    // -------------------------------------------------------------------------
    // Port A: Synchronous Read Logic with Pipeline Control
    // -------------------------------------------------------------------------
generate
    if (PIPELINE == 0) begin : no_pipeline
        // No pipeline - single register stage
        always_ff @(posedge clka) begin
            if (reseta) begin
                dout <= '0;
            end else if (cea) begin
                dout <= ram_memory[ada];
            end
        end
    end else if (PIPELINE == 1) begin : single_pipeline
        // Single pipeline stage
        always_ff @(posedge clka) begin
            if (reseta) begin
                dout_q <= '0;
                dout <= '0;
            end else if (cea) begin
                dout_q <= ram_memory[ada];
                dout <= dout_q;
            end
        end
    end 
endgenerate

endmodule