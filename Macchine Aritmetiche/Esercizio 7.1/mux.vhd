LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mux IS
    GENERIC (width : INTEGER RANGE 0 TO 17 := 8);
    PORT (
        mux_in_1, mux_in_2 : IN STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
        mux_sel : IN STD_LOGIC;
        mux_out : OUT STD_LOGIC_VECTOR(width - 1 DOWNTO 0)
    );
END mux;

ARCHITECTURE rtl OF mux IS

BEGIN

    mux_out <= mux_in_1 WHEN mux_sel = '0' ELSE
        mux_in_2 WHEN mux_sel = '1' ELSE
        (OTHERS => '0');
END rtl;