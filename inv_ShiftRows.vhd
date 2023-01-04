library ieee;
use ieee.std_logic_1164.all;


package inv_ShiftRows_package is

  subtype data128_t is std_logic_vector (127 downto 0);
  function inv_ShiftRows (input : in data128_t)return data128_t;

end package inv_ShiftRows_package;

package body inv_ShiftRows_package is
  
  function inv_ShiftRows (input : in data128_t)return data128_t is
    begin
      return 
    input(127 downto 120) &	input(23 downto 16) & input(47 downto 40) & input(71 downto 64) &
    input(95 downto 88) & input(119 downto 112) & input(15 downto 08) & input(39 downto 32) &
		input(63 downto 56) & input(87 downto 80) & input(111 downto 104) & input(07 downto 00) &
		input(31 downto 24) & input(55 downto 48) & input(79 downto 72) & input(103 downto 96);
end;

end package body inv_ShiftRows_package;
