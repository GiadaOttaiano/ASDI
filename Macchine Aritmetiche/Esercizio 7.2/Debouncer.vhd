library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity ButtonDebouncer is
    generic(
        CLK_period : integer := 10; -- periodo clock in ns
        btn_noise_time : integer := 10000000 -- durata oscillazione bottone in ns 
    );

    port(
        RST : IN STD_LOGIC;
        CLK : IN STD_LOGIC;
        BTN : IN STD_LOGIC;
        CLEARED_BTN : OUT STD_LOGIC
    );
end ButtonDebouncer;

architecture behavioral of ButtonDebouncer is

    type state is (NOT_PRESSED, CHECK_NOT_PRESSED, PRESSED, CHECK_PRESSED);
    signal BTN_STATE : stato := NOT_PRESSED;

    constant max_count : integer := btn_noise_time/CLK_period; -- 10000000/10 = conto 1000000 colpi di clock 

    begin
        process(CLK)
        variable count : integer := 0;

        begin
            if(CLK'EVENT and CLK = '1') then
                if RST = '1' then
                    BTN_STATE <= NOT_PRESSED;
                    CLEARED_BTN <= '0';
                else
                    case BTN_STATE is
                        when NOT_PRESSED =>
                            if BTN = '1' then
                                BTN_STATE <= CHECK_PRESSED;
                            else 
                                BTN_STATE <= NOT_PRESSED;
                            end if;
                        when CHECK_PRESSED =>
                            if count = max_count - 1 then
                                if BTN = '1' then
                                    count := 0;
                                    CLEARED_BTN <= '1';
                                    BTN_STATE <= PRESSED;
                                else
                                    count := 0;
                                    BTN_STATE <= NOT_PRESSED;
                                end if;
                            else
                                count := count + 1;
                                BTN_STATE <= CHECK_PRESSED;
                            end if;
                        when PRESSED => 
                            CLEARED_BTN <= '0'; 
                                if BTN = '0' then
                                    BTN_STATE <= CHECK_NOT_PRESSED;
                                else
                                    BTN_STATE <= PRESSED;
                                end if;
                        when CHECK_NOT_PRESSED =>
                                if count = max_count - 1 then
                                    if BTN = '0' then
                                        count := 0;
                                        BTN_STATE <= NOT_PRESSED;
                                    else
                                        count := 0;
                                        BTN_STATE <= PRESSED;
                                    end if;
                                else
                                    count := count + 1;
                                    BTN_STATE <= CHECK_NOT_PRESSED;
                                end if;
                        when others => 
                                BTN_STATE <= NOT_PRESSED;
                    end case;
                end if;
            end if;
        end process;
end behavioral;