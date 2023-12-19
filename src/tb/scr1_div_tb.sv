module scr1_div_tb();
// Division operations
//
// 31       25 24   20 19   15 14      12 11   7 6         0
// |  funct7  |  rs2  |  rs1  |  funct3  |  rd  |  opcode  |
//       7        5       5        3         5        7
//    MULTDIV  divisor dividend  DIV/REM   dest      OP
//
////

logic       clk   ;
logic [1:0] resp  ;

logic [6:0] opcode;
logic [2:0] funct3;

logic [4:0] divisor;
logic [4:0] dividend;

assign clk    = scr1_top_tb_ahb.i_top.i_imem_ahb.clk;
assign resp   = scr1_top_tb_ahb.i_top.i_imem_ahb.imem_resp;
assign opcode = scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[6:0];
assign funct3 = scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[14:12]; 

assign dividend = scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[19:15]; 
assign divisor  = scr1_top_tb_ahb.i_top.i_imem_ahb.imem_rdata[24:20]; 

always_ff @(posedge clk) begin
    if (resp == 2'b01) begin
        // valid data from ahb router
        if ((opcode == 7'b0110011) && (funct3 == 3'b100)) begin
            // detect DIV command
            $display("DIV command detected. Attributes:\n");
            $display("divisor = %b\n dividend = %b\n", divisor, dividend);
        end
    end
end
    
endmodule 