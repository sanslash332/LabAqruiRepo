library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);   -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);   -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);    -- Selector de la operación.
           c        : out std_logic;                        -- Señal de 'carry'.
           z        : out std_logic;                        -- Señal de 'zero'.
           n        : out std_logic;                        -- Señal de 'nagative'.
           result   : out std_logic_vector (15 downto 0));  -- Resultado de la operación.
end ALU;

architecture Behavioral of ALU is

signal alu : std_logic_vector(15 downto 0) := (others => '0');

begin

if (sop = '000') then --Suma
                
elsif (sop = '001') then --Resta

elsif (sop = '010') then --AND

elsif (sop = '011') then --OR

elsif (sop = '100') then --XOR

elsif (sop = '101') then --NOT

elsif (sop = '110') then --Shift Right

elsif (sop = '111') then --ShiftLeft
                         
end if;


result <= alu;
   
end Behavioral;
