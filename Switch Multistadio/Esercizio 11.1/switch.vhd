library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity switch is
    port(
        switch_in : IN std_logic_vector(1 downto 0);
        switch_sel : IN std_logic_vector(1 downto 0);
        switch_out : OUT std_logic_vector(1 downto 0)
    );
end switch;

architecture structural of switch is

    component mux21 is
        port(   
            mux21_input : in STD_LOGIC_VECTOR(1 downto 0);
            mux21_sel : in STD_LOGIC;
            mux21_output : out STD_LOGIC
        );
    end component;

    component demux12 is
        port(   
            demux12_input : in STD_LOGIC;
            demux12_sel : in STD_LOGIC;
            demux12_output : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal temp : std_logic_vector(1 downto 0);

    begin
        mux : mux21
            port map(
                mux21_input => switch_in,
                mux21_sel => switch_sel(0),
                mux21_output => temp
            );
        
        demux : demux12
            port map(
                demux12_input => temp,
                demux12_sel => switch_sel(1),
                demux12_output => switch_out
            );

end structural;