library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity PO_PC is

    port(
        pp_clock, pp_start, pp_stop : IN STD_LOGIC;
        pp_out : OUT STD_LOGIC_VECTOR(3 downto 0);
        cu_enable_out, cu_write_out, cu_read_out : OUT STD_LOGIC -- Segnali di ritorno per il test bench
    );

end PO_PC;

architecture structural of PO_PC is

    component control_unit is
        port(
            cu_start, cu_clock, cu_stop, cu_control : IN STD_LOGIC;
            cu_read, cu_write, cu_enable, cu_reset : OUT STD_LOGIC
        );
    end component;

    component counter_mod_16 is
        port(
            c_enable, c_clock, c_reset : IN STD_LOGIC;
            c_control : OUT STD_LOGIC;
            c_out : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component s_system is
        port(
            s_in : IN STD_LOGIC_VECTOR(3 downto 0);
            s_clock, s_rd : IN STD_LOGIC;
            s_out : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component memory is
        port(
            mem_address, mem_data : IN STD_LOGIC_VECTOR(3 downto 0);
            mem_wr, mem_clock : IN STD_LOGIC;
            mem_out : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal control, read, write, enable, reset : STD_LOGIC := '0';
    signal address, data : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

    begin
        cu : control
            port map(
                cu_start => pp_start,
                cu_clock => pp_clock,
                cu_stop => pp_stop,
                cu_control => control,
                cu_read => read,
                cu_write => write,
                cu_enable => enable,
                cu_reset => reset
            );

        counter : counter_mod_16
            port map(
                c_enable => enable,
                c_clock => pp_clock,
                c_reset => reset,
                c_control => control,
                c_output => address
            );
        
        s : s_system
            port map(
                s_input => address,
                s_clock => pp_clock,
                s_read => read,
                s_output => data
            );
        
        mem : memory
            port map(
                mem_address => address,
                mem_data => data,
                mem_wr => write,
                mem_clock => pp_clock,
                mem_out => pp_out
            );

        -- Segnali di ritorno
        cu_enable_out <= enable;
        cu_write_out <= write;
        cu_read_out <= read;
end structural;