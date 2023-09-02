module PC (clk, PC_next, PC_out);

input wire clk;
reg [31:0] memPosition = 0;
input wire [31:0] PC_next;
output reg [31:0] PC_out;



always @(posedge clk) begin
    PC_out <= memPosition;
	 
	 memPosition <= memPosition + 1;
end

endmodule
