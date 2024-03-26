library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux21 is
    port(   
            mux21_input : in STD_LOGIC_VECTOR(1 downto 0);
            mux21_sel : in STD_LOGIC;
            mux21_output : out STD_LOGIC
    );
end mux21;

architecture dataflow of mux21 is
    begin
        mux21_output <= ((mux21_input(0) AND (NOT mux21_sel)) OR (mux21_input(1) AND mux21_sel));
end dataflow;
