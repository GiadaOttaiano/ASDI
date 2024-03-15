library IEEE;
use IEEE.STD_LOGIC_1644.all;
use IEEE.numeric_std.all;

entity machine_m is

    port(
        m_input : IN STD_LOGIC_VECTOR(7 downto 0);
        m_output : OUT STD_LOGIC_VECTOR(3 downto 0)
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
            encoder_in => m_input(3 downto 0),
            encoder_out => m_output(1 downto 0)
        );
        encoder1 : encoder_42
        port map(
            encoder_in => m_input(7 downto 4),
            encoder_out => m_output(3 downto 2)
        );

end structural;