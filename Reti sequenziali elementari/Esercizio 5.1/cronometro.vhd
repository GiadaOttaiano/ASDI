LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY cronometro IS
    PORT (
        clock : IN STD_LOGIC; -- Clock di sistema
        reset : IN STD_LOGIC; -- Reset del cronometro
        set : IN STD_LOGIC; -- Set per impostare il tempo iniziale
        hours_in : IN INTEGER RANGE 0 TO 23; -- Ore iniziali
        minutes_in : IN INTEGER RANGE 0 TO 59; -- Minuti iniziali
        seconds_in : IN INTEGER RANGE 0 TO 59; -- Secondi iniziali
        hours_out : OUT INTEGER RANGE 0 TO 23; -- Ore del cronometro
        minutes_out : OUT INTEGER RANGE 0 TO 59; -- Minuti del cronometro
        seconds_out : OUT INTEGER RANGE 0 TO 59 -- Secondi del cronometro
    );
END cronometro;

architecture structural of cronometro is

    component contatore_mod_n is
        GENERIC (
            N : INTEGER := 6; -- Larghezza del contatore
            MAX : INTEGER := 60 -- Conteggio massimo
        );
        PORT (
            clock : IN STD_LOGIC; -- Clock di sistema
            reset : IN STD_LOGIC; -- Reset del contatore
            enable : IN STD_LOGIC := '1'; -- Abilitazione del contatore
            count : OUT INTEGER RANGE 0 TO MAX -- Conteggio del contatore
        );
    end component;

    signal hours_count : INTEGER RANGE 0 TO 23 := 'U'
    signal minutes_count, seconds_count : INTEGER RANGE 0 TO 59 := 'U';
    signal set_sync, reset_sync : STD_LOGIC := 'U';

    begin

        -- Sincronizzazione degli input
        process(clock, reset)
        begin
            if reset = '1' then
                reset_sync <= '1';
                set_sync <= '0'active
            elsif rising_edge(clock) then
                reset_sync <= '0';
                set_sync <= set;
            end if;
        end process;

        contatore_secondi : contatore_mod_n
            generic map(6, 59)
            port map(
                clock => clock,
                reset => reset_sync,
                enable => set_sync,
                count => seconds_count
            );
        contatore_minuti : contatore_mod_n
            generic map(6, 59)
            port map(
                clock => clock,
                reset => reset_sync,
                enable => set_sync,
                count => minutes_count
            );
        contatore_secondi : contatore_mod_n
            generic map(5, 23)
            port map(
                clock => clock,
                reset => reset_sync,
                enable => set_sync,
                count => hours_count
            );

        -- Output dei valori
        process (hours_count, minutes_count, seconds_count)
        begin
            hours_out <= hours_count;
            minutes_out <= minutes_count;
            seconds_out <= seconds_count;
        end process;
end structural;