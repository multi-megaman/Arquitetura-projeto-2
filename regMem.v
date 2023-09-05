//Grupo: Ru-Rural
//integrantes: 
//Pedro Henrique
//Everton da Silva
//Ricardo Pompilio

//banco de registradores (por motivos de "eu inverti as entradas da ULA" o readReg1 fica com o $rs e o readReg2 fica com o $rt)
module regmem(clk, readReg1 , readReg2 , writeReg , writeData , canWrite , outputData1 , outputData2, reset );
	parameter MEM_WIDTH = 32;
	parameter DATA_WIDTH = 32;
	
	input wire [4:0]  readReg1, readReg2, writeReg;
	input wire [31:0] writeData;
	input wire        canWrite;
	input wire 			clk,reset;
	output reg [31:0] outputData1, outputData2;
	
	reg [(DATA_WIDTH - 1): 0] regMemory [0: (MEM_WIDTH - 1)];
	integer r = 0;


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
		if (reset) begin
			for(r=0;r<32;r=r+1) begin
            regMemory[r] <= 32'B0;
            end
       end 
		 else begin
		if (canWrite) begin
			regMemory[writeReg] <= writeData;
			regMemory[0] <= 0; //$0 sempre 0
		end
		end
	end
	

endmodule 

//Mux que define qual vai ser o registrador destino do valor a ser escrito na regMem
module regMemMux ( rt , rd , regDest , regMemMuxOutput );
	input wire [4:0] rt, rd;
	input wire [1:0] regDest;
	output reg [4:0] regMemMuxOutput;
	always @(*) begin
		case (regDest)
			2'b00: regMemMuxOutput <= rt;
			2'b01: regMemMuxOutput <= rd;
			2'b10: regMemMuxOutput <= 5'b11111;
		endcase
	end
endmodule 