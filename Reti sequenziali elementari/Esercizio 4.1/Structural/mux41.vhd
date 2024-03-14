library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux41 is
    port(   mux41_input  :   in STD_LOGIC_VECTOR(3 downto 0);
            mux41_sel  :   in STD_LOGIC_VECTOR(1 downto 0);
            y0  :   out STD_LOGIC
    );
end mux41;

architecture structural of mux41 is
    signal u : STD_LOGIC_VECTOR(1 downto 0);
    component mux21 is
    port(   mux21_input  :   in STD_LOGIC_VECTOR(1 downto 0);
            s   :   in STD_LOGIC;
            y   :   out STD_LOGIC
    );
    end component;

    begin
        mux0: mux21
            port map( mux21_input => mux41_input(1 downto 0),
                      s => mux41_sel(0),
                      y => u(0)
            );
        mux1: mux21
            port map( mux21_input => mux41_input(3 downto 2),
                      s => mux41_sel(0),
                      y => u(1)
            );
        mux2: mux21
            port map( mux21_input => u,
                      s => mux41_sel(1),
                      y => y0
            );
end structural;