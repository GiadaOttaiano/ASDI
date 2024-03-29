LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY demux12 IS
    PORT (
        demux_12_in : IN STD_LOGIC;
        demux_12_sel : IN STD_LOGIC;
        demux_12_out : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END demux12;

ARCHITECTURE dataflow OF demux12 IS
BEGIN
    demux_12_out(0) <= ((NOT demux_12_sel) AND demux_12_in);
    demux_12_out(1) <= (demux_12_sel AND demux_12_in);
END dataflow;