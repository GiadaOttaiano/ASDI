library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux12 is
    port(   
        demux12_input : in STD_LOGIC;
        demux12_sel : in STD_LOGIC;
        demux12_output : out STD_LOGIC_VECTOR(1 downto 0)
    );
end demux12;

architecture dataflow of demux12 is
    begin
        demux12_output(0) <= (demux12_input AND NOT(demux12_sel));
        demux12_output(1) <= (demux12_input AND demux12_sel);
end dataflow;
