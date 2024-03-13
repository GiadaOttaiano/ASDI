library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity machine is
    port(   m_input : in STD_LOGIC_VECTOR(7 downto 0);
            m_output : out STD_LOGIC_VECTOR(3 downto 0)
    );
end machine;

architecture structural of machine is

    component bit_manipulator is
        port(   input_data : in STD_LOGIC_VECTOR(3 downto 0); 
                output_data : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    begin
        machine_0: bit_manipulator
        port map(
            input_data => m_input(3 downto 0),
            output_data => m_output(1 downto 0)
        );

        machine_1: bit_manipulator
        port map(
            input_data => m_input(7 downto 4),
            output_data => m_output(3 downto 2)
        );

end structural;