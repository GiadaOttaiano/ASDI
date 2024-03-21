library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity system is
    port(
        s1, s2 : IN std_logic;
        b1, b2 : IN std_logic;
        clock100MHZ : IN STD_LOGIC;
        Y : OUT std_logic
    );
end system;

architecture structural of system is

    signal data : std_logic;
    signal mode : std_logic;
    signal cleared_b1 : std_logic;
    signal cleared_b2 : std_logic;

    component ButtonDebouncer is
        generic(
            CLK_period : integer := 10; 
            btn_noise_time : integer := 10000000
        );

        port(
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BTN : in STD_LOGIC;
            CLEARED_BTN : out STD_LOGIC
        );
    end component;

    component control_unit is 
        port(
            switch_s1, switch_s2, button_1, button_2, clock_cu : IN std_logic;
            output_data, outpude_mode : OUT std_logic        
        );
    end component;

    component riconoscitore_sequenziale is
        port (
            rs_input : IN STD_LOGIC;
            rs_mode : IN STD_LOGIC;
            rs_temp : IN STD_LOGIC;
            rs_output : OUT STD_LOGIC
        );
    end component;

    begin
        debouncer_b1 : ButtonDebouncer
            port map(
                RST => '0',
                CLK => clock100MHZ,
                BTN => b1,
                CLEARED_BTN => cleared_b1
            );
        debouncer_b2 : ButtonDebouncer
            port map(
                RST => '0',
                CLK => clock100MHZ,
                BTN => b2,
                CLEARED_BTN => cleared_b2
            );
        cu : control_unit
            port map(
                switch_s1 => s1,
                switch_s2 => s2,
                button_b1 => cleared_b1,
                button_b2 => cleared_b2,
                clock_cu => clock100MHZ,
                output_data => data,
                output_mode => mode
            );
        riconoscitore : riconoscitore_sequenziale
            port map(
                rs_input => data,
                rs_mode => mode,
                rs_temp => clock100MHZ,
                rs_output => Y
            );

end structural;