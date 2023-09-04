module jump (next_PC, instruction, jump_Result, jump, j_Reg, branch_Destiny, branch_Result);

	input wire [31:0] next_PC, instruction, j_Reg, branch_Destiny;
	input wire [1:0]	jump;
	input wire branch_Result;
	output reg [31:0] jump_Result;
	
	always @(*) begin
		case (jump)
			2'b00: jump_Result <= next_PC;
			2'b01: jump_Result <= {next_PC[31:28],2'b00 ,instruction[25:0]};
			2'b10: jump_Result <= j_Reg;
			2'b11: begin
				if (branch_Result == 1) begin
					jump_Result <= branch_Destiny;
				end
				
				else begin
				jump_Result <= next_PC;
				end
			end
		
		endcase
	end
	


endmodule
