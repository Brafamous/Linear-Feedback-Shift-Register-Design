`timescale 1ns / 1ps
module LFSR_Design_tb;

//Defining signals for the testbench
parameter width_in = 8; // Width of the LFSR
parameter width_out = 8; // Number of bits in the LFSR
parameter countwidth = 4; // Width of the cycle counter


reg clk; // Clock signal
reg rst; // Reset signal
reg enable; // Enable signal for LFSR operation
reg output_enable; // Enable signal for output
reg [width_in-1:0] seed_value; // Initial seed value for LFSR


wire valid; // Valid signal indicating output is ready
wire Out; // Output of the LFSR
wire [width_out-1:0] lfsr_out; // Debug output showing LFSR state

//Instantiating the LFSR_Design module
LFSR_Design DUT(
.clk(clk),
.rst(rst),
.enable(enable),
.output_enable(output_enable),
.seed_value(seed_value),

.valid(valid),
.Out(Out),
.lfsr_out(lfsr_out)
);

//clock generation
initial
begin
    clk = 0;
end

always #5 clk = ~clk;

//Stimulus Block
initial

begin
    //Initial Values
    rst =0;
    enable =0;
    output_enable =0;
    seed_value = 8'b10010010;

    //Apply Reset
    #10;
    rst=1;

    #10;
    rst = 0;

    //Start LFSR Generation
    #10;
    enable = 1;

    //Wait
    #120;
    enable = 0;

    //Start Serial Output
    #10;
    output_enable = 1;

    //Stop Simulation
    #100;
    $stop;
end

// Print serial output bits
always @(posedge clk)
begin
    if (valid)
        $display("Time=%0t | Serial Out bit = %b", $time, Out);
end

initial
begin
    $monitor("Sim_time = %0t | valid = %b | Out= %b | lfsr_out =%b", $time, valid, Out,lfsr_out);
end
endmodule



