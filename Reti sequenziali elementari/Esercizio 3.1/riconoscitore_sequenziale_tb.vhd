LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY riconoscitore_sequenziale_tb IS
END riconoscitore_sequenziale_tb;

ARCHITECTURE behavioral OF riconoscitore_sequenziale_tb IS

    SIGNAL input : STD_LOGIC := 'U';
    SIGNAL mode : STD_LOGIC := 'U';
    SIGNAL temp : STD_LOGIC;
    SIGNAL output : STD_LOGIC := 'U';

    COMPONENT riconoscitore_sequenziale IS
        PORT (
            rs_input : IN STD_LOGIC;
            rs_mode : IN STD_LOGIC;
            rs_temp : IN STD_LOGIC;
            rs_output : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    uut : riconoscitore_sequenziale
    PORT MAP(
        rs_input => input,
        rs_mode => mode,
        rs_temp => temp,
        rs_output => output
    );

    temp_process : PROCESS
    BEGIN
        temp <= '0';
        WAIT FOR 5 ns;
        temp <= '1';
        WAIT FOR 5 ns;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        input <= '0';
        mode <= '0';
        WAIT FOR 10 ns;

        input <= '1';
        mode <= '0';
        WAIT FOR 10 ns;

        input <= '1';
        mode <= '0';
        WAIT FOR 10 ns;
        
        input <= '1';
        mode <= '0';
        WAIT FOR 10 ns;

        input <= '0';
        mode <= '0';
        WAIT FOR 10 ns;

        input <= '1';
        mode <= '0';
        WAIT FOR 10 ns; -- uscita alta

        input <= '0';
        mode <= '1';
        WAIT FOR 10 ns;

        input <= '1';
        mode <= '1';
        WAIT FOR 10 ns;

        input <= '0';
        mode <= '1';
        WAIT FOR 10 ns;

        input <= '1';
        mode <= '1';
        WAIT FOR 10 ns; -- uscita alta

        input <= '0';
        mode <= '1';
        WAIT FOR 10 ns;

        input <= '1';
        mode <= '1';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;
END behavioral;