
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

    entity cronometro is
          port ( 
                load_s : in std_logic;
                load_m : in std_logic;
                load_o : in std_logic;
                start : in std_logic;
                clk : in std_logic;  
                rst : in std_logic;
                init_s : in std_logic_vector(5 downto 0);
                init_m : in std_logic_vector(5 downto 0);
                init_o : in std_logic_vector(4 downto 0);
                secondi : out std_logic_vector(5 downto 0);
                minuti : out std_logic_vector(5 downto 0);
                ore : out std_logic_vector(4 downto 0)
          );
    end cronometro;
    
    architecture structural of cronometro is
    
        component contatore_modn is
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
        end component;
           
                
        signal en_m, en_o :std_logic;
        signal ab_m, ab_o :std_logic;
         
        begin

        contatore_secondi : contatore_modn
        generic map(
            n => 6,
            max => 59
        )
        port map(
            en => start,
            clk => clk,
            load => load_s,
            init => init_s,
            rst => rst,
            q => secondi, 
            co => en_m 
        );
        ab_m <= start and en_m;
        contatore_minuti : contatore_modn
        generic map(
            n => 6,
            max => 59
        )
        port map(
            en => ab_m,
            clk => clk,
            load => load_m,
            init => init_m,
            rst => rst,
            q => minuti,
            co => en_o
        );
        ab_o <= start and en_o;
        contatore_ore : contatore_modn
        generic map(
            n => 5,
            max => 23
        )
        port map(
            en => ab_o,
            clk => clk,
            load => load_o,
            init => init_o,
            rst => rst,
            q => ore
        );
    
 end structural;
