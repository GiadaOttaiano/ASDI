library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity OU is
    port(
        input : IN std_logic_vector(3 downto 0);
        selection : IN std_logic_vector(3 downto 0);
        output : OUT std_logic_vector(3 downto 0)
    );
end OU;

architecture structural of OU is

    component switch is
        port(
            switch_in : IN std_logic_vector(1 downto 0);
            switch_sel : IN std_logic_vector(1 downto 0);
            switch_out : OUT std_logic_vector(1 downto 0)
        );
    end component;

    signal temp_output : std_logic_vector(3 downto 0);

    begin
        switch0 : switch
            port map(
                switch_in(0) => input(0),
                switch_in(1) => input(2),
                switch_sel => selection(1 downto 0),
                switch_out => temp_output(1 downto 0)
            );

        switch1 : switch
            port map(
                switch_in(0) => input(1),
                switch_in(1) => input(3),
                switch_sel => selection(1 downto 0),
                switch_out => temp_output(3 downto 2)
            );

        switch2 : switch
            port map(
                switch_in(0) => temp_output(0),
                switch_in(1) => temp_output(2),
                switch_sel => selection(3 downto 2),
                switch_out => output(1 downto 0)
            );

        switch3 : switch
            port map(
                switch_in(0) => temp_output(1),
                switch_in(1) => temp_output(3),
                switch_sel => selection(3 downto 2),
                switch_out => output(3 downto 2)
            );
        
end structural;