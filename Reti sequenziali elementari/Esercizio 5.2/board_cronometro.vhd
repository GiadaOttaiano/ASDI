library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cronometro_on_board is
    port (
        rst, clk : in STD_LOGIC;
        anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        bottone_secondi : in STD_LOGIC;
        bottone_minuti : in STD_LOGIC;
        bottone_ore : in STD_LOGIC;
        hours_in : IN STD_LOGIC_VECTOR(4 downto 0); 
        minutes_in : IN STD_LOGIC_VECTOR(5 downto 0); 
        seconds_in : IN STD_LOGIC_VECTOR(5 downto 0)
    );
end cronometro_on_board;

architecture structural of cronometro_on_board is

    component contatore_mod_n is
        GENERIC (
            N : POSITIVE := 6; 
            MAX : POSITIVE := 60
        );

        PORT (
            bottone_load: in std_logic;
            init : IN STD_LOGIC_VECTOR(N - 1 downto 0); 
            clock : IN STD_LOGIC; 
            set : IN STD_LOGIC; 
            reset : IN STD_LOGIC; 
            enable : IN STD_LOGIC;
            carry_out : OUT STD_LOGIC; 
            count : OUT INTEGER RANGE 0 TO MAX
        );
    end component;

    component button_debouncer
        generic (
            CLK_period: integer := 10; -- Period of the board’s clock in nanoseconds
            btn_noise_time: integer := 10000000 -- Estimated button bounce duration in nanoseconds
        );
        port (
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BTN : in STD_LOGIC;
            CLEARED_BTN : out STD_LOGIC
        );
    end component;

    component display_seven_segments
        generic(
            CLKIN_freq : integer := 100000000;
            CLKOUT_freq : integer := 500
        );
        port ( 
            CLK : in STD_LOGIC;
            RST : in STD_LOGIC;
            VALUE : in STD_LOGIC_VECTOR (31 downto 0);
            ENABLE : in STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
            DOTS : in STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
            ANODES : out STD_LOGIC_VECTOR (7 downto 0);
            CATHODES : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    component clock_filter
        generic(
            CLKIN_freq : integer := 100000000;
            CLKOUT_freq : integer := 1
        );
        port(
            clock_in : IN std_logic;
            reset : in STD_LOGIC;
            clock_out : OUT std_logic
        );
    end component;

    component converter is
        port(
            seconds, minutes : IN std_logic_vector(5 downto 0);
            hours : IN std_logic_vector(3 downto 0);
            output : OUT std_logic_vector(31 downto 0)
        );
    end component;

    signal enable_m, enable_h : STD_LOGIC := '0';
    signal temp : std_logic;

    signal cleared_seconds_b, cleared_minutes_b, cleared_hours_b, cleared_reset_b : std_logic;

    signal val_32bit : std_logic_vector(31 downto 0);

    signal temp_s : std_logic_vector(5 downto 0) := (others => '0');
    signal temp_m : std_logic_vector(5 downto 0) := (others => '0');
    signal temp_h : std_logic_vector(4 downto 0) := (others => '0');

    signal filtered_clock : std_logic;

    begin

        clk_filter: clock_filter
            generic map(
                CLKIN_freq => 100000000,
                CLKOUT_freq => 1
            )
            port map(
                clock_in => clk_tot,
                reset => cleared_reset_b,
                clock_out => filtered_clock
            );

        cont_secondi: cont_mod_n
            generic map (
                N => 6,
                max => 60
            )
            port map (
                bottone_load => cleared_seconds_b,
                init => set_s,
                clock => clk_tot,
                reset => cleared_reset_b,
                count_in => filtered_clock,
                count => temp_s,
                y => enable_m
            );

        cont_minuti: cont_mod_n
            generic map (
                N => 6,
                max => 60
            )
            port map (
                bottone_load => cleared_minutes_b,
                init => set_m,
                clock => clk_tot,
                reset => cleared_reset_b,
                count_in => enable_m,
                count => temp_m,
                y => enable_h
            );

        cont_ore: cont_mod_n
            generic map (
                N => 4,
                max => 12
            )
            port map (
                bottone_load => cleared_hours_b,
                init => set_o,
                clock => clk_tot,
                reset => cleared_reset_b,
                count_in => enable_h,
                count => temp_o,
                y => temp
            );

        de_B_sec: button_debouncer
            Generic map (
                CLK_period => 10, -- Period of the board’s clock in 10ns
                btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
            )
            Port map (
                RST => '0','
                CLK => clk_tot,
                BTN => bottone_secondi,
                CLEARED_BTN => cleared_seconds_b
            );

        de_B_min: button_debouncer
            Generic map (
                CLK_period => 10, -- Period of the board’s clock in 10ns
                btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
            )
            Port map (
                RST => '0'',
                CLK => clk_tot,
                BTN => bottone_minuti,
                CLEARED_BTN => cleared_minutes_b
            );

        de_B_ore: button_debouncer
            Generic map (
                CLK_period => 10, -- Period of the board’s clock in 10ns
                btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
            )
            Port map (
                RST => '0',
                CLK => clk_tot,
                BTN => bottone_ore,
                CLEARED_BTN => cleared_hours_b
            );

        de_B_rst: button_debouncer
            Generic map (
                CLK_period => 10, -- Period of the board’s clock in 10ns
                btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
            )
            Port map (
                RST => '0',
                CLK => clk_tot,
                BTN => rst_tot,
                CLEARED_BTN => cleared_reset_b
            );

        input_display : convertitore
            Port map(
                secondi => temp_s,
                minuti => temp_m,
                ore => temp_o,
                uscita => val_32bit
            );

        seven_segment_array: display_seven_segments
            Generic map(
                CLKIN_freq => 100000000, --qui inserisco i parametri effettivi (clock della board e clock in uscita desiderato)
                CLKOUT_freq => 500 --inserendo un valore inferiore si vedranno le cifre illuminarsi in sequenza
            )
            Port map(
                CLK => clk_tot,
                RST => '0',
                value => val_32bit,
                enable => "11111111", --stabilisco che tutti i display siano accesi
                dots => "00000000", --stabilisco che tutti i punti siano spenti
                anodes => anodes_out,
                cathodes => cathodes_out
            );

end structural;