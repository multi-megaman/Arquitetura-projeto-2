//Grupo: Ru-Rural
//integrantes: 
//Pedro Henrique
//Everton da Silva
//Ricardo Pompilio

//extensor de sinal com duas saidas, o imediato com o sinal extendido e o imediato extendido apenas com zeros
module dual_out_sign_extend (
    imm, outExtended, outImm
);

input wire [15:0] imm;
output reg [31:0] outExtended;
output reg [31:0] outImm;

always @(*) begin
    outExtended <= {{16{imm[15]}}, imm};
	 outImm <= {16'b0, imm};
end

endmodule