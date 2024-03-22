LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY booth_multiplier_tb IS
END booth_multiplier_tb;

ARCHITECTURE behavioural OF booth_multiplier_tb IS

    COMPONENT booth_multiplier IS
        PORT (
            X, Y : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            start, clock, reset : IN STD_LOGIC;
            P : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            cu_stop : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL inputx, inputy : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL prod : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL clk, res, start : STD_LOGIC;
    SIGNAL t_stop : STD_LOGIC := '0';
    CONSTANT clk_period : TIME := 20 ns;

BEGIN

    uut : booth_multiplier PORT MAP(inputx, inputy, start, clk, res, prod, t_stop);

    clk_process : PROCESS
    BEGIN
        WHILE TRUE LOOP
            clk <= '1';
            WAIT FOR clk_period/2;
            clk <= '0';
            WAIT FOR clk_period/2;
        END LOOP;
        WAIT;
    END PROCESS;

    -- SIMULARE PER 9000 NS
    sim : PROCESS
    BEGIN

        WAIT FOR 100 ns;

        res <= '1';
        WAIT FOR 20 ns;
        res <= '0';

        -- -------------------------------------   operazione numero 1:
        -- 15*3=45 (002D)
        inputx <= "00001111";
        inputy <= "00000011";

        -- start deve essere visto da clk_div: poich� sar� generato dal button debouncer si aggiunger� anche il clk_div
        -- al button debouncer e il segnale di start deve durare quanto il periodo del clk rallentato
        WAIT FOR 40 ns;
        start <= '1';
        WAIT FOR 20 ns;
        start <= '0';
        WAIT;
    END PROCESS;
END behavioural;