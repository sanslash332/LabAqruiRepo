----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2016 01:34:45
-- Design Name: 
-- Module Name: FullAdder_16 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FullAdder_16 is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end FullAdder_16;

architecture Behavioral of FullAdder_16 is
signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15 : std_logic:='0';
begin

Full0 : entity work.FullAdder_1bit port map (A(0),B(0),Cin,S(0),c0);
Full1 : entity work.FullAdder_1bit port map (A(1),B(1),c0,S(1),c1);
Full2 : entity work.FullAdder_1bit port map (A(2),B(2),c1,S(2),c2);
Full3 : entity work.FullAdder_1bit port map (A(3),B(3),c2,S(3),c3);
Full4 : entity work.FullAdder_1bit port map (A(4),B(4),c3,S(4),c4);
Full5 : entity work.FullAdder_1bit port map (A(5),B(5),c4,S(5),c5);
Full6 : entity work.FullAdder_1bit port map (A(6),B(6),c5,S(6),c6);
Full7 : entity work.FullAdder_1bit port map (A(7),B(7),c6,S(7),c7);
Full8 : entity work.FullAdder_1bit port map (A(8),B(8),c7,S(8),c8);
Full9 : entity work.FullAdder_1bit port map (A(9),B(9),c8,S(9),c9);
Full10 : entity work.FullAdder_1bit port map (A(10),B(10),c9,S(10),c10);
Full11 : entity work.FullAdder_1bit port map (A(11),B(11),c10,S(11),c11);
Full12 : entity work.FullAdder_1bit port map (A(12),B(12),c11,S(12),c12);
Full13 : entity work.FullAdder_1bit port map (A(13),B(13),c12,S(13),c13);
Full14 : entity work.FullAdder_1bit port map (A(14),B(14),c13,S(14),c14);
Full15 : entity work.FullAdder_1bit port map (A(15),B(15),c14,S(15),c15);

Cout <= c15;

end Behavioral;
