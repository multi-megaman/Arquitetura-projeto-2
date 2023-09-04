module PC (clk, PC_next, PC_out, jump, jump_Result);

input wire clk;
input wire [31:0] PC_next, jump_Result;
input wire jump;
output reg [31:0] PC_out;



always @(posedge clk) begin
	if (jump == 0) begin
		PC_out <= PC_next;
	end
	else begin
		PC_out <= jump_Result;
	end
end

endmodule

module PCNext(actualPC,nextPC);
	
	input wire [31:0] actualPC;
	output reg [31:0] nextPC;
	
	always @(actualPC) begin
		
		nextPC <= actualPC + 1;
		
	end
	
endmodule
