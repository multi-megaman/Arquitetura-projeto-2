//Controlador central + controlador da ALU
module control(OPcode, func, memToReg, memRead, memWrite, regDst, regWrite, branch);
	
	input wire [5:0] OPcode;
	input wire [5:0] func;
	output reg       memToReg, regDst, regWrite, branch, memRead, memWrite;
	
	always @(*) begin
		memToReg <= 1'b0;
		memRead <= 1'b0;
		memWrite <= 1'b0;
		
		case (OPcode)
		
			//Instrucoes do tipo R
			6'b000000: begin
				regDst <= 1'b1;
				regWrite <= 1'b1;
				branch <= 1'b0;
				case (func)
					6'b001000:begin //jr								PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
						regDst <= 1'bx;
						branch <= 1'b0;
						regWrite <= 1'b0;
					end
				endcase
			end
			
			//Intrucoes do tipo I
			6'b000100:begin //beq
				regDst <= 1'bx;
				branch <= 1'b1;
				regWrite <= 1'b0;
			end
			6'b000101:begin //bne
				regDst <= 1'bx;
				branch <= 1'b1;
				regWrite <= 1'b0;
			end
			6'b001000:begin //addi
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001010:begin //slti
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
			
			end
			6'b001011:begin //sltiu
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
			
			end
			6'b001100:begin //andi
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001101:begin //ori
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001110:begin //xori
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001111:begin //lui
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
			
			end
			6'b100011:begin //lw
				regDst <= 1'b0;
				branch <= 1'b0;
				regWrite <= 1'b1;
				memToReg <= 1'b1;
				memRead <= 1'b1;
				memWrite <= 1'b0;
			end
			6'b101011:begin //sw
				regDst <= 1'bx;
				branch <= 1'b0;
				regWrite <= 1'b0;
				memToReg <= 1'bx;
				memRead <= 1'b0;
				memWrite <= 1'b1;
			end
			
			//Instrucoes do tipo J		
			6'b000010:begin //j										PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
				regDst <= 1'bx;
				branch <= 1'b0;
				regWrite <= 1'b0;
			end
			6'b000011:begin //jal										PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
				regDst <= 1'bx;
				branch <= 1'b0;
				regWrite <= 1'b0;
			end
			
		endcase
	end
	
endmodule