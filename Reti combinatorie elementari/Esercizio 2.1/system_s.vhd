library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity system_s is
    port(
        s_input : in STD_LOGIC_VECTOR(3 downto 0);
        s_output : out STD_LOGIC_VECTOR(3 downto 0)
    );
end system_s;

architecture structural of system_s is
    signal u : STD_LOGIC_VECTOR(7 downto 0);

    component rom is
        port(   address : in std_logic_vector(3 downto 0);
                rom_output : out std_logic_vector(7 downto 0)
    );
    end component;

    component machine is
        port(   m_input : in STD_LOGIC_VECTOR(7 downto 0);
                m_output : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;

    begin
        rom_system : rom
            port map(
                address => s_input,
                rom_output => u
            );

        machine_system : machine
            port map(
                m_input => u,
                m_output => s_output
            );
end structural;