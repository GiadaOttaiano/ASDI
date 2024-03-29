LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY contatore_mod_n IS
    GENERIC (
        N : POSITIVE := 6; -- Larghezza del contatore
        MAX : POSITIVE := 60 -- Conteggio massimo
    );
    PORT (
        init : IN STD_LOGIC_VECTOR(N - 1 downto 0);
        clock : IN STD_LOGIC; 
        set : IN STD_LOGIC; -- Set per inizializzare il contatore
        reset : IN STD_LOGIC;
        enable : IN STD_LOGIC; -- Abilitazione del contatore
        carry_out : OUT STD_LOGIC; 
        count : OUT INTEGER RANGE 0 TO MAX -- Conteggio del contatore
    );
END contatore_mod_n;

ARCHITECTURE behavioral OF contatore_mod_n IS
    SIGNAL counter : STD_LOGIC_VECTOR(N - 1 downto 0);
BEGIN

    PROCESS (clock, reset)
    BEGIN
        if set = '1' then
            counter <= init;
        end if;
        IF reset = '1' THEN
            counter <= (OTHERS => '0');
        ELSIF rising_edge(clock) AND enable = '1' THEN
            IF unsigned(counter) = MAX THEN      
                counter <= (OTHERS => '0'); 
            ELSE
                counter <= STD_LOGIC_VECTOR(unsigned(counter) + 1); 
            END IF;
        END IF;
    END PROCESS;

    count <= to_integer(unsigned(counter)); 
    carry_out <= '1' WHEN unsigned(counter) = MAX AND enable = '1' ELSE '0';

END behavioral;