library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux12 is
    port(   a0 : in STD_LOGIC;
            s : in STD_LOGIC;
            demux12_output : out STD_LOGIC_VECTOR(1 downto 0)
    );
end demux12;

architecture dataflow of demux12 is
    begin
        demux12_output(0) <= (a0 AND NOT(s));
        demux12_output(1) <= (a0 AND s);
end dataflow;
