module PC (clk, PC_out, jump_Result);

input wire clk;
input wire [31:0] jump_Result;
output reg [31:0] PC_out;



always @(posedge clk) begin
	PC_out <= jump_Result;	
end

endmodule

module PCNext(actualPC,nextPC);
	
	input wire [31:0] actualPC;
	output reg [31:0] nextPC;
	
	always @(actualPC) begin
		
		nextPC <= actualPC + 1;
		
	end
	
endmodule
