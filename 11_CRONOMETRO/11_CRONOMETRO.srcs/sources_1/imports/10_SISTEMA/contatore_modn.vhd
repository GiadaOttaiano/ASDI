library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contatore_modn is
    generic(
        n : positive := 6;
        max : positive := 60
    );
    port(
        en : in std_logic;
        clk: in std_logic;
        load : in std_logic;
        init : in std_logic_vector(n-1 downto 0);
        rst : in std_logic;
        q : out std_logic_vector(n-1 downto 0);
        co : out std_logic
    );
end contatore_modn;

architecture beh of contatore_modn is
    
    signal cont : std_logic_vector(n-1 downto 0) := (others => '0');

    begin
        
        process(clk) begin
        
         if (load = '1') then
                    cont <= init;
         end if;
         
         if(clk'event and clk = '1') then
            if(rst = '1') then
                cont <= (others => '0');
            else
                if(en = '1') then
                    cont <= std_logic_vector(unsigned(cont) + 1);
                    if unsigned(cont) = max then
                        cont <= (others => '0');
                    end if;
                end if;
            end if;
         end if;
        end process;
        q <= cont;
        co <= '1' when unsigned(cont) = max
                  else '0';
end beh; 
