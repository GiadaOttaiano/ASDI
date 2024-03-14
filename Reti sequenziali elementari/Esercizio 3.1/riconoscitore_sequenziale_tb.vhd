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
        port(
            i : IN STD_LOGIC;
            m : IN STD_LOGIC;
            a : IN STD_LOGIC;
            y : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    uut : riconoscitore_sequenziale
    PORT MAP(
        i => input,
        m => mode,
        a => temp,
        y => output
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
        i <= '0';
        m <= '0';
        WAIT FOR 10 ns;

        i <= '1';
        m <= '0';
        WAIT FOR 10 ns;

        i <= '1';
        m <= '0';
        WAIT FOR 10 ns;

        i <= '0';
        m <= '0';
        WAIT FOR 10 ns;

        i <= '1';
        m <= '0';
        WAIT FOR 10 ns;

        i <= '0';
        m <= '1';
        WAIT FOR 10 ns;

        i <= '1';
        m <= '1';
        WAIT FOR 10 ns;

        i <= '0';
        m <= '1';
        WAIT FOR 10 ns;

        i <= '1';
        m <= '1';
        WAIT FOR 10 ns;

        i <= '0';
        m <= '1';
        WAIT FOR 10 ns;

        i <= '0';
        m <= '0';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END PROCESS;