module memToRegMux(readData, aluResult, memToReg, memToRegOutput, nextPC);
	input wire [31:0] readData, aluResult, nextPC;
	input wire [1:0]	memToReg;
	output reg [31:0] memToRegOutput ;
	
	always@(*) begin
		case (memToReg)
			2'b00: memToRegOutput <= aluResult;
			2'b01: memToRegOutput <= readData;
			2'b10: memToRegOutput <= nextPC;
		endcase
	end

endmodule 