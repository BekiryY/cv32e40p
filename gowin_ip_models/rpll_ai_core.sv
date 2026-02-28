// ==============================================================================
// RPLL AI Core - Dummy Model for Vivado Synthesis
// ==============================================================================
// Description:
//   Simple pass-through PLL model for schematic generation in Vivado.
//   No actual frequency multiplication - just connects input to output.
//   
// Usage:
//   This is a placeholder for synthesis. For actual Gowin implementation,
//   use the Gowin RPLL IP with appropriate configuration.
// ==============================================================================

module rpll_ai_core (
    input  logic clkin,     // Input clock
    output logic clkout     // Output clock (pass-through)
);

    // Simple pass-through for schematic generation
    assign clkout = clkin;

endmodule
