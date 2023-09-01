module dataMem( address, writeData, memWrite, memRead, readData);

input wire [31:0] address, writeData ;
input wire 			memWrite, memRead ;
output reg [31:0] readData ;
reg [31:0] mainMemory [0:255] ; 

//integer i;
//initial begin
//    for (i = 0; i < memorySize; i = i + 1)
//    begin
//        mainMemory[i] <= 32'b0;
//    end
//end

always @(writeData) begin
    if (memWrite == 1'b1) begin
        mainMemory[address] <= writeData ;
    end
end

always @(writeData) begin
    if (memRead == 1'b1) begin
        readData <= mainMemory[address] ;
    end 
	 else begin
		  readData <= 32'bz ;
	 end	
end

endmodule

