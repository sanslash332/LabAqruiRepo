library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (2 downto 0);  -- Se�ales de entrada de los interruptores -- Arriba   = '1'   -- Los 3 swiches de la derecha: 2, 1 y 0.
        btn         : in   std_logic_vector (4 downto 0);  -- Se�ales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (3 downto 0);  -- Se�ales de salida  a  los leds          -- Prendido = '1'   -- Los 4 leds de la derecha: 3, 2, 1 y 0.
        clk         : in   std_logic;                      -- No Tocar - Se�al de entrada del clock   -- Frecuencia = 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las se�ales de segmentos.
        an          : out  std_logic_vector (3 downto 0)   -- No Tocar - Salida del selector de diplay.
          );
end Basys3;

architecture Behavioral of Basys3 is

-- Inicio de la declaraci�n de los componentes.

component Clock_Divider -- No Tocar
    Port (
        clk         : in    std_logic;
        speed       : in    std_logic_vector (1 downto 0);
        clock       : out   std_logic
          );
    end component;
    
component Display_Controller  -- No Tocar
    Port (  
        dis_a       : in    std_logic_vector (3 downto 0);
        dis_b       : in    std_logic_vector (3 downto 0);
        dis_c       : in    std_logic_vector (3 downto 0);
        dis_d       : in    std_logic_vector (3 downto 0);
        clk         : in    std_logic;
        seg         : out   std_logic_vector (7 downto 0);
        an          : out   std_logic_vector (3 downto 0)
          );
    end component;

component Debouncer  -- No Tocar
    Port (
        clk         : in    std_logic;
        datain      : in    std_logic_vector (4 downto 0);
        dataout     : out   std_logic_vector (4 downto 0));
    end component;

-- Fin de la declaraci�n de los componentes.

-- Inicio de la declaraci�n de se�ales.

signal clock            : std_logic;                     -- Se�al del clock reducido.                 
            
signal dis_a            : std_logic_vector(3 downto 0);  -- Se�ales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0);  -- Se�ales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0);  -- Se�ales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0);  -- Se�ales de salida al display D.  

signal d_btn            : std_logic_vector(4 downto 0);

-- Fin de la declaraci�n de los se�ales.

begin

-- Inicio de declaraci�n de comportamientos.

led(0) <= clock;

-- Inicio de declaraci�n de instancias.

inst_Clock_Divider: Clock_Divider port map( -- No Tocar - Intancia de Clock_Divider.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    speed       => "10", -- Selector de velocidad: "00" full, "01" fast, "10" normal y "11" slow. 
    clock       => clock -- No Tocar - Salida del clock reducido: 50Mhz, 8hz, 2hz y 0.5hz.
    );

inst_Display_Controller: Display_Controller port map( -- No Tocar - Intancia de Led_Driver.
    dis_a       => dis_a,-- No Tocar - Entrada de se�ales para el display A.
    dis_b       => dis_b,-- No Tocar - Entrada de se�ales para el display B.
    dis_c       => dis_c,-- No Tocar - Entrada de se�ales para el display C.
    dis_d       => dis_d,-- No Tocar - Entrada de se�ales para el display D.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    seg         => seg,  -- No Tocar - Salida de las se�ales de segmentos.
    an          => an    -- No Tocar - Salida del selector de diplay.
	);

inst_Debouncer: Debouncer port map(
    clk         => clk, -- No Tocar - Entrada del clock completo (100Mhz).
    datain      => btn, -- No Tocar - Entrada de se�ales de botones.
    dataout     => d_btn-- No Tocar - Salida de se�ales de botones con protecci�n antirrebote.
    );
    
-- Fin de declaraci�n de instancias.

-- Fin de declaraci�n de comportamientos.
  
end Behavioral;
