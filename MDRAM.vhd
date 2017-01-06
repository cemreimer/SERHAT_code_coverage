----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:30 11/07/2009 
-- Design Name: 
-- Module Name:    dram - Behavioral 
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

use work.types.all;
use work.vhdl_bl4cl2_parameters_0.all;


entity DRAMModule is
		Port (  PIClk  			  : in  STD_LOGIC;
            PIReset  		  : in  STD_LOGIC;
---------- PA Ram Ports --------------	
            PIRamDataIn 	: in byte_vector (255 downto 0);				
---------- PA Ram Ports --------------
---------- PB Ram Ports --------------				
            PIRamPBEn		  : in  STD_LOGIC;
            PORamDataOut 	: out STD_LOGIC_VECTOR (7 downto 0);	
            PIRamPBAddrIn	: in  STD_LOGIC_VECTOR (7 downto 0)				
---------- PB Ram Ports --------------
			);
end DRAMModule;




architecture Behavioral of DRAMModule is

   type TRAMArray is array (0 to 255) of std_logic_vector (7 downto 0);
	
   signal SRAMArr : TRAMArray;

begin
    
   process(PIRamPBAddrIn,SRAMArr,PIRamPBEn)
   begin      
      if PIRamPBEn='1' then
           PORamDataOut <= SRAMArr(conv_integer(PIRamPBAddrIn));
      end if;
	end process;
  
	
LDramDataIn :  for j in 0 to 255 generate

                SRAMArr(j)(7 downto 0) <= PIRamDataIn(j);	
                
               end generate;

end Behavioral;


