----------------------------------------------------------------------------------
-- Company: 		PAVO A.?
-- Engineer:		ILGAZ AZ 
-- 
-- Create Date:    09:17:04 01/19/2010 
-- Design Name: 	 1553 Top Module Design
-- Module Name:    MainController - Behavioral 
-- Project Name: 		
-- Target Devices: ML50X
-- Tool versions:  
-- Description: 
--
-- Dependencies: 
--
-- Revision: 	In?tial Rev
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

entity MainController is
	port (	POMR 				  : out std_logic;
          PODataIn			      : out std_logic_vector(15 downto 0);
          PORWAddr			      : out std_logic_vector(3 downto 0);
          PORdHI				  : out std_logic;
          POWrHI				  : out std_logic;
          PORxDpData		      : out std_logic_vector(15 downto 0);
          PORxDpAddr		      : out std_logic_vector(5 downto 0); -- 32 Words
          POWrEnable 			  : OUT std_logic_vector(0 downto 0);
          POTxDpAddr		      : out std_logic_vector(5 downto 0); -- 32 Words
          POErrorReg			  : out std_logic_vector(7 downto 0);
          POPBitErrorReg	      : out std_logic_vector(7 downto 0);
          PORxReady1553           : out std_logic;
          PIError				  : in std_logic;
          PIValMess			      : in std_logic;
          PIRCVA				  : in std_logic;
          PIRCVB				  : in std_logic;
          PIDataOut 		      : in std_logic_vector(15 downto 0);
          PIRWDone			      : in std_logic;
          PIProcessOK		      : in std_logic;
          PIBusyInOth		      : in std_logic;
          PIClrErrFlg		      : in std_logic;
          PITxDpData		      : in std_logic_vector(15 downto 0);
          PIClk50MHz		      : in std_logic;
          PORcvCmd			      : out std_logic;
          PISyncReset		      : in std_logic
				);

end MainController;


architecture Behavioral of MainController is

	type TStateType is (	StIdle, StMResetHI, StInitHI_w, StInitHI, StRdPrty, StRtPrtyCheck, StWaitRcv, StClearErr, 
                        StWaitRFlag, StRdStatusReg, StCheckValRcv, StBusChange, StIllegalModeCodeClearStatus, 
                        StRdCommWord, StMcCommWordCheck, StCommWordCheckIllegalRcv, StCommWordCheckIllegalTr, 
                        StBusChangeCnt, StCommWordCheck, StReceiveState, StCheckFFEmpty, StGetRcvWords, 
                        StSaveRcvWords, StRdFifoState, StCheckFifo, StEORcvCheck, StRdValMess, StCheckValMess, 
                        StReceiveDone, StModeCommCheck, StTransmit, StWaitProcessing, StTransmitVersion, 
                        StTransmitTxFifo, StRdTransmitDpram, StRdValMessTx, 
                        StUpdate, StCheckValMessTx, StTransmitComplete, StRdErrorReg, StMCTransmit, 
                        StMCTransmit2, StMCTransmit3, StMCTransmitterShutdownCtrl, 
                        StMCTransmitterShutdown, StMCBusChange, StMCOVTransmitterShutdownCtrl, 
                        StMCOVTransmitterShutdown, StMCOVBusChange, StMCResetRt, StMC_MRTransmit,
                        StMC_MRTransmit2, StMC_MRTransmit3, StIllegalCommand, StMC_IllegalCommand,
                        StBusyCommand, StWait, StIlTransmitTxFifo, StIlTransmitTxFifo1, StIlRdTransmitDpram);
                        
	signal SStCurrent                  : TStateType  := StIdle;
	signal SStPreCurrent               : TStateType  := StIdle;
	signal SRdCommWordCtrl             : std_logic   := '0';
	signal SPreRWDone 	               : std_logic;
	signal SRxDpAddr                   : std_logic_vector(5 downto 0); 
	signal STxDpAddr                   : std_logic_vector(5 downto 0); 
	signal STrWordCnt 	               : std_logic_vector(5 downto 0); 
	signal SRcvWordCnt 	               : std_logic_vector(5 downto 0);
	signal SMRCount	 	                 : std_logic_vector(15 downto 0);
	signal SRWAddr	 	                 : std_logic_vector(3 downto 0);
	signal SBusChangeData	 	           : std_logic_vector(15 downto 0);
	signal SMCBusChangeData	           : std_logic_vector(15 downto 0);
	signal SMCOVBusChangeData          : std_logic_vector(15 downto 0);
	signal STransmitStatusData         : std_logic_vector(15 downto 0);
	signal SMRTransmitStatusData       : std_logic_vector(15 downto 0);
	signal SBusChange                  : std_logic := '0';
  signal SPreBusChange	 	           : std_logic := '0';
	signal STrShutdownCtrlA	 	         : std_logic := '0';
	signal STrShutdownCtrlB	 	         : std_logic := '0';
	signal SIllegalCommandCtrl	 	     : std_logic := '0';
	signal SMCIllegalCommandCtrl	 	   : std_logic := '0';
	signal SIllegalCommandCtrlTrStatus : std_logic := '0';
	signal SValmessFF1	  : std_logic;
	signal SValmessFF2	  : std_logic;
	signal SValmessFF3	  : std_logic;
	signal SValmessFF4	  : std_logic;
	signal SValmessFF5	  : std_logic;
	signal SValmessFF6	  : std_logic;
	signal SRcvaFF1   	  : std_logic;
	signal SRcvaFF2   	  : std_logic;
	signal SRcvaFF3   	  : std_logic;
	signal SRcvaFF4   	  : std_logic;
	signal SRcvaFF5   	  : std_logic;
	signal SRcvaFF6   	  : std_logic;
	signal SRcvbFF1   	  : std_logic;
	signal SRcvbFF2   	  : std_logic;
	signal SRcvbFF3   	  : std_logic;
	signal SRcvbFF4   	  : std_logic;
	signal SRcvbFF5   	  : std_logic;
	signal SRcvbFF6   	  : std_logic;
	signal SErrorFF1	    : std_logic;
	signal SErrorFF2	    : std_logic;
	signal SErrorFF3	    : std_logic;
	signal SErrorFF4	    : std_logic;
	signal SErrorFF5	    : std_logic;
	signal SErrorFF6	    : std_logic;
	signal SClearError	  : std_logic;
	signal SClearErrorOK  : std_logic;
	signal SPBitCtrl		  : std_logic_vector(1 downto 0) := "00";
	signal SITimer		    : integer range 0 to 500000 := 0;
	signal SWaitCounter   : integer range 0 to 15;
	signal SErrorReg	    : std_logic_vector(7 downto 0);
	signal SBC1553Reset   : std_logic := '0';
	signal STimerReset    : std_logic := '0';
	signal SErrorDetect   : std_logic := '0';
	signal SRcvaDetect    : std_logic := '0';
	signal SRcvbDetect    : std_logic := '0';
  
  
