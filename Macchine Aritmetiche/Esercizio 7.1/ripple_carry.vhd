library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ripple_carry is
    port(
        rc_in_1, rc_in_2 : IN std_logic_vector(7 downto 0);
        rc_cin : IN std_logic;
        rc_cout : OUT std_logic;
        rc_out : OUT std_logic_vector(7 downto 0)
    );
end ripple_carry;

architecture structural of ripple_carry is

    signal temp : std_logic_vector(7 downto 0);

    component full_adder is
        port(
            fa_in_1, fa_in_2, fa_cin : IN std_logic;
            fa_cout, fa_out : OUT std_logic
        );
    end component;

    begin
        FA0 : full_adder
            port map(rc_in_1(0), rc_in_2(0), rc_cin, temp(0), rc_out(0));

        FA1to6 : FOR i IN 1 TO 6 GENERATE
                FA : full_adder port map(rc_in_1(i), rc_in_2(i), temp(i-1), temp(i), rc_out(i));
                END GENERATE;
        
        FA7 : full_adder
            port map(rc_in_1(7), rc_in_2(7), temp(6), rc_cout, rc_out(7));
end structural;