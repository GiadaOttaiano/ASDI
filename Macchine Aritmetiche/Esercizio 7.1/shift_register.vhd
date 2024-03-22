LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY shift_register IS
    PORT (
        sr_parallel_in : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
        sr_serial_in : IN STD_LOGIC;
        sr_clock, sr_reset, sr_load, sr_shift : IN STD_LOGIC;
        sr_out : OUT STD_LOGIC_VECTOR(16 DOWNTO 0)
    );
END shift_register;

ARCHITECTURE behavioral OF shift_register IS

    SIGNAL temp : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');

BEGIN
    PROCESS (sr_clock, sr_reset)
    BEGIN
        IF sr_reset = '1' THEN
            temp <= (OTHERS => '0');
        ELSIF rising_edge(sr_clock) THEN
            IF sr_load = '1' THEN
                temp <= sr_parallel_in;
            END IF;
            IF sr_shift = '1' THEN
                temp <= sr_serial_in & temp(16 DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;

    sr_out <= temp;
END behavioral;