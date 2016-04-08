----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2016 10:11:16
-- Design Name: 
-- Module Name: Multiplexor - Behavioral
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
library IEEE;
     use IEEE.STD_LOGIC_1164.all;

     ENTITY Multiplexor IS
        PORT(entrada1      : IN std_logic_vector(15 DOWNTO 0); 
             entrada2       : IN std_logic_vector(15 DOWNTO 0); 
             sel    : IN std_logic; 
             salida : OUT std_logic_vector(15 DOWNTO 0));
     END Multiplexor;

     ARCHITECTURE Behavioral OF Multiplexor IS
     BEGIN

       PROCESS (sel) IS
       BEGIN
         CASE sel IS
           WHEN '0' => salida <= entrada1;
           WHEN '1' => salida <= entrada2;
           WHEN OTHERS => salida <= "0000000000000000";
         END CASE;
       END PROCESS;
     END Behavioral;
