library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package MixColumns_package is

  subtype data128_t is std_logic_vector (127 downto 0);
  subtype slv is std_logic_vector (7 downto 0);
  function xtime( a: slv)  return slv; 
  function MixColumns (input : in data128_t)return data128_t;
  
end package MixColumns_package;

package body MixColumns_package is

  function xtime( a: slv)  return slv is
    begin
      --((x<<1) ^ (((x>>7) & 1) * 0x1b));
      return std_logic_vector (shift_left(unsigned(a), 1)) xor ("000"& a(7) & a(7) & '0' & a(7) & a(7));
    
      end xtime; 
    
  function MixColumns (input : in data128_t)return data128_t is
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
      output1(31 downto 24) := xtime(input1(31 downto 24)) xor xtime(input1(23 downto 16)) xor input1(23 downto 16) xor input1(15 downto 8) xor input1(7 downto 0);
      output1(23 downto 16) := xtime(input1(23 downto 16)) xor xtime(input1(15 downto 8)) xor input1(15 downto 8) xor input1(31 downto 24) xor input1(7 downto 0);
      output1(15 downto 8) := xtime(input1(15 downto 8)) xor xtime(input1(7 downto 0)) xor input1(7 downto 0) xor input1(31 downto 24) xor input1(23 downto 16);
      output1(7 downto 0)  := xtime(input1(7 downto 0)) xor xtime(input1(31 downto 24))  xor input1(31 downto 24) xor input1(23 downto 16) xor input1(15 downto 8);
      input2:=input(95 downto 64) ;
      output2(31 downto 24) := xtime(input2(31 downto 24)) xor xtime(input2(23 downto 16)) xor input2(23 downto 16) xor input2(15 downto 8) xor input2(7 downto 0);
      output2(23 downto 16) := xtime(input2(23 downto 16)) xor xtime(input2(15 downto 8)) xor input2(15 downto 8) xor input2(31 downto 24) xor input2(7 downto 0);
      output2(15 downto 8) := xtime(input2(15 downto 8)) xor xtime(input2(7 downto 0)) xor input2(7 downto 0) xor input2(31 downto 24) xor input2(23 downto 16);
      output2(7 downto 0)  := xtime(input2(7 downto 0)) xor xtime(input2(31 downto 24))  xor input2(31 downto 24) xor input2(23 downto 16) xor input2(15 downto 8);
      input3:=input(63 downto 32) ; 
      output3(31 downto 24) := xtime(input3(31 downto 24)) xor xtime(input3(23 downto 16)) xor input3(23 downto 16) xor input3(15 downto 8) xor input3(7 downto 0);
      output3(23 downto 16) := xtime(input3(23 downto 16)) xor xtime(input3(15 downto 8)) xor input3(15 downto 8) xor input3(31 downto 24) xor input3(7 downto 0);
      output3(15 downto 8) := xtime(input3(15 downto 8)) xor xtime(input3(7 downto 0)) xor input3(7 downto 0) xor input3(31 downto 24) xor input3(23 downto 16);
      output3(7 downto 0)  := xtime(input3(7 downto 0)) xor xtime(input3(31 downto 24))  xor input3(31 downto 24) xor input3(23 downto 16) xor input3(15 downto 8);
      input4:=input(31 downto 0) ; 
      output4(31 downto 24) := xtime(input4(31 downto 24)) xor xtime(input4(23 downto 16)) xor input4(23 downto 16) xor input4(15 downto 8) xor input4(7 downto 0);
      output4(23 downto 16) := xtime(input4(23 downto 16)) xor xtime(input4(15 downto 8)) xor input4(15 downto 8) xor input4(31 downto 24) xor input4(7 downto 0);
      output4(15 downto 8) := xtime(input4(15 downto 8)) xor xtime(input4(7 downto 0)) xor input4(7 downto 0) xor input4(31 downto 24) xor input4(23 downto 16);
      output4(7 downto 0)  := xtime(input4(7 downto 0)) xor xtime(input4(31 downto 24))  xor input4(31 downto 24) xor input4(23 downto 16) xor input4(15 downto 8);
      return output1 & output2 & output3 & output4;
      


        -- xtime(input(127 downto 120)) xor xtime(input(119 downto 112)) xor input(119 downto 112) xor input(111 downto 104) xor input(103 downto 96) &
        -- xtime(input(119 downto 112)) xor xtime(input(111 downto 104)) xor input(111 downto 104) xor input(127 downto 120) xor input(103 downto 96) &
        -- xtime(input(111 downto 104)) xor xtime(input(103 downto 96)) xor input(103 downto 96) xor input(127 downto 120) xor input(119 downto 112) &
        -- xtime(input(103 downto 96)) xor xtime(input(127 downto 120))  xor input(127 downto 120) xor input(119 downto 112) xor input(111 downto 104) &
        -- xtime(input(95 downto 88)) xor xtime(input(87 downto 80)) xor input(87 downto 80) xor input(79 downto 72) xor input(71 downto 64) &
        -- xtime(input(87 downto 80)) xor xtime(input(79 downto 72)) xor input(79 downto 72) xor input(95 downto 88) xor input(71 downto 64) &
        -- xtime(input(79 downto 72)) xor xtime(input(71 downto 64)) xor input(71 downto 64) xor input(95 downto 88) xor input(87 downto 80) &
        -- xtime(input(71 downto 64)) xor xtime(input(95 downto 88))  xor input(95 downto 88) xor input(87 downto 80) xor input(79 downto 72) &
        -- xtime(input(63 downto 56)) xor xtime(input(55 downto 48)) xor input(55 downto 48) xor input(47 downto 40) xor input(39 downto 32) &
        -- xtime(input(55 downto 48)) xor xtime(input(47 downto 40)) xor input(47 downto 40) xor input(63 downto 56) xor input(39 downto 32) &
        -- xtime(input(47 downto 40)) xor xtime(input(39 downto 32)) xor input(39 downto 32) xor input(63 downto 56) xor input(55 downto 48) &
        -- xtime(input(39 downto 32)) xor xtime(input(63 downto 56))  xor input(63 downto 56) xor input(55 downto 48) xor input(47 downto 40) &
        -- xtime(input(31 downto 24)) xor xtime(input(23 downto 16)) xor input(23 downto 16) xor input(15 downto 8) xor input(7 downto 0) &
        -- xtime(input(23 downto 16)) xor xtime(input(15 downto 8)) xor input(15 downto 8) xor input(31 downto 24) xor input(7 downto 0) &
        -- xtime(input(15 downto 8)) xor xtime(input(7 downto 0)) xor input(7 downto 0) xor input(31 downto 24) xor input(23 downto 16) &
        -- xtime(input(7 downto 0)) xor xtime(input(31 downto 24))  xor input(31 downto 24) xor input(23 downto 16) xor input(15 downto 8);


  end;

  end package body MixColumns_package;