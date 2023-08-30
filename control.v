//Controlador central + controlador da ALU
module control(OPcode, func, in1Mux, in2Mux, aluOp);
	
	input wire [5:0] OPcode;
	input wire [5:0] func;
	output reg [1:0] in1Mux;
	output reg       in2Mux;
	output reg [3:0] aluOp;
	
	always @(*) begin
		case (OPcode)
		
			//Instrucoes do tipo R
			6'b000000: begin 
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
			end
			6'b000101:begin //bne
				in1Mux <= 2'b00; //$rt
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0111; //sub zero_flag
			
			end
			6'b001000:begin //addi
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
			end
			6'b001010:begin //slti
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1100; //slt
			
			end
			6'b001011:begin //sltiu
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1100; //slt
			
			end
			6'b001100:begin //andi
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1000; //and
			end
			6'b001101:begin //ori
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1001; //or
			end
			6'b001110:begin //xori
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1010; //xor
			end
			6'b001111:begin //lui
				in1Mux <= 2'b10; //{16'b0, imm}
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b1110; //lui
			
			end
			6'b100011:begin //lw
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
			end
			6'b101011:begin //sw
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
			end
			
			//Instrucoes do tipo J		
			6'b000010:begin //j										PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
			end
			6'b000011:begin //jal										PENSAR EM COMO IMPLEMENTAR ISSO DEPOIS
				in1Mux <= 2'b01; //SingExt(imm)
				in2Mux <= 1'b0; //$rs
				aluOp <= 4'b0110; //add
			end
			
		endcase
	end
	
endmodule