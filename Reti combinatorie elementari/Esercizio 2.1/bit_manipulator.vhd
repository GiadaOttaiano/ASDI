LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY bit_manipulator IS
    PORT (
        bm_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        bm_output : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END bit_manipulator;

ARCHITECTURE dataflow OF bit_manipulator IS
    SIGNAL group1, group2 : signed(1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL result : signed(1 DOWNTO 0) := (OTHERS => '0');
BEGIN
    group1 <= signed(bm_input(3 DOWNTO 2));
    group2 <= signed(bm_input(1 DOWNTO 0));

    -- Scegli il numero più grande per la sottrazione
    result <= (OTHERS => '0') WHEN group1 = group2 ELSE
        (group1 - group2) WHEN group1 >= group2 ELSE
        (group2 - group1);

    bm_output <= STD_LOGIC_VECTOR(result);
END dataflow;