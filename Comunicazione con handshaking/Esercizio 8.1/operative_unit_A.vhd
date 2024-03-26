library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity OU_A is
    generic(
        N : positive := 16; -- Numero stringhe
        M : positive := 2**3;  -- Lunghezza stringhe
        DEPTH : positive := 4   
    );
    port(
        ouA_clock : IN std_logic;
        ouA_enable, ouA_reset : IN std_logic;
        ouA_read : IN std_logic;
        ouA_output : OUT std_logic_vector(M-1 downto 0);
        ouA_count : OUT std_logic_vector(DEPTH-1 downto 0)
    );
end OU_A;

architecture structural of OU_A is

    component counter_mod_N is
        generic(
            N : positive := 16;
            DEPTH : positive := 4   
        );
        port(
            c_clock, c_enable, c_reset : IN std_logic;
            c_output : OUT std_logic_vector(DEPTH - 1 downto 0)
        );
    end component;

    component A_mem is
        generic(
            N : positive := 16;
            M : positive := 2**3; 
            DEPTH : positive := 4   
        );
        port(
            A_address : IN std_logic_vector(DEPTH-1 downto 0);
            A_clock : IN std_logic;
            A_read : IN std_logic;
            A_output : OUT std_logic_vector(M-1 downto 0)
        );
    end component;

    signal count_output : std_logic_vector(3 downto 0);
    signal mem_output : std_logic_vector(7 downto 0);

    begin
        counter_A : counter_mod_N
            port map(
                c_clock => ouA_clock,
                c_enable => ouA_enable,
                c_reset => ouA_reset,
                c_output => count_output
            );

        memory_A : A_mem
            port map(
                A_address => count_output,
                A_clock => ouA_clock,
                A_read => ouA_read,
                A_output => mem_output
            );

        ouA_output <= mem_output;
        ouA_count <= count_output;
end structural;