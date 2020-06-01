library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity proj4 is
   port(
       rst_i : in STD_LOGIC;
       clk_i : in STD_LOGIC;
       led_o : out STD_LOGIC_VECTOR(1 downto 0) :="00";
	    led7_an_o : out STD_LOGIC_VECTOR(3 downto 0) --anody
        );
end proj4;

architecture Behavioral of proj4 is
signal led: STD_LOGIC_VECTOR(1 downto 0) := "00";
begin

led7_an_o(3 downto 0) <= "1111"; --wygaszenie anod

process    (clk_i, rst_i)

begin
   if rst_i = '1' then --zerowanie ( przyciskiem BTN3 )
       led <= "00";

   elsif rising_edge(clk_i) then   -- licznik graya ( przycisk BTN0 )
       case led is
           when "00" => led(1 downto 0) <= "01";
           when "01" => led(1 downto 0) <= "11";
           when "11" => led(1 downto 0) <= "10";
           when others => led(1 downto 0) <= "00"; --XOR 
       end case;

   end if;

end process;
   led_o <=led;

end Behavioral;






	


