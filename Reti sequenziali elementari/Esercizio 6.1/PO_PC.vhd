library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity PO_PC is

    port(
        pp_clock, pp_start, pp_stop : IN STD_LOGIC;
        pp_output : OUT STD_LOGIC_VECTOR(3 downto 0)
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
            c_output : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component s_system is
        port(
            s_input : IN STD_LOGIC_VECTOR(3 downto 0);
            s_clock, s_read : IN STD_LOGIC;
            s_output : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component memory is
        port(
            mem_address, mem_data : IN STD_LOGIC_VECTOR(3 downto 0);
            mem_wr, mem_clock : IN STD_LOGIC;
            mem_out : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal c_ctr, cu_wr_mem, cu_rd_rom, cu_en_count, cu_reset_count : STD_LOGIC := '0';
    signal c_address, s_data : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

    begin
        cu : control
            port map(
                cu_start => pp_start,
                cu_clock => pp_clock,
                cu_stop => pp_stop,
                cu_control => c_ctr,
                cu_read => cu_rd_rom,
                cu_write => cu_wr_rom,
                cu_enable => cu_en_count,
                cu_reset => cu_reset_count
            );

        counter : counter_mod_16
            port map(
                c_enable => cu_en_count,
                c_clock => pp_clock,
                c_reset => cu_reset_count,
                c_control => c_ctr,
                c_output => c_address
            );
        
        s : s_system
            port map(
                s_input => c_address,
                s_clock => pp_clock,
                s_read => cu_rd_rom,
                s_output => s_data
            );
        
        mem : memory
            port map(
                mem_address => c_address,
                mem_data => s_data,
                mem_wr => cu_wr_mem,
                mem_clock => pp_clock,
                mem_out => pp_out
            );
end structural;