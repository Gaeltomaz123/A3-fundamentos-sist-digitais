--------------------------------------------------------------------------------
-- RELOGIO DE XADREZ
-- Author - Fernando Moraes - 25/out/2023
-- Revision - Iaçanã Ianiski Weber - 30/out/2023
--------------------------------------------------------------------------------
library IEEE;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library work;

entity relogio_xadrez is
    port( 
        reset : in std_logic;
        clock : in std_logic;
        load : in std_logic;
        init_time : in std_logic_vector(7 downto 0);
        j1, j2 : in std_logic;
        contj1, contj2 : out std_logic_vector(15 downto 0);
        winJ1, winJ2 : out std_logic
    );
end relogio_xadrez;

architecture relogio_xadrez of relogio_xadrez is
    -- DECLARACAO DOS ESTADOS
    type states is (START, IDLE, J1, J2, WIN1, WIN2);
    signal EA, PE : states;
    -- ADICIONE AQUI OS SINAIS INTERNOS NECESSARIOS
    
begin

    -- INSTANCIACAO DOS CONTADORES
    contador1 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => (EA=J1),
        init_time => init_time,
        cont => count1
    );
    contador2 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => (EA=J2),
        init_time => init_time,
        cont => count2
    );

    -- PROCESSO DE TROCA DE ESTADOS
    process (clock, reset)
    begin
        
        -- COMPLETAR COM O PROCESSO DE TROCA DE ESTADO

    end process;

    -- PROCESSO PARA DEFINIR O PROXIMO ESTADO
    process ( ) --<<< Nao esqueca de adicionar os sinais da lista de sensitividade
    begin
        case EA is
            
            --COMPLETAR O CASE PARA CADA UM DOS ESTADOS DA SUA MAQUINA

        end case;
    end process;

    
    -- ATRIBUICAO COMBINACIONAL DOS SINAIS INTERNOS E SAIDAS - Dica: faca uma maquina de Moore, desta forma os sinais dependem apenas do estado atual!!
    

end relogio_xadrez;


