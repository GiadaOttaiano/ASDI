library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cronometro_on_board is
    port (
        reset, clock : in STD_LOGIC;
        anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        seconds_button : in STD_LOGIC;
        minutes_button : in STD_LOGIC;
        hours_button : in STD_LOGIC;
        hours_in : in STD_LOGIC_VECTOR(4 downto 0); 
        minutes_in : in STD_LOGIC_VECTOR(5 downto 0); 
        seconds_in : in STD_LOGIC_VECTOR(5 downto 0)
    );
end cronometro_on_board;

architecture structural of cronometro_on_board is

    component contatore_mod_n is
        GENERIC (
            N : POSITIVE := 2; 
            MAX : POSITIVE := 60
        );

        PORT (
            load_button: IN std_logic;
            init : IN STD_LOGIC_VECTOR(N - 1 downto 0); 
            clock : IN STD_LOGIC; 
            reset : IN STD_LOGIC; 
            enable : IN STD_LOGIC;
            carry_out : OUT STD_LOGIC; 
            count : OUT STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component;

    component ButtonDebouncer
        generic (
            CLK_period: integer := 10; 
            btn_noise_time: integer := 10000000 
        );
        port (
            RST : IN STD_LOGIC;
            CLK : IN STD_LOGIC;
            BTN : IN STD_LOGIC;
            CLEARED_BTN : OUT STD_LOGIC
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
    signal temp_h : std_logic_vector(3 downto 0) := (others => '0');

    signal filtered_clock : std_logic;

    begin

        clk_filter: clock_filter
            generic map(
                CLKIN_freq => 100000000,
                CLKOUT_freq => 1
            )
            port map(
                clock_in => clock,
                reset => cleared_reset_b,
                clock_out => filtered_clock
            );

        seconds_count: cont_mod_n
            generic map (
                N => 6,
                max => 60
            )
            port map (
                load_button => cleared_seconds_b,
                init => seconds_in,
                clock => clock,
                reset => cleared_reset_b,
                enable => filtered_clock,
                carry_out => enable_m,
                count => temp_s
            );

        minutes_count: cont_mod_n
            generic map (
                N => 6,
                max => 60
            )
            port map (
                load_button => cleared_minutes_b,
                init => minutes_in,
                clock => clock,
                reset => cleared_reset_b,
                enable => enable_m,
                carry_out => enable_h,
                count => temp_m                
            );

        hours_count: cont_mod_n
            generic map (
                N => 4,
                max => 12
            )
            port map (
                load_button => cleared_hours_b,
                init => hours_in,
                clock => clock,
                reset => cleared_reset_b,
                enable => enable_h,
                carry_out => temp,
                count => temp_h
            );

        Debouncer_seconds: button_debouncer
            Generic map (
                CLK_period => 10, 
                btn_noise_time => 10000000 
            )
            Port map (
                RST => '0','
                CLK => clock,
                BTN => seconds_button,
                CLEARED_BTN => cleared_seconds_b
            );

        Debouncer_minutes: button_debouncer
            Generic map (
                CLK_period => 10, 
                btn_noise_time => 10000000 
            )
            Port map (
                RST => '0'',
                CLK => clock,
                BTN => minutes_button,
                CLEARED_BTN => cleared_minutes_b
            );

        Debouncer_hours: button_debouncer
            Generic map (
                CLK_period => 10, 
                btn_noise_time => 10000000 
            )
            Port map (
                RST => '0',
                CLK => clock,
                BTN => hours_button,
                CLEARED_BTN => cleared_hours_b
            );

        Debouncer_reset: button_debouncer
            Generic map (
                CLK_period => 10, 
                btn_noise_time => 10000000
            )
            Port map (
                RST => '0',
                CLK => clock,
                BTN => reset,
                CLEARED_BTN => cleared_reset_b
            );

        input_display : convertitore
            Port map(
                seconds => temp_s,
                minutes => temp_m,
                hours => temp_h,
                output => val_32bit
            );

        seven_segment_array: display_seven_segments
            Generic map(
                CLKIN_freq => 100000000, 
                CLKOUT_freq => 500 
            )
            Port map(
                CLK => clock,
                RST => '0',
                value => val_32bit,
                enable => "11111111", -- Tutti i display accesi
                dots => "00000000", -- Tutti i punti spenti
                anodes => anodes_out,
                cathodes => cathodes_out
            );

end structural;