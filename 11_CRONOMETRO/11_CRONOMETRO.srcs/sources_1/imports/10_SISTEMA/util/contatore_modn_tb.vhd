library IEEE;
use IEEE.std_logic_1164.all;


entity contatore_modn_tb is
end contatore_modn_tb;

architecture rtl of contatore_modn_tb is
    
    component contatore_modn is
        generic(
            n : positive := 6;
            max : positive := 2**6-1
        );
        port(
            en : in std_logic;
            clk: in std_logic;
            rst : in std_logic;
            load : in std_logic;
            init : in std_logic_vector(n-1 downto 0);
            q : out std_logic_vector(n-1 downto 0);
            co : out std_logic
        );
    end component;

    
    signal output : std_logic_vector(5 downto 0) := (others => 'U');
    signal input : std_logic_vector(5 downto 0) := (others => 'U');
    signal reset : std_logic := 'U';
    signal clock : std_logic := 'U';
    signal init : std_logic := 'U';
    signal enable : std_logic := 'U';
    signal riporto :  std_logic := 'U';
    
    constant PERIOD : time := 5 ns;

    begin
    dut: contatore_modn
    port map(
        en => enable,
        rst => reset,
        load => init,
        q => output,
        init => input,
        clk => clock,
        co => riporto
    );

    stim_proc : process begin
             init <= '1';
             input <= "111110";
             clock <= '1';
             wait for PERIOD/2;
             clock <= '0';
             init <= '0';
             enable <= '1';
             wait for PERIOD/2;
             clock <= '1';
             wait for PERIOD/2;
             clock <= '0';
             wait for PERIOD/2;
             clock <= '1';
             wait for PERIOD/2;
             clock <= '0';
             wait for PERIOD/2;
             clock <= '1';
             wait for PERIOD/2;
             wait;
    end process;
end;