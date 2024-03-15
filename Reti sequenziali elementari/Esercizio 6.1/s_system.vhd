library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity s_system is

    port(
        s_in : IN STD_LOGIC_VECTOR(3 downto 0);
        s_clock, s_rd : IN STD_LOGIC;
        s_out : OUT STD_LOGIC_VECTOR(3 downto 0)
    );

end s_system;

architecture structural of s_system is

    component rom is
        port(
            rom_address : IN STD_LOGIC_VECTOR(3 downto 0);
            rom_clk : IN STD_LOGIC;
            rom_rd : IN STD_LOGIC;
            rom_out : OUT STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component machine_m is
        port(
            m_in : IN STD_LOGIC_VECTOR(7 downto 0);
            m_out : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal rom_to_m : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    begin
        s_rom : rom
        port map(
            rom_address => s_in,
            rom_clk => s_clock,
            rom_rd => s_rd,
            rom_out => rom_to_m
        );
        s_machine : machine_m
        port map(
            m_in => rom_to_m,
            m_out => s_out
        );   
end structural;