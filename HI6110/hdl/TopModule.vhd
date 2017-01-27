----------------------------------------------------------------------------------
-- Company: PAVO 
-- Engineer: Cemre Imer
-- 
-- Create Date:    16:02:34 01/18/2015 
-- Design Name:       Motor Control
-- Module Name:    TopModule - Behavioral 
-- Project Name:      SERHAT 
-- Target Devices: ACTEL IGLOO2
-- Tool versions:  Libero 11.4 
-- Description:       TopModule of 1553 coverage 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.types.all;

entity TopModule is
    Port (       PIClk          : in STD_LOGIC; 
                 PIReset        : in  STD_LOGIC;
                 PIClk_HI6110   : in STD_LOGIC;   
                 PIERR          : in std_logic_vector(8 DOWNTO 0);
                 PIRTA          : in std_logic_vector(4 DOWNTO 0);
                 PIRTAP         : in std_logic;
                 PICMD          : in std_logic_vector(15 DOWNTO 0);    
                 PIODATAWORD    : inout word_vector(31 downto 0);
                 PIBUSA         : in std_logic;
                 PIBUSB         : in std_logic
                 
              );
end TopModule;

architecture Behavioral of TopModule is


---------- Clk Divider Module --------------    
component MClkDivider
 Port( PIClk                : in  STD_LOGIC;  
       PIReset              : in  STD_LOGIC;     
       POClk12_5Mhz         : out STD_LOGIC;     
       POClk2_5Mhz          : out STD_LOGIC;
       POClk500Khz          : out STD_LOGIC;
       POClk1Mhz            : out STD_LOGIC; 
       POClk10Mhz           : out STD_LOGIC;   
       POClk1hz             : out STD_LOGIC      
      );
end component;
  

 
---------- 1553 Module --------------   
component TopMod_1553Controller
    port (  
          PIODataBus	        : inout std_logic_vector(15 downto 0);
          PORegAddr             : out std_logic_vector(3 downto 0);
          POSTR		            : out std_logic;
          POCS			        : out std_logic;
          PORW			        : out std_logic;
          POBCStart             : out std_logic;
          POMR		            : out std_logic;
          PIError	            : in std_logic;
          PIValMess             : in std_logic;
          PIRCVA		        : in std_logic;
          PIRCVB		        : in std_logic;
          PORxDpData	        : out std_logic_vector(15 downto 0);
          PORxDpAddr	        : out std_logic_vector(5 downto 0);
          POTxDpAddr	        : out std_logic_vector(5 downto 0); 
          PITxDpData	        : in std_logic_vector(15 downto 0);
          POWrEna		        : out std_logic_vector(0 downto 0);
          PORxReady1553		    : out std_logic;
          process_ok			: in std_logic;
          PIBusyInOth		    : in std_logic;
          PIConfigValueReady    : in std_logic;
          config_value_ok       : in std_logic;
          PIClrErrFlg		    : in  std_logic;
          PORcvCmd				: out std_logic;
          POErrorReg		    : out std_logic_vector(7 downto 0);
          POPBitErrorReg		: out std_logic_vector(7 downto 0);
          PIClk50MHz 		    : in std_logic
            );
end component;

----- TXRX word RAM---
component receive_cmd
    port (  PIClk       : IN std_logic;
            PIWE        : IN std_logic;
            PIWrAddr    : IN std_logic_VECTOR(5 downto 0); 
            PIWrData    : IN std_logic_VECTOR(15 downto 0);
            PIRdAddr    : IN std_logic_VECTOR(5 downto 0);          
            PORdData    : OUT std_logic_VECTOR(15 downto 0)
      );
end component;

------------------HI6110 mimic IC--------------
component HI6110 
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
   PIBUSA     : in std_logic;
   PIBUSB     : in std_logic;     
   PIODATAWORD: inout word_vector(31 downto 0);
   PICMD      : in std_logic_vector(15 downto 0); 
   PORCVA     : out std_logic;
   PORCVB     : out std_logic; 
   PIRTA      : in std_logic_vector(4 DOWNTO 0);
   PIRTAP     : in std_logic;
   PIERR      : in std_logic_vector(8 DOWNTO 0)   
);
end component;
 

signal SClearError              : STD_LOGIC_VECTOR(1 downto 0) := "00"; 
signal SModulesEn               : STD_LOGIC:= '0';
signal SClrErrFlg               : STD_LOGIC:= '0';
signal SProcessOk               : STD_LOGIC:= '0';
signal SRxReady1553             : STD_LOGIC:= '0';
signal SConfigValueOk           : STD_LOGIC:= '0';
signal SConfigValueReady        : STD_LOGIC:= '0';
signal STransmitRamWECh1        : std_logic;
signal STransmitRamDataCh1      : std_logic_VECTOR(15 downto 0);
signal STransmitRamAddrCh1      : std_logic_VECTOR(5 downto 0);
signal SReceiveRamAddrCh1       : std_logic_VECTOR(5 downto 0); 
signal SReceiveRamDataCh1       : std_logic_VECTOR(15 downto 0);
signal s_addr_dp_tx             : STD_LOGIC_VECTOR(5 downto 0);
signal s_addr_dp                : STD_LOGIC_VECTOR(5 downto 0);
signal s_wea                    : STD_LOGIC_VECTOR(0 downto 0);
signal s_dpram_buff             : STD_LOGIC_VECTOR(15 downto 0);
signal rx_ready_1553_1          : std_logic;
signal SProcessOK1553Ch1        : std_logic;
signal s_dpram_buff_tx          : STD_LOGIC_VECTOR(15 downto 0);
signal S1553Ch1WdError          : STD_LOGIC := '0';
signal rcv_cmd_1553_1           : std_logic;
signal cbit_1553_1_result       : std_logic_VECTOR(7 downto 0);
signal pbit_1553_1_result       : std_logic_VECTOR(7 downto 0);



