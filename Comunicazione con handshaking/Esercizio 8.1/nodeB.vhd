library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nodeB is
    port(
        start_B, clock_B, reset_B : IN std_logic;
        data : IN std_logic_vector(7 downto 0);
        DATA_READY_B : IN std_logic;
        ACK_B : OUT std_logic;
    );
end nodeB;

architecture structural of nodeB is

    component cuB is
        port(
            cuB_start : IN std_logic;
            cuB_clock, cuB_reset : IN std_logic;
    
            -- CONTATORE
            cuB_stop_count : IN std_logic_vector(3 downto 0);
            cuB_count_enable : OUT std_logic;
    
            -- ROM + MEM
            cuB_read_mem, cuB_write_mem : OUT std_logic;
    
            -- HANDSHAKE
            ACK : OUT std_logic;
            DATA_READY : IN std_logic;
    
            -- SOMMA
            cuB_sum : OUT std_logic
        );
    end component;

    component OU_B is
        generic(
            N : positive := 16; 
            M : positive := 2**3;  
            DEPTH : positive := 4   
        );
        port(
            ouB_clock : IN std_logic;
            ouB_enable, ouB_reset : IN std_logic;
            ouB_read, ouB_write : IN std_logic;
            ouB_A_data : IN std_logic_vector(M-1 downto 0);
            ouB_sum : IN std_logic;
            ouB_count : OUT std_logic_vector(DEPTH-1 downto 0)
        );
    end component;

    signal temp_count : std_logic_vector(3 downto 0);
    signal temp_enable : std_logic;
    signal temp_read, temp_write : std_logic;
    signal temp_sum : std_logic;

    begin
        control_unit_B : cuB
            port map(
                cuB_start => start_B,
                cuB_clock => clock_B,
                cuB_reset => reset_B,
                cuB_stop_count => temp_count,
                cuB_count_enable => temp_enable,
                cuB_read_mem => temp_read,
                cuB_write_mem => temp_write,
                ACK => ACK_B,
                DATA_READY => DATA_READY_B,
                cuB_sum => temp_sum
            ); 

        operative_unit_B : OU_B
            port map(
                ouB_clock => clock_B,
                ouB_enable => temp_enable,
                ouB_reset => reset_B,
                ouB_read => temp_read,
                ouB_write => temp_write,
                ouB_A_data => data,
                ouB_sum => temp_sum,
                ouB_count => temp_count
            );

end structural;