# Gowin IP Models - Dummy Modules for Vivado Synthesis

This directory contains behavioral models and dummy modules for Gowin-specific IP blocks to enable synthesis and simulation in non-Gowin tools (e.g., Vivado, ModelSim).

## Memory Models

### Block RAM Models
- **`block_ram_model_DP.sv`** - Dual Port Block RAM behavioral model
- **`shadow_ram_model_SDP.sv`** - Simple Dual Port Shadow RAM model
- **`shadow_ram_model_SP.sv`** - Single Port Shadow RAM model

### Block ROM Models
- **`block_rom_model.sv`** - Block ROM behavioral model

## PLL Models (Dummy for Schematic Generation)

### RPLL Modules
- **`rpll_270.sv`** - RPLL 270 MHz dummy module
- **`rpll_ai_core.sv`** - RPLL AI Core dummy module

**Note**: The RPLL modules are simple pass-through modules (clkout = clkin) intended only for:
- Schematic generation in Vivado
- Syntax checking
- Module hierarchy visualization

They do **NOT** perform actual frequency multiplication or PLL functionality.

## Usage

### For Simulation
Include these models in your simulation filelist when simulating designs that use Gowin IP blocks.

### For Synthesis (Vivado)
The RPLL dummy modules allow Vivado to:
1. Parse the design hierarchy
2. Generate schematics
3. Check for connectivity issues

**Important**: For actual FPGA implementation on Gowin devices, use the real Gowin RPLL IP configured through Gowin EDA tools.

## File Organization

```
verification/gowin_ip_models/
├── block_ram_model_DP.sv       # Dual Port RAM
├── block_rom_model.sv          # ROM model
├── shadow_ram_model_SDP.sv     # Simple Dual Port RAM
├── shadow_ram_model_SP.sv      # Single Port RAM
├── rpll_270.sv                 # PLL dummy (270 MHz)
├── rpll_ai_core.sv             # PLL dummy (AI Core)
└── README.md                   # This file
```

## Adding New Models

When adding new Gowin IP dummy models:
1. Create a `.sv` file with the same module name as the Gowin IP
2. Match the port interface exactly
3. Add behavioral logic for simulation (or pass-through for synthesis-only)
4. Document the purpose and limitations
5. Update this README

---

**Last Updated**: 2026-02-15
