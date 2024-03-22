LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY adder_subtractor IS
    PORT (
        as_in_1, as_in_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        as_c_in : IN STD_LOGIC;
        as_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        as_c_out : OUT STD_LOGIC
    );
END adder_subtractor;

ARCHITECTURE structural OF adder_subtractor IS
    COMPONENT ripple_carry_adder IS
        PORT (
            rc_in_1, rc_in_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            rc_c_in : IN STD_LOGIC;
            rc_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            rc_c_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL complementoy : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

BEGIN
    complemento_y : FOR i IN 0 TO 7 GENERATE
        complementoy(i) <= as_in_2(i) XOR as_c_in;
    END GENERATE;

    RA : ripple_carry_adder
    PORT MAP(
        as_in_1, complementoy, as_c_in, as_out, as_c_out
    );

END structural;