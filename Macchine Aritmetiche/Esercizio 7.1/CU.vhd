LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CU IS
    PORT (
        Q : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        cu_start, cu_clock, cu_reset : IN STD_LOGIC;
        cu_count : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        cu_loadAQ, cu_count_in, cu_shift, cu_loadM, cu_sub, cu_selAQ, cu_stop : OUT STD_LOGIC
    );

END CU;

ARCHITECTURE behavioral OF CU IS

    TYPE state IS (IDLE, FETCH, WAIT_F, SCAN, RSHIFT, INCREMENT, STOP);
    SIGNAL current_state, next_state : state := IDLE;

BEGIN

    transition : PROCESS (cu_clock)
    BEGIN
        IF (rising_edge(cu_clock)) THEN
            IF (cu_reset = '1') THEN
                current_state <= IDLE;
                ELSE
                current_state <= next_state;
            END IF;
        END IF;
    END PROCESS;

    main : PROCESS (current_state, cu_start, cu_count)
    BEGIN

        cu_count_in <= '0';
        cu_sub <= '0';
        cu_selAQ <= '0';
        cu_loadAQ <= '0';
        cu_loadM <= '0';
        cu_stop <= '0';
        cu_shift <= '0';

        CASE current_state IS
            WHEN IDLE =>
                IF cu_start = '1' THEN
                    next_state <= FETCH;
                ELSE
                    next_state <= IDLE;
                END IF;
            WHEN FETCH =>
                cu_loadM <= '1';
                cu_loadAQ <= '1';
                next_state <= WAIT_F;
            WHEN WAIT_F =>
                next_state <= SCAN;
            WHEN SCAN =>
                IF (Q = "01") THEN
                    cu_selAQ <= '1';
                    cu_loadAQ <= '1';
                    next_state <= RSHIFT;
                ELSIF (Q = "10") THEN
                    cu_sub <= '1';
                    cu_selAQ <= '1';
                    cu_loadAQ <= '1';
                    next_state <= RSHIFT;
                ELSIF (Q = "00" OR Q = "11") THEN
                    next_state <= RSHIFT;
                END IF;
            WHEN RSHIFT =>
                cu_shift <= '1';
                IF cu_count = "111" THEN
                    next_state <= STOP;
                ELSE
                    next_state <= INCREMENT;
                END IF;
            WHEN INCREMENT =>
                cu_count_in <= '1';
                next_state <= SCAN;
            WHEN STOP =>
                cu_stop <= '1';
                next_state <= IDLE;
        END CASE;
    END PROCESS;
END behavioral;