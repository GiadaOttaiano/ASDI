library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        r_address : IN std_logic_vector(2 downto 0);
        r_clock : IN std_logic;
        r_read : IN std_logic;
        r_out : OUT std_logic_vector(7 downto 0)
    );
end rom;

architecture rtl of rom is
    type MEM_8_8 is array(0 to 7) of std_logic_vector(7 downto 0);

    constant ROM_8_8 : MEM_8_8 := (
        "00010001", 
        "00100010", 
        "01000100", 
        "10001000", 
        "00010010", 
        "00010100", 
        "00011000", 
        "00100001"
    );

    begin
        process(r_clock)
            begin
                if rising_edge(r_clock) AND r_read = '1' then
                    r_out <= ROM_8_8(to_integer(unsigned(r_address)));
                end if;
        end process;

end rtl;