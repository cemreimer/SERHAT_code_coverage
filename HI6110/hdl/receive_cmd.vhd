      ----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:46 11/03/2009 
-- Design Name: 
-- Module Name:    receive_cmd - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity receive_cmd is
	port (  PIClk       : IN std_logic;
          PIWE        : IN std_logic;
          PIWrAddr		: IN std_logic_VECTOR(5 downto 0); 
          PIWrData    : IN std_logic_VECTOR(15 downto 0);
          PIRdAddr    : IN std_logic_VECTOR(5 downto 0);          
          PORdData    : OUT std_logic_VECTOR(15 downto 0)
        );
end receive_cmd;

architecture Behavioral of receive_cmd is

	type TRam1553 is array (0 to 32) of std_logic_vector (15 downto 0);
  
	signal SRam : TRam1553;
  
	
  begin

  process (PIClk)
  begin
    if (PIClk'event and PIClk = '1') then      
      if (PIWE = '1') then
        SRam(conv_integer(PIWrAddr)) <= PIWrData;
      else
        SRam(conv_integer(PIWrAddr)) <= x"0000";
      end if;      
    end if;
  end process;

  process(PIRdAddr,SRam)
  begin      
    if PIRdAddr > "100000" then 
      PORdData <= x"DEAD";
    else
      PORdData <= SRam(conv_integer(PIRdAddr));
    end if;    
  end process;

end Behavioral;

