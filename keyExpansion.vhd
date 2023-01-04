library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.sbox_package.all;


package keyExpansion_package is

  type rcon_array is array (integer range <>) of std_logic_vector(7 downto 0) ;
  constant rcon : rcon_array(0 to 9):=(
    X"01", X"02", X"04", X"08", X"10", X"20", X"40", X"80", X"1b", X"36"
  );

  subtype word is std_logic_vector (31 downto 0); 
  subtype key_type is std_logic_vector (127 downto 0);

  function rotWord( b: word)  return word;
  function subWord( a: word)  return word;
  function nextKey (key: key_type ; i: integer)return key_type;
end package keyExpansion_package;
 

package body keyExpansion_package is
 
  function rotWord( b: word)  return word is
     begin
      return  b(23 downto 0) & b(31 downto 24 );   
    end rotWord;

    function subWord( a: word)  return word is
    begin 
      return  
      sbox(a(31 downto 24)) & sbox(a(23 downto 16)) & sbox(a(15 downto 8)) & sbox(a(7 downto 0 ));   
    end subWord;  

  function nextKey (key: key_type; i: integer)return key_type is -- i starts with 0

    variable temp1 : word;
    variable temp2 : word;
    variable temp3 : word;
    variable temp4 : word;
   
  begin
      
      temp1 :=  key(127 downto 96) xor subWord(rotWord(key(31 downto 0))) xor (rcon(i) & x"000000"); 
      temp2 := temp1 xor key(95 downto 64);
      temp3 := temp2 xor key(63 downto 32);
      temp4 := temp3 xor key(31 downto 0);  
      return temp1 & temp2 & temp3 & temp4;
      
    end;

    end package body keyExpansion_package;