begin

	LGlitchClean : process(PIClk50MHz, SBC1553Reset, PIRCVA, PIRCVB, PIError)
	begin	
		if PIClk50MHz'event and PIClk50MHz = '1' then			
			if SBC1553Reset = '1' then
				SValmessFF1	<= '0';
				SValmessFF2	<= '0';
				SValmessFF3	<= '0';
				SValmessFF4	<= '0';
				SValmessFF5	<= '0';
				SValmessFF6	<= '0';
				SRcvaFF1   	<= '0';
				SRcvaFF2   	<= '0';
				SRcvaFF3   	<= '0';
				SRcvaFF4   	<= '0';
				SRcvaFF5   	<= '0';
				SRcvaFF6   	<= '0';
				SRcvbFF1   	<= '0';
				SRcvbFF2   	<= '0';
				SRcvbFF3   	<= '0';
				SRcvbFF4   	<= '0';
				SRcvbFF5   	<= '0';
				SRcvbFF6   	<= '0';
				SErrorFF1		<= '0';
				SErrorFF2		<= '0';
				SErrorFF3		<= '0';
				SErrorFF4		<= '0';
				SErrorFF5		<= '0';
				SErrorFF6		<= '0';
				SPreRWDone		<= '0';				
			else				
				SPreRWDone		<= PIRWDone;
				SValmessFF1 	<= PIValMess;
				SValmessFF2 	<= SValmessFF1;
				SValmessFF3 	<= SValmessFF2;
				SRcvaFF1		<= PIRCVA;
				SRcvaFF2		<= SRcvaFF1;
				SRcvaFF3		<= SRcvaFF2;
				SRcvbFF1		<= PIRCVB;
				SRcvbFF2		<= SRcvbFF1;
				SRcvbFF3		<= SRcvbFF2;
				SErrorFF1		<= PIError;
				SErrorFF2		<= SErrorFF1;
				SErrorFF3		<= SErrorFF2;
				
				SErrorFF4		<= SErrorFF3 and SErrorFF2;		
				SErrorFF5		<= SErrorFF4 and SErrorFF3;
				SErrorFF6		<= SErrorFF5 and SErrorFF4;
				
				
				SRcvaFF4		<= SRcvaFF3 and SRcvaFF2;		
				SRcvaFF5		<= SRcvaFF4 and SRcvaFF3;
				SRcvaFF6		<= SRcvaFF5 and SRcvaFF4;
				
				
				SRcvbFF4		<= SRcvbFF3 and SRcvbFF2;		
				SRcvbFF5		<= SRcvbFF4 and SRcvbFF3;
				SRcvbFF6		<= SRcvbFF5 and SRcvbFF4;
				
				SValmessFF4		<= SValmessFF3 and SValmessFF2;		
				SValmessFF5		<= SValmessFF4 and SValmessFF3;
				SValmessFF6		<= SValmessFF5 and SValmessFF4;				
			end if;
		end if;	
	end process;

	process(PIClk50MHz)
	begin
		if PIClk50MHz'event and PIClk50MHz = '1' then
			if PIClrErrFlg = '1' then
				SClearError <= '1';
			elsif SClearErrorOK = '1' then
				SClearError <= '0';
			end if;
		end if;
	end process;
	
	process(PIClk50MHz,PISyncReset)
	begin
		if PISyncReset = '1' then
			SITimer <= 0;
			STimerReset <= '0';
		elsif PIClk50MHz'event and PIClk50MHz = '1' then
			SStPreCurrent <= SStCurrent;
			if SStCurrent /= StWaitRcv then
				if SITimer = 500000 then
					SITimer <= 0;
					STimerReset <= '1';
				else
					SITimer <= SITimer + 1;
					STimerReset <= '0';
				end if;
			else
				SITimer <= 0;
				STimerReset <= '0';
			end if;
		end if;
	end process;
	
	SBC1553Reset <= PISyncReset or STimerReset;
	process(PIClk50MHz, SBC1553Reset)
	begin
		if SBC1553Reset = '1' then
				
				SStCurrent 		<= StIdle;
				SRxDpAddr 	<= (others => '0');
				STxDpAddr 	<= (others => '0');
				STrWordCnt		<= (others => '0');
				SRcvWordCnt		<= (others => '0');
				PORcvCmd			<= '0';
				SErrorReg		<= x"00";
			
		elsif PIClk50MHz'event and PIClk50MHz = '1' then
			
				if SErrorFF5 = '1' and SErrorFF6 = '0' then
					SErrorDetect <= '1';
				else
					SErrorDetect <= SErrorDetect;
				end if;
				if SRcvaFF5 = '1' and SRcvaFF6 = '0' then
					SRcvaDetect <= '1';
				else
					SRcvaDetect	<=	SRcvaDetect;
				end if;
				if SRcvbFF5 = '1' and SRcvbFF6 = '0' then
					SRcvbDetect <= '1';
				else
					SRcvbDetect	<=	SRcvbDetect;
				end if;
				case SStCurrent is
				
					when StIdle =>					
						SStCurrent <= StMResetHI;                        
            STrShutdownCtrlA <= '0';
            STrShutdownCtrlB <= '0';
						SBusChange <= '0';
            
					when StMResetHI =>
						if SMRCount(3) = '1' then
							SStCurrent <= StInitHI_w;
							SMRCount <= (others => '0');
						else
							SStCurrent <= StMResetHI;
							SMRCount <= SMRCount + 1;
						end if;
					
					when StInitHI_w =>
						if SMRCount(3) = '1' then
							SStCurrent <= StInitHI;
							SMRCount <= (others => '0');
						else
							SStCurrent <= StInitHI_w;
							SMRCount <= SMRCount + 1;
						end if;

					when StInitHI =>					
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StWaitRcv;
						else
							SStCurrent <= StInitHI;
						end if;
					              
					when StWaitRcv =>
						SIllegalCommandCtrl <= '0';
						SMCIllegalCommandCtrl <= '0';
						if SIllegalCommandCtrl = '1' or SMCIllegalCommandCtrl = '1' then
							SIllegalCommandCtrlTrStatus <= '1' ;
						else
							SIllegalCommandCtrlTrStatus <= SIllegalCommandCtrlTrStatus;
						end if ;
						SIllegalCommandCtrl <= '0';
						if SErrorDetect = '1' then
							SErrorDetect <= '0';
							SStCurrent <= StRdErrorReg;
							SClearErrorOK <= '0';
							PORcvCmd <= '1';
					   elsif SRcvaDetect = '1' then
							SRcvaDetect <= '0';
							PORcvCmd <= '0';
							if SBusChange = '0'  and STrShutdownCtrlA ='0' then
								SStCurrent <= StRdCommWord;
							else
								SBusChange <= '0';	
								 if STrShutdownCtrlA = '1' then   
									 SStCurrent <= StWaitRcv;
								 else
									 SBusChangeData <= "0001000001" & "01" & "1000";          --"00" & tr_shutdown_ctrl & "1000001011000"; --1058
									 SStCurrent <= StBusChange;
								 end if;
							end if;
			--			elsif SRcvbFF6 = '0' and SRcvbFF5 = '1' then
						elsif SRcvbDetect = '1' then
							SRcvbDetect <= '0';
						--	SStCurrent 	<= StRdStatusReg;
							PORcvCmd <= '0';
							if SBusChange = '1' and STrShutdownCtrlB = '0' then
								SStCurrent <= StRdCommWord;		-- Pinlerde RCV ve PIRFlag alg?lanmas?ndan sonra, gürültüden olu?abilecek
							else
								SBusChange <= '1';
                        if STrShutdownCtrlB = '1' then     
									SStCurrent <= StWaitRcv;
                        else
                           SBusChangeData <= "0001000001" & "10" & "1000";          --"00" & tr_shutdown_ctrl & "1000001101000"; --1068
                           SStCurrent <= StBusChange;
                        end if;
                      end if;		
						elsif SClearError = '1' then
							SStCurrent <= StClearErr;
							PORcvCmd <= '0';
						else
							SStCurrent <= StWaitRcv;
							PORcvCmd <= '0';
							if SPBitCtrl = "00" then
								SPBitCtrl <= "10";
								POPBitErrorReg <= x"00";
							end if;
						end if;
					
					when StClearErr =>
						SClearErrorOK <= '1'; 
						SErrorReg <= x"00";
						SStCurrent <= StWaitRcv;
            
					when StRdStatusReg =>						
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StCheckValRcv;
						else
							SStCurrent <= StRdStatusReg;
						end if;
						
					when StCheckValRcv =>						-- Burada hem PIRCVA hem PIRCVB hemde PIRFlag sinyallerinin gelip gelmedi?i ve status saklay?c?s?na yaz?l?p yaz?lmad??? s?nanm??t?r...
						if PIDataOut(1) = '1' then
							if SBusChange = '0' then
								SStCurrent <= StRdCommWord;
							else
								SBusChange <= '0';
								SBusChangeData <= x"1058";
								SStCurrent <= StBusChange;
							end if;							
							SRWAddr <= "0000";
						elsif PIDataOut(2) = '1' then
							if SBusChange = '1' then
								SStCurrent <= StRdCommWord;		-- Pinlerde RCV ve PIRFlag alg?lanmas?ndan sonra, gürültüden olu?abilecek
							else
								SBusChange <= '1';
								SBusChangeData <= x"1068";
								SStCurrent <= StBusChange;
							end if;							
							SRWAddr <= "0000";
						else										-- hatalar? önlemek için status word okunarak birkez daha kontrol yap?l?r.
							SStCurrent <= StIdle;				-- Alg?lama sonras? de?erler, saklay?c?dan da do?ru okunmu?sa i?leme devam edilir..
						end if;							 		-- E?er, saklay?c?daki de?erler yanl??sa StIdle'a dallan?l?r...
					
					when StBusChange =>						
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StRdCommWord;
						else
							SStCurrent <= StBusChange;
						end if;
						
					when StRdCommWord =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							if PIDataOut = x"0000" and SRdCommWordCtrl = '1' then
								SRdCommWordCtrl <= '0';
								SStCurrent <= StIdle;
							
							elsif PIDataOut = x"0000" and SRdCommWordCtrl = '0' then
								SRdCommWordCtrl <= '1';
								if SRcvaFF6 = '1'  then
									SRcvaDetect <= '1';
									SStCurrent <= StWaitRcv;
								elsif SRcvbFF6 = '1' then
									SRcvbDetect <= '1';
									SStCurrent <= StWaitRcv;
								end if;
							else
									if PIDataOut(10) = '0' then	 
										SStCurrent <= StCommWordCheckIllegalRcv;
									else
										SStCurrent <= StCommWordCheckIllegalTr;
									end if;
							end if;
						else
						  SStCurrent <= StRdCommWord;
						end if;
            
         when StCommWordCheckIllegalRcv =>
            SStCurrent <= StUpdate;--StCommWordCheck;
            case PIDataOut(9 downto 5) is
              when "00000" =>
                SIllegalCommandCtrl <= '0';
              when "00001" =>
                SIllegalCommandCtrl <= '1';
              when "00010" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "01010" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "00011" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "01000" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "00100" =>
                  SIllegalCommandCtrl <= '0';
              when "00101" =>
                  SIllegalCommandCtrl <= '0';
              when "00110" =>
                  SIllegalCommandCtrl <= '0';
              when "00111" =>
                  SIllegalCommandCtrl <= '0';
              when "01000" =>
                  SIllegalCommandCtrl <= '0';
              when "01001" =>
                  SIllegalCommandCtrl <= '0';
              when "01010" =>
                  SIllegalCommandCtrl <= '0';
              when "01011" =>
                  SIllegalCommandCtrl <= '0';
              when "01100" =>
                  SIllegalCommandCtrl <= '0';
              when "01110" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "10110" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "01111" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11010" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "10000" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11100" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
				  when "10001" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "00100" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
				  when "10011" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "00001" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "11111" =>
                SIllegalCommandCtrl <= '0';
              when others =>
                SIllegalCommandCtrl <= '1';
            end case;
            
         when StCommWordCheckIllegalTr =>
            SStCurrent <= StUpdate;
            case PIDataOut(9 downto 5) is
              when "00000" =>
                SIllegalCommandCtrl <= '0';
              when "00001" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11000" then
                    SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "00010" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11000" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "00011" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "01001" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "00100" =>
                  SIllegalCommandCtrl <= '0';
              when "00101" =>
                  SIllegalCommandCtrl <= '0';
              when "00110" =>
                  SIllegalCommandCtrl <= '0';
              when "00111" =>
                  SIllegalCommandCtrl <= '0';
              when "01000" =>
                  SIllegalCommandCtrl <= '0';
              when "01001" =>
                  SIllegalCommandCtrl <= '0';
              when "01010" =>
                  SIllegalCommandCtrl <= '0';
              when "01011" =>
                  SIllegalCommandCtrl <= '0';
              when "01100" =>
                  SIllegalCommandCtrl <= '0';
              when "01101" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "00011" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "01110" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "10110" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "01111" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11010" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "10000" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11101" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "10001" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "01010" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;
              when "10010" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "01000" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;	
				  when "10011" =>
                SIllegalCommandCtrl <= '0';
				  when "10100" =>
                SIllegalCommandCtrl <= '0';
				  when "10101" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11100" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;	
              when "10110" =>
                SIllegalCommandCtrl <= '0';
				  when "10111" =>
                if PIDataOut(4 downto 0) = "00000" or PIDataOut(4 downto 0) > "11100" then
                  SIllegalCommandCtrl <= '1';
                else	
                  SIllegalCommandCtrl <= '0';
                end if;	
				  when "11000" =>
                SIllegalCommandCtrl <= '0';
				  when "11001" =>
                SIllegalCommandCtrl <= '0';
				  when "11111" =>
                SIllegalCommandCtrl <= '0';
              when others =>
                SIllegalCommandCtrl <= '1';
            end case;  
         when StUpdate =>
            if SIllegalCommandCtrl = '1' then
              SStCurrent <= StIllegalCommand;
            else
               if PIDataOut(9 downto 5) = "01101" then
                SStCurrent <= StIllegalModeCodeClearStatus;
              else
                if PIBusyInOth = '1' then
                  SIllegalCommandCtrl <= '1';
                  SStCurrent <= StBusyCommand;
                else
                  SStCurrent <= StIllegalModeCodeClearStatus;
                end if;
              end if;
            end if;
                when StIllegalModeCodeClearStatus =>
                    if SPreRWDone = '0' and PIRWDone = '1' then
              SStCurrent <= StCommWordCheck;
            else
              SStCurrent <= StIllegalModeCodeClearStatus;
            end if;
         when StBusChangeCnt =>
            if SPreBusChange = SBusChange then
              SStCurrent <= StCommWordCheck;
            else
              SPreBusChange <= SBusChange;
              SStCurrent <= StBusChange;
            end if;
				 when StCommWordCheck =>
            if (PIDataOut(9 downto 5) = "11111") or (PIDataOut(9 downto 5) = "00000") then
              PORcvCmd <= '1';
              SStCurrent 	<= StModeCommCheck;
            elsif PIDataOut(10) = '1' then 
              if SIllegalCommandCtrl = '1' then
                PORcvCmd <= '1';
                --SStCurrent 	<= StIlTransmitTxFifo;
                SStCurrent   <= StWaitRcv;
              else
