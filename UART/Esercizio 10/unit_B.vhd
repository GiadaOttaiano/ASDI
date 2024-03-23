library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity unit_B is
    port(
        B_in, B_start, B_send, B_clock, B_reset: IN std_logic;
        B_receive : OUT std_logic
    );
end unit_B;

architecture structural of unit_B is

    component Rs232RefComp is
        Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;					
            CLK 	: in  std_logic;					--Master Clock
            DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
            DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
            RDA	: inout std_logic;						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
            TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
            RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
            WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
            PE		: out std_logic;					--Parity Error Flag
            FE		: out std_logic;					--Frame Error Flag
            OE		: out std_logic;					--Overwrite Error Flag
            RST		: in  std_logic	:= '0'              --Master Reset
        );			
    end component;

    component mem is
        port(
            m_data : IN std_logic_vector(7 downto 0);
            m_address : IN std_logic_vector(2 downto 0);
            m_clock : IN std_logic;
            m_write : IN std_logic;
            m_out : OUT std_logic_vector(7 downto 0)
        );
    end component;

    component count_mod_8 is
        port(
            c_enable, c_clock, c_reset : IN std_logic;
            c_out : OUT std_logic_vector(2 downto 0);
            c_max : OUT std_logic
        );
    end component;

    component control_unit_B is
        port(
            cuB_start, cuB_reset, cuB_clock, cuB_send, cuB_max, cuB_stop : IN std_logic;
            cuB_TBE, cuB_RDA : IN std_logic;
            cuB_reset_count, cuB_RD, cuB_mem_wr, cuB_count_en, cuB_receive : OUT std_logic
        );
    end component;

    signal temp_address : std_logic_vector(2 downto 0) := (others => '0');
    signal temp_data : std_logic_vector(7 downto 0) := (others => '0');
    signal temp_write, temp_max, temp_reset, temp_enable, temp_RD, temp_TBE, temp RDA : std_logic := '0';


    begin
        UART_B : Rs232RefComp
            port map ( 
                TXD => TXD,
                RXD => B_in,		
                CLK => B_clock,		
                DBIN => DBIN,
                DBOUT => temp_data,
                RDA	=> temp_RDA,	
                TBE	=> temp_TBE,	
                RD => temp_RD,
                WR => WR,		
                PE => PE,		
                FE => FE,			
                OE => OE,			
                RST	=> B_reset   
            );
        
        MEM_B : mem
            port map(
                m_data => temp_data,
                m_address => temp_address,
                m_clock => B_clock,
                m_write => temp_write,
                m_out => m_out
            );
        
        COUNTER_B : count_mod_8
            port map(
                c_enable => temp_enable,
                c_clock => B_clock,
                c_reset => temp_reset,
                c_out => temp_address,
                c_max => temp_max
            );

        CUB : control_unit_B
            port map(
                cuB_start => B_start,
                cuB_reset => B_reset,
                cuB_clock => B_clock,
                cuB_send => B_send,
                cuB_max => temp_max,
                cuB_stop => cuB_stop,
                cuB_TBE => temp_TBE,
                cuB_RDA => temp_RDA,
                cuB_reset_count => B_reset,
                cuB_RD => temp_RD,
                cuB_mem_wr => temp_write,
                cuB_count_en => temp_enable,
                cuB_send => B_receive
            );
end structural;