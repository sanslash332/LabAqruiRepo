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

component Ful_adder_16 is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           Cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (15 downto 0);
           Cout : out STD_LOGIC);
end component;

signal suma  : std_logic_vector (15 downto 0);
signal resta : std_logic_vector (15 downto 0);
signal temp : std_logic_vector (15 downto 0);

signal carry : std_logic;
signal carry2 : std_logic;

signal cs : std_logic;
signal cr : std_logic;
signal na : std_logic;

begin


-- Ineficiente pero funciona, podría haberlo hecho con un solo adder

-- sumador
inst_FullAdder1: Ful_adder_16 port map (
a=>a,
b=>b, 
Cin=>'0',
s=>suma,
Cout=>carry
);

-- restador
inst_FullAdder2: Ful_adder_16 port map (
a=>a,
b=>not b, 
Cin=>'1',
s=>resta,
Cout=>carry2
);


-- Operación
process(sop) is
begin
case sop is
 when "000" => temp  <= suma ;
           when "001" => temp  <= resta ;
           when "010" => temp  <= a and b ;
           when "011" => temp  <=  a or b ;
           when "100" => temp  <= a xor b ;
           when "101" => temp  <= not a ;
           when "110"  => temp  <= ('0' & a(15 downto 1)) ;
           when "111" => temp  <= a(14 downto 0) & '0';
           when others => temp  <= X"0000" ;
end case;

if temp < suma then 
cs <= '1';
else 
cs<= '0';
end if;

if a >= b then 
cr <= '1';
else 
cr<= '0';
end if;

if (temp = X"0000") then 
z <= '1';
else 
z<= '0';
end if;

if (a < b) then 
na <= '1';
else 
na<= '0';
end if;

case sop is
       when "001" => n <= na;
       when others => n <= '0' ; 
end case;

case sop is
       when "000" => c <= cs;
       when "001" => c <= cr; 
       when "110" => c <= a(0);
       when "111" => c <= a(15);
       when others => c <= '0' ; 
   end case;
result<=temp; 
end process;         

end Behavioral;
