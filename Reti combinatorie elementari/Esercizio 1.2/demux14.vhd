library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux14 is
    port(   demux14_input : in STD_LOGIC;
            demux14_control : in STD_LOGIC_VECTOR(1 downto 0);
            demux14_output : out STD_LOGIC_VECTOR(3 downto 0)
    );
end demux14;

architecture structural of demux14 is
    signal u_vector : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    component demux12 is 
    port(   a0 : in STD_LOGIC;
            s : in STD_LOGIC;
            demux12_output : out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

    begin
        demux0: demux12
        port map( a0 => demux14_input,
                  s => demux14_control(1),
                  demux12_output => u_vector
        );

        demux1: demux12
        port map( a0 => u_vector(0),
                  s => demux14_control(0),
                  demux12_output => demux14_output(1 downto 0)
        );

        demux2: demux12
        port map( a0 => u_vector(1),
                  s => demux14_control(0),
                  demux12_output => demux14_output(3 downto 2)
        );
end structural;
