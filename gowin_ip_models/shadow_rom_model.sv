module shadow_rom_model #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 32,
    parameter ADDR_DEPTH = 1 << ADDR_WIDTH
)
 (
    input [ADDR_WIDTH-1:0] ad,
    output [DATA_WIDTH-1:0] dout
);
    // -------------------------------------------------------------------------
    // Internal Memory Storage
    // -------------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] rom_memory [0:ADDR_DEPTH-1];

    // -------------------------------------------------------------------------
    // Initialization
    // -------------------------------------------------------------------------
   initial begin
       // Uncomment below to load from hex file:
       $readmemh("C:/Users/BEK/repos/silicore_teknofest_mcu_2026/other/scripts/hex/Conv2D_bias.hex", rom_memory);
   end
    // -------------------------------------------------------------------------
    // Combinational Read Logic
    // -------------------------------------------------------------------------

    assign dout = rom_memory[ad];

endmodule