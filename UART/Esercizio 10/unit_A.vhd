library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity unit_A is
    port(
        A_start, A_receive, A_clock, A_reset: IN std_logic;
        A_send, A_out : OUT std_logic
    );
end unit_A;

architecture structural of unit_A is

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

    component rom is
        port(
            r_address : IN std_logic_vector(2 downto 0);
            r_clock : IN std_logic;
            r_read : IN std_logic;
            r_out : OUT std_logic_vector(7 downto 0)
        );
    end component;

    component count_mod_8 is
        port(
            c_enable, c_clock, c_reset : IN std_logic;
            c_out : OUT std_logic_vector(2 downto 0);
            c_max : OUT std_logic
        );
    end component;

    component control_unit_A is
        port(
            cuA_start, cuA_reset, cuA_receive, cuA_clock, cuA_max, cuA_stop : IN std_logic;
            cuA_TBE : IN std_logic;
            cuA_reset_count, cuA_WR, cuA_rom_rd, cuA_count_en, cuA_send : OUT std_logic
        );
    end component;

    signal temp_address : std_logic_vector(2 downto 0) := (others => '0');
    signal temp_data : std_logic_vector(7 downto 0) := (others => '0');
    signal temp_read, temp_max, temp_reset, temp_enable, temp_WR, temp_TBE : std_logic := '0';


    begin
        UART_A : Rs232RefComp
            port map ( 
                TXD => A_out,
                RXD => RXD,		
                CLK => A_clock,		
                DBIN => temp_data,
                DBOUT => DBOUT,
                RDA	=> RDA,	
                TBE	=> temp_TBE,	
                RD => RD,
                WR => temp_WR,		
                PE => PE,		
                FE => FE,			
                OE => OE,			
                RST	=> A_reset   
            );
        
        ROM_A : rom
            port map(
                r_address => temp_address,
                r_read => temp_read,
                r_clock => A_clock,
                r_out => temp_data
            );
        
        COUNTER_A : count_mod_8
            port map(
                c_enable => temp_enable,
                c_clock => A_clock,
                c_reset => temp_reset,
                c_out => temp_address,
                c_max => temp_max
            );

        CUA : control_unit_A
            port map(
                cuA_start => A_start,
                cuA_reset => A_reset,
                cuA_receive => A_receive,
                cuA_clock => A_clock,
                cuA_max => temp_max,
                cuA_stop => cuA_stop,
                cuA_TBE => temp_TBE,
                cuA_reset_count => temp_reset,
                cuA_WR => temp_WR,
                cuA_rom_rd => temp_read,
                cuA_count_en => temp_enable,
                cuA_send => A_send
            );
end structural;