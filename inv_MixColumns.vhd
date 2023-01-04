library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package inv_MixColumns_package is

  subtype data128_t is std_logic_vector (127 downto 0);
  subtype slv is std_logic_vector (7 downto 0);
  function xtime( a: slv)  return slv; 
  function multiply( x: slv; y: slv)  return slv;
  function inv_MixColumns (input : in data128_t)return data128_t;
  function bit_to_byte(x: std_logic)  return slv;
  
end package inv_MixColumns_package;

package body inv_MixColumns_package is

  function bit_to_byte(x: std_logic)  return slv is
    begin
      return x&x&x&x&x&x&x&x;
    end bit_to_byte;
  
  function xtime( a: slv)  return slv is
  begin
    --((x<<1) ^ (((x>>7) & 1) * 0x1b));
    return std_logic_vector (shift_left(unsigned(a), 1)) xor ("000"& a(7) & a(7) & '0' & a(7) & a(7));
  end xtime; 

  

  function multiply( x: slv; y: slv)  return slv is
    begin
      return ( bit_to_byte(x(0)) and y ) xor
             ( bit_to_byte(x(1)) and xtime(y) ) xor
             ( bit_to_byte(x(2)) and xtime(xtime(y)) ) xor
             ( bit_to_byte(x(3)) and xtime(xtime(xtime(y))) ) xor
             ( bit_to_byte(x(4)) and xtime(xtime(xtime(xtime(y)))) );
             
      end multiply; 
    
  function inv_MixColumns (input : in data128_t)return data128_t is
    variable input1 : std_logic_vector (31 downto 0);
    variable input2 : std_logic_vector (31 downto 0);
    variable input3 : std_logic_vector (31 downto 0);
    variable input4 : std_logic_vector (31 downto 0);
    variable output1 : std_logic_vector (31 downto 0);
    variable output2 : std_logic_vector (31 downto 0);
    variable output3 : std_logic_vector (31 downto 0);
    variable output4 : std_logic_vector (31 downto 0);
    begin
         
      input1:=input(127 downto 96) ;
      output1(31 downto 24) := multiply (x"0e",input1(31 downto 24)) xor multiply(x"0b",input1(23 downto 16)) xor multiply(x"0d",input1(15 downto 8)) xor multiply(x"09",input1(7 downto 0));
      output1(23 downto 16) := multiply (x"09",input1(31 downto 24)) xor multiply(x"0e",input1(23 downto 16)) xor multiply(x"0b",input1(15 downto 8)) xor multiply(x"0d",input1(7 downto 0));
      output1(15 downto 8) := multiply (x"0d",input1(31 downto 24)) xor multiply(x"09",input1(23 downto 16)) xor multiply(x"0e",input1(15 downto 8)) xor multiply(x"0b",input1(7 downto 0));
      output1(7 downto 0)  := multiply (x"0b",input1(31 downto 24)) xor multiply(x"0d",input1(23 downto 16)) xor multiply(x"09",input1(15 downto 8)) xor multiply(x"0e",input1(7 downto 0));
      input2:=input(95 downto 64) ;
      output2(31 downto 24) := multiply (x"0e",input2(31 downto 24)) xor multiply(x"0b",input2(23 downto 16)) xor multiply(x"0d",input2(15 downto 8)) xor multiply(x"09",input2(7 downto 0));
      output2(23 downto 16) := multiply (x"09",input2(31 downto 24)) xor multiply(x"0e",input2(23 downto 16)) xor multiply(x"0b",input2(15 downto 8)) xor multiply(x"0d",input2(7 downto 0));
      output2(15 downto 8) := multiply (x"0d",input2(31 downto 24)) xor multiply(x"09",input2(23 downto 16)) xor multiply(x"0e",input2(15 downto 8)) xor multiply(x"0b",input2(7 downto 0));
      output2(7 downto 0)  := multiply (x"0b",input2(31 downto 24)) xor multiply(x"0d",input2(23 downto 16)) xor multiply(x"09",input2(15 downto 8)) xor multiply(x"0e",input2(7 downto 0));
      input3:=input(63 downto 32) ; 
      output3(31 downto 24) := multiply (x"0e",input3(31 downto 24)) xor multiply(x"0b",input3(23 downto 16)) xor multiply(x"0d",input3(15 downto 8)) xor multiply(x"09",input3(7 downto 0));
      output3(23 downto 16) := multiply (x"09",input3(31 downto 24)) xor multiply(x"0e",input3(23 downto 16)) xor multiply(x"0b",input3(15 downto 8)) xor multiply(x"0d",input3(7 downto 0));
      output3(15 downto 8) := multiply (x"0d",input3(31 downto 24)) xor multiply(x"09",input3(23 downto 16)) xor multiply(x"0e",input3(15 downto 8)) xor multiply(x"0b",input3(7 downto 0));
      output3(7 downto 0)  := multiply (x"0b",input3(31 downto 24)) xor multiply(x"0d",input3(23 downto 16)) xor multiply(x"09",input3(15 downto 8)) xor multiply(x"0e",input3(7 downto 0));
      input4:=input(31 downto 0) ; 
      output4(31 downto 24) := multiply (x"0e",input4(31 downto 24)) xor multiply(x"0b",input4(23 downto 16)) xor multiply(x"0d",input4(15 downto 8)) xor multiply(x"09",input4(7 downto 0));
      output4(23 downto 16) := multiply (x"09",input4(31 downto 24)) xor multiply(x"0e",input4(23 downto 16)) xor multiply(x"0b",input4(15 downto 8)) xor multiply(x"0d",input4(7 downto 0));
      output4(15 downto 8) := multiply (x"0d",input4(31 downto 24)) xor multiply(x"09",input4(23 downto 16)) xor multiply(x"0e",input4(15 downto 8)) xor multiply(x"0b",input4(7 downto 0));
      output4(7 downto 0)  := multiply (x"0b",input4(31 downto 24)) xor multiply(x"0d",input4(23 downto 16)) xor multiply(x"09",input4(15 downto 8)) xor multiply(x"0e",input4(7 downto 0));
      return output1 & output2 & output3 & output4;
    
  end;

  end package body inv_MixColumns_package;