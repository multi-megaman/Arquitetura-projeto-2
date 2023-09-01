module memToRegMux(readData, aluResult, memToReg, memToRegOutput);
	input wire [31:0] readData, aluResult ;
	input wire 			memToReg;
	output reg [31:0] memToRegOutput ;
	
	always@(*) begin
		case (memToReg)
			1'b0: memToRegOutput <= aluResult;
			1'b1: memToRegOutput <= readData;
		endcase
	end

endmodule 