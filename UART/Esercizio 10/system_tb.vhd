library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity system_tb is
end system_tb;

architecture behavioral of system_tb is
    component system is
        port(
            start, clock, reset : IN std_logic;
        );
    end component;
end behavioral;