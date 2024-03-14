LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY shift_register_structural IS
    PORT (
        reg_input, rst, clk : IN STD_LOGIC;
        shift : STD_LOGIC_VECTOR(1 DOWNTO 0);
        reg_output : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END shift_register_structural;

ARCHITECTURE structural OF shift_register_structural IS
    COMPONENT mux41 IS
        PORT (
            mux41_input : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            mux41_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            y0 : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT flipflop_d IS
        PORT (
            D, clk, rst : IN STD_LOGIC;
            Q : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL M : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL F : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

BEGIN
    mux0 : mux41
    PORT MAP(
        mux41_input(3) => F(2),
        mux41_input(2) => F(1),
        mux41_input(1) => reg_input,
        mux41_input(0) => reg_input,
        mux41_sel => shift,
        y0 => M(0)
    );
    mux1 : mux41
    PORT MAP(
        mux41_input(3) => F(3),
        mux41_input(2) => F(2),
        mux41_input(1) => reg_input,
        mux41_input(0) => F(0),
        mux41_sel => shift,
        y0 => M(1)
    );
    mux2 : mux41
    PORT MAP(
        mux41_input(3) => reg_input,
        mux41_input(2) => F(3),
        mux41_input(1) => F(0),
        mux41_input(0) => F(1),
        mux41_sel => shift,
        y0 => M(2)
    );
    mux3 : mux41
    PORT MAP(
        mux41_input(3) => reg_input,
        mux41_input(2) => reg_input,
        mux41_input(1) => F(1),
        mux41_input(0) => F(2),
        mux41_sel => shift,
        y0 => M(3)
    );

    ff0 : flipflop_d
    PORT MAP(
        D => M(0),
        clk => clk,
        rst => rst,
        Q => F(0)
    );
    reg_output(0) <= F(0);

    ff1 : flipflop_d
    PORT MAP(
        D => M(1),
        clk => clk,
        rst => rst,
        Q => F(1)
    );
    reg_output(1) <= F(1);

    ff2 : flipflop_d
    PORT MAP(
        D => M(2),
        clk => clk,
        rst => rst,
        Q => F(2)
    );
    reg_output(2) <= F(2);

    ff3 : flipflop_d
    PORT MAP(
        D => M(3),
        clk => clk,
        rst => rst,
        Q => F(3)
    );
    reg_output(3) <= F(3);
END structural;