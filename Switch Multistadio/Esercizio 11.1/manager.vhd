library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity manager is
    port(
        prio0, prio1, prio2, prio3 : IN std_logic;
        sel_source : OUT std_logic_vector(1 downto 0)
    );
end manager;

architecture dataflow of manager is

    begin
        sel_source <= "00" when prio0 = '1' else
                    "01" when prio1 = '1' else
                    "10" when prio2 = '1' else
                    "11" when prio3 = '1' else
                    "--";

end dataflow;