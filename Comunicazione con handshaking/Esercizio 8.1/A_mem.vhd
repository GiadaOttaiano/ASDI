library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity A_mem is
    generic(
        N : positive := 16; -- Numero stringhe
        M : positive := 2**3;  -- Lunghezza stringhe
        DEPTH : positive := 4   
    );
    port(
        A_address : IN std_logic_vector(DEPTH-1 downto 0);
        A_clock : IN std_logic;
        A_read : IN std_logic;
        A_output : OUT std_logic_vector(M-1 downto 0)
    );
end A_mem;

architecture rtl of A_mem is
    type MEM_N_M is array(0 to N-1) of std_logic_vector(M-1 downto 0);
    constant MEM_A : MEM_N_M := (
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
        process(A_clock)
        begin
            if rising_edge(A_clock) and A_read = '1' then
                A_output <= MEM_A(to_integer(unsigned(A_address)));
            end if;
        end process;
end rtl;