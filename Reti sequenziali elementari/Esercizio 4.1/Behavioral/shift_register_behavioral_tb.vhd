LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY shift_register_behavioral_tb IS
END shift_register_behavioral_tb;

ARCHITECTURE behavioral OF shift_register_behavioral_tb IS

    COMPONENT shift_register_behavioral
        PORT (
            reg_input : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            shift_dir : IN STD_LOGIC;
            Y : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            reg_output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL tb_clk : STD_LOGIC := '0';
    SIGNAL tb_rst : STD_LOGIC := '0';
    SIGNAL tb_shift_dir : STD_LOGIC := '0';
    SIGNAL tb_Y : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL tb_reg_input : STD_LOGIC := '0';
    SIGNAL tb_reg_output : STD_LOGIC_VECTOR(7 DOWNTO 0); -- Assumiamo N = 8

BEGIN
    uut : shift_register_behavioral
    PORT MAP(
        reg_input => tb_reg_input,
        clk => tb_clk,
        rst => tb_rst,
        shift_dir => tb_shift_dir,
        Y => tb_Y,
        reg_output => tb_reg_output
    );

    clock : PROCESS
    BEGIN
        WAIT FOR 5 ns;
        tb_clk <= NOT tb_clk;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        
        -- Reset
        tb_rst <= '1';
        WAIT FOR 5 ns;
        tb_rst <= '0';
        WAIT FOR 10 ns;

        -- Shift a destra di una posizione
        tb_shift_dir <= '0';
        tb_Y <= "01"; -- Quantità  dello shift (1)
        tb_reg_input <= '1'; -- Input da shiftare
        WAIT FOR 10 ns;

        -- Shift a sinistra di due posizioni
        tb_shift_dir <= '1';
        tb_Y <= "10"; -- Quantità  dello shift (2)
        tb_reg_input <= '1'; -- Input da shiftare
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END behavioral;