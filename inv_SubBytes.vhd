library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.inv_sbox_package.all;

package inv_SubBytes_package is
  subtype data128_t is std_logic_vector (127 downto 0);
  function inv_subBytes (input : in data128_t)return data128_t;
end package inv_SubBytes_package;

package body inv_SubBytes_package is
  function inv_SubBytes (input : in data128_t)return data128_t is
    begin
      return 
            inv_sbox(input(127 downto 120)) & inv_sbox(input(119 downto 112)) & inv_sbox(input(111 downto 104)) & 
            inv_sbox(input(103 downto 96)) & inv_sbox(input(95 downto 88)) & inv_sbox(input(87 downto 80)) & 
            inv_sbox(input(79 downto 72)) & inv_sbox(input(71 downto 64)) & inv_sbox(input(63 downto 56)) & 
            inv_sbox(input(55 downto 48)) & inv_sbox(input(47 downto 40)) & inv_sbox(input(39 downto 32)) & 
            inv_sbox(input(31 downto 24)) & inv_sbox(input(23 downto 16)) & inv_sbox(input(15 downto 08)) & 
            inv_sbox(input(07 downto 00));
    end;
    
  end package body inv_SubBytes_package;
