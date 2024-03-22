library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity full_adder is
    port(
        fa_in_1, fa_in_2, fa_cin : IN std_logic;
        fa_cout, fa_out : OUT std_logic
    );
end full_adder;

architecture dataflow of full_adder is

    begin 

        fa_out <= ((fa_in_1 XOR fa_in_2) XOR fa_cin);
        fa_cout <= ((fa_in_1 AND fa_in_2) OR (fa_cin AND (fa_in_1 XOR fa_in_2)));

end dataflow;