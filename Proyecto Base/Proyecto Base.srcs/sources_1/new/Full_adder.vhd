-- Full adder 1 bit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_adder is 
  port (
    A:  in  std_logic;
    B:  in  std_logic;
    Cin: in  std_logic;
    S:  out std_logic;
    Cout:  out std_logic
  );
end entity Full_adder;

architecture Behavioral of Full_adder is

component Half_adder
    Port (
        A       : in      std_logic;
        B       : in      std_logic;
        S       : out     std_logic;
        C       : out     std_logic
          );
    end component;
    
signal S1           : std_logic;   
signal C1           : std_logic;  
signal C2           : std_logic;

begin

inst_Half_adder1: Half_adder port map(A=>A, B =>B,S=>S1,C=>C1);
inst_Half_adder2: Half_adder port map(A=>S1, B =>Cin,S=>S,C=>C2);

Cout <= C2 or C1;

end Behavioral;