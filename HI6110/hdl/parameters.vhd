LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

package parameters is
constant size_row, size_col : integer := 2;
constant reel_type_bit_size : integer := 64;
																							--		1553 -> UBB																										UBB <- 1553
constant sub_adr_1		: STD_LOGIC_VECTOR (4 downto 0) := "00001";  --	Start/Stop IBIT/CBIT																		Status/IBIT/CBIT deðerlerinin okunmasý
constant sub_adr_2		: STD_LOGIC_VECTOR (4 downto 0) := "00010";	--																									Analog Input deðerlerinin okunmasý
constant sub_adr_3		: STD_LOGIC_VECTOR (4 downto 0) := "00011";	--																									D.I., GPIO, A.I., TC, Freq deðerlerinin okunmasý
constant sub_adr_4		: STD_LOGIC_VECTOR (4 downto 0) := "00100";	--	RS-422 block yapýsý																		RS-422 block yapýsý		
constant sub_adr_5		: STD_LOGIC_VECTOR (4 downto 0) := "00101";	-- RS-422 block yapýsý																		RS-422 block yapýsý
constant sub_adr_6		: STD_LOGIC_VECTOR (4 downto 0) := "00110";	-- RS-422 block yapýsý																		RS-422 block yapýsý
constant sub_adr_7		: STD_LOGIC_VECTOR (4 downto 0) := "00111";	-- RS-422 block yapýsý																		RS-422 block yapýsý
constant sub_adr_8		: STD_LOGIC_VECTOR (4 downto 0) := "01000";	--	RS-485 block yapýsý																		RS-485 block yapýsý
constant sub_adr_9		: STD_LOGIC_VECTOR (4 downto 0) := "01001";	--	RS-485 block yapýsý																		RS-485 block yapýsý
constant sub_adr_10		: STD_LOGIC_VECTOR (4 downto 0) := "01010";	--	RS-485 block yapýsý																		RS-485 block yapýsý
constant sub_adr_11		: STD_LOGIC_VECTOR (4 downto 0) := "01011";	--	RS-485 block yapýsý																		RS-485 block yapýsý
constant sub_adr_12		: STD_LOGIC_VECTOR (4 downto 0) := "01100";	--	RS-232 block yapýsý																		RS-232 block yapýsý
constant sub_adr_13		: STD_LOGIC_VECTOR (4 downto 0) := "01101";	-- UARTs clear command																		UARTs status
constant sub_adr_14		: STD_LOGIC_VECTOR (4 downto 0) := "01110";	--	Default deðerlerin güncellenmesi														O anki default deðerlerin okunmasý
constant sub_adr_15		: STD_LOGIC_VECTOR (4 downto 0) := "01111";	-- Output Geçerlilik sürelerinin güncellenmesi										Output Geçerlilik sürelerinin okunmasý
constant sub_adr_16		: STD_LOGIC_VECTOR (4 downto 0) := "10000";	-- Analog Output deðerlerinin güncellenmesi											Analog Output Deðerlerinin okunmasý
constant sub_adr_17		: STD_LOGIC_VECTOR (4 downto 0) := "10001";	-- D.O.,GPIO,PWM,UARTS En,CCS En,CVS En deðerlenin güncellenmesi				D.O.,GPIO,PWM,UARTs En,CCS En,CVS En deðerlerinin okunmasý
constant sub_adr_18		: STD_LOGIC_VECTOR (4 downto 0) := "10010";	-- ShutDown Command																			UBB Management Status
end package parameters; 