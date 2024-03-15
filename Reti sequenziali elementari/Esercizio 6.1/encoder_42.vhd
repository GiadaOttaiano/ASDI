library IEEE;
use IEEE.STD_LOGIC_1644.all;
use IEEE.numeric_std.all;

entity encoder_42 is

    port(
        encoder_in : IN STD_LOGIC_VECTOR(3 downto 0);
        encoder_out : OUT STD_LOGIC_VECTOR(1 downto 0)
    );
end encoder_42;

architecture dataflow of encoder_42 is

    begin
        encoder_out <= "00" when encoder_in = "0001" else
                        "01" when encoder_in = "0010" else
                        "10" when encoder_in = "0100" else
                        "11" when encoder_in = "1000" else
                        "--";
end dataflow;