--                if PIDataOut(9 downto 5) = "01101" then
--                  PORcvCmd <= '0';
--                  SStCurrent <= StTransmitVersion;
--                else
                  PORcvCmd <= '1';
                  SStCurrent <= StTransmit;
            --    end if;
              end if;
              if PIDataOut(4 downto 0) = "00000" then -- 32 Words
                STrWordCnt(5) <=  '1';
              else
                STrWordCnt(5) <=  '0';
              end if;
              STrWordCnt(4 downto 0) <=  PIDataOut(4 downto 0);
            elsif PIDataOut(10) = '0' then	
              PORcvCmd <= '1';
              SStCurrent 	<= StReceiveState;   
              if PIDataOut(4 downto 0) = "00000" then -- 32 Words
                SRcvWordCnt(5) <=  '1';
              else
                SRcvWordCnt(5) <=  '0';
              end if;
              SRcvWordCnt(4 downto 0) <=  PIDataOut(4 downto 0);
            else
              SStCurrent <= StIdle;
            end if;
				 when StMcCommWordCheck =>
            if PIDataOut(10) = '1' then 
              if SIllegalCommandCtrl = '1' then
                SStCurrent 	<= StIlTransmitTxFifo;
              else
                SStCurrent <= StTransmit;
              end if;
              if PIDataOut(4 downto 0) = "00000" then  -- 32 Words
                STrWordCnt(5) <=  '1';
              else
                STrWordCnt(5) <=  '0';
              end if;
              STrWordCnt(4 downto 0) <=  PIDataOut(4 downto 0);
            elsif PIDataOut(10) = '0' then	
              SStCurrent 	<= StReceiveState;    
              if PIDataOut(4 downto 0) = "00000" then  -- 32 Words
                SRcvWordCnt(5) <=  '1';
              else
                SRcvWordCnt(5) <=  '0';
              end if;
              SRcvWordCnt(4 downto 0) <=  PIDataOut(4 downto 0);
            else
              SStCurrent <= StIdle;
            end if;
