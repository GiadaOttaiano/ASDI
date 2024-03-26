library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity omega_network_tb is
end omega_network_tb;

architecture behavioral of omega_network_tb is

    component omega_network is
        port(
            msg0, msg1, msg2, msg3 : IN std_logic_vector(2 downto 0);
            sel : IN std_logic_vector(3 downto 0);
            output : OUT std_logic_vector(3 downto 0)
        );
    end component;

    signal sel_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal msg0_tb, msg1_tb, msg2_tb, msg3_tb : STD_LOGIC_VECTOR(2 downto 0);
    signal output_tb : STD_LOGIC_VECTOR(3 downto 0);

begin
    
    uut: omega_network
        port map (
            sel => sel_tb,
            msg0 => msg0_tb,
            msg1 => msg1_tb,
            msg2 => msg2_tb,
            msg3 => msg3_tb,
            output => output_tb
        );


    stimulus: process
    begin
        -- Test 1
        sel <= "0001";
        msg0 <= "101";
        msg1 <= "010";
        msg2 <= "111";
        msg3 <= "001";
        wait for 50 ns;

        -- Test 2
        sel <= "1010";
        msg0 <= "011";
        msg1 <= "100";
        msg2 <= "001";
        msg3 <= "110";
        wait for 50 ns;
        wait;
    end process;

end behavioral;