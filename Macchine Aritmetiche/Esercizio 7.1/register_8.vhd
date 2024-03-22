LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY register_8 IS
    PORT (
        r_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        r_clock, r_reset, r_load : IN STD_LOGIC;
        r_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END register_8;

ARCHITECTURE behavioral OF register_8 IS

    SIGNAL reg : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    PROCESS (r_clock, r_reset)
    BEGIN
        IF r_reset = '1' THEN
            reg <= (OTHERS => '0');
        ELSIF rising_edge(r_clock) THEN
            IF r_load = '1' THEN
                reg <= r_in;
            END IF;
        END IF;
    END PROCESS;

    r_out <= reg;

END behavioral;