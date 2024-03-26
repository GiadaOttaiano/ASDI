library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity omega_network is
    port(
        msg0, msg1, msg2, msg3 : IN std_logic_vector(2 downto 0);
        sel : IN std_logic_vector(3 downto 0);
        output : OUT std_logic_vector(3 downto 0)
    );
end omega_network;

architecture structural of omega_network is

    component OU is
        port(
            input : IN std_logic_vector(3 downto 0);
            selection : IN std_logic_vector(3 downto 0);
            output : OUT std_logic_vector(3 downto 0)
        );
    end component;

    component manager is
        port(
            prio0, prio1, prio2, prio3 : IN std_logic;
            sel_source : OUT std_logic_vector(1 downto 0)
        );
    end component;

    signal temp_source : std_logic_vector(1 downto 0);
    signal temp_destination : std_logic_vector(1 downto 0);

    begin
        operative_unit : OU
            port map(
                input(0) => msg0(2),
                input(1) => msg1(2),
                input(2) => msg2(2),
                input(3) => msg3(2),
                selection(0) => temp_source(0),
                selection(1) => temp_destination(0),
                selection(2) => temp_source(1),
                selection(3) => temp_destination(1),
                output => output
            );

        man : manager
            port map(
                prio0 => sel(0),
                prio1 => sel(1),
                prio2 => sel(2),
                prio3 => sel(3),
                sel_source => temp_source
            );

        with 

end structural;