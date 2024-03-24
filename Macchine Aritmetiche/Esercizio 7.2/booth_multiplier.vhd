LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY booth_multiplier IS
    PORT (
        X, Y : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        start, clock, reset : IN STD_LOGIC;
        P : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        cu_stop : OUT STD_LOGIC
    );
END booth_multiplier;

ARCHITECTURE structural OF booth_multiplier IS
    COMPONENT OU IS
        PORT (
            ou_in_1, ou_in_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ou_clock, ou_reset, ou_loadAQ, ou_loadM, ou_shift, ou_sub, ou_selAQ, ou_count_in : IN STD_LOGIC;
            ou_result : OUT STD_LOGIC_VECTOR(16 DOWNTO 0);
            ou_count : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT CU IS
        PORT (
            Q : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            cu_start, cu_clock, cu_reset : IN STD_LOGIC;
            cu_count : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            cu_loadAQ, cu_count_in, cu_shift, cu_loadM, cu_sub, cu_selAQ, cu_stop : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL tempQ : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL temp_count : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL tempP : STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
    SIGNAL loadAQ, loadM, count_in, shift, sub, selAQ : STD_LOGIC := '0';

BEGIN
    control_unit : CU
    PORT MAP(
        Q => tempQ,
        cu_start => start,
        cu_clock => clock,
        cu_reset => reset,
        cu_count => temp_count,
        cu_loadAQ => loadAQ,
        cu_count_in => count_in,
        cu_shift => shift,
        cu_loadM => loadM,
        cu_sub => sub,
        cu_selAQ => selAQ,
        cu_stop => cu_stop
    );

    operative_unit : OU
    PORT MAP(
        ou_in_1 => X,
        ou_in_2 => Y,
        ou_clock => clock,
        ou_reset => reset,
        ou_loadAQ => loadAQ,
        ou_loadM => loadM,
        ou_shift => shift,
        ou_sub => sub,
        ou_selAQ => selAQ,
        ou_count_in => count_in,
        ou_result => tempP,
        ou_count => temp_count
    );

    tempQ <= tempP(1 DOWNTO 0);
    P <= tempP(16 DOWNTO 1);

END structural;