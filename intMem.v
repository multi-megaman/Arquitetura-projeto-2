//Grupo: Ru-Rural
//integrantes: 
//Pedro Henrique
//Everton da Silva
//Ricardo Pompilio

//Memoria ROM onde as instrucoes ficam armazenadas
module intMem (clk, address, instruction);
   parameter MEM_WIDTH = 64;
	parameter DATA_WIDTH = 32;
	
	input wire clk;
	input wire [31:0] address;
	output reg [31:0] instruction;
	
	reg [(DATA_WIDTH - 1): 0] intMemory [0: (MEM_WIDTH - 1)];
	
	//	// Iniciando alguns registradores com alguns valores (PARA TESTES APENAS) (se for testar isso, comentar a parte de escrever na memoria, esse procedimento so pode ser feito em uma ROM, nao em uma RAM)
		initial begin
//			$readmemb("C:/Users/ricar/Desktop/Faculdade/Arquitetura-projeto-2/instruction.list", intMemory);
			$readmemb("D:/GitHub/Arquitetura-projeto-2/instruction.list", intMemory);
	
		end
	
	
	always @(*) begin
	    instruction <= intMemory[address];
	end
	

endmodule