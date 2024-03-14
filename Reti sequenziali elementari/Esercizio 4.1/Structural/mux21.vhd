library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux21 is
    port(   mux21_input  :   in STD_LOGIC_VECTOR(1 downto 0);
            s   :   in STD_LOGIC;
            y   :   out STD_LOGIC
    );
end mux21;

architecture dataflow of mux21 is
    begin
        y <= ((mux21_input(0) AND (NOT s)) OR (mux21_input(1) AND s));
end dataflow;
