LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY OU IS
    PORT (
        ou_in_1, ou_in_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ou_clock, ou_reset, ou_loadAQ, ou_loadM, ou_shift, ou_sub, ou_selAQ, ou_count_in : IN STD_LOGIC;
        ou_result : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
        ou_count : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END OU;

ARCHITECTURE structural OF OU IS
    COMPONENT adder_subtractor IS
        PORT (
            as_in_1, as_in_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            as_c_in : IN STD_LOGIC;
            as_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            as_c_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT counter_mod_8 IS
        PORT (
            c_in, c_clock, c_reset : IN STD_LOGIC;
            c_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT register_8 IS
        PORT (
            r_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            r_clock, r_reset, r_load : IN STD_LOGIC;
            r_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );

    END COMPONENT;

    COMPONENT shift_register IS
        PORT (
            sr_parallel_in : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
            sr_serial_in : IN STD_LOGIC;
            sr_clock, sr_reset, sr_load, sr_shift : IN STD_LOGIC;
            sr_out : OUT STD_LOGIC_VECTOR(16 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT mux IS
        GENERIC (width : INTEGER RANGE 0 TO 17 := 8);
        PORT (
            mux_in_1, mux_in_2 : IN STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
            mux_sel : IN STD_LOGIC;
            mux_out : OUT STD_LOGIC_VECTOR(width - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL m_reg : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL AQ_init : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL AQ_in : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL AQ_out : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL partial : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL AQ_sum_in : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL carry : STD_LOGIC := '0';
    SIGNAL sr_s_in : STD_LOGIC := '0';

BEGIN

    AQ_init <= "00000000" & ou_in_1 & "0";

    M : register_8 PORT MAP(ou_in_2, ou_clock, ou_reset, ou_loadM, m_reg);

    AQ_sum_in <= partial & AQ_out(8 DOWNTO 0);

    MUX_SR_parallel_in : mux GENERIC MAP(width => 17) PORT MAP(AQ_init, AQ_sum_in, ou_selAQ, AQ_in);

    sr_s_in <= AQ_out(16);

    SR : shift_register PORT MAP(AQ_in, sr_s_in, ou_clock, ou_reset, ou_loadAQ, ou_shift, AQ_out);

    ADD_SUB : adder_subtractor PORT MAP(AQ_out(16 DOWNTO 9), m_reg, ou_sub, partial, carry);

    COUNTER : counter_mod_8 PORT MAP(ou_clock, ou_reset, ou_count_in, ou_count);

    ou_result <= AQ_out;

END structural;