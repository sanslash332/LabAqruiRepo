-- Half Adder 1 bit
library ieee;
use ieee.std_logic_1164.all;

entity Half_adder is 
  port (
    A:  in  std_logic;
    B:  in  std_logic;
    S:  out std_logic;
    C:  out std_logic
  );
end entity Half_adder;

architecture Behavioral of Half_adder is
begin

  process(A,B)
  begin
    S <= A xor B;
    C <= A and B;
  end process;

end Behavioral;