-----------------------------------mode codes-----------------------------------------------------      
        when StModeCommCheck =>
              if PIDataOut(10) = '1' and PIDataOut(4 downto 0) = "00010" then       --Transmit Status
                  SStCurrent <= StMCTransmit;
              elsif PIDataOut(10) = '1' and PIDataOut(4 downto 0) = "00100" then    --Transmitter Shutdown
                  SStCurrent <= StMCTransmitterShutdownCtrl;
              elsif PIDataOut(10) = '1' and PIDataOut(4 downto 0) = "00101" then    --Override Transmitter Shutdown
                  SStCurrent <= StMCOVTransmitterShutdownCtrl;
              elsif PIDataOut(10) = '1' and PIDataOut(4 downto 0) = "01000" then    --Reset RT
                  SStCurrent <= StMCResetRt;
              else
                  SStCurrent <= StMC_IllegalCommand;
              end if;
        when StMCTransmit =>
            if SPreRWDone = '0' and PIRWDone = '1' then
              SStCurrent <= StMCTransmit2;
            else
              SStCurrent <= StMCTransmit;
            end if;
        when StMCTransmit2 =>
           SIllegalCommandCtrlTrStatus <= '0';
          if PIDataOut(8) = '1' or SIllegalCommandCtrlTrStatus = '1' then
              STransmitStatusData <= x"0400";
          else
              STransmitStatusData <= x"0000";--x"0000" do?rusu
          end if;
            SStCurrent <= StMCTransmit3;
            
       when StMCTransmit3 =>
          if SPreRWDone = '0' and PIRWDone = '1' then
            SStCurrent <= StWaitRcv;
          else
            SStCurrent <= StMCTransmit3;
          end if;
       when StMCTransmitterShutdownCtrl =>
          SStCurrent <= StMCTransmitterShutdown;
       when StMCTransmitterShutdown =>
          if SBusChange = '0' then          -- Komut Bus A'dan geldi. 
              STrShutdownCtrlB <= '1';
              SStCurrent <= StWaitRcv;
          else                                -- Komut Bus B'dan geldi.
              STrShutdownCtrlA <= '1';
              SStCurrent <= StWaitRcv;
          end if;
          
       when StMCBusChange =>
          if SPreRWDone = '0' and PIRWDone = '1' then
            SStCurrent <= StWaitRcv;
          else
            SStCurrent <= StMCBusChange;
          end if;
          
       when StMCOVTransmitterShutdownCtrl =>
          SStCurrent <= StMCOVTransmitterShutdown;
          
       when StMCOVTransmitterShutdown =>
          if SBusChange = '0' then             -- Komut Bus A'dan geldi. 
              STrShutdownCtrlB <= '0';
              SStCurrent <= StWaitRcv;
          else                                -- Komut Bus B'dan geldi.
              STrShutdownCtrlA <= '0';
              SStCurrent <= StWaitRcv;
          end if;
          
       when StMCOVBusChange =>
          if SPreRWDone = '0' and PIRWDone = '1' then
						SStCurrent <= StWaitRcv;
          else
						SStCurrent <= StMCOVBusChange;
          end if;			
             when StMCResetRt =>
          if SValmessFF6 = '0' and SValmessFF5 = '1' then
            SStCurrent <= StIdle;--StMResetHI;
          else
            SStCurrent <= StMCResetRt;
          end if; 
          
        when StMC_MRTransmit => 
          if SPreRWDone = '0' and PIRWDone = '1' then
            SStCurrent <= StMC_MRTransmit2;
          else
            SStCurrent <= StMC_MRTransmit;
          end if;
          
        when StMC_MRTransmit2 => 
          if PIDataOut(8) = '1' then
            SMRTransmitStatusData <= x"0400";
          else
            SMRTransmitStatusData <= x"0000";
          end if;
          SStCurrent <= StMC_MRTransmit3;
          
				when StMC_MRTransmit3 =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StMCResetRt;
						else
							SStCurrent <= StMC_MRTransmit3;
						end if; 
            
