library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_register_structural is
    port(
        reg_input, rst, clk : in STD_LOGIC;
        shift : in STD_LOGIC_VECTOR(1 downto 0);
        reg_output : out STD_LOGIC
    );
end shift_register_structural;

architecture structural of shift_register_structural is
    component mux41 is
        port(   
            mux41_input : in STD_LOGIC_VECTOR(3 downto 0);
            mux41_sel : in STD_LOGIC_VECTOR(1 downto 0);
            y0 : out STD_LOGIC
    );
    end component;

    component flip_flop_d is
        port(
        D, clk, rst : in STD_LOGIC;
        Q : out STD_LOGIC
    );
    end component;

    signal M : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal F : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

    begin
        mux0 : mux41
        port map(
            mux41_input(3) => reg_input,
            mux41_input(2) => reg_input,
            mux41_input(1) => F(2),
            mux41_input(0) => F(1),
            mux41_sel => shift,
            y0 => M(0) 
        );

        mux1 : mux41
        port map(
            mux41_input(3) => reg_input,
            mux41_input(2) => F(0),
            mux41_input(1) => F(3),
            mux41_input(0) => F(2),
            mux41_sel => shift,
            y0 => M(1) 
        );

        mux2 : mux41
        port map(
            mux41_input(3) => F(0),
            mux41_input(2) => F(1),
            mux41_input(1) => reg_input,
            mux41_input(0) => F(3),
            mux41_sel => shift,
            y0 => M(2) 
        );

        mux3 : mux41
        port map(
            mux41_input(3) => F(1),
            mux41_input(2) => F(2),
            mux41_input(1) => reg_input,
            mux41_input(0) => reg_input,
            mux41_sel => shift,
            y0 => M(3) 
        );

        ff0 : flip_flop_d
        port map(
            D => M(0),
            clk => clk,
            rst => rst,
            Q => F(0)
        );
        reg_output => F(0);

        ff1 : flip_flop_d
        port map(
            D => M(1),
            clk => clk,
            rst => rst,
            Q => F(1)
        );
        reg_output => F(1);

        ff2 : flip_flop_d
        port map(
            D => M(2),
            clk => clk,
            rst => rst,
            Q => F(2)
        );
        reg_output => F(2);
        
        ff3 : flip_flop_d
        port map(
            D => M(3),
            clk => clk,
            rst => rst,
            Q => F(3)
        );
        reg_output => F(3);

end behavioral;