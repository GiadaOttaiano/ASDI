library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux is
    generic (width : integer range 0 to 17 := 8);
	port( 
        mux_in_1, mux_in_2 : IN std_logic_vector(width - 1 downto 0); 
		mux_sel : IN std_logic;
		mux_out : OUT std_logic_vector(width - 1 downto 0)
    );
end mux;

architecture rtl of mux_21 is

	begin
	
        mux_out <= mux_in_1 when mux_sel = '0' else 
        mux_in_2 when mux_sel = '1' else
            (others => '0');
end rtl;