----------------------------------mode codes----------------------------------------------------------------	
----------------------------------illegal command----------------------------------------------------------------	
				  when StIllegalCommand =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StCommWordCheck;
						else
							SStCurrent <= StIllegalCommand;
						end if;
					when StMC_IllegalCommand =>
						SMCIllegalCommandCtrl <= '1';
						if SPreRWDone = '0' and PIRWDone = '1' then
							if PIDataOut(10) = '1' then	
								SStCurrent <= StWaitRcv;
							else
								SStCurrent <= StMcCommWordCheck;
							end if;
						else
							SStCurrent <= StMC_IllegalCommand;
						end if;
					when StBusyCommand =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StCommWordCheck;
						else
							SStCurrent <= StBusyCommand;
						end if;
          when StWait =>
						SIllegalCommandCtrl <= '0';
						if SValmessFF6 = '0' and SValmessFF5 = '1' then
							STxDpAddr <= (others => '0');
							SStCurrent <= StIdle;
						else
							SStCurrent <= StWait;
						end if;
					when StTransmitVersion =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							STxDpAddr <= (others => '0');
							SStCurrent <= StRdValMessTx;
						else
							SStCurrent <= StTransmitVersion;
						end if;
					when StIlTransmitTxFifo =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StIlRdTransmitDpram;
							STxDpAddr <= STxDpAddr + 1;
						else
							SStCurrent <= StIlTransmitTxFifo;
						end if;
					when StIlRdTransmitDpram =>					
						if STxDpAddr = STrWordCnt then
							STxDpAddr <= (others => '0');
							SStCurrent <= StRdValMessTx;
						else
							SStCurrent <= StIlTransmitTxFifo1;
						end if;
					when StIlTransmitTxFifo1 =>
               if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StIlRdTransmitDpram;
							STxDpAddr <= STxDpAddr + 1;
						else
							SStCurrent <= StIlTransmitTxFifo1;
						end if;     
					when StReceiveState =>	
						
						if SPreRWDone = '0' and PIRWDone = '1' then
							if SMCIllegalCommandCtrl = '1' then
								SStCurrent <= StGetRcvWords;
							else
								SStCurrent <= StCheckFFEmpty;
							end if;
						else
							SStCurrent <= StReceiveState;
						end if;
						
					when StCheckFFEmpty =>		----state ismi guncellenecek----
						
						--if PIDataOut(7) = '1' then     -----------------------------------------
