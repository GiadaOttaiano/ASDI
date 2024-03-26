library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nodeA is
    port(
        start_A, clock_A, reset_A : IN std_logic;
        ACK_A : IN std_logic;
        DATA_READY_A : OUT std_logic;
        data : OUT std_logic_vector(7 downto 0)
    );
end nodeA;

architecture structural of nodeA is
    component cuA is
        port(
            cuA_start : IN std_logic;
            cuA_clock, cuA_reset : IN std_logic;

            -- CONTATORE
            cuA_stop_count : IN std_logic_vector(3 downto 0);
            cuA_count_enable : OUT std_logic;

            -- MEM
            cuA_read_mem : OUT std_logic;

            -- HANDSHAKE
            ACK : IN std_logic;
            DATA_READY : OUT std_logic
        );
    end component;

    component OU_A is
        generic(
            N : positive := 16;
            M : positive := 2**3;
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

    signal temp_count : std_logic_vector(3 downto 0);
    signal temp_enable : std_logic;
    signal temp_read : std_logic;

    begin
        control_unit_A : cuA
            port map(
                cuA_start => start_A,
                cuA_clock => clock_A,
                cuA_reset => reset_A,
                cuA_stop_count => temp_count,
                cuA_count_enable => temp_enable,
                cuA_read_mem => temp_read,
                ACK => ACK_A,
                DATA_READY => DATA_READY_A
            );
        
        operative_unit_A : OU_A
            port map(
                ouA_clock => clock_A,
                ouA_enable => temp_enable,
                ouA_reset => reset_A,
                ouA_read => temp_read,
                ouA_output => data,
                ouA_count => temp_count
            );
end structural;