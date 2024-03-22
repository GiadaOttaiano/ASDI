library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity OU is
    port(
        ou_in_1, ou_in_2 : IN std_logic_vector(7 downto 0);
        ou_clock, ou_reset, ou_loadAQ, ou_loadM, ou_shift, ou_selAQ, ou_count_in, ou_sub : IN std_logic;
        ou_result : OUT std_logic_vector(16 downto 0);
        ou_count : OUT std_logic_vector(2 downto 0)
    );
end OU;

architecture structural of OU is

    component adder_subtractor is
        port(
            as_in_1, as_in_2 : IN std_logic_vector(7 downto 0);
            as_cin : IN std_logic;
            as_cout : OUT std_logic;
            as_out : OUT std_logic_vector(7 downto 0)
        );
    end component;

    component counter_mod_8 is
        port(
            c_in, c_clock, c_reset : IN std_logic;
            c_out : out std_logic_vector(2 downto 0)
        );
    end component;

    component register_8 is
        port(
            reg_input : IN std_logic_vector(7 downto 0);
            reg_clock, reg_reset, reg_load : IN std_logic;
            reg_output : OUT std_logic_vector(7 downto 0)
        );
    end component;

    component shift_register is
        port(
            sr_parallel_input : IN std_logic_vector(16 downto 0);
            sr_serial_input : IN std_logic;
            sr_clock, sr_reset, sr_load, sr_shift : IN std_logic;
            sr_parallel_output : OUT std_logic_vector(16 downto 0)
        );
    end component;

    component mux is
        generic (width : integer range 0 to 17 := 8);
        port( 
            mux_in_1, mux_in_2 : IN std_logic_vector(width - 1 downto 0); 
            mux_sel : IN std_logic;
            mux_out : OUT std_logic_vector(width - 1 downto 0)
        );
    end component;

    signal m_reg: std_logic_vector(7 downto 0); 
    signal AQ_init: std_logic_vector(16 downto 0); 
    signal AQ_in: std_logic_vector(16 downto 0); 
    signal AQ_out: std_logic_vector(16 downto 0); 
    signal partial: std_logic_vector(7 downto 0); 
    signal AQ_sum_in : std_logic_vector(16 downto 0);  
    signal carry: std_logic;
    signal sr_s_in: std_logic;
	
    begin

        M: register_8 port map(ou_in_2, ou_clock, ou_reset, ou_loadM, m_reg);
        
        AQ_init <= "00000000" & ou_in_1 & "0"; 
        
        AQ_sum_in <= partial & AQ_out(8 downto 0); 
        
        MUX_SR_parallel_in : mux generic map (width => 17) port map(AQ_init, AQ_sum_in, ou_selAQ, AQ_in); 
        
        sr_s_in <= AQ_out(16); 
            
        SR: shift_register port map(AQ_in, sr_s_in, ou_clock, ou_reset, ou_loadAQ, ou_shift, AQ_out);
        
        ADD_SUB : adder_subtractor port map(AQ_out(16 downto 9), m_reg, ou_sub, carry, partial);
        
        CONT: counter_mod_8 port map(ou_clock, ou_reset, ou_count_in, ou_count);
        
        ou_result <= AQ_out;

end structural;