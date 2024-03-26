library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity B_mem is
    generic(
        N : positive := 16; -- Numero stringhe
        M : positive := 2**3;   -- Lunghezza stringhe
        DEPTH : positive := 4   
    );
    port(
        B_address : IN std_logic_vector(DEPTH-1 downto 0);
        B_clock : IN std_logic;
        B_read : IN std_logic;
        B_output : OUT std_logic_vector(M-1 downto 0)
    );
end B_mem;

architecture rtl of B_mem is
    type MEM_N_M is array(0 to N-1) of std_logic_vector(M-1 downto 0);
    constant MEM_B : MEM_N_M := (
        "00010001", 
        "00100010", 
        "01000100", 
        "10001000", 
        "00010010", 
        "00010100", 
        "00011000", 
        "00100001", 
        "00100100", 
        "00101000", 
        "01000001", 
        "01000010", 
        "01001000", 
        "10000001", 
        "10000100", 
        "10000010"
    ); 

    begin
        process(B_clock)
        begin
            if rising_edge(B_clock) and B_read = '1' then
                B_output <= MEM_B(to_integer(unsigned(B_address)));
            end if;
        end process;
end rtl;