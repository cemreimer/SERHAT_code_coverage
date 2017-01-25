--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: HI6110_IC.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::IGLOO2> <Die::M2GL025T> <Package::484 FBGA>
-- Author: <Name>
--
--------------------------------------------------------------------------------

----default libs----
library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

----third party libs----
use work.types.all;

----HI6110 pinout(used ones only)----
entity HI6110 is
port (
   PISTR      : in std_logic;
   PIRW       : in std_logic;
   PICS       : in std_logic;
   PIOWORD    : inout std_logic_vector(15 downto 0);
   PIRegAddr  : in std_logic_vector(3 downto 0);
   PICLK      : in std_logic;   --- 50 MHz 
   PIBCSTART  : in std_logic;
   PIMR       : in std_logic;
   POERROR    : out std_logic;
   POVALMESS  : out std_logic;
   PIBUSA     : in std_logic;
   PIBUSB     : in std_logic;     
   PIODATAWORD: inout word_vector(31 downto 0);
   PICMD      : in std_logic_vector(15 downto 0); 
   PORCVA     : out std_logic;
   PORCVB     : out std_logic; 
   PIRTA      : in std_logic_vector(4 DOWNTO 0);
   PIRTAP     : in std_logic;
   PIERR      : in std_logic_vector(8 DOWNTO 0)  ---- HI6110 error register tanimina bakin. 
);
end HI6110;

architecture architecture_HI6110 of HI6110 is

----HI6110 Message and Register Buffering States----
type states is (StIdle, StBusActivity, StValidCmdCheck, StErrorHandlingValidCMD, StProcessCmd, StProcessData) 
signal H6110_states: states;

----From FPGA to HI6110 ports----
signal SMR, SRTAP, SBCSTART : std_logic; 
signal SRTA : std_logic_vector(4 downto 0);

----From HI6110 to FPGA IRQs----
signal SRCVA, SRCVB, SError, SVALMESS, SFFEMPTY: std_logic; 

----RT Physical Address Parity Check Signal----
signal SPrtyCheck: std_logic;
signal SPRTYERR: std_logic;
signal SPrty: std_logic;

----Bus Activity Detectors---
signal SRcvFlags: std_logic_vector(1 downto 0);
signal SBUSA, SBUSB: std_logic;
signal SPrevBUSA, SPrevBUSB : std_logic;
signal SActA, SActB: std_logic;

----Data FIFOs----
signal STXFIFO  : word_vector(31 downto 0);
signal SRXFIFO  : word_vector(31 downto 0);

----Register Access Signals----
signal SCS, SSTR, SRW, SPrevSTR: std_logic;  
signal SRegAccess: std_logic_vector(2 downto 0);


----HI6110 Accessible Registers----
signal STXSTATWORD : std_logic_vector(15 downto 0);
signal STXMODEDATAWORD : std_logic_vector(15 downto 0);
signal SCTRL : std_logic_vector(15 downto 0);
signal SCOMMWORD : std_logic_vector(15 downto 0);
signal SRXMODEDATAWORD : std_logic_vector(15 downto 0);
signal SSTAT : std_logic_vector(15 downto 0);
signal SMSG : std_logic_vector(15 downto 0);
signal SERR : std_logic_vector(15 downto 0);
signal SBUSAWORD : std_logic_vector(15 downto 0);
signal SBUSBWORD : std_logic_vector(15 downto 0);
signal SModeOrData : std_logic_vector(1 downto 0);

----others----
signal SDATAWORDLEN: integer range 0 to 32;

----error timer----
signal SErrorCounter: integer range 0 to 199;
signal SPrevErrorTimerFlag, SErrorTimerFlag: std_logic;
type states_of_error is (StIdle, StWaitErrorTimerFlag, StErrorCount)
signal error_states:states_of_error;

----Status register signals----
signal ErrorSTAT: std_logic;
signal RcvaSTAT: std_logic;
signal RcvbSTAT: std_logic;
signal FfemptySTAT: std_logic;
signal ValmessSTAT: std_logic;
signal RF0STAT: std_logic;
signal RF1STAT: std_logic;
signal RFlagnSTAT : std_logic;
signal IdleSTAT : std_logic;

begin

----I/O to Internal Register Buffering----
SSTR      <= PISTR;     
SRW       <= PIRW;     
SCS       <= PICS; 
SRegAccess<= SCS & SRW & SSTR;
SRegAddr  <= PIRegAddr;
SCLK      <= PICLK;
SReset    <= PIMR;    
SBCSTART  <= PIBCSTART; 

SCMD      <= PICMD;


