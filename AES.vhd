library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.keyExpansion_package.all;
use work.MixColumns_package.all;
use work.ShiftRows_package.all;
use work.SubBytes_package.all;

--use work.inv_MixColumns_package.all;
--use work.inv_ShiftRows_package.all;
--use work.inv_SubBytes_package.all;

entity AES is
	port (
			 i_clock  : in std_logic;
			 i_op  : in std_logic_vector (1 downto 0);
			 i_key  : in std_logic_vector (127 downto 0);
			 i_data  : in std_logic_vector (127 downto 0);
			 i_start : in std_logic;
			 o_data : out std_logic_vector (127 downto 0);
			 o_done : out std_logic;
			 o_active :out std_logic

   ) ;
end AES;
--00112233445566778899aabbccddeeff000102030405060708090a0b0c0d0e0f01
architecture arch of AES is

--	signal i_clock : std_logic:='0';
--	signal i_op : std_logic_vector (1 downto 0) := "01";
--	signal i_key : std_logic_vector (127 downto 0) := x"000102030405060708090a0b0c0d0e0f";
----	signal i_data : std_logic_vector (127 downto 0) := x"69c4e0d86a7b0430d8cdb78070b4c55a"; -- cipher
--	signal i_data : std_logic_vector (127 downto 0) := x"00112233445566778899aabbccddeeff"; --plain text
--	signal i_start : std_logic;
--	signal o_data : std_logic_vector (127 downto 0);
--	signal o_done : std_logic;
--	signal o_active : std_logic;
  

  subtype data128_t is std_logic_vector (127 downto 0);

  type operation_t is (idle, enc, clean_up);
  signal operation : operation_t := idle;
  
  type step_t is (init, for_loop, finale);
  signal step : step_t := init;

  signal iteration : integer range 0 to 15 := 0;

--	type key_array_t is array (0 to 10) of data128_t;
--	signal key_array : key_array_t;
	 

begin
-- i_clock <= not i_clock after 10 ns;

  aes_p : process( i_clock )
    variable state : data128_t;
	 variable key : data128_t;
  begin
    if(rising_edge(i_clock))then
		case (operation) is
			when idle =>
				o_done <= '0';
				o_active <= '0';

				if(i_start = '1')then
					o_active <= '1';
					iteration <= 0;
					case( i_op ) is				
						when "01" => operation <= enc;
						when others => operation <= clean_up;
					end case ;
				end if;			

			when enc =>
				case( step ) is
				  when init =>
					 key := i_key;
					 state := i_data xor key;
					 step <= for_loop;
					-- iteration <= 1;

				  when for_loop =>
					 state := subBytes(state);
					 state := shiftRows(state);
					 state := mixColumns(state);
					 key := nextKey(key, iteration);
					 state :=  key xor state;
					 if(iteration = 8)then
						step <= finale;
					 else
						iteration <= iteration + 1;
					 end if;

				  when finale =>
					 state := subBytes(state);
					 state := shiftRows(state);
					 key := nextKey(key, iteration+1);
					 state :=  key xor state;
					 o_data <= state;
					 operation <= clean_up;
				end case; --step

				
		  when clean_up =>
			 o_done <= '1';
			 step <= init;
			 operation <= idle;

		end case ;--operation
    end if;
  end process ; -- aes_p
 
-- stop_p : process
-- begin
--		wait until rising_edge(i_clock);
--		wait until rising_edge(i_clock);
--		wait until rising_edge(i_clock);
--		i_start <= '1';
--		wait until rising_edge(i_clock);
--		i_start <= '0';
--
--   	wait for 1000 ns;
--   	report "END" severity failure;
-- end process ; -- stop_p

end arch;