library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_register is
    port(
        sr_parallel_input : IN std_logic_vector(16 downto 0);
        sr_serial_input : IN std_logic;
        sr_clock, sr_reset, sr_load, sr_shift : IN std_logic;
        sr_parallel_output : OUT std_logic_vector(16 downto 0)
    );
end shift_register;

architecture behavioral of shift_register is

    signal temp : std_logic_vector(16 downto 0);

    begin
        process(sr_clock)
            begin
                if rising_edge(sr_clock) then
                    if sr_reset = '1' then
                        temp <= (others => '0');
                    else
                        if sr_load = '1' then
                            temp <= sr_parallel_input;
                elsif sr_shift = '1' then
                    temp(15 downto 0) <= temp(16 downto 1);
                    temp(16) <= sr_serial_input;
                    end if;
                end if;
            end if;
        end process;

    sr_parallel_output <= temp;

end behavioral;