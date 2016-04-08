library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (2 downto 0);  -- Señales de entrada de los interruptores -- Arriba   = '1'   -- Los 3 swiches de la derecha: 2, 1 y 0.
        btn         : in   std_logic_vector (4 downto 0);  -- Señales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (3 downto 0);  -- Señales de salida  a  los leds          -- Prendido = '1'   -- Los 4 leds de la derecha: 3, 2, 1 y 0.
        clk         : in   std_logic;                      -- No Tocar - Señal de entrada del clock   -- Frecuencia = 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las señales de segmentos.
        an          : out  std_logic_vector (3 downto 0)   -- No Tocar - Salida del selector de diplay.
          );
end Basys3;

architecture Behavioral of Basys3 is

-- Inicio de la declaración de los componentes.

component Reg is
    Port ( clock    : in  std_logic;                        -- Señal del clock (reducido).
           load     : in  std_logic;                        -- Señal de carga.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           datain   : in  std_logic_vector (15 downto 0);   -- Señales de entrada de datos.
           dataout  : out std_logic_vector (15 downto 0));  -- Señales de salida de datos.
end component;

component ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);   -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);   -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);    -- Selector de la operación.
           c        : out std_logic;                        -- Señal de 'carry'.
           z        : out std_logic;                        -- Señal de 'zero'.
           n        : out std_logic;                        -- Señal de 'nagative'.
           result   : out std_logic_vector (15 downto 0));  -- Resultado de la operación.
end component;

component Multiplexor
        PORT(entrada1      : IN std_logic_vector(15 DOWNTO 0); 
             entrada2       : IN std_logic_vector(15 DOWNTO 0); 
             sel    : IN std_logic; 
             salida : OUT std_logic_vector(15 DOWNTO 0));
END component;


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

-- Fin de la declaración de los componentes.

-- Inicio de la declaración de señales.

signal clock            : std_logic;                     -- Señal del clock reducido.                 
            
signal dis_a            : std_logic_vector(3 downto 0);  -- Señales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0);  -- Señales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0);  -- Señales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0);  -- Señales de salida al display D.  
signal d_btn            : std_logic_vector(4 downto 0);

signal load_op          : std_logic := '0';

signal dis_a1            : std_logic_vector(3 downto 0);
signal dis_b1            : std_logic_vector(3 downto 0);
signal dis_c1            : std_logic_vector(3 downto 0);
signal dis_d1            : std_logic_vector(3 downto 0);

-- Multiplexor de display
signal entrada1           : std_logic_vector(15 downto 0);
signal entrada2           : std_logic_vector(15 downto 0);
signal salida             : std_logic_vector(15 downto 0);

-- Operandos
signal operando1           : std_logic_vector(15 downto 0);
signal operando2           : std_logic_vector(15 downto 0);
signal resultado           : std_logic_vector(15 downto 0);

signal dis_a2            : std_logic_vector(3 downto 0);
signal dis_b2            : std_logic_vector(3 downto 0);
signal dis_c2            : std_logic_vector(3 downto 0);
signal dis_d2            : std_logic_vector(3 downto 0);



signal unconected1           : std_logic_vector(3 downto 0);
signal unconected2           : std_logic_vector(3 downto 0);
signal unconected3           : std_logic_vector(3 downto 0);
signal unconected4           : std_logic_vector(3 downto 0);
signal carry                 : std_logic;
signal carry_in              : std_logic;

-- Fin de la declaración de los señales.

begin

-- Inicio de declaración de comportamientos.

    led(0) <= clock;
    carry_in <= '0';
    entrada1 <= dis_a1 & dis_b1 & dis_c1 & dis_d1;
    entrada2 <= dis_a2 & dis_b2 & dis_c2 & dis_d2;
    operando1 <= unconected2 & unconected1 & dis_a1 & dis_b1;
    operando2 <= unconected4 & unconected3 & dis_c1 & dis_d1;
    
    dis_a <= salida(15 downto 12);
    dis_b <= salida(11 downto 8);
    dis_c <= salida(7 downto 4);
    dis_d <= salida(3 downto 0);

-- Inicio de declaración de instancias.

inst_reg_a:Reg port map(
    clock  => clock,
    load   => load_op,
    up     => d_btn(1) and d_btn(2),
    down   => d_btn(4) and d_btn(2),
    datain =>"0000000000000000",
    dataout(3 downto 0)=>dis_b1,
    dataout(7 downto 4)=>dis_a1,
    dataout(11 downto 8)=>unconected1,
    dataout(15 downto 12)=>unconected2
    );

inst_reg_b:Reg port map(
    clock=>clock,
    load   => load_op,
    up     => d_btn(1) and d_btn(3),
    down   => d_btn(4) and d_btn(3),
    datain =>"0000000000000000",
    dataout(3 downto 0)=>dis_d1,
    dataout(7 downto 4)=>dis_c1,
    dataout(11 downto 8)=>unconected3,
    dataout(15 downto 12)=>unconected4
    );

inst_reg_resultado:Reg port map(
    clock=>clock,
    load   => '1',
    up     => '0',
    down   => '0',
    datain =>resultado,
    dataout(3 downto 0)=>dis_d2,
    dataout(7 downto 4)=>dis_c2,
    dataout(11 downto 8)=>dis_b2,
    dataout(15 downto 12)=>dis_a2
    );

inst_ALU: ALU port map (a=>operando1,b=>operando2,sop=>sw,c=>led(1),z=>led(2),n=>led(3),result=>resultado);

inst_Mux: Multiplexor port map (entrada1 => entrada1, entrada2 =>entrada2, sel=>d_btn(0), salida=>salida);

inst_Clock_Divider: Clock_Divider port map( -- No Tocar - Intancia de Clock_Divider.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    speed       => "10", -- Selector de velocidad: "00" full, "01" fast, "10" normal y "11" slow. 
    clock       => clock -- No Tocar - Salida del clock reducido: 50Mhz, 8hz, 2hz y 0.5hz.
    );

inst_Display_Controller: Display_Controller port map( -- No Tocar - Intancia de Led_Driver.
    dis_a       => dis_a,-- No Tocar - Entrada de señales para el display A.
    dis_b       => dis_b,-- No Tocar - Entrada de señales para el display B.
    dis_c       => dis_c,-- No Tocar - Entrada de señales para el display C.
    dis_d       => dis_d,-- No Tocar - Entrada de señales para el display D.
    clk         => clk,  -- No Tocar - Entrada del clock completo (100Mhz).
    seg         => seg,  -- No Tocar - Salida de las señales de segmentos.
    an          => an    -- No Tocar - Salida del selector de diplay.
	);

inst_Debouncer: Debouncer port map(
    clk         => clk, -- No Tocar - Entrada del clock completo (100Mhz).
    datain      => btn, -- No Tocar - Entrada de señales de botones.
    dataout     => d_btn-- No Tocar - Salida de señales de botones con protección antirrebote.
    );
    
-- Fin de declaración de instancias.

-- Fin de declaración de comportamientos.
  
end Behavioral;
