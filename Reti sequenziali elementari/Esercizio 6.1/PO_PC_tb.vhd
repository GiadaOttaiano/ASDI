LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY PO_PC_tb IS
END PO_PC_tb;

ARCHITECTURE behavioral OF PO_PC_tb IS

    COMPONENT PO_PC
        PORT (
            pp_clock, pp_start, pp_stop : IN STD_LOGIC;
            pp_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            cu_enable_out, cu_write_out, cu_read_out : OUT STD_LOGIC -- Segnali di ritorno per il test bench
        );
    END COMPONENT;

    SIGNAL pp_clock_tb, pp_start_tb, pp_stop_tb : STD_LOGIC := '0';
    SIGNAL pp_out_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    SIGNAL cu_enable_tb, cu_write_tb, cu_read_tb : STD_LOGIC;

BEGIN

    uut : PO_PC
    PORT MAP(
        pp_clock => pp_clock_tb,
        pp_start => pp_start_tb,
        pp_stop => pp_stop_tb,
        pp_out => pp_out_tb,
        cu_enable_out => cu_enable_tb,
        cu_write_out => cu_write_tb,
        cu_read_out => cu_read_tb
    );

    clock : PROCESS
    BEGIN
        WAIT FOR 5 ns;
        pp_clock_tb <= NOT pp_clock_tb;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN

        WAIT FOR 100 ns;

        pp_start_tb <= '1';

        WAIT FOR 1000 ns;

        pp_start_tb <= '0';
        pp_stop_tb <= '1';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END behavioral;