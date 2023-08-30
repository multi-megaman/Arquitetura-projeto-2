module ulaCore (In1, In2, OP, result, Zero_flag);

	input wire [31:0] In1, In2; // In1 = $rt or SingExt(imm) or {16'b0, imm}    In2 = $rs or $shamt
	input wire [4:0] OP;
	output reg [31:0] result;
	output Zero_flag;
	
	always @(*) begin
		case (OP)
			// $rt com shamt
			4'b0000: result <= In1 << In2;    												// sll ($rt << shamt)
			4'b0001: result <= In1 >> In2;    												// srl ($rt >> shamt)
			4'b0010: result <= $signed ($signed (In1) >>> In2);    					// sra  signed ($rt >> shamt)
			
			// $rt com $rs
			4'b0011: result <= (In1) << (In2);  											// sllv ($rt << $rs)
			4'b0100: result <= $unsigned($unsigned(In1) >> $unsigned(In2));      // srlv ($rt >> $rs)
			4'b0101: result <= $signed($signed(In1) >> $signed(In2));      		// srav signed ($rt >> $rs)
			
			//$rs com SingExt(imm) ou {16'b0, imm} ou {imm, 16'b0}
			4'b0110: result <= In2 + In1;       											// add ($rs + $rt) or addi($rs + SingExt(imm))
			4'b0111: result <= In2 - In1;       											// sub ($rs - $rt)
			4'b1000: result <= In2 & In1;       											// and ($rs & $rt)   or andi($rs & {16'b0, imm})
			4'b1001: result <= In2 | In1;       											// or  ($rs | $rt)   or ori($rs or {16'b0, imm})
			4'b1010: result <= In2 ^ In1;       											// xor ($rs xor $rt) or xor($rs xor {16'b0, imm})
			4'b1011: result <= ~((In2) | (In1));											// nor !($rs or $rt)
			4'b1100: result <= $signed($signed(In2) < $signed(In1));       		// slt signed ($rs < $rt)    or slti signed    ($rs < SingExt(imm))
			4'b1101: result <= $unsigned($unsigned(In2) < $unsigned(In1));       // sltu unsigned ($rs < $rt) or sltui unsigned ($rs < SingExt(imm))
			4'b1110: result <= {In1[15:0], 16'b0};     									// lui
			default: result <= 32'b0;
		endcase
	end
	
	assign Zero_flag = (result == 32'b0); // 1 if result == 0 else 0
endmodule 

//Mux da In1 do AluCore
module ulaIn1Mux(ulaIn1Rt, ulaIn1Imm, ulaIn1ExImm, ulaIn1MuxController, ulaIn1MuxOut);
	
	input wire [31:0] ulaIn1Rt, ulaIn1ExImm;
	input wire [15:0] ulaIn1Imm;
	input wire [1:0] ulaIn1MuxController;
	output reg [31:0] ulaIn1MuxOut;
	
	always @(*) begin
		case (ulaIn1MuxController)
			2'b00: ulaIn1MuxOut <= ulaIn1Rt;
			2'b01: ulaIn1MuxOut <= ulaIn1ExImm;
			2'b10: ulaIn1MuxOut <= {16'b0, ulaIn1Imm };
		endcase
	end

endmodule 

//Mux da In2 do AluCore
module ulaIn2Mux(ulaIn2Rs, ulaIn2Shamt, ulaIn2MuxController, ulaIn2MuxOut);
	
	input wire [31:0] ulaIn2Rs;
	input wire [4:0] ulaIn2Shamt;
	input wire ulaIn2MuxController;
	output reg [31:0] ulaIn2MuxOut;
	
	always @(*) begin
		case (ulaIn2MuxController)
			1'b0: ulaIn2MuxOut <= ulaIn2Rs;
			1'b1: ulaIn2MuxOut <= {27'b0, ulaIn2Shamt };
		endcase
	end

endmodule 



