library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder_subtractor is
    port(
        as_in_1, as_in_2 : IN std_logic_vector(7 downto 0);
        as_cin : IN std_logic;
        as_cout : OUT std_logic;
        as_out : OUT std_logic_vector(7 downto 0)
    );
end adder_subtractor;

architecture structural of adder_subtractor is

    component ripple_carry is
        port(
            rc_in_1, rc_in_2 : IN std_logic_vector(7 downto 0);
            rc_cin : IN std_logic;
            rc_cout : OUT std_logic;
            rc_out : OUT std_logic_vector(7 downto 0)
        );
    end component;

    signal complementoy : std_logic_vector(7 downto 0);

    begin 
        complemento_y : FOR i IN 0 TO 7 GENERATE
                        complementoy(i) <= as_in_2(i) XOR as_cin;
                        END GENERATE;

        RA : ripple_carry
            port map(as_in_1, complementoy, as_cin, as_cout, as_out);
end structural;