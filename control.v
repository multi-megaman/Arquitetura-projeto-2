//Grupo: Ru-Rural
//integrantes: 
//Pedro Henrique
//Everton da Silva
//Ricardo Pompilio

//Controlador central + controlador da ALU
module control(OPcode, func, in1Mux, in2Mux, aluOp, memToReg, memRead, memWrite, regDst, regWrite, branch, jump);
	
	input wire [5:0] OPcode;
	input wire [5:0] func;
	output reg [1:0] in1Mux, memToReg, jump;
	output reg       in2Mux, regDst, regWrite, branch, memRead, memWrite;
	output reg [3:0] aluOp;
	
	always @(*) begin
		memToReg <= 2'b00;
		memRead <= 1'b0;
		memWrite <= 1'b0;
		jump <= 2'b00;
		
		case (OPcode)
		
			//Instrucoes do tipo R
			6'b000000: begin
				regDst <= 2'b01;
				regWrite <= 1'b1;
				branch <= 1'b0;
				case (func)
					6'b000000:begin //sll
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b1; //shamt
						aluOp <= 4'b0000; //sll
					end
					6'b000010:begin //srl
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b1; //shamt
						aluOp <= 4'b0001; //srl
					end
					6'b000011:begin //sra
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b1; //shamt
						aluOp <= 4'b0010; //sra
					end
					6'b000100:begin //sllv
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b0011; //sllv				
					end
					6'b000110:begin //srlv
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b0100; //srlv
					end
					6'b000111:begin //srav
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b0101; //srav
					end
					6'b001000:begin //jr								PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
						in1Mux <= 2'bxx; //(don't care)
						in2Mux <= 1'bx; //(don't care)
						aluOp <= 4'bxxxx; //(don't care)
						regDst <= 2'bxx;
						branch <= 1'b0;
						regWrite <= 1'b0;
						jump <= 2'b10;
						
						
					end
					6'b100000:begin  //add
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b0110; //add
					end
					6'b100010:begin //sub
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b0111; //sub
					end
					6'b100100:begin //and
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b1000; //and
					end
					6'b100101:begin //or
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b1001; //or
					end
					6'b100110:begin //xor
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b1010; //xor
					end
					6'b100111:begin //nor
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b1011; //nor
					end
					6'b101010:begin //slt
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b1100; //slt
					end
					6'b101011:begin //sltu
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b1101; //sltu
					end
					default:begin
						in1Mux <= 2'b00; //$rt
						in2Mux <= 1'b0; //$rs
						aluOp <= 4'b0100; //srlv
					end
				endcase
			end
			
			//Intrucoes do tipo I
			6'b000100:begin //beq
				in1Mux <= 2'b00; //$rt
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0111; //sub zero_flag
				regDst <= 2'bxx;
				branch <= 1'b1;
				regWrite <= 1'b0;
				jump <= 2'b11;
			end
			6'b000101:begin //bne
				in1Mux <= 2'b00; //$rt
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0111; //sub zero_flag
				regDst <= 2'bxx;
				branch <= 1'b1;
				regWrite <= 1'b0;
				jump <= 2'b11;
			end
			6'b001000:begin //addi
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001010:begin //slti
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1100; //slt
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
			
			end
			6'b001011:begin //sltiu
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1100; //slt
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
			
			end
			6'b001100:begin //andi
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1000; //and
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001101:begin //ori
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1001; //or
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001110:begin //xori
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1010; //xor
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
			end
			6'b001111:begin //lui
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1110; //lui
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
			
			end
			6'b100011:begin //lw
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
				regDst <= 2'b00;
				branch <= 1'b0;
				regWrite <= 1'b1;
				memToReg <= 2'b01;
				memRead <= 1'b1;
				memWrite <= 1'b0;
			end
			6'b101011:begin //sw
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
				regDst <= 2'bxx;
				branch <= 1'b0;
				regWrite <= 1'b0;
				memToReg <= 2'bxx;
				memRead <= 1'b0;
				memWrite <= 1'b1;
			end
			
			//Instrucoes do tipo J		
			6'b000010:begin //j										PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1111; //default
				regDst <= 2'bxx;
				branch <= 1'b0;
				regWrite <= 1'b0;
				jump <= 2'b01;
			end
			6'b000011:begin //jal										PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
				regDst <= 2'bxx;
				branch <= 1'b0;
				regWrite <= 1'b1;
				jump <= 2'b01;
				memToReg <= 2'b10;
			end
			
		endcase
	end
	
endmodule