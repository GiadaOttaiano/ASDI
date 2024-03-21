LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity converter is
    port(
        seconds, minutes : IN std_logic_vector(5 downto 0);
        hours : IN std_logic_vector(3 downto 0);
        output : OUT std_logic_vector(31 downto 0)
    );
end converter;

architecture behavioral of converter is

    signal seconds_units : integer;
    signal seconds_tens : integer;
    signal minutes_units : integer;
    signal minutes_tens : integer;
    signal hours_units : integer;
    signal hours_tens : integer;

    signal seconds_tot : std_logic_vector(7 downto 0);
    signal minutes_tot : std_logic_vector(7 downto 0);
    signal hours_tot : std_logic_vector(7 downto 0);
    signal output_temp : std_logic_vector(31 downto 0);

    begin
        seconds_units <= to_integer(unsigned(seconds)) mod 10;
        seconds_tens <= to_integer(unsigned(seconds)) / 10;
        
        minutes_units <= to_integer(unsigned(minutes)) mod 10;
        minutes_tens <= to_integer(unsigned(minutes)) / 10;
        
        hours_units <= to_integer(unsigned(hours)) mod 10;
        hours_tens <= to_integer(unsigned(hours)) / 10;

        seconds_tot (3 downto 0) <= std_logic_vector(to_unsigned(seconds_units, 4));
        seconds_tot (7 downto 4) <= std_logic_vector(to_unsigned(seconds_tens, 4));
        
        minutes_tot (3 downto 0) <= std_logic_vector(to_unsigned(minutes_units, 4));
        minutes_tot (7 downto 4) <= std_logic_vector(to_unsigned(minutes_tens, 4));
        
        hours_tot (3 downto 0) <= std_logic_vector(to_unsigned(hours_units, 4));
        hours_tot (7 downto 4) <= std_logic_vector(to_unsigned(hours_tens, 4));

        output_temp(7 downto 0) <= seconds_tot;
        output_temp(11 downto 8) <= "1111";
        output_temp(19 downto 12) <= minutes_tot;
        output_temp(23 downto 20) <= "1111";
        output_temp(31 downto 24) <= hours_tot;

        output <= output_temp;
end behavioral;