SRTA      <= PIRTA;  
SRTAP     <= PIRTAP;    
SBUSA     <= PIBUSA;
SBUSB     <= PIBUSB;  

SPrty<= SRTA(4) xnor SRTA(3) xnor SRTA(2) xor SRTA(1) xnor SRTA(0);
SPrtyCheck <= '1' when SPrty = SRTAP else '0';

SERR(9 downto 0) <= SPRTYERR & PIERR;
SERR(15 downto 10) <= (others=>'0');

SDATAWORDLEN <= to_integer(SCOMMWORD(4 downto 0))-1 when SCOMMWORD(4 downto 0)>"00000" else 31;

SSTAT(0) <= RcvaSTAT;
SRCVA    <= SSTAT(1);
PORCVA   <= SRCVA;
 
SSTAT(1) <= RcvbSTAT;
SRCVB    <= SSTAT(2);
PORCVB   <= SRCVB;

SSTAT(8) <= ErrorSTAT;
SError   <= SSTAT(8);
POERROR  <= SError;

SSTAT(7)  <= ValmessSTAT;
SVALMESS  <= SSTAT(7);
POVALMESS <= SVALMESS;

SSTAT(3)  <= FfemptySTAT;

SSTAT(5)  <= RF0STAT;

SSTAT(6)  <= RF1STAT;

SSTAT(4)  <= RFlagnSTAT;

SSTAT(0)  <= IdleSTAT;
 
process(SCLK, SReset, SRTA, SRTAP, SRW)
        begin
            if SReset='1' then
                H6110_states <= StIdle;
                SSTAT        <= x"0000";
                SRXFIFO      <= (others=>x"0000");
                SRCVA        <= '0';
                SRCVB        <= '0';
                SVALMESS     <= '0'
                SDATAWORDLEN <= 0;
                SModeOrData  <= "00";

            elsif rising_edge(SCLK) then
                       
                case H6110_states is
                    when StIdle =>
                        if SPrtyCheck='1' then
                           SPRTYERR <= '0';
                           H6110_states <= StBusActivity;
                        else
                           SPRTYERR <= '1';
                           H6110_states <= StIdle; 
                        end if;
                    
                    when StBusActivity =>
                        
                        if (SBUSA xor SBUSB) = '1'   then
                            H6110_states <= StValidCmdCheck;
                            SActA <= SBUSA;
                            SActB <= SBUSB;
                        else
                            H6110_states <= StBusActivity;
                            SActA <= '0';
                            SActB <= '0';
                            
                        end if;    
                        SErrorTimerFlag <= '0'; 
                            
                       
                    when StValidCmdCheck =>
                   
                            if SCMD(0)(15 downto 11)<"11111" and SCMD(0)(15 downto 11)>"00000" then
                                if SCMD(0)(15 downto 11)=SRTA then
                                   H6110_states<=StErrorHandlingValidCMD; 
                                   IdleSTAT <= '0'; 
                                   RcvaSTAT <= SActA;
                                   RcvbSTAT <= SActB; 
                                    
                                else
                                   H6110_states<=StBusActivity;
                                   IdleSTAT <= '1'; 
                                   RcvaSTAT <= '0';
                                   RcvbSTAT <= '0';
                                
                                end if;
                            else
                                H6110_states<=StErrorHandlingValidCMD;
                                IdleSTAT <= '0'; 
                                RcvaSTAT <= SActA;
                                RcvbSTAT <= SActB; 
                               
                            end if;
                       
                    when StErrorHandlingValidCMD =>
                          if SERR > x"0000" then
                              H6110_states<=StBusActivity;
                              SErrorTimerFlag <= '1';  
                          else
                              H6110_states<=StProcessCmd;
                              SErrorTimerFlag <= '0'; 
                          end if;

                          if SERR(1)='1' then
                              SCOMMWORD <= SCOMMWORD; 
                          else 
                              SCOMMWORD <= SCMD;  
                          end if;       
                        


                    when StProcessCmd =>
                          if SCOMMWORD(10)='0' then
                              RF0STAT <= SActA;
                              RF1STAT <= SActB;
                              H6110_states <= StProcessData;  
                          else
                              RF0STAT <= '0';
                              RF1STAT <= '0';
                              H6110_states <= StTransmitData;  
                          end if;
                            
                          
                    
                
     
                    when StProcessData=>
                              
                          if SERR(5 downto 0) = "000000" then
                              if SCOMMWORD(15 downto 11)<"11111" and SCOMMWORD(15 downto 11)>"00000" then
                                  SRXFIFO <=  PIODATAWORD;
                                  
                                    H6110_states <= StBusActivity;
                                  
                                  if SActA='1' and SActB='0' then
                                     SBUSAWORD <= PIODATAWORD(SDATAWORDLEN);
                                  elsif SActB='1' and SActA='0' then
                                     SBUSBWORD <= PIODATAWORD(SDATAWORDLEN);
                                  else
                                     SRXMODEDATAWORD <= SRXMODEDATAWORD;
                                  end if;
                                    
                              else
                                  
                                  SRXMODEDATAWORD <= PIODATAWORD(SDATAWORDLEN);  
                                
                              end if;
                              ValmessSTAT <= '1';  
                          else
                             H6110_states <= StBusActivity; 
                             ValmessSTAT <= '0';
                          end if;

                
                     when StTransmitData=>
                        
            end if;
