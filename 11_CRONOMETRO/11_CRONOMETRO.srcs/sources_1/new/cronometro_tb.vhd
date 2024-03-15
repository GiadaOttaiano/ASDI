
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity cronometro_tb is
end cronometro_tb;

architecture rtl of cronometro_tb is

   component cronometro is
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
    end component;
    
    signal load : std_logic := 'U';
    signal start :  std_logic := 'U';
    signal clk :  std_logic := 'U';
    signal rst :  std_logic := 'U';
    signal init_s :  std_logic_vector(5 downto 0) := (others => 'U');
    signal init_m : std_logic_vector(5 downto 0):= (others => 'U');
    signal init_o :  std_logic_vector(4 downto 0):= (others => 'U');
    signal s :  std_logic_vector(5 downto 0):= (others => 'U');
    signal m :  std_logic_vector(5 downto 0):= (others => 'U');
    signal o :  std_logic_vector(4 downto 0) := (others => 'U');
    constant SEMIPERIOD : time := 5 ns;
begin
    
    dut: cronometro
    port map(
                load_s => load,
                load_m => load,
                load_o => load,
                start => start,
                clk => clk,
                rst => rst,
                init_s => init_s,
                init_m => init_m,
                init_o => init_o,
                secondi => s,
                minuti => m,
                ore => o
    );
    
    stim_proc : process begin
             init_s <= "111011";
             init_m <= "111011";
             init_o <= "10111";
             clk <= '0';
             load <= '1';
             wait for 10 ns;
             load <= '0';
             wait for 10 ns;
             start <= '1';
             for i in 0 to 10 loop
                clk <= '0';
                wait for SEMIPERIOD;
                clk <= '1';
                wait for SEMIPERIOD;
             end loop;
             wait;
    end process;

end rtl;
