LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ripple_carry_adder IS
    PORT (
        rc_in_1, rc_in_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        rc_c_in : IN STD_LOGIC;
        rc_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        rc_c_out : OUT STD_LOGIC
    );
END ripple_carry_adder;

ARCHITECTURE structural OF ripple_carry_adder IS

    COMPONENT full_adder IS
        PORT (
            fa_in_1, fa_in_2, fa_c_in : IN STD_LOGIC;
            fa_out, fa_c_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL temp : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    FA0 : full_adder
    PORT MAP(
        rc_in_1(0),
        rc_in_2(0),
        rc_c_in,
        rc_out(0),
        temp(0)
    );

    FA1to6 : FOR i IN 1 TO 6 GENERATE
        FA : full_adder PORT MAP(
            rc_in_1(i),
            rc_in_2(i),
            temp(i - 1),
            rc_out(i),
            temp(i)
        );
    END GENERATE;

    FA7 : full_adder
    PORT MAP(
        rc_in_1(7), rc_in_2(7), temp(6), rc_out(7), rc_c_out
    );

END structural;