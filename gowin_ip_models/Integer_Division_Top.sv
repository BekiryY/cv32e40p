//=====================================================
//DISCLAIMER: TESTING AND SCHEMATIC PURPOSES ONLY.
//DO NOT USE THIS MODULE FOR IMPLEMENTATION
//=====================================================
module Integer_Division_Top (
    input  wire       clk,
    input  wire       rstn,
    input  wire [7:0] dividend,
    input  wire [9:0] divisor,
    output wire [7:0] quotient
);

    // 10-stage shift register to hold the quotients
    reg [7:0] pipe [0:9];
    integer i;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i = 0; i < 10; i = i + 1) begin
                pipe[i] <= 8'd0;
            end
        end else begin
            // Calculate division on the first stage (includes simple divide-by-zero protection)
            pipe[0] <= (divisor != 10'd0) ? (dividend / divisor) : 8'd0;
            
            // Shift the result through the remaining 9 stages
            for (i = 1; i < 10; i = i + 1) begin
                pipe[i] <= pipe[i-1];
            end
        end
    end

    // Output the final registered value (10 clocks later)
    assign quotient = pipe[9];

endmodule