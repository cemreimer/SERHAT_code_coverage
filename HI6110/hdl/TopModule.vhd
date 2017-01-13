----------------------------------------------------------------------------------
-- Company: PAVO 
-- Engineer: Sinan Ali TOK 
-- 
-- Create Date:    16:02:34 01/18/2015 
-- Design Name:       Motor Control
-- Module Name:    TopModule - Behavioral 
-- Project Name:      SERHAT 
-- Target Devices: ACTEL IGLOO2
-- Tool versions:  Libero 11.4 
-- Description:       TopModule of SERHAT Project
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

use work.types.all;
use work.vhdl_bl4cl2_parameters_0.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopModule is
    Port (       PIClk          : in STD_LOGIC;--!50Mhz Clk Input
                 PIReset        : in  STD_LOGIC;--!Hardware Reset Input

--------------  1553 Module 1 --------------------
                 POBCSTART      : Out   STD_LOGIC;
                 POCS           : Out   STD_LOGIC;
                 PIODATABUS     : InOut STD_LOGIC_VECTOR(15 DOWNTO 0);
                 POMR           : Out   STD_LOGIC;
                 POREG_ADDR     : Out   STD_LOGIC_VECTOR(3 DOWNTO 0);
                 PORW           : Out   STD_LOGIC;
                 POSTR          : Out   STD_LOGIC;
                 PIVHD_ERROR    : In    STD_LOGIC;
                 PIVHD_FFEMPTY  : In    STD_LOGIC;
                 PIVHD_RCVA     : In    STD_LOGIC;
                 PIVHD_RCVB     : In    STD_LOGIC;
                 PIVHD_RCVCMDA  : In    STD_LOGIC;
                 PIVHD_RCVCMDB  : In    STD_LOGIC;
                 PIVHD_RFLAG    : In    STD_LOGIC;
                 PIVHD_VALMESS  : In    STD_LOGIC; 
                 POM1553B_RTA   : out std_logic_vector(4 downto 0);
                 POM1553B_RTAP  : out STD_LOGIC;
--------------  1553 Module 1 --------------------


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
       POClk10Mhz           : out STD_LOGIC; ---8.3 MHz(50/6)    
       POClk1hz             : out STD_LOGIC      
      );
end component;
---------- Clk Divider Module --------------    

 
---------- 1553 Module --------------   
component TopMod_1553Controller
    port (  PIODataBus          : inout std_logic_vector(15 downto 0);
          PORegAddr             : out std_logic_vector(3 downto 0);
          POSTR                 : out std_logic;
          POCS                  : out std_logic;
          PORW                  : out std_logic;
          POBCStart             : out std_logic;
          POMR                  : out std_logic;
          PIError               : in std_logic;
          PIValMess             : in std_logic;
          PIRFlag               : in std_logic;
          PIRCVA                : in std_logic;
          PIRCVB                : in std_logic;
          PIFFEmpty             : in std_logic;
          RCVCMDA               : in std_logic;
          RCVCMDB               : in std_logic;             
          PORxDpData            : out std_logic_vector(15 downto 0);
          PORxDpAddr            : out std_logic_vector(5 downto 0); -- özgür may 07.12.2010 32 word rcv data
          POTxDpAddr            : out std_logic_vector(5 downto 0); -- özgür may 07.12.2010 32 word rcv data
          PITxDpData            : in std_logic_vector(15 downto 0);
          POWrEna               : out std_logic_vector(0 downto 0);
          PORxReady1553         : out std_logic;
          process_ok            : in std_logic;
          PIBusyInOth           : in std_logic;
          PIConfigValueReady    : in std_logic;
          config_value_ok       : in std_logic;
          PIClrErrFlg           : in  std_logic;
          PORcvCmd              : out std_logic;
          POErrorReg            : out std_logic_vector(7 downto 0);
          POPBitErrorReg        : out std_logic_vector(7 downto 0);
          PIClk50MHz            : in std_logic
            );
end component;

---------- 1553 Module --------------   
    component receive_cmd
        port (  PIClk       : IN std_logic;
                PIWE        : IN std_logic;
                PIWrAddr    : IN std_logic_VECTOR(5 downto 0); 
                PIWrData    : IN std_logic_VECTOR(15 downto 0);
                PIRdAddr    : IN std_logic_VECTOR(5 downto 0);          
                PORdData    : OUT std_logic_VECTOR(15 downto 0)
          );
    end component;


 


               


signal SClearError                                                    : STD_LOGIC_VECTOR(1 downto 0) := "00"; 



signal SClk12_5Mhz              : STD_LOGIC:= '0';
signal SClk2_5Mhz               : STD_LOGIC:= '0';
signal SClk500Khz               : STD_LOGIC:= '0';
signal SClk1Mhz                 : STD_LOGIC:= '0';
signal SClk10Mhz                : STD_LOGIC:= '0';
signal SClk1hz                  : STD_LOGIC:= '0';
signal SCommand                                                       : byte_vector(1 downto 0):= (others => x"00");






signal  SModulesEn              : STD_LOGIC:= '0';
signal  SClrErrFlg              : STD_LOGIC:= '0';
signal  SProcessOk              : STD_LOGIC:= '0';
signal  SRxReady1553            : STD_LOGIC:= '0';
signal  SConfigValueOk          : STD_LOGIC:= '0';
signal  SConfigValueReady       : STD_LOGIC:= '0';

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
            PIRFlag                 => PIVHD_RFLAG,    
            PIRCVA                  => PIVHD_RCVA,    
            PIRCVB                  => PIVHD_RCVB,    
            PIFFEmpty               => PIVHD_FFEMPTY,    
            RCVCMDA                 => PIVHD_RCVCMDA,    
            RCVCMDB                 => PIVHD_RCVCMDB,    
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
            PIClrErrFlg             => SClearError(0), --------------------
            PORcvCmd                => rcv_cmd_1553_1,
            POErrorReg              => cbit_1553_1_result,
            POPBitErrorReg          => pbit_1553_1_result,
            PIClk50MHz              => SClk
            );

--------- 1553 module 1 -----------
LReceiveRam1553Ch1 : receive_cmd
   port map ( PIClk      => SClk, 
              PIWE       => s_wea(0), 
              PIWrAddr   => s_addr_dp(5 downto 0),  
              PIWrData   => s_dpram_buff, 
              PIRdAddr   => SReceiveRamAddrCh1(5 downto 0), 
              PORdData   => SReceiveRamDataCh1 
            );  
---------- Uart Module --------------   
LTransmitRam1553Ch1 : receive_cmd
   port map ( PIClk       => SClk,
              PIWE        => STransmitRamWECh1,
              PIWrAddr    => STransmitRamAddrCh1(5 downto 0),
              PIWrData    => STransmitRamDataCh1,
              PIRdAddr    => s_addr_dp_tx(5 downto 0),
              PORdData    => s_dpram_buff_tx        
            );



    
---------- Clk Divider Module --------------    
LClkDividerModule: MClkDivider
  Port Map (  PIClk         =>  SClk,    
              PIReset       =>  SReset,
              POClk12_5Mhz  =>  SClk12_5Mhz,
              POClk2_5Mhz   =>  SClk2_5Mhz,
              POClk500Khz   =>  SClk500Khz,
              POClk1Mhz     =>  SClk1Mhz,
              POClk10Mhz    =>  SClk10Mhz, ---8.3 MHz(50/6)
              POClk1hz      =>  SClk1hz
            );
















end Behavioral;
