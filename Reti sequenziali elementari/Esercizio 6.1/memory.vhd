library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is

    port(
        mem_address, mem_data : IN STD_LOGIC_VECTOR(3 downto 0);
        mem_wr, mem_clock : IN STD_LOGIC;
        mem_out : OUT STD_LOGIC_VECTOR(3 downto 0)
    );

end memory;

architecture dataflow of memory is

    type MEMORY_16_4 is array(0 to 15) of std_logic_vector(3 downto 0);
    signal MEM_16_4 : MEMORY_16_4 := (others => "0000");

    begin
        process(mem_clock)
        begin
            if rising_edge(mem_clock) AND mem_wr = '1' then
                MEM_16_4(to_integer(unsigned(mem_address))) <= mem_data;
            end if;
        end process;

        mem_out <= mem_data;
        
end dataflow;