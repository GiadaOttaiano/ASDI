library IEEE;
use IEEE.std_logic_1164.ALL;

entity net164 is
    port(   net164_input : in STD_LOGIC_VECTOR(15 downto 0);
            net164_mux_s : in STD_LOGIC_VECTOR(3 downto 0);
            net164_demux_s : in STD_LOGIC_VECTOR(1 downto 0);
            net164_output : out STD_LOGIC_VECTOR(3 downto 0)    
    );
end net164;

architecture structural of net164 is
    signal net164_u : STD_LOGIC := '0';

    component mux161 is
    port(   mux161_input : in STD_LOGIC_VECTOR(15 downto 0);
            mux161_control : in STD_LOGIC_VECTOR(3 downto 0);
            mux161_output : out STD_LOGIC
    );
    end component;

    component demux14 is
    port(   demux14_input : in STD_LOGIC;
            demux14_control : in STD_LOGIC_VECTOR(1 downto 0);
            demux14_output : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;

    begin
        net164_mux: mux161
            port map(   mux161_input => net164_input,
                        mux161_control => net164_mux_s,
                        mux161_output => net164_u
            );
        net164_demux: demux14
            port map(   demux14_input => net164_u,
                        demux14_control => net164_demux_s,
                        demux14_output => net164_output
            );
end structural;