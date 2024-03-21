library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cronometro_board is
    port (
        rst_tot : in STD_LOGIC;
        clk_tot : in STD_LOGIC;
        anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        bottone_secondi : in STD_LOGIC;
        bottone_minuti : in STD_LOGIC;
        bottone_ore : in STD_LOGIC;
        set_s : in std_logic_vector(5 downto 0);
        set_m : in std_logic_vector(5 downto 0);
        set_o : in std_logic_vector(3 downto 0)
    );
end cronometro_board;

architecture structural of cronometro_board is

    component cont_mod_n is
        generic(
            N : positive := 2;
            max : positive := 60
        );
        port( 
            bottone_load: in std_logic;
            init : in std_logic_vector(N-1 downto 0);
            clock, reset: in std_logic;
            count_in: in std_logic;
            count: out std_logic_vector(N-1 downto 0);
            y : out std_logic
        );
    end component;

    component button_debouncer
        generic (
            CLK_period: integer := 10; -- Period of the
            board’s clock in nanoseconds
            btn_noise_time: integer := 10000000 -- Estimated
            button bounce duration in nanoseconds
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

    component convertitore is
        Port (
            secondi : in std_logic_vector(5 downto 0);
            minuti : in std_logic_vector(5 downto 0);
            ore : in std_logic_vector(3 downto 0);
            uscita : out std_logic_vector(31 downto 0)
        );
    end component;

    signal abilita_minuti : std_logic;
    signal abilita_ore : std_logic;
    signal temp : std_logic;

    signal bottone_s_pulito : std_logic;
    signal bottone_m_pulito : std_logic;
    signal bottone_o_pulito : std_logic;
    signal bottone_rst_pulito : std_logic;

    signal val_32bit : std_logic_vector(31 downto 0);

    signal temp_s : std_logic_vector(5 downto 0) := (others => '0');
    signal temp_m : std_logic_vector(5 downto 0) := (others => '0');
    signal temp_o : std_logic_vector(3 downto 0) := (others => '0');

    signal clock_filtrato : std_logic;

    begin

        clk_filter: clock_filter
            generic map(
                CLKIN_freq => 100000000,
                CLKOUT_freq => 1
            )
            port map(
                clock_in => clk_tot,
                reset => bottone_rst_pulito,
                clock_out => clock_filtrato
            );

        cont_secondi: cont_mod_n
            generic map (
                N => 6,
                max => 60
            )
            port map (
                bottone_load => bottone_s_pulito,
                init => set_s,
                clock => clk_tot,
                reset => bottone_rst_pulito,
                count_in => clock_filtrato,
                count => temp_s,
                y => abilita_minuti
            );

        cont_minuti: cont_mod_n
            generic map (
                N => 6,
                max => 60
            )
            port map (
                bottone_load => bottone_m_pulito,
                init => set_m,
                clock => clk_tot,
                reset => bottone_rst_pulito,
                count_in => abilita_minuti,
                count => temp_m,
                y => abilita_ore
            );

        cont_ore: cont_mod_n
            generic map (
                N => 4,
                max => 12
            )
            port map (
                bottone_load => bottone_o_pulito,
                init => set_o,
                clock => clk_tot,
                reset => bottone_rst_pulito,
                count_in => abilita_ore,
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
                CLEARED_BTN => bottone_s_pulito
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
                CLEARED_BTN => bottone_m_pulito
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
                CLEARED_BTN => bottone_o_pulito
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
                CLEARED_BTN => bottone_rst_pulito
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