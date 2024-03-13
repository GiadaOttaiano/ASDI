library IEEE;
use IEEE.std_logic_1164.ALL;

entity mux161_tb is
end mux161_tb;

architecture behavioural of mux161_tb is
    component mux161 is
        port(   c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10,
            c11, c12, c13, c14, c15, s0, s1, s2, s3 : in STD_LOGIC;
            y1 : out STD_LOGIC
        );
    end component;

    signal input    : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    signal control  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal output   : STD_LOGIC := '0';

    begin
        uut : mux161
            port map(
                c0 => input(0),
                c1 => input(1),
                c2 => input(2),
                c3 => input(3),
                c4 => input(4),
                c5 => input(5),
                c6 => input(6),
                c7 => input(7),
                c8 => input(8),
                c9 => input(9),
                c10 => input(10),
                c11 => input(11),
                c12 => input(12),
                c13 => input(13),
                c14 => input(14),
                c15 => input(15),
                s0 => control(0),
                s1 => control(1),
                s2 => control(2),
                s3 => control(3),
                y1 => output
            );

        stim_proc : process
        begin
            wait for 100 ns;
            input <= "1000110101101001";

            wait for 10 ns;
            control <= "0000";

            wait for 10 ns;
            control <= "0011";

            wait for 10 ns;
            control <= "0100";

            wait for 10 ns;
            control <= "1000";

            assert output = '0'
            report "errore"
            severity failure;
            wait;
        end process;
end;
