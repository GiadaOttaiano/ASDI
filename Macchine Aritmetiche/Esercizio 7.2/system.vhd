library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity booth_on_board is
    port(
        READ, RESET, CLOCK : IN std_logic;
        X_in, Y_in : IN std_logic_vector(7 downto 0);
        Product : OUT std_logic_vector(15 downto 0);
        cu_stop : OUT std_logic
    );
end booth_on_board;

architecture structural of booth_on_board is
    component booth_multiplier is
        port (
            X, Y : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            start, clock, reset : IN STD_LOGIC;
            P : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            cu_stop : OUT STD_LOGIC
        );
    end component;

    component ButtonDebouncer is
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
    end component;

    signal cleared_read, cleared_reset : std_logic;

    begin
        debouncer_read : ButtonDebouncer
            generic map(10, 10000000)
            port map(
                RST => '0'',
                CLK => CLOCK,
                BTN => READ,
                CLEARED_TBN => cleared_read
            );

        debouncer_reset : ButtonDebouncer
            generic map(10, 10000000)
            port map(
                RST => '0',
                CLK => CLOCK,
                BTN => RESET,
                CLEARED_TBN => cleared_reset
            );

        multiplier : booth_multiplier
            port map(
                X => X_in,
                Y => Y_in,
                start => cleared_read,
                clock => CLOCK,
                reset => cleared_reset,
                P => Product,
                cu_stop => stop_cu
            );

end structural;