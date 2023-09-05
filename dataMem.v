//Grupo: Ru-Rural
//integrantes: 
//Pedro Henrique
//Everton da Silva
//Ricardo Pompilio

//memodira de dados (teve que ser sincrona pois a assincrona dava um erro desconhecido)
module dataMem(clk, address, writeData, memWrite, memRead, readData);

input wire [31:0] address, writeData ;
input wire 			memWrite, memRead ;
output wire [31:0] readData ;
reg [31:0] mainMemory [0:255] ; 

input clk;
always @(posedge clk) begin
    if (memWrite == 1'b1) begin
        mainMemory[address] <= writeData ;
    end
end

assign readData = mainMemory[address];

//always @(writeData) begin
//    if (memRead == 1'b1) begin
//        readData <= mainMemory[address] ;
//    end 
//	 else begin
//		  readData <= 32'bz ;
//	 end	
//end

endmodule

