library IEEE;
use IEEE.STD_LOGIC_1644.all;
use IEEE.numeric_std.all;

entity rom is
    port(
        rom_address : IN STD_LOGIC_VECTOR(3 downto 0);
        rom_clk : IN STD_LOGIC;
        rom_read : IN STD_LOGIC;
        rom_output : OUT STD_LOGIC_VECTOR(7 downto 0)
    );
end rom;

architecture dataflow of rom is
    type MEMORY_16_8 is array(0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
    CONSTANT ROM_16_8 : MEMORY_16_8 := (
        "00010001", 
        "00100010", 
        "01000100", 
        "10001000", 
        "00010010", 
        "00010100", 
        "00011000", 
        "00100001", 
        "00100100", 
        "00101000", 
        "01000001", 
        "01000010", 
        "01001000", 
        "10000001", 
        "10000100", 
        "10000010"
    );

    begin
        process(rom_clk)
            begin
                if rising_edge(rom_clk) then
                    if rom_read = '1' then
                    rom_output <= ROM_16_8(to_integer(unsigned(rom_address)));
                    end if;
                end if;
    end process;
end dataflow;