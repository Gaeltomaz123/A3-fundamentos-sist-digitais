--------------------------------------------------------------------------------
-- RELOGIO DE XADREZ
-- Author - Fernando Moraes - 25/out/2023
-- Revision - Iaçanã Ianiski Weber - 30/out/2023
-- Gabriel de Cezaro Tomaz 08/nov/2023
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

    type states is (START, IDLE, P1, P2, WIN1, WIN2);
    signal EA, PE : states;
    signal cont1, cont2: std_logic_vector(15 downto 0);
    signal enj1, enj2: std_logic;

begin


    contador1 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => enj1,
        init_time => init_time,
        cont => cont1
    );
    contador2 : entity work.temporizador port map (
        clock => clock,
        reset => reset,
        load => load,
        en => enj2,
        init_time => init_time,
        cont => cont2
    );

 
    process (clock, reset)
    begin

        if reset = '1' then
            EA <= START;
        elsif rising_edge(clock) then
            EA <= PE;
        end if;
    end process;


    process (load, cont1, cont2, j1, j2, EA)
    begin
        case EA is

            when START =>
                if load = '1' then
                    PE <= IDLE;
                else 
                    PE <= START;
                end if;

                when IDLE =>
                if j1 = '1' then
                    PE <= P1;
                elsif j2 = '1' then
                    PE <= P2;
                else
                    PE <= IDLE;
                end if;

                when P1 =>
                if j1 = '1' then
                    PE <= P2;
                elsif cont1 = x"0" then
                    PE <= WIN2;
                elsif j1 = '0' then    
                    PE <= P1;
                end if;

                when P2 =>
                if j2 = '1' then
                    PE <= P1;
                elsif cont2 = x"0" then
                    PE <= WIN1; 
                elsif j2 = '0' then 
                    PE <= P2;
                end if;

                when WIN1 =>
                    PE <= START;
                when WIN2 =>
                    PE <= START;
        end case;
    end process;

    

    enj1 <= '1' when EA = P1 else '0';
    enj2 <= '1' when EA = P2 else '0';
    winJ1 <= '1' when PE = WIN1 else '0';
    winJ2 <= '1' when PE = WIN2 else '0';
    contj1 <= cont1;
    contj2 <= cont2;
end relogio_xadrez;


