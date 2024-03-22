library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity B_register is
    generic(
        N : positive := 16; -- Numero stringhe
        M : positive := 2**3;   -- Lunghezza stringhe
        DEPTH : positive := 4   
    );
    port(
        reg_address : IN std_logic_vector(DEPTH-1 downto 0);
        reg_data : IN std_logic_vector(M-1 downto 0);
        reg_clock, reg_write : IN std_logic;
        reg_out : OUT std_logic_vector(M-1 downto 0)
    );
end B_register;

architecture rtl of B_register is
    type REG_N_M is array(0 to N-1) of std_logic_vector(M-1 downto 0);
    signal reg_B : REG_N_M := (others => "00000000");

    begin
        process(reg_clock)
        begin
            if rising_edge(reg_clock) and reg_write = '1' then
                reg_B(to_integer(unsigned(reg_address))) <= reg_data;
            end if;
        end process;

        reg_out <= reg_data;
end rtl;