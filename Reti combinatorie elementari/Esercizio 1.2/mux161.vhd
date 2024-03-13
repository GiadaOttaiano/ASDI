library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux161 is
    port(   mux161_input : in STD_LOGIC_VECTOR(15 downto 0);
            mux161_control : in STD_LOGIC_VECTOR(3 downto 0);
            mux161_output : out STD_LOGIC
    );
end mux161;

architecture structural of mux161 is
    signal u : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    component mux41 is
    port(   mux41_input  :   in STD_LOGIC_VECTOR(3 downto 0);
            mux41_sel  :   in STD_LOGIC_VECTOR(1 downto 0);
            y0  :   out STD_LOGIC
    );
    end component;

    begin
    mux0: mux41
        port map( mux41_input => mux161_input(3 downto 0),
                  mux41_sel => mux161_control(1 downto 0),
                  y0 => u(0)
        );
    mux1: mux41
        port map( mux41_input => mux161_input(7 downto 4),
                  mux41_sel => mux161_control(1 downto 0),
                  y0 => u(1)
        );
    mux2: mux41
        port map( mux41_input => mux161_input(11 downto 8),
                  mux41_sel => mux161_control(1 downto 0),
                  y0 => u(2)
        );
    mux3: mux41
        port map( mux41_input => mux161_input(15 downto 12),
                  mux41_sel => mux161_control(1 downto 0),
                  y0 => u(3)
        );
    mux4: mux41
        port map( mux41_input => u,
                  mux41_sel => mux161_control(3 downto 2),
                  y0 => mux161_output
        );
end structural;