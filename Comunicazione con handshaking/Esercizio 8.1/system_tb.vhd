library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity system_tb is 
end system_tb;

architecture behavioral of system_tb is

    component system is 
        port(
            start, clock, reset : IN std_logic
        );
    end component;

    signal start_tb, clock_tb, reset_tb := '0';
    signal period : time := 10 ns;

    begin

        uut : system
            port map( start_tb, clock_tb, reset_tb );

        clk_process : process
            begin
                while TRUE loop
                    clock_tb <= '1';
                    wait for period/2;
                    clock_tb <= '0';
                    wait for period/2;
                end loop;
            wait;
            end process;

        stim_proc : process
            begin
                reset_tb <= '1';
                wait for 10 ns;
                reset_tb <= '0';
                wait for 10 ns; 
                start_tb <= '1'; 
                wait for 500 ns; 
                start_tb <= '0'; 
                wait for 100 ns; 
                reset_tb <= '1';
                wait for 10 ns;
                wait;
            end process;

end structural;