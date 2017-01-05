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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all

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
   PICLK      : in std_logic;
   PIBCSTART  : in std_logic;
   PIMR       : in std_logic;
   POERROR    : out std_logic;
   POVALMESS  : out std_logic;
   POFFEMPTY  : out std_logic;
   PORFLAG    : out std_logic;
   PIBUSA     : in std_logic;
   PIBUSB     : in std_logic;     
   PIODATAWORD: inout word_vector(31 downto 0);
   PICMD      : in std_logic_vector(15 downto 0);
   PORCVA     : out std_logic;
   PORCVB     : out std_logic; 
   PIRTA      : in std_logic;
   PIRTAP     : in std_logic
);
end HI6110;

architecture architecture_HI6110 of HI6110 is

----HI6110 Message and Register Buffering States----
type states is (StIdle, StCSWait, StValidCmd, ) 
signal H6110_states: states;

----From FPGA to HI6110 ports----
signal SMR, SRTA, SRTAP, SBCSTART : std_logic; 

----From HI6110 to FPGA IRQs----
signal SRCVA, SRCVB, SError, SVALMESS, SFFEMPTY, SRFLAG: std_logic; 

----RT Physical Address Parity Check Signal----
signal SPrtyCheck: std_logic;

----Bus Activity Detectors---
signal SRcvFlags: std_logic_vector(1 downto 0);
signal SBUSA, SBUSB: std_logic;

----Data FIFOs----
signal STXFIFO  : word_vector(31 downto 0);
signal SRXFIFO  : word_vector(31 downto 0);

----Register Access Signals----
signal SCS, SSTR, SRW: std_logic;  
signal SRegAccess: std_logic_vector(2 downto 0);
signal SRiseSTR: std_logic;

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
begin

----I/O to Internal Register Buffering----
SSTR      <= PISTR;     
SRW       <= PIRW;     
SCS       <= PICS; 
SRegAccess <= SCS & SRW & SSTR;
SRegAddr  <= PIRegAddr;
SCLK      <= PICLK;
SReset    <= PIMR;    
SBCSTART  <= PIBCSTART; 
POERROR   <= SError;
POVALMESS <= SVALMESS;
POFFEMPTY <= SFFEMPTY;
PORFLAG   <= SRFLAG;  
SCMD     <= PICMD;
PORCVA    <= SRCVA;
PORCVB    <= SRCVB;
SRTA      <= PIRTA;  
SRTAP     <= PIRTAP;    
SRcvFlags <= SBUSB & SBUSA;
SBUSA     <= PIBUSA;
SBUSB     <= PIBUSB;  
SPrtyCheck<= SRTA(4) xnor SRTA(3) xnor SRTA(2) xor SRTA(1) xnor SRTA(0);



    process(PICLK, PIMR, PIRTA, PIRTAP, PIRW, PIRA, PIBCSTART)
        begin
            if PIMR='1' then
                H6110_states <= StIdle;
                SSTAT     <= x"0000";
                SCTRL     <= x"0000";
                SERR      <= x"0000";
                SRXFIFO      <= (others=>x"0000");
                SRCVA        <= '0';
                SRCVB        <= '0';

            elsif rising_edge(PICLK) then
               

                case H6110_states is
                    when StIdle=>
                        if SPrtyCheck=SRTAP then
                           SERR(9) <= '0';
                           H6110_states <= StIdle;----degistir 
                        else
                           SERR(9) <= '1';
                           H6110_states <= StIdle; 
                        end if;

                    
                    when StProcessCmd=>
                        if PICMD(0)(15 downto 11)<"11111" and PICMD(0)(15 downto 11)=SRTA then
                            if PICMD(0)(9 downto 5)>"00000" and PICMD(0)(9 downto 5)<"11111" then
                                if PICMD(0)(10)='0' then
                                    H6110_states<=StSubAddr;
                                else
                                    H6110_states<=StStatusSet;
                                end if;
                            else
                                H6110_states<=StModeCode;
                            end if;
                        else
                            H6110_states<=StBroadcast;
                        end if;
                        

                    when StBroadcast=>
                            
                    when StModeCode=>

                    when StSubAddr=>
                           case SRcvFlags is
                                when "10" =>
                                    SRCVB<='1';
                                    SRCVA<='0';
                                    SCOMMWORD <= PICMD;
                                when "01" =>
                                    SRCVA<='1';
                                    SRCVB<='0';  
                                    SCOMMWORD <= PICMD;
                                when others =>
                                    SRCVA<='0';
                                    SRCVB<='0';
                                    SCOMMWORD <= SCOMMWORD;
                            end case;   
                            H6110_states<=StRcvData;

                    when StRcvData=>
                           SRXFIFO      <= PIODATAWORD;
                           H6110_states <= StStatusSet;
                            
                       
                            
                    when StStatusSet=>

