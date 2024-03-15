LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY contatore_mod_n IS
    GENERIC (
        N : INTEGER := 6; -- Larghezza del contatore
        MAX : INTEGER := 60 -- Conteggio massimo
    );
    PORT (
        clock : IN STD_LOGIC; -- Clock di sistema
        reset : IN STD_LOGIC; -- Reset del contatore
        enable : IN STD_LOGIC := '1'; -- Abilitazione del contatore
        count : OUT INTEGER RANGE 0 TO MAX -- Conteggio del contatore
    );
END contatore_mod_n;

ARCHITECTURE behavioral OF contatore_mod_n IS
    SIGNAL counter : unsigned(N - 1 DOWNTO 0);
BEGIN

    PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            counter <= (OTHERS => '0'); -- Reset del contatore
        ELSIF rising_edge(clock) AND enable = '1' THEN
            IF counter = counter'high THEN      -- Counter raggiunge il suo massimo valore
                counter <= (OTHERS => '0'); -- Ritorna a zero quando raggiunge il massimo
            ELSE
                counter <= counter + 1; -- Incrementa il contatore
            END IF;
        END IF;
    END PROCESS;

    count <= to_integer(counter); -- Output del valore del contatore

END behavioral;