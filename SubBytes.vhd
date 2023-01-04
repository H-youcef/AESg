library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.sbox_package.all;

package SubBytes_package is
  subtype data128_t is std_logic_vector (127 downto 0);
  function subBytes (input : in data128_t)return data128_t;
end package SubBytes_package;

package body SubBytes_package is

  function SubBytes (input : in data128_t)return data128_t is
    begin
      return 
            sbox(input(127 downto 120)) & sbox(input(119 downto 112)) & sbox(input(111 downto 104)) & 
            sbox(input(103 downto 96)) & sbox(input(95 downto 88)) & sbox(input(87 downto 80)) & 
            sbox(input(79 downto 72)) & sbox(input(71 downto 64)) & sbox(input(63 downto 56)) & 
            sbox(input(55 downto 48)) & sbox(input(47 downto 40)) & sbox(input(39 downto 32)) & 
            sbox(input(31 downto 24)) & sbox(input(23 downto 16)) & sbox(input(15 downto 08)) & 
            sbox(input(07 downto 00));
    end;
    
  end package body SubBytes_package;
