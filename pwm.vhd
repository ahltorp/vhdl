use ieee.numeric_std.all;

entity pwm is
  Port ( clock50mhz : in  STD_LOGIC;
         width : in integer range 0 to 255;
         pwmout : out  STD_LOGIC := '0');
end pwm;

architecture Behavioral of pwm is

begin
  process(clock50mhz)
    variable count : numeric_std.unsigned(7 downto 0) := X"00";
  begin
    if clock50mhz'event and clock50mhz='1' then
      if count = 0 then
        pwmout <= '1';
      elsif count = width then
        pwmout <= '0';
      end if;
      count:=count+1;
    end if;
  end process;
end Behavioral;

