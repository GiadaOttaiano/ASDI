library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bit_manipulator is
    port (
        input_data : in STD_LOGIC_VECTOR(3 downto 0); 
        output_data : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity bit_manipulator;

architecture Behavioral of bit_manipulator is
    signal group1, group2 : STD_LOGIC_VECTOR(1 downto 0);
    signal result : signed(1 downto 0);
    
    begin 
        group1 <= input_data(3 downto 2);
        group2 <= input_data(1 downto 0);
        
        result <= signed(group1) - signed(group2);
        
        output_data <= STD_LOGIC_VECTOR(result) when result >= 0 else STD_LOGIC_VECTOR(result + to_signed(4, 2));

end architecture Behavioral;
