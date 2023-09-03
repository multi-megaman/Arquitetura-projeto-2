module PC (clk, PC_next, PC_out);

input wire clk;
input wire [31:0] PC_next;
output reg [31:0] PC_out;



always @(posedge clk) begin
    PC_out <= PC_next;
	 
end

endmodule

module PCNext(actualPC,nextPC);
	
	input wire [31:0] actualPC;
	output reg [31:0] nextPC;
	
	always @(actualPC) begin
		
		nextPC <= actualPC + 1;
		
	end
	
endmodule
