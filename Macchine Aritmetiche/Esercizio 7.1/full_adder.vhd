LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY full_adder IS
    PORT (
        fa_in_1, fa_in_2, fa_c_in : IN STD_LOGIC;
        fa_out, fa_c_out : OUT STD_LOGIC
    );
END full_adder;

ARCHITECTURE dataflow OF full_adder IS

BEGIN
    fa_out <= ((fa_in_1 XOR fa_in_2) XOR fa_c_in);
    fa_c_out <= ((fa_in_1 AND fa_in_2) OR (fa_c_in AND (fa_in_1 XOR fa_in_2)));
END dataflow;