end process;




process
error_irq_handling:process(SCLK, SReset)
                        begin
                            if SReset='1' then
                                SERR <= x"0000";        
                                SError <= '0';
                                SErrorCounter <= 0;
                                error_states <= StIdle;

                            elsif rising_edge(SCLK) then
                                SPrevErrorTimerFlag <= SErrorTimerFlag;
                                    case error_states is
                                        
                                        when StIdle =>
                                                error_states <= StWaitErrorTimerFlag;

                                        when StWaitErrorTimerFlag =>
                                            if SPrevErrorTimerFlag='0' and SErrorTimerFlag='1' then
                                                 error_states <= StErrorCount;
                                            else 
                                                 error_states <= StIdle;
                                            end if;

                                        when StErrorCount =>
                                            if SCTRL(6)='1' then
                                                if SErrorCounter < 199 then
                                                    ErrorSTAT <= '1';
                                                    SErrorCounter <= SErrorCounter + 1;
                                                    error_states <= StErrorCount;
                                                else
                                                    ErrorSTAT <= '0';
                                                    SErrorCounter <= 0;
                                                    error_states <= StWaitErrorTimerFlag;
                                                end if;
                                            else
                                                ErrorSTAT <= '1';
                                                SErrorCounter <= 0;
                                                error_states <= StWaitErrorTimerFlag;
                                            end if;

                                        end case;
                          end process;

process(SCLK, SReset, SRegAccess, SRegAddr, SRiseSTR)
    begin
        if SReset='1' then
            PIOWORD         <= (others=>'Z');
            SPrevSTR        <= '0';
            SCTRL           <= x"0000";
            STXFIFO         <= (others=>x"0000");
            STXSTATWORD     <= x"0000";
            STXMODEDATAWORD <= x"0000";

        elsif rising_edge(SCLK) then
            case SRegAccess is
                SPrevSTR <= SSTR;
                when "000" =>
                        PIOWORD <= (OTHERS=>'Z');
                        

                when "001" =>
                    if SSTR='1' and SPrevSTR='0' then
                        if SRegAddr(2 downto 0)="000" then
                            STXSTATWORD <= PIOWORD;
                         
                        elsif SRegAddr(2 downto 0)="001" then
                            STXMODEDATAWORD <= PIOWORD;
                           
                        elsif SRegAddr(2 downto 0)="010" then
                            STXFIFO <= (others=>x"0000");
                           
                        elsif SRegAddr(2 downto 0)="011" then
                            STXFIFO<= (others=>PIOWORD);
                          
                        elsif SRegAddr(2)='1' then
                            SCTRL <= PIOWORD;
                           
                        else
                            PIOWORD <= PIOWORD;
                        end if;
                       
                    else
                            PIOWORD <= PIOWORD;
                    end if;     
                    
                    when "010" =>
                        if SRegAddr="0000" then
                            PIOWORD <= SCOMMWORD;
                        elsif SRegAddr="0010" then
                            PIOWORD <= SRXMODEDATAWORD;
                        elsif SRegAddr="0100" then
                            PIOWORD <= SRXFIFO(0);
                        elsif SRegAddr="0101" then
                            PIOWORD <= SSTAT;
                        elsif SRegAddr="0110" then
                            PIOWORD <= SMSG;
                        elsif SRegAddr="0111" then
                            PIOWORD <= SERR;
                        elsif SRegAddr="1100" then
                            PIOWORD <= SCTRL;
                        elsif SRegAddr="1001" then
                            PIOWORD <= SBUSAWORD;
                        elsif SRegAddr="1010" then
                            PIOWORD <= SBUSBWORD;
                        else
                            PIOWORD <= (others =>'Z');
                        end if; 
                    
                       
                        
                        when others =>
                            PIOWORD <= (OTHERS=>'Z');
                           
                         
                       
                        end case;
          end if;           
end process;



end architecture_HI6110;
