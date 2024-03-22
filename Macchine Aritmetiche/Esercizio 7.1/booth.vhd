library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity booth_multiplier is 
    port(
        X, Y : IN std_logic_vector(7 downto 0);
        clock, reset, start : IN std_logic;
        P : OUT std_logic_vector(15 downto 0);
        stop : OUT std_logic
    );
end booth_multiplier;

architecture structural of booth_multiplier is

    component CU is
        port(
            Q : IN std_logic_vector(1 downto 0);
            cu_clock, cu_start, cu_reset : IN std_logic;
            cu_count : IN std_logic_vector(2 downto 0);
            cu_loadAQ, cu_count_in, cu_shift, cu_loadM, cu_selAQ, cu_sub, cu_stop: OUT std_logic
        );
    end component;

    component OU is
        port(
            ou_in_1, ou_in_2 : IN std_logic_vector(7 downto 0);
            ou_clock, ou_reset, ou_loadAQ, ou_loadM, ou_shift, ou_selAQ, ou_count_in, ou_sub : IN std_logic;
            ou_result : OUT std_logic_vector(16 downto 0);
            ou_count : OUT std_logic_vector(2 downto 0)
        );
    end component;

    signal tempQ : std_logic_vector(1 downto 0);
    signal temp_count : std_logic_vector(2 downto 0);
    signal tempP : std_logic_vector(16 downto 0);
    signal loadAQ, loadM, count_in, shift, sub, selAQ : std_logic;

    begin
        control_unit : CU
            port map(
                Q => tempQ,
                cu_clock => clock,
                cu_start => start,
                cu_reset => reset,
                cu_count => temp_count,
                cu_loadAQ => loadAQ,
                cu_count_in => count_in,
                cu_shift => shift,
                cu_loadM => loadM,
                cu_selAQ => selAQ,
                cu_sub => sub,
                cu_stop => stop
            );

        operative_unit : OU
            port map(
                ou_in_1 => X,
                ou_in_2 => Y,
                ou_clock => clock,
                ou_reset => reset,
                ou_loadAQ => loadAQ,
                ou_count_in => count_in,
                ou_shift => shift,
                ou_sub => sub,
                ou_loadM => loadM,
                ou_selAQ => selAQ, 
                ou_result => tempP,
                ou_count => temp_count
            );

        tempQ <= tempP(1 downto 0);
        P <= tempP(16 downto 1);

end structural;