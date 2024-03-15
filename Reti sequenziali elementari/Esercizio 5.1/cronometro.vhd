LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY cronometro IS
    PORT (
        clock : IN STD_LOGIC; -- Clock di sistema
        reset : IN STD_LOGIC; -- Reset del cronometro
        set : IN STD_LOGIC; -- Set per impostare il tempo iniziale
        start : IN STD_LOGIC; -- Avvio cronometro
        hours_in : IN STD_LOGIC_VECTOR(4 downto 0); -- Ore iniziali
        minutes_in : IN STD_LOGIC_VECTOR(5 downto 0); -- Minuti iniziali
        seconds_in : IN STD_LOGIC_VECTOR(5 downto 0); -- Secondi iniziali
        hours_out : OUT INTEGER RANGE 0 TO 23; -- Ore del cronometro
        minutes_out : OUT INTEGER RANGE 0 TO 59; -- Minuti del cronometro
        seconds_out : OUT INTEGER RANGE 0 TO 59 -- Secondi del cronometro
    );
END cronometro;

architecture structural of cronometro is

    component contatore_mod_n is
        GENERIC (
            N : POSITIVE := 6; 
            MAX : POSITIVE := 60
        );
        PORT (
            init : IN STD_LOGIC_VECTOR(N - 1 downto 0); 
            clock : IN STD_LOGIC; 
            set : IN STD_LOGIC; 
            reset : IN STD_LOGIC; 
            enable : IN STD_LOGIC;
            carry_out : OUT STD_LOGIC; 
            count : OUT INTEGER RANGE 0 TO MAX
        );
    end component;

    signal enable_m, enable_h : STD_LOGIC := '0';

    begin

        contatore_secondi : contatore_mod_n
            generic map(6, 59)
            port map(
                init => seconds_in,
                clock => clock,
                set => set,
                reset => reset,
                enable => start,
                carry_out => enable_m,
                count => seconds_out
            );
        contatore_minuti : contatore_mod_n
            generic map(6, 59)
            port map(
                init => minutes_in,
                clock => clock,
                set => set,
                reset => reset,
                enable => enable_m,
                carry_out => enable_h,
                count => minutes_out
            );
        contatore_ore : contatore_mod_n
            generic map(5, 23)
            port map(
                init => hours_in,
                clock => clock,
                set => set,
                reset => reset,
                enable => enable_h,
                count => hours_out
            );
end structural;