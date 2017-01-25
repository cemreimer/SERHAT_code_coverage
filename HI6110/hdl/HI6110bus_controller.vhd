----------------------------------------------------------------------------------
-- Company: 		PAVO A.?
-- Engineer: 		ILGAZ AZ
-- 
-- Create Date:    13:16:01 01/08/2010 
-- Design Name: 
-- Module Name:    HI6110bus_controller - Behavioral 
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

entity HI6110bus_controller is
	port ( 
          PIODataBus  : inout std_logic_vector(15 downto 0);
          PIDataIn    : in    std_logic_vector(15 downto 0);
          PIClk50MHz  : in    std_logic;
          PISyncReset : in    std_logic;
          PIWrHI      : in    std_logic;
          PIRdHI 	  : in    std_logic;
          PIRWAddr    : in    std_logic_vector(3 downto 0);
          PODataOut   : out   std_logic_vector(15 downto 0);
          PORegAddr   : out   std_logic_vector(3 downto 0);
          POStr       : out   std_logic;
          PORW        : out   std_logic;
          POCS        : out   std_logic;
          PORWDone	  : out   std_logic
        );
end HI6110bus_controller;

architecture Behavioral of HI6110bus_controller is

	type TStateType is ( StIdle, StWrActvCS, StWrActvStr, StWrStrHold1, StWrStrHold2, StWrDeactvStr, StWrDeactvStr2, 
                       StWrDeactvCS, StWrComplete, StRdActvCS, StRdActvStr, StRdStrHold1, StRdStrHold2, 
                       StRdStrHold3, StRdStrHold4, StRdDeactvStr, StRdDeactvCS, StRdComplete
                      );
                      
	signal SStCurrent   : TStateType;
	signal SClkCnt      : integer range 0 to 7;
	signal SClk12MHz    : std_logic;
	signal STrisEn      : std_logic;
	signal SDataBus     : std_logic_vector(15 downto 0);
	signal SLastRData   : std_logic_vector(15 downto 0) := x"0000";
	
	signal STimeCSWS    : integer range 0 to 6 := 0;
	signal STimeStr     : integer range 0 to 6 := 0;
	signal STimeDWH     : integer range 0 to 5 := 0;
	
	signal STimeRStr    : integer range 0 to 10 := 0;
	signal STimeCSRH    : integer range 0 to 5 := 0;
	signal STimeRWRS    : integer range 0 to 5 := 0;
	
	signal STimeWrComplete  : integer range 0 to 12 := 0;
  
	
