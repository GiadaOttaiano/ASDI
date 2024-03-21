library IEEE;
use IEEE.std_logic_1164.ALL;

entity control_unit is
    port(
        switch_s1, switch_s2, button_1, button_2, clock_cu : IN std_logic;
        output_data, output_mode : OUT std_logic        
    );
end control_unit;

architecture behavioral of control_unit is

    signal temp_data, temp_mode : std_logic;

    begin
        process(clock_cu, switch_s1, switch_s2, button_1, button_2)
            begin
                if (clock_cu'EVENT and clock_cu = '1') then
                    if button_1 = '1' then
                        temp_data <= switch_s1;
                    end if;
                    
                    if button_2 = '1' then
                        temp_mode <= switch_s2;
                    end if;
                end if;
        end process;

    output_data <= temp_data;
    output_mode <= temp_mode;

end behavioral;