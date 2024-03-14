LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY riconoscitore_sequenziale IS
    PORT (
        rs_input : IN STD_LOGIC;
        rs_mode : IN STD_LOGIC;
        rs_temp : IN STD_LOGIC;
        rs_output : OUT STD_LOGIC
    );
END riconoscitore_sequenziale;

ARCHITECTURE behavioral OF riconoscitore_sequenziale IS
    TYPE state IS (Q0, Q1, Q2, Q3, Q4);
    SIGNAL current_state : state := Q0;
    SIGNAL next_state : state;
    SIGNAL next_output : STD_LOGIC := 'U';

BEGIN
    transition : PROCESS (current_state, rs_input, rs_mode)
    BEGIN
        CASE rs_mode IS
            WHEN '0' =>
                CASE current_state IS
                    WHEN Q0 =>
                        IF (rs_input = '1') THEN
                            next_state <= Q1;
                        ELSE
                            next_state <= Q2;
                        END IF;
                        next_output <= '0';

                    WHEN Q1 =>
                        IF (rs_input = '1') THEN
                            next_state <= Q3;
                        ELSE
                            next_state <= Q4;
                        END IF;
                        next_output <= '0';

                    WHEN Q2 =>
                        next_state <= Q3;
                        next_output <= '0';

                    WHEN Q3 =>
                        next_state <= Q0;
                        next_output <= '0';

                    WHEN Q4 =>
                        next_state <= Q0;
                        IF (rs_input = '1') THEN
                            next_output <= '1';
                        ELSE
                            next_output <= '0';
                        END IF;
                    WHEN OTHERS =>
                        next_state <= Q0;
                        next_output <= '0';
                END CASE;
            WHEN '1' =>
                CASE current_state IS
                    WHEN Q0 =>
                        IF (rs_input = '1') THEN
                            next_state <= Q1;
                        ELSE
                            next_state <= Q0;
                        END IF;
                        next_output <= '0';

                    WHEN Q1 =>
                        IF (rs_input = '1') THEN
                            next_state <= Q1;
                        ELSE
                            next_state <= Q2;
                        END IF;
                        next_output <= '0';

                    WHEN Q2 =>
                        next_state <= Q0;
                        IF (rs_input = '1') THEN
                            next_output <= '1';
                        ELSE
                            next_output <= '0';
                        END IF;
                    WHEN OTHERS =>
                        next_state <= Q0;
                        next_output <= '0';
                END CASE;
            WHEN OTHERS =>
                next_state <= Q0;
                next_output <= '0';
        END CASE;
    END PROCESS;

    clock : PROCESS (rs_temp)
    BEGIN
        IF (rs_temp'event AND rs_temp = '1') THEN
            current_state <= next_state;
            rs_output <= next_output;
        END IF;
    END PROCESS;
END behavioral;