
module MIPS (clock, PC_out,nextPC, instruction, aluResult, Zero_flag, regWriteData, canWriteReg, reset, regMemOut1, regMemOut2);
	// OPcode =  instruction [31:26]
	// func = instruction [5:0]
	// rt = instruction [20:16]
	// rs =  instruction [25:21]
	// rd = instruction [15:11]
	// shamt = instruction [10:6]
	// imm = instruction [15:0]
	input wire clock, reset;
   output wire [31:0] nextPC;
	output wire [31:0] instruction ;
	output wire [31:0] aluResult ;
	output Zero_flag ;
	
	//Valores de testes
	//instrucao de exemplo de add $rs + $rt     = 000000 00001 00010 11111 01010 100000 -> resultado deve ser a soma de de R[$rs] com R[$rt]
	//instrucao de exemplo de lui {imm, 0x0000} = 001111 11111 00000 1001001011000011 -> resultado deve ser os 16 ultimos bits + 16'b0
	
	//teste supremo
	//instrucao de exemplo 1 de lui {imm, 0x0000} = 001111 00000 00000 0000000000000011 -> resultado deve ser os 16 ultimos bits + 16'b0
	//instrucao de exemplo 1 de lui {imm, 0x0000} = 001111 00001 00001 0000000000000101 -> resultado deve ser os 16 ultimos bits + 16'b0
	//instrucao de exemplo de add $rs + $rt     = 000000 00001 00000 00010 01010 100000 -> resultado deve ser a soma de de R[$rs] com R[$rt]
	wire [31:0] rt = 32'b00000000000000000000000000000010 ;
	wire [31:0] rs = 32'b00000000000000000000000000000011 ; 
	
	//testes para as entradas do banco de registradores
	wire [4:0] rtMem = 5'b00101;
	wire [4:0] rsMem = 5'b00001;
	wire [4:0] rdMem = 5'b00010;
	output wire [31:0] regWriteData;
	
	//testes para sinais do controlador
	wire 		  branch;
	output wire 		  canWriteReg ; //1 = true
	wire       regDest ; //0 = rt
	wire		  memWrite; //0 = false
	wire		  memRead ; //1 = true
	wire [1:0] memToReg, jump_Wire; //1 = readData mudei aqui
	
	//Contador de Programa (PC)
	wire [31:0] PC_next;
	output wire [31:0] PC_out;
	PC pc(clock, PC_out, jump_Result);
	PCNext nextInstruction(PC_out, nextPC);
	
	
	//modulo que serve como mutiplexador para instruções de jump
	wire [31:0] jump_Result;
	jump jump (PC_next, instruction, jump_Result, jump_Wire, regMemOut2, zeroFillImm, branch_Result);
	
	//modulo que faz a verificação das instruções de branch
	wire 			branch_Result;
	branch_module b_module (branch, aluResult, branch_Result, instruction[31:26]);
	
	
	//Memória de instrução (intMem)
	intMem intMem(clock, PC_out, instruction);
	
	//Controlador central (controlador do MIPS e da ULA)
	wire [1:0] aluIn1MuxController ;
	wire       aluIn2MuxController ;
	wire [3:0] aluOP ;
	control control( instruction[31:26] , instruction[5:0] , aluIn1MuxController, aluIn2MuxController , aluOP, memToReg, memRead, memWrite, regDest, canWriteReg, branch, jump_Wire); //entrada, entrada, saida, saida, saida
	
	
	//Banco de registradores
	output wire [31:0] regMemOut1, regMemOut2;
	wire [4:0] regMemWriteMuxOutput;
	regMemMux regMemWriteMux (instruction [20:16] /*rt*/, instruction [15:11]/*rd*/, regDest, regMemWriteMuxOutput ); //entrada, entrada, entrada, saida
	regmem regmem(clock, instruction [20:16]/*rt*/ , instruction [25:21] /*rs*/ , regMemWriteMuxOutput , regWriteData , canWriteReg , regMemOut1 , regMemOut2, reset  ); //entrada, entrada, entrada, entrada, entrada, saida, saida
	
	
	//dual output extensor de sinal
	wire [31:0] exImm ; //saida 1 do extensor de sinal (imediato com o sinal extendido)
	wire [31:0] zeroFillImm ; //saida 2 do extensor de sinal (o imediato preenchido com apenas zeros)
	dual_out_sign_extend sign_extend( instruction[15:0] , exImm , zeroFillImm ); //entrada, saida, saida
	
	//Mux do In1 da ULA
	wire [31:0] aluIn1MuxOut ;
	ulaIn1Mux ulaIn1(regMemOut1/*$rt*/ , zeroFillImm , exImm , aluIn1MuxController, aluIn1MuxOut ); //entrada, entrada, entrada, entrada, saida
	
	//Mux do In2 da ULA
	wire [31:0] aluIn2MuxOut ;
	ulaIn2Mux ulaIn2(regMemOut2/*$rs*/ , instruction [10:6] , aluIn2MuxController , aluIn2MuxOut ); //entrada, entrada, entrada, saida
	
	//Ula
	ulaCore ula( aluIn1MuxOut , aluIn2MuxOut , aluOP , aluResult , Zero_flag ); // entrada, entrada, entrada, saida, saida
	
	//dataMem
	wire [31:0] readData;
	dataMem dataMem(clock, aluResult, regMemOut1/*rt*/, memWrite , memRead , readData );
	
	//memToReg mux
	memToRegMux memToRegMux ( readData ,  aluResult , memToReg , regWriteData );
endmodule 