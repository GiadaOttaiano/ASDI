library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity OU_B is
    generic(
        N : positive := 16; -- Numero stringhe
        M : positive := 2**3;  -- Lunghezza stringhe
        DEPTH : positive := 4   
    );
    port(
        ouB_clock : IN std_logic;
        ouB_enable, ouB_reset : IN std_logic;
        ouB_read, ouB_write : IN std_logic;
        ouB_A_data : IN std_logic_vector(M-1 downto 0);
        ouB_sum : IN std_logic;     -- Segnale di abilitazione alla somma
        ouB_count : OUT std_logic_vector(DEPTH-1 downto 0)
    );
end OU_B;

architecture structural of OU_B is

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

    component B_mem is
        generic(
            N : positive := 16;
            M : positive := 2**3;
            DEPTH : positive := 4   
        );
        port(
            B_address : IN std_logic_vector(DEPTH-1 downto 0);
            B_clock : IN std_logic;
            B_read : IN std_logic;
            B_output : OUT std_logic_vector(M-1 downto 0)
        );
    end component;

    component B_register is
        generic(
            N : positive := 16;
            M : positive := 2**3;
            DEPTH : positive := 4
        );
        port(
            reg_address : IN std_logic_vector(DEPTH-1 downto 0);
            reg_data : IN std_logic_vector(M-1 downto 0);
            reg_clock, reg_write : IN std_logic;
            reg_out : OUT std_logic_vector(M-1 downto 0)
        );
    end component;

    signal count_output : std_logic_vector(3 downto 0);
    signal mem_output : std_logic_vector(7 downto 0);
    signal temp_sum : std_logic_vector(7 downto 0) := (others => 'U');

    begin
        counter_B : counter_mod_N
            port map(
                c_clock => ouB_clock,
                c_enable => ouB_enable,
                c_reset => ouB_reset,
                c_output => count_output
            );

        memory_B : B_mem
            port map(
                B_address => count_output,
                B_clock => ouB_clock,
                B_read => ouB_read,
                B_output => mem_output
            );
        
        reg_B : B_register
            port map(
                reg_address => count_output,
                reg_data => temp_sum,
                reg_clock => ouB_clock,
                reg_write => ouB_write
            );

        temp_sum <= std_logic_vector(unsigned(ouB_A_data) + unsigned(mem_output)) when ouB_sum = '1';
        ouB_count <= count_output;
end structural;