begin

	process(PIClk50MHz, PISyncReset, SStCurrent)
	begin	
		if PIClk50MHz'event and PIClk50MHz = '1' then			
			if PISyncReset = '1' then				
				SStCurrent <= StIdle;				
			else				
				case SStCurrent is				
					when StIdle =>						
						if PIWrHI = '1' then
							SStCurrent <= StWrActvCS;
						elsif PIRdHI = '1' then							
							SStCurrent <= StRdActvCS;
						else
							SStCurrent <= StIdle;
						end if;
					
					when StWrActvCS =>						
						if STimeCSWS = 4 then
							STimeCSWS <= 0;
							SStCurrent <= StWrActvStr;
						else
							STimeCSWS <= STimeCSWS + 1;
							SStCurrent <= StWrActvCS;
						end if;
					
					when StWrActvStr =>					
						if STimeStr = 4 then
							STimeStr <= 0;
							SStCurrent <= StWrDeactvStr;							
						else
							STimeStr <= STimeStr + 1;
							SStCurrent <= StWrActvStr;
						end if;
					
					when StWrStrHold1 =>						
						SStCurrent <= StWrStrHold2;
					
					when StWrStrHold2 =>						
						SStCurrent <= StWrDeactvStr;
					
					when StWrDeactvStr =>					
						if STimeDWH = 3 then
							STimeDWH <= 0;
							SStCurrent <= StWrDeactvCS;
						else
							STimeDWH <= STimeDWH + 1;
							SStCurrent <= StWrDeactvStr;
						end if;
						
					when StWrDeactvStr2 =>						
						SStCurrent <= StWrDeactvCS;
					
					when StWrDeactvCS =>						
							SStCurrent <= StWrComplete;
						
					when StWrComplete =>					
						if STimeWrComplete = 3 then
							STimeWrComplete <= 0;
							SStCurrent <= StIdle;
						else
							STimeWrComplete <= STimeWrComplete + 1;
							SStCurrent <= StWrComplete;
						end if;
	
					when StRdActvCS =>
						if STimeRWRS = 3 then
							STimeRWRS <= 0;
							SStCurrent <= StRdActvStr;
						else
							STimeRWRS <= STimeRWRS + 1;
							SStCurrent <= StRdActvCS;
						end if;
					
					when StRdActvStr =>					
						if STimeRStr = 9 then
							STimeRStr <= 0;
							SStCurrent <= StRdDeactvStr;
						else
							STimeRStr <= STimeRStr + 1;
							SStCurrent <= StRdActvStr;
						end if;
					
					when StRdStrHold1 =>					
						SStCurrent <= StRdStrHold2;
					
					when StRdStrHold2 =>					
						SStCurrent <= StRdStrHold3;
					
					when StRdStrHold3 =>					
						SStCurrent <= StRdStrHold4;
					
					when StRdStrHold4 =>					
						SStCurrent <= StRdDeactvStr;
					
					when StRdDeactvStr =>					
						SStCurrent <= StRdDeactvCS;
						
					when StRdDeactvCS =>						
						if STimeCSRH = 3 then
							STimeCSRH <= 0;
							SStCurrent <= StRdComplete;
						else
							STimeCSRH <= STimeCSRH + 1;
							SStCurrent <= StRdDeactvCS;
						end if;
						
					when StRdComplete =>					
						SStCurrent <= StIdle;
	
					when others =>						
						SStCurrent <= StIdle;
            
				end case;
			end if;
		end if;	
	end process;
  
	
	process(PIClk50MHz, SStCurrent)
	begin	
		if PIClk50MHz'event and PIClk50MHz= '1' then			
			case SStCurrent is				
					when StIdle =>						    
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '1';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= (others => '0');

					when StWrActvCS =>						
						POStr		<= '1';         
						PORW       <= '0';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
					
					when StWrActvStr =>					
						POStr		<= '0';         
						PORW       <= '0';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
					
					when StWrStrHold1 =>						
						POStr		<= '0';         
						PORW       <= '0';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
					
					when StWrStrHold2 =>						
						POStr		<= '0';         
						PORW       <= '0';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
					
					when StWrDeactvStr =>					
						POStr		<= '1';         
						PORW       <= '0';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
					
					when StWrDeactvStr2 =>					
						POStr		<= '1';         
						PORW       <= '0';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
					
					when StWrDeactvCS =>							
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '1';
						PORWDone	<= '1';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
						
					when StWrComplete =>					
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '1';
						PORWDone	<= '1';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '1';
						SDataBus <= PIDataIn;
	
					when StRdActvCS =>					
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
					when StRdActvStr =>					
						POStr		<= '0';         
						PORW       <= '1';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
					when StRdStrHold1 =>					
						POStr		<= '0';         
						PORW       <= '1';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
					when StRdStrHold2 =>					
						POStr		<= '0';         
						PORW       <= '1';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
					when StRdStrHold3 =>					
						POStr		<= '0';         
						PORW       <= '1';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
					when StRdStrHold4 =>					
						POStr		<= '0';         
						PORW       <= '1';   
						POCS			<= '0';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
					when StRdDeactvStr =>					
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '0';
						PORWDone	<= '1';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= PIODataBus;
					   SLastRData <= PIODataBus;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
					when StRdDeactvCS =>						
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '1';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
						
					when StRdComplete =>					
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '1';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
	
					when others =>						
						POStr		<= '1';         
						PORW       <= '1';   
						POCS			<= '1';
						PORWDone	<= '0';
						PORegAddr <= PIRWAddr;         	 
						PODataOut <= SLastRData;
						STrisEn  <= '0';
						SDataBus <= (others => '0');
					
				end case;
			end if;
	end process;
	
	PIODataBus <= SDataBus when STrisEn = '1' else (others => 'Z');
	
	process(PIClk50MHz, PISyncReset)		
	begin													
		if PIClk50MHz'event and PIClk50MHz = '1' then		
			if PISyncReset = '1' then
				SClk12MHz <= '1';
				SClkCnt <= 0;				
			elsif SClkCnt = 3 then		
				SClkCnt <= 0;
				SClk12MHz <= not(SClk12MHz);	
			else
				SClkCnt <= SClkCnt + 1;

			end if;
		end if;	
	end process;
  
end Behavioral;

