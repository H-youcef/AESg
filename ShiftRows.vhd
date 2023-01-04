library ieee;
use ieee.std_logic_1164.all;


package ShiftRows_package is

  subtype data128_t is std_logic_vector (127 downto 0);
  function ShiftRows (input : in data128_t)return data128_t;

end package ShiftRows_package;

package body ShiftRows_package is
  
  function ShiftRows (input : in data128_t)return data128_t is
    begin
      return 
        input(127 downto 120) &	input(87 downto 80) & input(47 downto 40) & input(07 downto 00) &
        input(95 downto 88) & input(55 downto 48) & input(15 downto 08) & input(103 downto 96) &
        input(63 downto 56) & input(23 downto 16) & input(111 downto 104) & input(71 downto 64) &
        input(31 downto 24) & input(119 downto 112) & input(79 downto 72) & input(39 downto 32);
    end;

end package body ShiftRows_package;
