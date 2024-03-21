LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ALL;

ENTITY rom IS
    PORT (
        rom_address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        rom_output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END rom;

ARCHITECTURE RTL OF rom IS
    TYPE MEMORY_16_8 IS ARRAY(0 TO 15) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    CONSTANT ROM_16_8 : MEMORY_16_8 := (
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

BEGIN
    rom_output <= ROM_16_8(to_integer(unsigned(rom_address)));

END ARCHITECTURE RTL;