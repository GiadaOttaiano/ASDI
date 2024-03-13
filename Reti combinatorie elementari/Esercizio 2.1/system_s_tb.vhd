library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity system_s_tb is
end system_s_tb;

architecture behavioral of system_s_tb is
    component system_s is
        port(
            s_input : in STD_LOGIC_VECTOR(3 downto 0);
            s_output : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal input : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');
    signal output : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');

    begin
        uut: system_s
            port map(
                s_input => input,
                s_output => output
            );

        stim_proc : process
        begin
            wait for 100 ns;
            wait for 100 ns;
            input <= "1100";
            wait for 10 ns;
            input <= "0011";
            wait for 10 ns;
            input <= "1010";
            wait for 10 ns;
            wait;
        end process;

end behavioral;