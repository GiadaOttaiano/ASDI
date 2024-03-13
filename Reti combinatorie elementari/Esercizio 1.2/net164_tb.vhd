library IEEE;
use IEEE.std_logic_1164.ALL;

entity net164_tb is
end net164_tb;

architecture behavioural of net164_tb is
    component net164 is
        port(   net164_input : in STD_LOGIC_VECTOR(15 downto 0);
            net164_mux_s : in STD_LOGIC_VECTOR(3 downto 0);
            net164_demux_s : in STD_LOGIC_VECTOR(1 downto 0);
            net164_output : out STD_LOGIC_VECTOR(3 downto 0)     
        );
    end component;

    signal input : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    signal mux_control  : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal demux_control : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal output : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

    begin
        uut : net164
            port map(
                net164_input => input,
                net164_mux_s => mux_control,
                net164_demux_s => demux_control,
                net164_output => output
            );

    stim_proc : process
        begin
            wait for 100 ns;
            input <= "1000110101101101";

            wait for 10 ns;
            mux_control <= "0010";

            wait for 10 ns;
            demux_control <= "01";

            wait for 10 ns;
            wait;
        end process;
end;