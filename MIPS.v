
module MIPS (instruction, result, Zero_flag);
	// OPcode =  instruction [31:26]
	// func = instruction [5:0]
	// rt = instruction [20:16]
	// rs =  instruction [25:21]
	// shamt = instruction [10:6]
	// imm = instruction [15:0]
	input wire [31:0] instruction ; //instrucao de 32 bits (por agora eh apenas para testar a ALU)
	output wire [31:0] result ;
	output Zero_flag ;
	
	//Valores de testes
	//instrucao de exemplo de add $rs + $rt = 00000011111000001111101010100000 -> resultado deve ser a soma de de R[$rs] com R[$rt]
	wire [31:0] rt = 32'b00000000000000000000000000000010 ;
	wire [31:0] rs = 32'b00000000000000000000000000000011 ; 
	
	
	//Controlador central (controlador do MIPS e da ULA)
	wire [1:0] aluIn1MuxController ;
	wire       aluIn2MuxController ;
	wire [3:0] aluOP ;
	control control(instruction[31:26] , instruction[5:0] , aluIn1MuxController, aluIn2MuxController , aluOP ); //entrada, entrada, saida, saida, saida
	
	//dual output extensor de sinal
	wire [31:0] exImm ; //saida 1 do extensor de sinal (imediato com o sinal extendido)
	wire [31:0] zeroFillImm ; //saida 2 do extensor de sinal (o imediato preenchido com apenas zeros)
	dual_out_sign_extend sign_extend( instruction[15:0] , exImm , zeroFillImm ); //entrada, saida, saida
	
	//Mux do In1 da ULA
	wire [31:0] aluIn1MuxOut ;
	ulaIn1Mux ulaIn1(rt , zeroFillImm , exImm , aluIn1MuxController, aluIn1MuxOut ); //entrada, entrada, entrada, entrada, saida
	
	//Mux do In2 da ULA
	wire [31:0] aluIn2MuxOut ;
	ulaIn2Mux ulaIn2(rs , instruction [10:6] , aluIn2MuxController , aluIn2MuxOut ); //entrada, entrada, entrada, saida
	
	ulaCore ula( aluIn1MuxOut , aluIn2MuxOut , aluOP , result , Zero_flag ); // entrada, entrada, entrada, saida, saida
endmodule 