process(SRegAccess, SRegAddr, SRiseSTR)
    begin
        if PIMR='1' then
            PIOWORD         <= (others=>'Z');
            SRiseSTR        <= '0';  
            SCTRL           <= x"0000";
            STXFIFO         <= (others=>x"0000");
            STXSTATWORD     <= x"0000";
            STXMODEDATAWORD <= x"0000";
        else    
            case SRegAccess is

                when "000" =>
                        PIOWORD <= (OTHERS=>'Z');
                        SRiseSTR<='1';
                        STXSTATWORD <= STXSTATWORD;
                        STXMODEDATAWORD <= STXMODEDATAWORD;  
                        STXFIFO <= STXFIFO;
                        SCTRL <= SCTRL; 

                when "001" =>
                    if SRiseSTR='1' then
                        if SRegAddr(2 downto 0)="000" then
                            STXSTATWORD <= PIOWORD;
                            STXMODEDATAWORD <= STXMODEDATAWORD;  
                            STXFIFO <= STXFIFO;
                            SCTRL <= SCTRL; 
                        elsif SRegAddr(2 downto 0)="001" then
                            STXMODEDATAWORD <= PIOWORD;
                            STXSTATWORD <= STXSTATWORD;
                            STXFIFO <= STXFIFO;
                            SCTRL <= SCTRL; 
                        elsif SRegAddr(2 downto 0)="010" then
                            STXFIFO <= (others=>x"0000");
                            STXSTATWORD <= STXSTATWORD;
                            STXMODEDATAWORD <= STXMODEDATAWORD;  
                            SCTRL <= SCTRL;  
                        elsif SRegAddr(2 downto 0)="011" then
                            STXFIFO<= (others=>PIOWORD);
                            STXSTATWORD <= STXSTATWORD;
                            STXMODEDATAWORD <= STXMODEDATAWORD;  
                            SCTRL <= SCTRL;  
                        elsif SRegAddr(2)='1' then
                            SCTRL <= PIOWORD;
                            STXSTATWORD <= STXSTATWORD;
                            STXMODEDATAWORD <= STXMODEDATAWORD;  
                            STXFIFO <= STXFIFO;
                        else
                            STXSTATWORD <= STXSTATWORD;
                            STXMODEDATAWORD <= STXMODEDATAWORD;  
                            STXFIFO <= STXFIFO;
                            SCTRL <= SCTRL;  
                        end if;
                        SRiseSTR <= '0';
                        PIOWORD <= PIOWORD;
                    else
                        STXSTATWORD <= STXSTATWORD;
                        STXMODEDATAWORD <= STXMODEDATAWORD;  
                        STXFIFO <= STXFIFO;
                        SCTRL <= SCTRL;   
                        SRiseSTR <= '0';
                    end if;     
                    
                    when "010" =>
                        if SRegAddr="0000" then
                            PIOWORD <= SCOMMWORD;
                        elsif SRegAddr="0010" then
                            PIOWORD <= SRXMODEDATAWORD;
                        elsif SRegAddr="0100" then
                            PIOWORD <= SRXFIFO;
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
                        STXSTATWORD <= STXSTATWORD;
                        STXMODEDATAWORD <= STXMODEDATAWORD;  
                        STXFIFO <= STXFIFO;
                        SCTRL <= SCTRL;
                        SRiseSTR <= '0';
                        
                        when others =>
                            PIOWORD <= (OTHERS=>'Z');
                            SRiseSTR<='0';
                            STXSTATWORD <= STXSTATWORD;
                            STXMODEDATAWORD <= STXMODEDATAWORD;  
                            STXFIFO <= STXFIFO;
                            SCTRL <= SCTRL; 
                       
                        end case;
          end if;           
end process;



end architecture_HI6110;
