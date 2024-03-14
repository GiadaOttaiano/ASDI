library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity riconoscitore_sequenza is
    port(
        i : IN STD_LOGIC;
        m : IN STD_LOGIC;
        a : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
end riconoscitore_sequenza;

architecture behavioral of riconoscitore_sequenza is
    type stato is (q0, q1, q2, q3, q4);
    signal stato_corrente : stato := q0;
    signal stato_prossimo : stato;
    signal uscita_corrente : STD_LOGIC := 'U';
    signal modalità_corrente : STD_LOGIC := 'U';

    begin
        transizione : process(stato_corrente, i, m)
        begin
            case m is
                when '0' =>
                    case stato_corrente is
                        when q0 =>
                            if (i = '1') then
                                stato_prossimo <= q1;
                                uscita_corrente <= '0';
                            else
                                stato_prossimo <= q2;
                                uscita_corrente <= '0';
                            end if;
                        when q1 =>
                            if (i = '1') then
                                stato_prossimo <= q3;
                                uscita_corrente <= '0';
                            else
                                stato_prossimo <= q4;
                                uscita_corrente <= '0';
                            end if;
                        when q2 =>
                            stato_prossimo <= q3;
                            uscita_corrente <= '0';
                        when q3 =>
                            stato_prossimo <= q0;
                            uscita_corrente <= '0';
                        when q4 =>
                            stato_prossimo <= q0;
                            if (i = '1') then
                                uscita_corrente <= '1';
                            else
                                uscita_corrente <= '0';
                            end if;
                    end case;
                when '1' =>
                    case stato_corrente is
                        when q0 => 
                            if (i = '1') then
                                stato_prossimo <= q1;
                                uscita_corrente <= '0';
                            else
                                stato_prossimo <= q0;
                                uscita_corrente <= '0';
                            end if;
                        when q1 => 
                            if (i = '1') then
                                stato_prossimo <= q1;
                                uscita_corrente <= '0';
                            else
                                stato_prossimo <= q2;
                                uscita_corrente <= '0';
                            end if;
                        when q2 => 
                            stato_prossimo <= q0;
                            if (i = '1') then
                                uscita_corrente <= '1';
                            else
                                uscita_corrente <= '0';
                            end if;
                    end case;
        end process;

        tempificazione : process(a)
        begin
            if (a'event and a = '1') then
                stato_corrente <= stato_prossimo;
                m <= modalità_corrente;
                y <= uscita_corrente;
            end if;
        end process;
end behavioral;