//Grupo: Ru-Rural
//integrantes: 
//Pedro Henrique
//Everton da Silva
//Ricardo Pompilio

//Modulo que calcula os sinais corretos dos casos de branch
module branch_module (branch, ula_Result, branch_Result, op_Code);

	input wire branch;
	input wire [31:0] ula_Result;
	input wire [5:0] op_Code;
	output reg branch_Result;
	
	always @(*) begin
		case (op_Code)
			6'b000100:begin
				if (ula_Result == 0) begin
					branch_Result <= 1'b1;
				end
				else begin
					branch_Result <= 1'b0;
				end
			end
			6'b000101:begin
				if (ula_Result != 0) begin
					branch_Result <= 1'b1;
				end
				else begin
					branch_Result <= 1'b0;
				end
			end
		endcase
	end




endmodule
