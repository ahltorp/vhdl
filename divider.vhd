library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divider is
  generic (
    dividehalf : integer := 50000000);
  Port ( clock50mhz : in  STD_LOGIC;
         divided : out  STD_LOGIC := '0');
end divider;

architecture Behavioral of divider is

begin
  process(clock50mhz)
    variable COUNT : integer := 0;
    variable STATE : std_logic := '0';
  begin
    if clock50mhz'event and clock50mhz='1' then
      if count = 0 then
        STATE := not STATE;
        divided <= STATE;
      end if;
      COUNT:=COUNT+1;
      if count = dividehalf then
        count:=0;
      end if;
    end if;
  end process;
end Behavioral;
