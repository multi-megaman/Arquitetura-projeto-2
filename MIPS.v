//module MIPS(In1, In2,OP, result, Zero_flag);
//	input wire [31:0] In1, In2; // In1 = $rt or imm or SingExt(imm)    In2 = $rs or $shamt
//	input wire [4:0] OP;
//	output reg [31:0] result;
//	output wire Zero_flag;
//ula ulaCore(In1, In2, OP, result, Zero_flag);
//endmodule 

module MIPS (In1, In2, OP, result, Zero_flag);

	input wire [31:0] In1, In2; // In1 = $rt or imm or SingExt(imm)    In2 = $rs or $shamt
	input wire [3:0] OP;
	output wire [31:0] result;
	output Zero_flag;
	
	//Mux do In1 da ULA
	wire [31:0] rt;
	wire [15:0] imm;
	wire [31:0] exImm;
	wire [1:0]  aluIn1MuxController;
	wire [31:0] aluIn1MuxOut;
	ulaIn1Mux ulaIn1(rt,imm,exImm,aluIn1MuxController, aluIn1MuxOut);
	
	//Mux do In2 da ULA
	wire [31:0] rs;
	wire [4:0] shamt;
	wire aluIn2MuxController;
	wire aluIn2MuxOut;
	ulaIn2Mux ulaIn2(rs, shamt, aluIn2MuxController, aluIn2MuxOut);
	
	ulaCore ula(aluIn1MuxOut, aluIn2MuxOut, OP, result, Zero_flag);
endmodule 