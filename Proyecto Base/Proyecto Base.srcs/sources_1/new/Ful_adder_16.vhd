
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ful_adder_16 is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end Ful_adder_16;

architecture Behavioral of Ful_adder_16 is

component Full_adder
    Port (
        A       : in      std_logic;
        B       : in      std_logic;
        Cin     : in      std_logic; 
        S       : out     std_logic;
        Cout    : out     std_logic
          );
    end component;

signal Co1           : std_logic;
signal Co2           : std_logic;
signal Co3           : std_logic;
signal Co4           : std_logic;
signal Co5           : std_logic;
signal Co6           : std_logic;
signal Co7           : std_logic;
signal Co8           : std_logic;
signal Co9           : std_logic;
signal Co10           : std_logic;
signal Co11           : std_logic;
signal Co12           : std_logic;
signal Co13          : std_logic;
signal Co14          : std_logic;
signal Co15          : std_logic;



begin

FA1: Full_adder port map(A=>A(0),B=>B(0),S=>S(0),Cin=>Cin,Cout=>Co1);
FA2: Full_adder port map(A=>A(1),B=>B(1),S=>S(1),Cin=>Co1,Cout=>Co2);
FA3: Full_adder port map(A=>A(2),B=>B(2),S=>S(2),Cin=>Co2,Cout=>Co3);
FA4: Full_adder port map(A=>A(3),B=>B(3),S=>S(3),Cin=>Co3,Cout=>Co4);
FA5: Full_adder port map(A=>A(4),B=>B(4),S=>S(4),Cin=>Co4,Cout=>Co5);
FA6: Full_adder port map(A=>A(5),B=>B(5),S=>S(5),Cin=>Co5,Cout=>Co6);
FA7: Full_adder port map(A=>A(6),B=>B(6),S=>S(6),Cin=>Co6,Cout=>Co7);
FA8: Full_adder port map(A=>A(7),B=>B(7),S=>S(7),Cin=>Co7,Cout=>Co8);
FA9: Full_adder port map(A=>A(8),B=>B(8),S=>S(8),Cin=>Co8,Cout=>Co9);
FA10: Full_adder port map(A=>A(9),B=>B(9),S=>S(9),Cin=>Co9,Cout=>Co10);
FA11: Full_adder port map(A=>A(10),B=>B(10),S=>S(10),Cin=>Co10,Cout=>Co11);
FA12: Full_adder port map(A=>A(11),B=>B(11),S=>S(11),Cin=>Co11,Cout=>Co12);
FA13: Full_adder port map(A=>A(12),B=>B(12),S=>S(12),Cin=>Co12,Cout=>Co13);
FA14: Full_adder port map(A=>A(13),B=>B(13),S=>S(13),Cin=>Co13,Cout=>Co14);
FA15: Full_adder port map(A=>A(14),B=>B(14),S=>S(14),Cin=>Co14,Cout=>Co15);
FA16: Full_adder port map(A=>A(15),B=>B(15),S=>S(15),Cin=>Co15,Cout=>Cout);

end Behavioral;