--						if valmess = '1' then
						if SValmessFF6 = '0' and SValmessFF5 = '1' then
							SStCurrent <= StGetRcvWords;
						else
--							SStCurrent <= StReceiveState;	------------------------------------------
							SStCurrent <= StCheckFFEmpty;
						end if;
						
					when StGetRcvWords =>
						
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StSaveRcvWords;
							SRxDpAddr <= SRxDpAddr + 1;
						else
							SStCurrent <= StGetRcvWords;
						end if;
						
					when StSaveRcvWords =>
						SStCurrent <= StEORcvCheck;
					
					when StEORcvCheck =>
						if SRxDpAddr = SRcvWordCnt then
--							SStCurrent <= StRdFifoState;;
							if SIllegalCommandCtrl = '0' and SMCIllegalCommandCtrl = '0' then
								SStCurrent <= StReceiveDone;
							else	
								SStCurrent <= StWaitRcv;
								SRxDpAddr <= (others => '0');
							end if;	
						else
							SStCurrent <= StGetRcvWords;		
						end if;
									
					when StRdFifoState =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StCheckFifo;
						else
							SStCurrent <= StRdFifoState;
						end if;
						
					when StCheckFifo =>
						
						if PIDataOut(3) = '1' then
							SStCurrent <= StRdValMess;
						else
							SStCurrent <= StIdle;
						end if;

					when StRdValMess =>
						
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StCheckValMess;
						else
							SStCurrent <= StRdValMess;
						end if;
						
					when StCheckValMess =>
						
						if PIDataOut(7) = '1' then
							SStCurrent <= StReceiveDone;
							SIllegalCommandCtrl <= '0';
						else
							SStCurrent <= StIdle;
						end if;							
					
					when StReceiveDone =>
						
						SStCurrent <= StWaitRcv;
						SRxDpAddr <= (others => '0');
					
					when StTransmit =>	-- command word rx_fifosunun ilk gözüne kaydedilir ve PORxReady1553 ç?kar?l?r.
							if SWaitCounter = 10 then
								SWaitCounter <= 0;
								SStCurrent <= StWaitProcessing;
							else
								SWaitCounter <= SWaitCounter + 1;
								SStCurrent <= StTransmit;
							end if;

					when StWaitProcessing =>		
							if PIProcessOK = '1' then
								SStCurrent <= StTransmitTxFifo;
							else
								SStCurrent <= StWaitProcessing;
							end if;
						
					when StTransmitTxFifo =>
						
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StRdTransmitDpram;
							STxDpAddr <= STxDpAddr + 1;
						else
							SStCurrent <= StTransmitTxFifo;
						end if;	
					when StRdTransmitDpram =>
						
						if STxDpAddr = STrWordCnt then
							SStCurrent <= StRdValMessTx;
						else
							SStCurrent <= StTransmitTxFifo;
						end if;
						
					when StRdValMessTx =>
						
						if SPreRWDone = '0' and PIRWDone = '1' then
							SStCurrent <= StCheckValMessTx;
						else
							SStCurrent <= StRdValMessTx;
						end if;
						
					when StCheckValMessTx =>
						
						if PIDataOut(7) = '1' then
							SStCurrent <= StTransmitComplete;
						else
							SStCurrent <= StRdValMessTx;		-- error durumu;
						end if;
							
					when StTransmitComplete =>
						
						SStCurrent <= StWaitRcv;
						STxDpAddr <= (others => '0');	
					
					when StRdErrorReg =>
						if SPreRWDone = '0' and PIRWDone = '1' then
							SErrorReg(5 downto 0)		<= PIDataOut(5 downto 0);
							SErrorReg(6)				<= PIDataOut(7);
							SErrorReg(7)				<= PIDataOut(9);
							if SPBitCtrl = "00" then
								SPBitCtrl <= "01";
								POPBitErrorReg(5 downto 0)		<= PIDataOut(5 downto 0);
								POPBitErrorReg(6)					<= PIDataOut(7);
								POPBitErrorReg(7)					<= PIDataOut(9);
							end if;
							SStCurrent <= StIdle;
						else
							SStCurrent <= StRdErrorReg;
						end if;
					
					when others =>
						
						SStCurrent <= StIdle;
						SRxDpAddr 	<= (others => '0');
						STxDpAddr 	<= (others => '0');
						STrWordCnt		<= (others => '0');
						SRcvWordCnt		<= (others => '0');
					
				end case;
		end if;
	end process;
	

	process(PIClk50MHz, SBC1553Reset, SStCurrent)
	begin
	
		if PIClk50MHz'event and PIClk50MHz = '1' then
				
			case SStCurrent is
			
				when StIdle =>
				
					POMR 				<= '0';
				--	BCMODE 			<= '0';
				--	RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
