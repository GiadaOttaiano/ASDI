library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity machine_m is

    port(
        m_in : IN STD_LOGIC_VECTOR(7 downto 0);
        m_out : OUT STD_LOGIC_VECTOR(3 downto 0)
    );

end machine_m;

architecture structural of machine_m is

    component encoder_42 is
        port(
        encoder_in : IN STD_LOGIC_VECTOR(3 downto 0);
        encoder_out : OUT STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

    begin
        encoder0 : encoder_42
        port map(
            encoder_in => m_in(3 downto 0),
            encoder_out => m_out(1 downto 0)
        );
        encoder1 : encoder_42
        port map(
            encoder_in => m_in(7 downto 4),
            encoder_out => m_out(3 downto 2)
        );

end structural;