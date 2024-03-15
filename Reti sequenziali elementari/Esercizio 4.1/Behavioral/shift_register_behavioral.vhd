library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_register_behavioral is
    generic (
        N : INTEGER := 8    -- Numero di bit del registro
    );
    
    port(
        reg_input : in STD_LOGIC;
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        shift_dir : in STD_LOGIC;       -- Shift a destra o shift a sinistra
        Y : in STD_LOGIC_VECTOR(1 downto 0);    -- Shift amount
        reg_output : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end shift_register_behavioral;

architecture behavioral of shift_register_behavioral is

    signal temp_input : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

    begin
        process(clk, rst)
            variable temp_output : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
        begin
            if rst = '1' then
                temp_input <= (others => '0');
                temp_output := (others => '0');
            elsif rising_edge(clk) then
               if shift_dir = '1' then -- Shift a destra
                    if Y = "01" then   -- Shift di una posizione
                        temp_output := reg_input & temp_input(N-1 downto 1);
                    elsif Y = "10" then     -- Shift di due posizioni
                        temp_output := reg_input & reg_input & temp_input(N-1 downto 2);
                    end if;
                else     -- Shift a sinistra
                    if Y = "01" then   -- Shift di una posizione
                        temp_output := temp_input(N-2 downto 0) & reg_input;
                    elsif Y = "10" then     -- Shift di due posizioni
                        temp_output := temp_input(N-3 downto 0) & reg_input & reg_input;
                    end if;
               end if;
               temp_input <= temp_output;
            end if;
        end process;
        reg_output <= temp_input;
end behavioral;