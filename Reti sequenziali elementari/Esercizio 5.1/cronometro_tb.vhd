LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cronometro_tb IS
END cronometro_tb;

ARCHITECTURE behavioral OF cronometro_tb IS

    COMPONENT cronometro
        PORT (
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            set : IN STD_LOGIC;
            start : IN STD_LOGIC;
            hours_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            minutes_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            seconds_in : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            hours_out : OUT INTEGER RANGE 0 TO 23;
            minutes_out : OUT INTEGER RANGE 0 TO 59;
            seconds_out : OUT INTEGER RANGE 0 TO 59
        );
    END COMPONENT;

    SIGNAL clock_tb : STD_LOGIC := '0';
    SIGNAL reset_tb : STD_LOGIC := '0';
    SIGNAL set_tb : STD_LOGIC := '0';
    SIGNAL start_tb : STD_LOGIC := '0';

    SIGNAL hours_in_tb : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL minutes_in_tb : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL seconds_in_tb : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');

    SIGNAL hours_out_tb : INTEGER RANGE 0 TO 23;
    SIGNAL minutes_out_tb : INTEGER RANGE 0 TO 59;
    SIGNAL seconds_out_tb : INTEGER RANGE 0 TO 59;

BEGIN

    uut : cronometro
    PORT MAP(
        clock => clock_tb,
        reset => reset_tb,
        set => set_tb,
        start => start_tb,
        hours_in => hours_in_tb,
        minutes_in => minutes_in_tb,
        seconds_in => seconds_in_tb,
        hours_out => hours_out_tb,
        minutes_out => minutes_out_tb,
        seconds_out => seconds_out_tb
    );

    clock : PROCESS
    BEGIN
        WAIT FOR 5 ns;
        clock_tb <= NOT clock_tb;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
    
        reset_tb <= '1';
        WAIT FOR 10 ns;
        reset_tb <= '0';
        WAIT FOR 10 ns;
        
        -- Imposta il tempo iniziale
        set_tb <= '1';
        hours_in_tb <= "01010"; -- 10 ore
        minutes_in_tb <= "111011"; -- 59 minuti
        seconds_in_tb <= "001010"; -- 10 secondi
        WAIT FOR 10 ns;
        set_tb <= '0';
        WAIT FOR 10 ns;
        
        -- Attiva il cronometro
        start_tb <= '1';

        -- Attendi per qualche istante per consentire al cronometro di funzionare
        WAIT FOR 1000 ns;

        -- Ferma il cronometro
        start_tb <= '0';
        reset_tb <= '0';

        WAIT;
    END PROCESS;

END behavioral;