--------------  1553 Module 1 --------------------
signal POBCSTART      : STD_LOGIC;
signal POCS           : STD_LOGIC;
signal PIODATABUS     : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal POMR           : STD_LOGIC;
signal POREG_ADDR     : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal PORW           : STD_LOGIC;
signal POSTR          : STD_LOGIC;
signal PIVHD_ERROR    : STD_LOGIC;
signal PIVHD_FFEMPTY  : STD_LOGIC;
signal PIVHD_RCVA     : STD_LOGIC;
signal PIVHD_RCVB     : STD_LOGIC;
signal PIVHD_RCVCMDA  : STD_LOGIC;
signal PIVHD_RCVCMDB  : STD_LOGIC;
signal PIVHD_RFLAG    : STD_LOGIC;
signal PIVHD_VALMESS  : STD_LOGIC; 
signal POM1553B_RTA   : std_logic_vector(4 downto 0);
signal POM1553B_RTAP  : STD_LOGIC;
--------------  1553 Module 1 --------------------

begin

--------- 1553 module 1 -----------
LMTop1553Ch1: TopMod_1553Controller 
  PORT MAP( PIODataBus              => PIODATABUS,       
            PORegAddr               => POREG_ADDR,    
            POSTR                   => POSTR,    
            POCS                    => POCS,    
            PORW                    => PORW,    
            POBCStart               => POBCSTART,    
            POMR                    => POMR,    
            PIError                 => PIVHD_ERROR,    
            PIValMess               => PIVHD_VALMESS,    
            PIRCVA                  => PIVHD_RCVA,    
            PIRCVB                  => PIVHD_RCVB,    
            PORxDpData              => s_dpram_buff,    
            PORxDpAddr              => s_addr_dp(5 downto 0),       
            POTxDpAddr              => s_addr_dp_tx(5 downto 0),    
            PITxDpData              => s_dpram_buff_tx,    
            POWrEna                 => s_wea,    
            PORxReady1553           => SRxReady1553,   
            process_ok              => SProcessOk,
            PIBusyInOth             => '0',
            PIConfigValueReady      => SConfigValueReady,
            config_value_ok         => SConfigValueOk,
            PIClrErrFlg             => SClearError(0), 
            PORcvCmd                => rcv_cmd_1553_1,
            POErrorReg              => cbit_1553_1_result,
            POPBitErrorReg          => pbit_1553_1_result,
            PIClk50MHz              => PICLK
            );

------------------HI6110 mimic IC--------------
IC_HI6110: HI6110 
port map(
   PISTR       =>  POSTR,
   PIRW        =>  PORW,
   PICS        =>  POCS,
   PIOWORD     =>  PIODATABUS,
   PIRegAddr   =>  POREG_ADDR,
   PICLK       =>  PIClk_HI6110,
   PIBCSTART   =>  POBCSTART, 
   PIMR        =>  POMR,  
   POERROR     =>  PIVHD_ERROR,
   POVALMESS   =>  PIVHD_VALMESS,
   PIBUSA      =>  PIBUSA, 
   PIBUSB      =>  PIBUSB,   
   PIODATAWORD =>  PIODATAWORD, 
   PICMD       =>  PICMD,  
   PORCVA      =>  PIVHD_RCVA,
   PORCVB      =>  PIVHD_RCVB,
   PIRTA       =>  PIRTA, 
   PIRTAP      =>  PIRTAP, 
   PIERR       =>  PIERR 
);


--------- 1553 received words -----------
LReceiveRam1553Ch1 : receive_cmd
   port map ( PIClk      => PICLK, 
              PIWE       => s_wea(0), 
              PIWrAddr   => s_addr_dp(5 downto 0),  
              PIWrData   => s_dpram_buff, 
              PIRdAddr   => SReceiveRamAddrCh1(5 downto 0), 
              PORdData   => SReceiveRamDataCh1 
            );  


----------1553 transmitted words  --------------   
LTransmitRam1553Ch1 : receive_cmd
   port map ( PIClk       => PICLK,
              PIWE        => STransmitRamWECh1,
              PIWrAddr    => STransmitRamAddrCh1(5 downto 0),
              PIWrData    => STransmitRamDataCh1,
              PIRdAddr    => s_addr_dp_tx(5 downto 0),
              PORdData    => s_dpram_buff_tx        
            );



end Behavioral;
