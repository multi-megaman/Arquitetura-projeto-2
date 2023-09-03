//banco de registradores (por motivos de "eu inverti as entradas da ULA" o readReg1 fica com o $rs e o readReg2 fica com o $rt)
module regmem(clk, readReg1 , readReg2 , writeReg , writeData , canWrite , outputData1 , outputData2 );
	parameter MEM_WIDTH = 32;
	parameter DATA_WIDTH = 32;
	
	input wire [4:0]  readReg1, readReg2, writeReg;
	input wire [31:0] writeData;
	input wire        canWrite;
	input wire 			clk;
	output reg [31:0] outputData1, outputData2;
	
	reg [(DATA_WIDTH - 1): 0] regMemory [0: (MEM_WIDTH - 1)];
	


//	// Iniciando alguns registradores com alguns valores (PARA TESTES APENAS) (se for testar isso, comentar a parte de escrever na memoria, esse procedimento so pode ser feito em uma ROM, nao em uma RAM)
//	initial begin
//		$readmemb("D:/GitHub/Arquitetura-projeto-2/regMemTest.list", regMemory);
//
//	end
	
	
	always @(readReg1 or clk) begin
		outputData1 <= regMemory[ readReg1 ];

	end
	
	always @(readReg2 or clk) begin
		outputData2 <= regMemory[ readReg2 ];

	end
	
	always @(posedge clk) begin
		if (canWrite) begin
			regMemory[writeReg] <= writeData;
		end
	end
	

endmodule 

module regMemMux ( rt , rd , regDest , regMemMuxOutput );
	input wire [4:0] rt, rd;
	input wire       regDest;
	output reg [4:0] regMemMuxOutput;
	always @(*) begin
		case (regDest)
			1'b0: regMemMuxOutput <= rt;
			1'b1: regMemMuxOutput <= rd;
		endcase
	end
endmodule 