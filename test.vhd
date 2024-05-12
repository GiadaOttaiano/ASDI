library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shift_reg_A is
    port(
        reg_input : IN std_logic_vector(3 downto 0);
        clk, rst : IN std_logic;
        shift, load : IN std_logic;
        count : OUT integer;
        reg_output : OUT std_logic
    );
end shift_reg_A;

architecture behavioral of shift_reg_A is
    signal registro : std_logic_vector(3 downto 0);
    signal shift_num : integer range 0 to 4 := 0;

    begin  
        process(clk, rst)
            if rst = '1' then
                registro <= (others => '0');
                shift_num := '0';
            else if rising_edge(clk) then
                if load = '1' then
                    registro <= reg_input;
                elsif shift = '1' then
                    reg_output <= registro(0);  -- Scrivo il bit meno significativo in output
                    registro <= '0' & registro(3 downto 1);
                    shift_num := shift_num + 1;
                end if;
            end if;
        end process;

        count <= shift_num;
end behavioral;

/*
L'idea è che l'unità A riceva un segnale di start dall'esterno. Quando start diventa alto, si passa allo stato READ, altrimenti si permane in IDLE.
Nello stato READ viene alzato il segnale di read_rom da inviare alla ROM per caricare tutti i bit nello shift register di A e un segnale di load allo shift register.
Dopodiché si passa allo stato SHIFTING nel quale si alza il segnale shift per effettuare uno shift a destra e inviare il primo bit e il segnale DATA_READY
da inviare all'unità B per indicare la presenza di un bit disponibile da memorizzare nello shift register. Si transita nello stato WAIT_ACK dove si attende che
il segnale di ACK da B diventi alto, per transitare nello stato WAIT_OP. Si permane in WAIT_OP finché ACK è alto, in attesa che B termini le operazioni. 
Lo shift register di A conta quanti bit sono stati shiftati verso destra con una variabile interna count, la quale viene mandata in output alla CU. Quando count diventa pari a 4 
(poiché 4 sono i bit di un dato da inviare) e ACK è basso, si passa allo stato INCREMENT, nel quale si incrementa il valore di ADDRESS abilitando il contatore 
in maniera tale da passare alla locazione successiva da trasmettere. Altrimenti, si passa allo stato SHIFTING nel quale si effettua nuovamente uno shift
a destra per inviare un successivo carattere, rialzando il segnale DATA_READY e rimettendosi in attesa del segnale ACK da B. Una volta che address raggiunge 
il valore "1111", tutte le locazioni sono state visitate e si torna nello stato di IDLE.
*/