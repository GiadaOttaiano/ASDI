library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mem is
    port(
        m_data : IN std_logic_vector(7 downto 0);
        m_address : IN std_logic_vector(2 downto 0);
        m_clock : IN std_logic;
        m_write : IN std_logic;
        m_out : OUT std_logic_vector(7 downto 0)
    );
end mem;

architecture rtl of mem is
    type MEMORY_8_8 is array(0 to 7) of std_logic_vector(7 downto 0);

    signal MEMORY_8_8 : MEM_8_8 := (others => "000");

    begin
        process(m_clock)
            begin
                if rising_edge(m_clock) AND m_write = '1' then
                    MEMORY_8_8(to_integer(unsigned(m_address))) <= m_data;
                end if;
        end process;

    m_out <= m_data;
end rtl;