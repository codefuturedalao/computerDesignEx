`timescale 1ns/1ns
module system_tb(
  );
  
  reg sysclk;
  reg rst;
  SYSTEM mySYSTEM(sysclk,rst);
  
  initial sysclk = 0;
  always #5 sysclk = ~sysclk;
  
  initial
    begin
      rst <= 0;
      #10 rst <= 1;
      #10 rst <= 0;
    end
endmodule
