library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity system is
    port(
        start, clock, reset : IN std_logic;
    )
end system;

architecture structural of system is
    component unit_A is
        port(
            A_start, A_receive, A_clock, A_reset: IN std_logic;
            A_send, A_out : OUT std_logic
        );
    end component;

    component unit_B is
        port(
            B_in, B_start, B_send, B_clock, B_reset: IN std_logic;
            B_receive : OUT std_logic
        );
    end component;

    signal temp_out, temp_send, temp_receive : std_logic := '0'; 

    begin
        UA : unit_A
            port map(
                A_start => start,
                A_receive => temp_receive,
                A_clock => clock,
                A_reset => reset,
                A_send => temp_send,
                A_out => temp_out
            );
        
        UB : unit_B
            port map(
                B_in => temp_out,
                B_start => start,
                B_send => temp_send,
                B_clock => clock,
                B_reset => reset,
                B_receive => temp_receive
            );
end structural;