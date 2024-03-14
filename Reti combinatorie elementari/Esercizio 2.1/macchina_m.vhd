LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY machine_m IS
    PORT (
        m_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END machine_m;

ARCHITECTURE structural OF machine_m IS
    COMPONENT bit_manipulator IS
        PORT (
            bm_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            bm_output : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    bit_m_0 : bit_manipulator
    PORT MAP(
        bm_input => m_input(3 DOWNTO 0),
        bm_output => m_output(1 DOWNTO 0)
    );
    bit_m_1 : bit_manipulator
    PORT MAP(
        bm_input => m_input(7 DOWNTO 4),
        bm_output => m_output(3 DOWNTO 2)
    );
END structural;