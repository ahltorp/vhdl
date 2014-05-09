library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fader is
  generic (
    divide : integer := 100000;
    maxvalue : integer := 128;
    minvalue : integer := 1;
    phase : integer := 0;
    phasedir : std_logic := '0');
  Port ( clock50mhz : in  STD_LOGIC;
         faderout : out  STD_LOGIC := '0');
end fader;

architecture Behavioral of fader is
  signal width : integer := 0;
  signal clock100hz : std_logic;

begin
  
  divider : entity work.divider generic map (
    dividehalf       => divide) port map (
      clock50mhz => clock50mhz,
      divided => clock100hz);
  pwm : entity work.pwm port map (
      clock50mhz => clock50mhz,
      width => width,
      pwmout => faderout);

  process(clock100hz)
    variable count : integer := phase;
    variable direction : std_logic := phasedir;
  begin
    if clock100hz'event and clock100hz='1' then
      width <= count;
      if direction = '0' then
        count:=count+1;
        if count = maxvalue then
          direction := '1';
        end if;
      end if;
      if direction = '1' then
        count:=count-1;
        if count = minvalue then
          direction := '0';
        end if;
      end if;
    end if;
  end process;
end Behavioral;

