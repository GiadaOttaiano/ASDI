library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity rom is
    port(   address : in std_logic_vector(3 downto 0);
            rom_output : out std_logic_vector(7 downto 0)
    );
end entity rom;

architecture RTL of rom is
    type MEMORY_168 is array (0 to 15) of std_logic_vector(7 downto 0);
    constant ROM_168 : MEMORY_168 := (
        "00010001",
        "00101001",
        "10010100",
        "00100100",
        "00000001",
        "10101010",
        "00101101",
        "11111111",
        "01010101",
        "01000101",
        "10100010",
        "11111110",
        "00010010",
        "00011111",
        "10010010",
        "10000001"
    );

    begin
        rom_output <= ROM_168(to_integer(unsigned(address)));
end architecture RTL;