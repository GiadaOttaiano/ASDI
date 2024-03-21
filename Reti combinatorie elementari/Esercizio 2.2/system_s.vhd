LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY system_s IS
    PORT (
        s_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END system_s;

ARCHITECTURE structural OF system_s IS
    SIGNAL system_u : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

    COMPONENT rom IS
        PORT (
            rom_address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            rom_output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT machine_m IS
        PORT (
            m_input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            m_output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    system_rom : rom
    PORT MAP(
        rom_address => s_input,
        rom_output => system_u
    );
    system_machine_m : machine_m
    PORT MAP(
        m_input => system_u,
        m_output => s_output
    );
END structural;