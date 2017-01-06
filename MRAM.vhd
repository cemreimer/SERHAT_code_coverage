----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:21:38 02/27/2015 
-- Design Name: 
-- Module Name:    MRAM - Behavioral 
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
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:17:42 02/27/2015 
-- Design Name: 
-- Module Name:    MRAMRd - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MRAM is
   Port (  PIMainClk    : in STD_LOGIC;
           PIReset      : in  STD_LOGIC;
           
           PIWrAddr	: in std_logic_vector(7 downto 0);       
           PIWrData	: in std_logic_vector(7 downto 0);
           PIWE      : in STD_LOGIC;
           
           PIRdAddr  : in std_logic_vector(7 downto 0);
           PORdData	: out std_logic_vector(7 downto 0)
         );
end MRAM;


Architecture Behavioral of MRAM is

   type TRAMArray is array (0 to 255) of std_logic_vector (7 downto 0);
	
   signal SRAMArr : TRAMArray;
	
begin

   process (PIMainClk,PIReset)
   begin
      if PIReset = '1' then  
      elsif rising_edge (PIMainClk) then
         if PIWE='1' then
           SRAMArr(conv_integer(PIWrAddr)) <= PIWrData;
			end if;
      end if;
   end process;  	

   process(PIRdAddr,SRAMArr)
   begin
		--if PIRdAddr > "" then 
      --   PORdData <= x"DD";
      --else
         PORdData <= SRAMArr(conv_integer(PIRdAddr));
      --end if;
	end process;

end Behavioral;