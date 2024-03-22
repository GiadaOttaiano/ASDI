library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity complete_system is
    port(
        clock : IN std_logic;
        START, RESET : IN std_logic;
        output : OUT std_logic_vector(3 downto 0)
    );
end complete_system;

architecture structural of complete_system is

    component PO_PC port(
        pp_clock, pp_start, pp_stop : IN STD_LOGIC;
        pp_out : OUT STD_LOGIC_VECTOR(3 downto 0);
        cu_enable_out, cu_write_out, cu_read_out : OUT STD_LOGIC
    );
    end component;

    component ButtonDebouncer is
        generic(
            CLK_period : integer := 10; 
            btn_noise_time : integer := 10000000
        );
    
        port(
            RST : IN STD_LOGIC;
            CLK : IN STD_LOGIC;
            BTN : IN STD_LOGIC;
            CLEARED_BTN : OUT STD_LOGIC
        );
    end component;

    signal cleared_start, cleared_reset : std_logic;
    
    begin
        po_pc : PO_PC
            port map(
                pp_clock <= clock,
                pp_start <= cleared_start,
                pp_stop <= cleared_reset,
                pp_out <= output
            );

        debouncer_start : ButtonDebouncer
            generic map(10, 10000000);
            port map(
                RST <= '0',
                CLK <= clock,
                BTN <= START,
                CLEARED_BTN <= cleared_start
            );

        debouncer_reset : ButtonDebouncer
            generic map(10, 10000000);
            port map(
                RST <= '0',
                CLK <= clock,
                BTN <= RESET,
                CLEARED_BTN <= cleared_reset
            );
        
end structural;