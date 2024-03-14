LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY shift_register_structural_tb IS
END shift_register_structural_tb;

ARCHITECTURE behavioral OF shift_register_structural_tb IS

    COMPONENT shift_register_structural IS
        PORT (
            reg_input, rst, clk : IN STD_LOGIC;
            shift : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            reg_output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL reg_input_tb, rst_tb, clk_tb : STD_LOGIC := '0';
    SIGNAL shift_tb : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => 'U');
    SIGNAL reg_output_tb : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 'U');

BEGIN

    UUT : shift_register_structural PORT MAP(
        reg_input => reg_input_tb,
        rst => rst_tb,
        clk => clk_tb,
        shift => shift_tb,
        reg_output => reg_output_tb
    );

    clock : PROCESS
    BEGIN
        WAIT FOR 5 ns;
        clk_tb <= NOT clk_tb;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN

        WAIT FOR 100 ns;
        rst_tb <= '1';
        WAIT FOR 10 ns;
        rst_tb <= '0';
        WAIT FOR 10 ns;
        
        reg_input_tb <= '1'; -- Input di prova

        shift_tb <= "01"; -- Shift di due posizioni a sinistra
        WAIT FOR 10 ns; -- 0011

        shift_tb <= "10"; -- Shift di una posizione a destra
        WAIT FOR 10 ns; -- 1001

        shift_tb <= "11"; -- Shift di due posizioni a destra
        WAIT FOR 10 ns; -- 1110
        
        shift_tb <= "00"; -- Shift di una posizione a sinistra
        WAIT FOR 10 ns; -- 1101
        
        WAIT;
    END PROCESS;
END behavioral;