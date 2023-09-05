//Grupo: Ru-Rural
//integrantes: 
//Pedro Henrique
//Everton da Silva
//Ricardo Pompilio

//Mux que define qual vai ser o dado que vai ser escrito no regmem
module memToRegMux(readData, aluResult, memToReg, memToRegOutput, nextPC);
	input wire [31:0] readData, aluResult, nextPC;
	input wire [1:0]	memToReg;
	output reg [31:0] memToRegOutput ;
	
	always@(*) begin
		case (memToReg)
			2'b00: memToRegOutput <= aluResult;
			2'b01: memToRegOutput <= readData;
			2'b10: memToRegOutput <= nextPC;
			default: memToRegOutput <= 32'bz;
		endcase
	end

endmodule 