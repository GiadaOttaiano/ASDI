library IEEE;
use IEEE.std_logic_1164.ALL;

entity system is

    port(
        input : in std_logic_vector(7 downto 0);
        button : in std_logic_vector(1 downto 0);
        sel_mux : in std_logic_vector(3 downto 0);
        sel_demux : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(3 downto 0)
    );

end system;

architecture structural of system is

    component net164 is
        port(   
            net164_input : in STD_LOGIC_VECTOR(15 downto 0);
            net164_mux_s : in STD_LOGIC_VECTOR(3 downto 0);
            net164_demux_s : in STD_LOGIC_VECTOR(1 downto 0);
            net164_output : out STD_LOGIC_VECTOR(3 downto 0)    
        );
    end net164;

    component control_unit is
        port(
            switch_in : in std_logic_vector(7 downto 0);
            buttons : in std_logic_vector(1 downto 0);
            switch_out : out std_logic_vector(15 downto 0)
        );
    end component;

    signal input_sel : std_logic_vector(15 downto 0);

    begin
        cu : control_unit
            port map(
                switch_in => input,
                buttons => button,
                switch_out => input_sel
            );
        net : net164
            port map(
                net164_input => input_sel,
                net164_mux_s => sel_mux,
                net164_demux_s => sel_demux,
                net164_output => output
            );

end structural;