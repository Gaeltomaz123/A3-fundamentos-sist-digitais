--------------------------------------------------------------------------------
-- Temporizador decimal do cronometro de xadrez
-- Fernando Moraes - 25/out/2023
-- Gabriel de Cezaro Tomaz - 06/nov/2023
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
library work;

entity temporizador is
    port( clock, reset, load, en : in std_logic;
          init_time : in  std_logic_vector(7 downto 0);
          cont      : out std_logic_vector(15 downto 0)
      );
end temporizador;

architecture a1 of temporizador is
    signal segL, segH, minL, minH : std_logic_vector(3 downto 0);
    signal en1, en2, en3, en4: std_logic;
    signal segl_logic, segH_logic, minL_logic, minH_logic, compare: std_logic;
begin
    segl_logic <= '1' when segL = x"0" else '0';
    segH_logic <= '1' when segH = x"0" else '0';
    minL_logic <= '1' when minL = x"0" else '0';
    minH_logic <= '1' when minH = x"0" else '0';
    
    compare <= segl_logic and segH_logic and minL_logic and minH_logic;

    en1 <= (
        en and not compare
    );
    en2 <= (
        en1 and segL_logic
    );
    en3 <= (
        en2 and segH_logic
    );
    en4 <= (
        en3 and minL_logic
    );

   sL : entity work.dec_counter port map (
        clock => clock,
        reset => reset,
        load => load,
        en => en1,
        first_value => x"0",
        limit => x"9",
        cont => segL
   );
   sH : entity work.dec_counter port map (
    clock => clock,
        reset => reset,
        load => load,
        en => en2,
        first_value => x"0",
        limit => x"5",
        cont => segH
   );
   mL : entity work.dec_counter port map (
       clock => clock,
        reset => reset,
        load => load,
        en => en3,
        first_value => init_time(3 downto 0),
        limit => x"9",
        cont => minL
   );
   mH : entity work.dec_counter port map (
       clock => clock,
        reset => reset,
        load => load,
        en => en4,
        first_value => init_time(7 downto 4),
        limit => x"9",
        cont => minH
   );
   
   cont <= minH & minL & segH & segL;
end a1;


