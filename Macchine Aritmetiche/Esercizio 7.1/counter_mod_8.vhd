LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY counter_mod_8 IS
    PORT (
        c_in, c_clock, c_reset : IN STD_LOGIC;
        c_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );

END counter_mod_8;

ARCHITECTURE behavioral OF counter_mod_8 IS

    SIGNAL counter : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');

BEGIN
    PROCESS (c_clock, c_reset)
    BEGIN
        IF rising_edge(c_clock) THEN 
            IF c_reset = '1' THEN
            counter <= (OTHERS => '0');
            ELSE
                IF c_in = '1' THEN
                    counter <= STD_LOGIC_VECTOR(unsigned(counter) + 1);
                END IF;
            END IF;
        END IF;
END PROCESS;

c_out <= counter;

END behavioral;