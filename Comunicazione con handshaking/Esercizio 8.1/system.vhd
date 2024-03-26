library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity system is
    port(
        start, clock, reset : IN std_logic
    );
end system;

architecture structural of system is

    component nodeA is
        port(
            start_A, clock_A, reset_A : IN std_logic;
            ACK_A : IN std_logic;
            DATA_READY_A : OUT std_logic;
            data : OUT std_logic_vector(7 downto 0)
        );
    end component;

    component nodeB is
        port(
            start_B, clock_B, reset_B : IN std_logic;
            data : IN std_logic_vector(7 downto 0);
            DATA_READY_B : IN std_logic;
            ACK_B : OUT std_logic
        );
    end component;

    signal ACK, DATA_READY : std_logic;
    signal temp_data : std_logic_vector(7 downto 0);

    begin
        A : nodeA
            port map(
                start_A => start,
                clock_A => clock,
                reset_A => reset,
                ACK_A => ACK,
                DATA_READY_A => DATA_READY,
                data => temp_data
            );

        B : nodeB
            port map(
                start_B => start,
                clock_B => clock,
                reset_B => reset,
                data => temp_data,
                DATA_READY_B => DATA_READY,
                ACK_B => ACK
            );
end structural;