--					POErrorReg			<= x"00";
                    
                    --tr_shutdown_ctrl <= '0';
				
				when StMResetHI =>
				
					POMR 				<= '1';
                    
				--	BCMODE 			<= '0';
				--	RTMODE			<= '1';
					PODataIn			<= x"1059";
					PORWAddr			<= "0100";
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StInitHI_w =>
					POMR 				<= '0';
                    
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= x"1059";
					PORWAddr			<= "0100";
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StInitHI =>
					POMR 				<= '0';
					PODataIn			<= x"1058";
					PORWAddr			<= "0100";
					PORdHI				<= '0';
					POWrHI				<= '1';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StRdPrty =>
					POMR 				<= '0';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0111";
					PORdHI				<= '1';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StRtPrtyCheck =>
					POMR 				<= '0';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StWaitRFlag =>
					POMR 				<= '0';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StWaitRcv =>
					POMR 				<= '0';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StClearErr =>
					POMR 				<= '0';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StRdStatusReg =>
					POMR 				<= '0';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0101";
					PORdHI				<= '1';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StCheckValRcv =>
				
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
				when StBusChange =>
					
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					--PODataIn			<= x"1058";
					PODataIn			<= SBusChangeData;
					PORWAddr			<= "0100";
					PORdHI				<= '0';
					POWrHI				<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
					when StUpdate =>
				
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                    
                when StIllegalModeCodeClearStatus =>
                
                    POMR 				<= '0';
				--	BCMODE 			<= '0';
				--	RTMODE			<= '1';
					PODataIn			<= x"0000";
					PORWAddr			<= "1000";
					PORdHI				<= '0';
					POWrHI				<= '1';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StRdCommWord =>
						
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0000";
				--	PORWAddr			<= SRWAddr;
					PORdHI				<= '1';
					POWrHI				<= '0';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
					
				when StBusChangeCnt =>
				
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= x"FFFF";
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					
				when StCommWordCheck =>
				
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
                    
					PORxDpData		<= PIDataOut;
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "1";
                    
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
            
				when StMcCommWordCheck =>
				
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
                    
					PORxDpData		<= PIDataOut;
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "1";
                    
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;				
                    
                    -----------------------------------mode codes-----------------------------------------------------
                
                
               when StModeCommCheck => -- mode code belirlendi
                
               POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                
                
                
                when StMCTransmit => --  status okundu
					 
					
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0101";
					PORdHI				<= '1';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
					when StMCTransmit2 => --  status error kontrol edildi
					
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
					when StMCTransmit3 => --  transmit status yaz?ld?
                
               POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= STransmitStatusData;
					PORWAddr			<= "1000";
					PORdHI				<= '0';
					POWrHI				<= '1';       
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                    
                when StMCTransmitterShutdownCtrl =>
                
                    --tr_shutdown_ctrl <= '1';
                    
               POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;

                    
                
                
                when StMCTransmitterShutdown =>
                    
                    POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                    
                when StMCBusChange =>
                
                    POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					--PODataIn			<= x"1058";
					PODataIn			<= SMCBusChangeData;
					PORWAddr			<= "0100";
					PORdHI				<= '0';
					POWrHI				<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                    
                when StMCOVTransmitterShutdownCtrl =>
                
                    --tr_shutdown_ctrl <= '0';
                    
                    POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;

                
                when StMCOVTransmitterShutdown =>
                
                     POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                    
                when StMCOVBusChange =>
                
                    POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					--PODataIn			<= x"1058";
					PODataIn			<= SMCOVBusChangeData;
					PORWAddr			<= "0100";
					PORdHI				<= '0';
					POWrHI				<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;

                
                when StMCResetRt =>
                    
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
               
                when StMC_MRTransmit =>           --POMR öncesi transmit status word okundu 
             	
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0101";
					PORdHI				<= '1';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
					when StMC_MRTransmit2 => --  status error kontrol edildi
					
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
					when StMC_MRTransmit3 => --  transmit status yaz?ld?
                
               POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= SMRTransmitStatusData;
					PORWAddr			<= "1000";
					PORdHI				<= '0';
					POWrHI				<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                
                
                
                
                -----------------------------------mode codes-----------------------------------------------------
                -----------------------------------illegal command-----------------------------------------------------
                
                when StIllegalCommand =>
                
               POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= x"0400";
					PORWAddr			<= "1000";
					PORdHI				<= '0';
					POWrHI				<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
                when StMC_IllegalCommand =>
                
               POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= x"0400";
					PORWAddr			<= "1000";
					PORdHI				<= '0';
					POWrHI				<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StBusyCommand =>
                
                    POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= x"0008";
					PORWAddr			<= "1000";
					PORdHI				<= '0';
					POWrHI				<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
                
            when StWait =>
					POMR 				<= '0';
			--		BCMODE 			<= '0';
			--		RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StTransmitVersion =>
					POMR 				<= '0';
					PODataIn			<= x"0245";
					PORWAddr			<= "0011";
					PORdHI			<= '0';
					POWrHI			<= '1';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StIlTransmitTxFifo =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= x"0000";
					PORWAddr			<= "0011";
					PORdHI			<= '0';
					POWrHI			<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				when StIlTransmitTxFifo1 =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= x"0000";
					PORWAddr			<= "0011";
					PORdHI			<= '0';
					POWrHI			<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
						
				when StIlRdTransmitDpram =>
				
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
				when StReceiveState =>
					
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0101";
					PORdHI				<= '1';
					POWrHI				<= '0';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StCheckFFEmpty =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StGetRcvWords =>
						
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0100";
					PORdHI				<= '1';
					POWrHI				<= '0';       
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;					
						
				when StSaveRcvWords =>
						
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
                    
					PORxDpData		<= PIDataOut;
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "1";
                    
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
						
				when StEORcvCheck =>
						
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StRdFifoState =>
					
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0101";
					PORdHI				<= '1';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StCheckFifo =>
				
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StRdValMess =>
					
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0101";
					PORdHI				<= '1';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StCheckValMess =>
					
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StReceiveDone =>
					
					POMR 				<= '0';
		--			BCMODE 			<= '0';
		--			RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI			<= '0';
					POWrHI			<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
                    
					PORxReady1553 	<= '1';
                    
					POErrorReg			<= SErrorReg;
					
				when StTransmit =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
                    
					PORxReady1553 	<= '1';
                    
					POErrorReg			<= SErrorReg;
					
				when StWaitProcessing =>
				
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
				when StTransmitTxFifo =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= PITxDpData;
					PORWAddr			<= "0011";
					PORdHI			<= '0';
					POWrHI			<= '1';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
				when StRdTransmitDpram =>
				
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
				when StRdValMessTx =>
				
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0101";
					PORdHI				<= '1';
					POWrHI				<= '0';
                    
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
				when StCheckValMessTx =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
					
				when StTransmitComplete =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;
				
				when StRdErrorReg =>
					
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= (others => '0');
					PORWAddr			<= "0111";
					PORdHI				<= '1';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					POErrorReg			<= SErrorReg;					
				
				when others =>
				
					POMR 				<= '0';
	--				BCMODE 			<= '0';
	--				RTMODE			<= '1';
					PODataIn			<= x"FFFF";
					PORWAddr			<= (others => '0');
					PORdHI				<= '0';
					POWrHI				<= '0';
					PORxDpData		<= (others => '0');
					PORxDpAddr		<= SRxDpAddr;
					POWrEnable			<= "0";
					POTxDpAddr		<= STxDpAddr;
					PORxReady1553 	<= '0';
					
			end case;
		end if;
	end process;

end Behavioral;

