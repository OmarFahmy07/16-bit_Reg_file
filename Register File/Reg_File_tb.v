`timescale 1 us / 1 ns

module Reg_File_tb();
  
  reg WrEn_tb, RdEn_tb;
  reg [2:0] Address_tb;
  reg [15:0] WrData_tb;
  reg CLK_tb, RST_tb;
  wire [15:0] RdData_tb;
  
  Reg_File DUT (
  .WrEn(WrEn_tb),
  .RdEn (RdEn_tb),
  .Address (Address_tb),
  .WrData (WrData_tb),
  .CLK (CLK_tb),
  .RST (RST_tb),
  .RdData (RdData_tb)
  );
  
  always #5 CLK_tb = ~CLK_tb;
  
  initial
    begin
      $dumpvars;
      $dumpfile("Reg_File.vcd");
      CLK_tb = 1'b0;
      RST_tb = 1'b1;
      WrEn_tb = 1'b0;
      RdEn_tb = 1'b0;
      WrData_tb = 16'b0;
      Address_tb = 3'b0;
      
      // Reset all registers
      #7
      RST_tb = 1'b0;
      
      // Write the value 17 in register 1
      #7
      RST_tb = 1'b1;
      WrData_tb = 16'd17;
      WrEn_tb = 1'b1;
      Address_tb = 16'd1;
      
      // Read register 1 to make sure that the value 17 is written
      #10
      WrEn_tb = 1'b0;
      RdEn_tb = 1'b1;
      #2
      if (RdData_tb == 16'd17)
        $display("Test case 1 passed");
      else if (RdData_tb == 16'd0)
        $display("Test case 1 failed");
      else
        $display("Unexpected behavior");
        
      // Write the value 10 in register 4
      #8
      WrData_tb = 16'd10;
      WrEn_tb = 1'b1;
      Address_tb = 16'd4;
      #2
      RdEn_tb = 1'b1;
      WrEn_tb = 1'b0;
      #10
      if (RdData_tb == 16'd10)
        $display("Test case 2 passed");
      else if (RdData_tb == 16'd0)
        $display("Test case 2 failed");
      else
        $display("Unexpected behavior");
        
      // Test that data is not written if write enable is low
      WrEn_tb = 1'b0;
      RdEn_tb = 1'b0;
      WrData_tb = 16'd15;
      #10
      RdEn_tb = 1'b1;
      #10
      if (RdData_tb == 16'd10)
        $display("Test case 3 passed");
      else if (RdData_tb == 16'd15)
        $display("Test case 3 failed");
      else
        $display("Unexpected behavior");
        
      // Test that data is not read if read enable is low
      RdEn_tb = 1'b0;
      Address_tb = 3'd1;
      #10
      if (RdData_tb == 16'd10)
        $display("Test case 4 passed");
      else if (RdData_tb == 16'd17)
        $display("Test case 4 failed");
      else
        $display("Unexpected behavior");
        
      $finish;
    end
  
endmodule
