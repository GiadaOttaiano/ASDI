LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY system_s_tb IS
END system_s_tb;

ARCHITECTURE behavioral OF system_s_tb IS
    SIGNAL input : STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL output : STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '0');
    
    COMPONENT system_s IS
        PORT (
            s_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            s_output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    uut : system_s
    PORT MAP(
        s_input => input,
        s_output => output
    );

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        input <= "0011";
        
        WAIT FOR 10 ns;
        input <= "1100";

        WAIT FOR 10 ns;
        input <= "1010";

        WAIT;
    END PROCESS;
END;