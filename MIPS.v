
module MIPS (instruction, result, Zero_flag);
	// OPcode =  instruction [31:26]
	// func = instruction [5:0]
	// rt = instruction [20:16]
	// rs =  instruction [25:21]
	// rd = instruction [15:11]
	// shamt = instruction [10:6]
	// imm = instruction [15:0]
	input wire [31:0] instruction ; //instrucao de 32 bits (por agora eh apenas para testar a ALU)
	output wire [31:0] result ;
	output Zero_flag ;
	
	//Valores de testes
	//instrucao de exemplo de add $rs + $rt     = 000000 00001 00010 11111 010101 00000 -> resultado deve ser a soma de de R[$rs] com R[$rt]
	//instrucao de exemplo de lui {imm, 0x0000} = 001111 11111 00000 1001001011000011 -> resultado deve ser os 16 ultimos bits + 16'b0
	wire [31:0] rt = 32'b00000000000000000000000000000010 ;
	wire [31:0] rs = 32'b00000000000000000000000000000011 ; 
	
	//testes para as entradas do banco de registradores
	wire [4:0] rtMem = 5'b00101;
	wire [4:0] rsMem = 5'b00001;
	wire [4:0] rdMem = 5'b00010;
	wire [31:0] writeData = 32'b00000000000000000000000000011111 ;
	
	//testes para sinais do controlador
	wire 		  canWrite = 1'b1; //1 = true
	wire       regDest =  1'b0; //0 = rt
	
	
	//Controlador central (controlador do MIPS e da ULA)
	wire [1:0] aluIn1MuxController ;
	wire       aluIn2MuxController ;
	wire [3:0] aluOP ;
	control control( instruction[31:26] , instruction[5:0] , aluIn1MuxController, aluIn2MuxController , aluOP ); //entrada, entrada, saida, saida, saida
	
	//Banco de registradores
	wire [31:0] regMemOut1, regMemOut2;
	wire [4:0] regMemWriteMuxOutput;
	regMemMux regMemWriteMux (instruction [20:16] /*rt*/, instruction [15:11]/*rd*/, regDest, regMemWriteMuxOutput ); //entrada, entrada, entrada, saida
	regmem regmem( instruction [20:16]/*rt*/ , instruction [25:21] /*rs*/ , regMemWriteMuxOutput , writeData , canWrite , regMemOut1 , regMemOut2  ); //entrada, entrada, entrada, entrada, entrada, saida, saida
	
	
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
	

	ulaCore ula( aluIn1MuxOut , aluIn2MuxOut , aluOP , result , Zero_flag ); // entrada, entrada, entrada, saida, saida
endmodule 