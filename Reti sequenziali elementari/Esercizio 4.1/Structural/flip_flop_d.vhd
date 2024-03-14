library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flip_flop_d is
    port(
        D, clk, rst : in STD_LOGIC;
        Q : out STD_LOGIC
    );
end flip_flop_d;

architecture Behavioral of flip_flop_d is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                Q <= '0';
            else
                Q <= D;
            end if;
        end if;
    end process;
end dataflow;