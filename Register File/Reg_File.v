module Reg_File (
  input wire WrEn,
  input wire RdEn,
  input wire [2:0] Address,
  input wire [15:0] WrData,
  input wire CLK,
  input wire RST,
  output reg [15:0] RdData
  );
  
  reg [15:0] registers [7:0];
  integer index;
  
  always @(posedge CLK or negedge RST)
    begin
      if (!RST)
        begin
          for (index = 0; index < 8; index = index + 1)
            begin
              registers [index] <= 16'b0;
            end
        end
      else if (WrEn)
        begin
          registers [Address] <= WrData;
        end
      else if (RdEn)
        begin
          RdData <= registers [Address];
        end
    end
  
endmodule
