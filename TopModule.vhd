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
                --PIReset           : in  STD_LOGIC;--!Hardware Reset Input
                 POLED          : out STD_LOGIC;
--------------  FRAM SPI Ports   --------------------
        --      POFramMosi      : out STD_LOGIC;--!Fram MOSI
        --      PIFramMiso      : in  STD_LOGIC;--!Fram Miso
        --      POFramSck       : out STD_LOGIC;--!Fram Sck
        --      POFramCs        : out STD_LOGIC;--!Fram Cs
--------------  FRAM SPI Ports   --------------------
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
--------------  UART Ports               ---------------------
                POUartTxd       : out STD_LOGIC_vector(1 downto 0);--!Uart Data Send
                PIUartRxd       : in  STD_LOGIC_vector(1 downto 0);--!Uart Data Receive
                POUartTxdEn     : out STD_LOGIC_vector(1 downto 0);--!Uart Data Send Enable
                POUartRxdEn     : out STD_LOGIC_vector(1 downto 0);--!Uart Data Receive Enable
               -- POUartTxdEn1    : out STD_LOGIC;--!Uart Data Send Enable
                --POUartTxdEn2    : out STD_LOGIC;--!Uart Data Receive Enable
              --  POUartChEnable  : out STD_LOGIC;
--------------  UART Ports               ---------------------                  
--------------  Temprature Sensor SPI Ports             ---------------------
                POTmpSck        : out STD_LOGIC_vector(1 downto 0);--!Clock
                POTmpCs         : out STD_LOGIC_vector(1 downto 0);--!Chip Select
                POTmpMosi       : out STD_LOGIC_vector(1 downto 0);--!Master Out Slave In
                PITmpMiso       : in  STD_LOGIC_vector(1 downto 0);--!Master In Slave Out
--------------  Temprature Sensor SPI Ports             --------------------
--------------  CurrentIn&VoltageIn&CurrentOut&VoltageOut SPI Ports   --------------------
                POAdcConv      : out STD_LOGIC_vector(5 downto 0);  --!Converstion      --!(0):CurrentIn;(1):VoltageIn;(2):CurrentOut;(3):VoltageOut
                PIAdcSdo       : in  STD_LOGIC_vector(5 downto 0);  --!Slve Data Out    --!(0):CurrentIn;(1):VoltageIn;(2):CurrentOut;(3):VoltageOut
                POAdcSck       : out STD_LOGIC_vector(5 downto 0);  --!Clock                --!(0):CurrentIn;(1):VoltageIn;(2):CurrentOut;(3):VoltageOut  
--------------  CurrentIn&VoltageIn&CurrentOut&VoltageOut SPI Ports   --------------------      
--------------  ETM Ports              --------------------
                PIEtmSdo       : in  STD_LOGIC;--!Slve Data Out 
    --          POEtmSck       : out STD_LOGIC;--!Clock             
--------------  ETM Ports              --------------------     
--------------  Hall Effect Ports   --------------------
                PIHallEffectA  : in  STD_LOGIC; 
                PIHallEffectB  : in  STD_LOGIC; 
                PIHallEffectC  : in  STD_LOGIC; 
--------------  Hall Effect Ports   --------------------
--------------  NVM Ports   --------------------
                PILogMISO      : in  STD_LOGIC_VECTOR(1 downto 0);     
                POLogMOSI      : out STD_LOGIC_VECTOR(1 downto 0);   
                POLogCS        : out STD_LOGIC_VECTOR(1 downto 0);   
                POLogSCK       : out STD_LOGIC_VECTOR(1 downto 0);
    --          POFlashReset   : out STD_LOGIC;
--------------  NVM Ports   --------------------
--------------  Mosfet Driver Ports --------------------
                POHighSideA      : out  STD_LOGIC;
                POLowSideA       : out  STD_LOGIC;
                POHighSideB      : out  STD_LOGIC;
                POLowSideB       : out  STD_LOGIC;
                POHighSideC      : out  STD_LOGIC;
                POLowSideC       : out  STD_LOGIC;
--------------  Mosfet Driver Ports -------------------- 
--------------  PGBE  Ports -------------------- 
                POPgbeSck      : out  STD_LOGIC;
                POPgbeCs       : out  STD_LOGIC;
                POPgbeWR       : out  STD_LOGIC;
                POPgbeOE       : out  STD_LOGIC;
                POPgbeAddress  : out STD_LOGIC_VECTOR(1 downto 0);
                PIOPGBEData    : inout STD_LOGIC_VECTOR(13 downto 0);
                --POSinyal       : out  STD_LOGIC;
--------------  PGBE  Ports -------------------- 
--------------  Physical Address  Port -------------------- 
                PIPhysicalAddress : in  STD_LOGIC_VECTOR(7 downto 0)   
--------------  PGBE  Ports -------------------- 
--Deneme Portlar
                --POClk1Mhz       : out  STD_LOGIC;
                --POHighSideA1       : out  STD_LOGIC;
                --POLowSideA1        : out  STD_LOGIC;
                --POHighSideB1       : out  STD_LOGIC;
                --POLowSideB1        : out  STD_LOGIC;
                --POHighSideC1       : out  STD_LOGIC;
                --POLowSideC1        : out  STD_LOGIC

              );
end TopModule;

architecture Behavioral of TopModule is

---------- Uart Module --------------   
    component MUart
      Port( PIClk               : in  STD_LOGIC;  
            PIReset             : in  STD_LOGIC;
            PIModuleEnable      : in  std_logic;
---------- 'Uart Module <--> Main Process Module' Ports --------------           
            PITxDataReadyInRAM  : in STD_LOGIC;
            POTxDataFromMainOK  : out STD_LOGIC;
            PORxDataReadyInRAM  : out STD_LOGIC;
            PIRxDataToMainOK    : in STD_LOGIC;
---------- 'Uart Module <--> Main Process Module' Ports --------------
---------- CBIT Ports --------------             
            PIClearErrFlag      : in STD_LOGIC;
            POCBitResult        : out std_logic_vector(7 downto 0);
            POCBitResultUpdate  : out STD_LOGIC;  
---------- CBIT Ports --------------    
---------- PBIT Ports --------------    
            POPBitResult        : out std_logic_vector(7 downto 0);
---------- PBIT Ports --------------    
---------- Configuration Ports --------------               
            PICfgEn             : in  STD_LOGIC;  
            PICfgData           : in  STD_LOGIC_VECTOR(15 downto 0);
---------- Configuration Ports --------------                   
---------- Uart Ports --------------            
            POTXD               : out STD_LOGIC;
            PIRXD               : in  STD_LOGIC;
            POTxdEn             : out STD_LOGIC;
            PORxdEn             : out STD_LOGIC;
---------- Uart Ports --------------                
---------- 'Uart Module <--> Main Process Module' Command Ram Ports --------------              
            PORAMWrAddr         : out std_logic_vector(7 downto 0);       
            PORAMWrData         : out std_logic_vector(7 downto 0);
            PORAMWE             : out STD_LOGIC;   
---------- 'Uart Module <--> Main Process Module' Command Ram Ports --------------   
---------- 'Uart Module <--> Main Process Module' Physical Address Port ---------- 
            POPhysicalAddress   : out std_logic_vector(5 downto 0); 
            PISetupMode         : in  STD_LOGIC; 
---------- 'Uart Module <--> Main Process Module' Physical Address Port ----------      
---------- 'Uart Module <--> Main Process Module' Response Ram Ports --------------             
            PORdAddr            : out std_logic_vector(7 downto 0);
            PIRdData            : in std_logic_vector(7 downto 0);
            PORdEnable          : out STD_LOGIC
---------- 'Uart Module <--> Main Process Module' Response Ram Ports --------------             
            );         
    end component;
---------- Uart Module --------------   
---------- utc --------------   
    component UTC
        port (
           utcWR              : in  STD_LOGIC;
           utcCLK             : in  STD_LOGIC;          -- 50 MHz; 20 nsec;
           utcRESET           : in  STD_LOGIC;
           PIClrErrFlg        : in  std_logic;
           utcSecIn           : in  STD_LOGIC_VECTOR (31 downto 0);
           utcMiliSecIn       : in  STD_LOGIC_VECTOR (31 downto 0);
           utcSecOut          : out  STD_LOGIC_VECTOR (31 downto 0);
           utcMiliSecOut      : out  STD_LOGIC_VECTOR (31 downto 0);
           POUTCError         : out std_logic
        );
    end component;
---------- utc --------------
  component MLog
   Port (  PIClk                : in STD_LOGIC;
           PIClk500Khz          : in  STD_LOGIC;
           PIReset              : in  STD_LOGIC;
           PIClk1Hz             : in STD_LOGIC;
           PIModuleEnable       : in STD_LOGIC;
           PIMISO               : in STD_LOGIC;
           POMOSI               : out STD_LOGIC;
           POCS                 : out STD_LOGIC;
           POSCK                : out STD_LOGIC;
           PIBitResults         : in byte_vector(255 downto 0);
           PIUtc                : in  STD_LOGIC_VECTOR (31 downto 0);
           POFlashReset         : out STD_LOGIC;
           PIBaseAddrRead       : in STD_LOGIC_VECTOR (15 downto 0);
           PILogReadMode        : in STD_LOGIC;
           PIReadRequest        : in STD_LOGIC;
           PIEraseRequest       : in STD_LOGIC;
           POConfRamAddr        : out STD_LOGIC_VECTOR (9 downto 0);
           POConfRamData        : out STD_LOGIC_VECTOR (7 downto 0);
           POConfRamWE          : out STD_LOGIC;
           POFrameRead          : out STD_LOGIC;
           POAgeingCounter      : out STD_LOGIC_VECTOR (31 downto 0)
           );
  end component;
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

---------- Main Process Module --------------   
    component MainProcessModule
        Port (PIClk                         : in  STD_LOGIC;
                PIReset                     : in  STD_LOGIC;
                PICfgOk                     : in  STD_LOGIC;
                POSystemEn                  : out STD_LOGIC;
---------- 'Uart Module <--> Main Process Module' Ports --------------
                POTxDataReadyInRAM          : out  STD_LOGIC;
                PITxDataFromMainOK          : in   STD_LOGIC;
                PIRxDataReadyInRAM          : in   STD_LOGIC;
                PORxDataToMainOK            : out  STD_LOGIC;
---------- 'Uart Module <--> Main Process Module' Ports --------------
---------- CBIT Ports --------------
                POClearError                : out STD_LOGIC;  
                POCBitResult                : out STD_LOGIC_VECTOR(7 downto 0);
                POCBitResultUpdate          : out STD_LOGIC;
---------- CBIT Ports --------------    
---------- PBIT Ports --------------    
                POPBitResult                : out STD_LOGIC_VECTOR(7 downto 0); 
---------- PBIT Ports --------------                                        
---------- 'Uart Module <--> Main Process Module' Receive Ram Ports --------------              
                POUartMainRRamEn            : out  STD_LOGIC;
                PIUartMainRRamDataOut       : in   STD_LOGIC_VECTOR (7 downto 0);   
                POUartMainRRamAddrIn        : out  STD_LOGIC_VECTOR (7 downto 0);               
---------- 'Uart Module <--> Main Process Module' Receive Ram Ports --------------
---------- 'Uart Module <--> Main Process Module' Transmit Ram Ports --------------             
                POUartMainTRamEn            : out  STD_LOGIC;
                POUartMainTRamDataIn        : out  STD_LOGIC_VECTOR (7 downto 0);   
                POUartMainTRamAddrIn        : out  STD_LOGIC_VECTOR (7 downto 0);               
---------- 'Uart Module <--> Main Process Module' Transmit Ram Ports -------------- 
---------- Physical Addres Ports -------------- 
                PIPhysicalAddress           : in   STD_LOGIC_VECTOR (7 downto 0);   
                PIReadPhysicalAddress       : in   STD_LOGIC_VECTOR (5 downto 0);   
                PISetupMode                 : in   STD_LOGIC;
                POReceivedData              : out byte_vector(31 downto 0);
                POCommand                   : out STD_LOGIC_VECTOR(7 downto 0);   
                POConfigData 	: out byte_vector(26 downto 0); 
                POMsgType                   : out  STD_LOGIC_VECTOR (1 downto 0);       
---------- Physical Addres Ports -------------- 


---------- 'CBIT Module <--> Main Process Module' Ram Ports --------------              
                POCBitMainRamEn             : out  STD_LOGIC;
                PICBitMainRamDataOut        : in   STD_LOGIC_VECTOR (7 downto 0);   
                POCBitMainRamAddrIn         : out  STD_LOGIC_VECTOR (7 downto 0);               
---------- 'CUart Module <--> Main Process Module' Ram Ports --------------
---------- 'PBIT Module <--> Main Process Module' Ram Ports --------------              
                POPBitMainRamEn             : out  STD_LOGIC;
                PIPBitMainRamDataOut        : in   STD_LOGIC_VECTOR (7 downto 0);   
                POPBitMainRamAddrIn         : out  STD_LOGIC_VECTOR (7 downto 0);               
---------- 'PUart Module <--> Main Process Module' Ram Ports -------------- 
         --   POSDebug: out  STD_LOGIC_VECTOR (7 downto 0); --------------- silinecek
---------- 'Motor Control Module <--> Main Process Module' Ports -------------- 
                POReceiveUTC                : out  byte_vector(7 downto 0) ; 
                PIPositionOk                : in   STD_LOGIC;
                POPositionUpdate            : out  STD_LOGIC;
                POPositionData              : out  STD_LOGIC_VECTOR (15 downto 0)               
---------- 'Motor Control Module <--> Main Process Module' Ports --------------         
            );
    end component;
---------- Main Process Module --------------   

---------- Ram Module --------------    
    component RamModule
        Port (  PIClk           : in  STD_LOGIC;
                PIReset         : in  STD_LOGIC;
---------- PA Ram Ports --------------              
                PIRamPAEn       : in  STD_LOGIC;
                PIRamDataIn     : in  STD_LOGIC_VECTOR (7 downto 0);    
                PIRamPAAddrIn   : in  STD_LOGIC_VECTOR (7 downto 0);                
---------- PA Ram Ports --------------
---------- PB Ram Ports --------------              
                PIRamPBEn       : in  STD_LOGIC;
                PORamDataOut    : out STD_LOGIC_VECTOR (7 downto 0);    
                PIRamPBAddrIn   : in  STD_LOGIC_VECTOR (7 downto 0)             
---------- PB Ram Ports --------------
            );
    end component;
---------- Ram Module --------------    
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
---------- BIT Result Module -------------- 
component BitResultModule
  Port    (     PIClk                       : in  STD_LOGIC;        
                PIReset                     : in  STD_LOGIC;
                PIModuleEn                  : in  STD_LOGIC;
---------- CBIT Ports --------------          
                PIUartCBitResult            : in  STD_LOGIC_VECTOR(7 downto 0);                     
                PIMainCBitResult            : in  STD_LOGIC_VECTOR(7 downto 0);                     
                PIMotorControlCBitResult    : in  STD_LOGIC_VECTOR(15 downto 0);    
                PIUartCBitUpdate            : in STD_LOGIC;
                PIMainCBitUpdate            : in STD_LOGIC;
                PIMotorCBitUpdate           : in STD_LOGIC;
---------- CBIT Ports --------------    
---------- PBIT Ports --------------    
                PIUartPBitResult            : in  STD_LOGIC_VECTOR(7 downto 0);                     
                PIMainPBitResult            : in  STD_LOGIC_VECTOR(7 downto 0);                     
                PIMotorControlPBitResult    : in  STD_LOGIC_VECTOR(15 downto 0);    
---------- PBIT Ports --------------    
---------- 'BIT Module <--> CBIT RAM Module' Ports --------------           
                POBitCBitRamDataIn          : out byte_vector (32 downto 0);            
---------- 'BIT Module <--> CBIT RAM Module' Ports --------------   
---------- 'BIT Module <--> PBIT RAM Module' Ports --------------               
                POBitPBitRamEn              : out  STD_LOGIC;
                POBitPBitRamDataIn          : out  STD_LOGIC_VECTOR (7 downto 0);   
                POBitPBitRamAddrIn          : out  STD_LOGIC_VECTOR (7 downto 0);       
---------- 'BIT Module <--> PBIT RAM Module' Ports --------------       
----------- BIT Module <--> ADC Module Ports --------------------
                PI1553Cbit                  : in  STD_LOGIC_VECTOR(7 downto 0);
                PIPGBEData                  : in  STD_LOGIC_VECTOR(15 downto 0);
                PICIAdcData                 : in  STD_LOGIC_VECTOR(15 downto 0);    
                PIVIAdcData                 : in  STD_LOGIC_VECTOR(15 downto 0);    
                PIVOAdcData                 : in  STD_LOGIC_VECTOR(15 downto 0);    
                PICOAAdcData                : in  STD_LOGIC_VECTOR(15 downto 0);
                PICOBAdcData                : in  STD_LOGIC_VECTOR(15 downto 0);
                PICOCAdcData                : in  STD_LOGIC_VECTOR(15 downto 0);
                PITempData1                 : in  STD_LOGIC_VECTOR(15 downto 0);
                PITempData2                 : in  STD_LOGIC_VECTOR(15 downto 0);
                PIPgbeDataReg               : in word_vector (31 downto 0); 
                PIReceivedData              : in byte_vector (31 downto 0); 
                PISDenemeSinyal             : in  word_vector(3 downto 0);
                PIDurum                     : in  STD_LOGIC_VECTOR(7 downto 0);
--            PIClk12_5Mhz                :in STD_LOGIC;
--            POAdcConv                   :out STD_LOGIC_VECTOR(2 downto 0);
--            PIAdcSdo                    :in  STD_LOGIC_VECTOR(2 downto 0); 
--            POAdcSck                    :out STD_LOGIC_VECTOR(2 downto 0)          
----------- BIT Module <--> ADC Module Ports --------------------      
----------- BIT Module <--> Main Process Module Ports --------------------  
                PISetupMode                 : in   STD_LOGIC;
                PIMsgType                   : in  STD_LOGIC_VECTOR (1 downto 0)   
----------- BIT Module <--> Main Process Module Ports --------------------                 
            );
end component;
---------- BIT Result Module --------------

---------- DRAM Module --------------------
component DRAMModule 
        Port (  PIClk           : in  STD_LOGIC;
                PIReset         : in  STD_LOGIC;
---------- PA Ram Ports --------------  
                PIRamDataIn     : in byte_vector (32 downto 0);             
---------- PA Ram Ports --------------
---------- PB Ram Ports --------------              
                PIRamPBEn       : in  STD_LOGIC;
                PORamDataOut    : out STD_LOGIC_VECTOR (7 downto 0);    
                PIRamPBAddrIn   : in  STD_LOGIC_VECTOR (7 downto 0)             
---------- PB Ram Ports --------------
            );
end component; 
---------- DRAM Module -------------------- 

component process_1553
 Port   ( PIClk                             : in  STD_LOGIC;
              reset                         : in  STD_LOGIC;
              
              receive_cmd_r_dpra            : out STD_LOGIC_VECTOR (5 downto 0);         --1553 komutlar?n?n okundu?u ramin adres giri?i
              receive_cmd_r_dpo             : in  STD_LOGIC_VECTOR (15 downto 0);        --1553 komutlar?n?n okundu?u ramin data ç?k???
              
              transmit_buf_r_a              : out STD_LOGIC_VECTOR (5 downto 0);         --1553 üzerinden UKB ye gönderilecek olan datalar?n tutuldu?u ramin adres giri?i
              transmit_buf_r_d              : out STD_LOGIC_VECTOR (15 downto 0);        --1553 üzerinden UKB ye gönderilecek olan datalar?n tutuldu?u ramin data giri?i
              transmit_buf_r_we             : out STD_LOGIC;                             --1553 üzerinden UKB ye gönderilecek olan datalar?n tutuldu?u ramin write enable giri?i
              
              dram_addr                     : out STD_LOGIC_VECTOR (7 downto 0);         --Distributed Ramlerin Adres giri?i
              dram_dout                     : in  STD_LOGIC_VECTOR (15 downto 0);        --Distributed Ramlerin Data ç?k???
              dram_din                      : out STD_LOGIC_VECTOR (15 downto 0);        --Distributed Ramlerin Data giri?i
              
              modules_en                    : out std_logic;                             --Alt modullerin Enable giri?i
              clr_err_flg                   : out std_logic;                                      
      
              process_ok                    : out STD_LOGIC;                             --1553 komutlar? ile gelen görevin tamamland???n? 1553_Ctrl modulüne belirtir  
              rx_ready_1553                 : in  STD_LOGIC;                             --UKB den 1553 bus üzerinden gelen komut dizinin ilgili ram bölgesine yaz?ld???n? bilgisini verir
              config_value_ok               : in  std_logic;                             --Fram den okuma i?leminin tamamlan?p config datalar?n ilgili ramlere yaz?ld??? bilgisini verir
              config_value_ready            : in  std_logic                              --Fram den okuma i?leminin tamamlan?p config datalar?n ilgili ramlere yaz?ld??? bilgisini verir
         );
end component;          
 
component clkbuf_lvcmos33
port (pad : in std_logic; y : out std_logic);
end component; 


component MTemperature
  Port( 
       PIClk                    : in STD_LOGIC;
       PIReset                  : in  STD_LOGIC;    
       POTempSCK                : out std_logic;
       POTempCS                 : out std_logic;
       POTempMOSI               : out std_logic;
       PITempMISO               : in std_logic;
  --       PIClrErrorFlag       : in std_logic;
       POTempData               : out std_logic_vector(15 downto 0);
       POTempOK                 : out std_logic
  );
end component;


component MADCController
  Port ( PIClk          : in STD_LOGIC;
         PIClk12M5Hz    : in STD_LOGIC;
         PIReset        : in  STD_LOGIC;
         PIADCEnable    : in  STD_LOGIC;
         POCNV          : out std_logic;
         POSCLK         : out std_logic;
         PISData        : in STD_LOGIC;
         POADCDataReady : out std_logic;
         POADCData      : out STD_LOGIC_VECTOR(15 downto 0) 
       );
end component;       


component MPGBEController is
port (   PIClk          : in STD_LOGIC;
         PIReset        : in  STD_LOGIC;
         POPgbeSck      : out  STD_LOGIC;
         POPgbeCs       : out  STD_LOGIC;
         POPgbeWR       : out  STD_LOGIC;
         POPgbeOE       : out  STD_LOGIC;
         POPgbeAddress  : out STD_LOGIC_VECTOR(1 downto 0);
         PIOADCData     : inout STD_LOGIC_VECTOR(13 downto 0);
         POPgbeDataReg  : out word_vector(31 downto 0);
         POPgbeData     : out STD_LOGIC_VECTOR(13 downto 0)
         );
end component; 

component Motor_Controller IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        Shaft_Position                    :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14
        Pos_Demand                        :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14
        ia                                :   IN    std_logic_vector(11 DOWNTO 0);  -- sfix12
        Hall_A                            :   IN    std_logic;
        Hall_B                            :   IN    std_logic;
        Hall_C                            :   IN    std_logic;
        ib                                :   IN    std_logic_vector(11 DOWNTO 0);  -- sfix12
        ic                                :   IN    std_logic_vector(11 DOWNTO 0);  -- sfix12
        ce_out_0                          :   OUT   std_logic;
        ce_out_1                          :   OUT   std_logic;
        I_a_ref                           :   OUT   std_logic_vector(13 DOWNTO 0);  -- sfix14_En
        I_b_ref                           :   OUT   std_logic_vector(13 DOWNTO 0);  -- sfix14_En
        I_c_ref                           :   OUT   std_logic_vector(13 DOWNTO 0);  -- sfix14_En8
        Hin_A                             :   OUT   std_logic;
        Lin_A                             :   OUT   std_logic;
        Hin_B                             :   OUT   std_logic;
        Lin_B                             :   OUT   std_logic;
        Hin_C                             :   OUT   std_logic;
        Lin_C                             :   OUT   std_logic;
        Ara_deger                         :   OUT   std_logic_vector(8 DOWNTO 0);  -- uint8
        posFilted                         :   OUT   std_logic_vector(13 DOWNTO 0);  -- ufix14
        Pfark                             :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En8
        Speed                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En8
        posFilted_ref                     :   OUT   std_logic_vector(13 DOWNTO 0);  -- ufix14
        Motor_durum                       :   OUT   std_logic;
        Hiz                               :   IN    std_logic_vector(8 DOWNTO 0);  -- ufix24
        Direction                         :   IN    std_logic;
        Position_P_virgul                 :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        Position_P_deger                  :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Position_I_virgul                 :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        Position_I_deger                  :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Position_D_virgul                 :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        Position_D_deger                  :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Speed_P_virgul                    :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        Speed_P_deger                     :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Speed_I_virgul                    :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        Speed_I_deger                     :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Speed_D_virgul                    :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
        Speed_D_deger                     :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        Pos_integretor                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En24
        Pos_turev                         :   OUT   std_logic_vector(13 DOWNTO 0);  -- sfix14_En8
        Speed_integretor                  :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En24
        Speed_turev                       :   OUT   std_logic_vector(20 DOWNTO 0);  -- sfix21_En16
        Pos_sature                        :   OUT   std_logic;
        Speed_sature                      :   OUT   std_logic;
        Position_res                      :   IN    std_logic;
        Speed_res                         :   IN    std_logic
        );
END component;

type TStOpMode is (StSetup,StFloat,StNormal);                         
signal SStOpMode :  TStOpMode := StFloat;

type TStDirection is (StIdle,StHallA,StHallB,StHallC);                         
signal StDirection :  TStDirection := StIdle;
signal StPreDirection :  TStDirection := StIdle;

signal SDirection                                                     : STD_LOGIC := '0';  
signal SStHall                                                        : STD_LOGIC_VECTOR(2 downto 0) := "000"; -------deneme 
signal SClk, SReset                                                   : STD_LOGIC := '0';
signal SCommandReady,SCommandReadyOk,SResponseReady,SResponseReadyOk  : STD_LOGIC_VECTOR(1 downto 0) := "00"; 
signal SSystemEn                                                      : STD_LOGIC_VECTOR(1 downto 0) := "00"; 
signal SClearError                                                    : STD_LOGIC_VECTOR(1 downto 0) := "00"; 
signal SUartCBitResult, SUartPBitResult                               : byte_vector (1 downto 0):= (others => x"00"); 
signal SMainCBitResult, SMainPBitResult                               : byte_vector (1 downto 0):= (others => x"00"); 
signal SMotorControlCBitResult,SMotorControlPBitResult                : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal SCfgData                                                       : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal SDenemeSinyal                                                  : word_vector(3 downto 0):= (others => x"0000"); 
--signal SUartTxd,SUartRxd,SUartTxdEn,SUartRxdEn                      : STD_LOGIC := '0';
signal SUartMainRRamPAEn,SUartMainTRamPAEn                            : STD_LOGIC_VECTOR(1 downto 0) := "00";       
signal SUartMainRRamPBEn,SUartMainTRamPBEn                            : STD_LOGIC_VECTOR(1 downto 0) := "00";       
signal SUartMainRRamDataIn,SUartMainTRamDataOut                       : byte_vector (1 downto 0):= (others => x"00"); 
signal SUartMainRRamDataOut,SUartMainTRamDataIn                       : byte_vector (1 downto 0):= (others => x"00"); 
signal SUartMainRRamPAAddrIn,SUartMainTRamPBAddrIn                    : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal SUartMainRRamPBAddrIn,SUartMainTRamPAAddrIn                    : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal SCBitMainRamDataOut                                            : STD_LOGIC_VECTOR(7 downto 0) := x"00";
signal SPBitRamDataIn,SPBitMainRamDataOut                             : STD_LOGIC_VECTOR(7 downto 0) := x"00";
signal SCBitMainRamPBAddrIn                                           : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal SPBitMainRamPBAddrIn                                           : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal SPBitRamPAAddrIn                                               : STD_LOGIC_VECTOR(7 downto 0) := x"00";
signal SCBitMainRamPBEn                                               : STD_LOGIC_VECTOR(1 downto 0) := "00"; 
signal SPBitMainRamPBEn                                               : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal SPBitRamPAEn                                                   : STD_LOGIC := '0';
signal SCfgOk                                                         : STD_LOGIC := '0';
signal SPositionOk                                                    : STD_LOGIC := '0';
signal SPositionUpdate                                                : STD_LOGIC_VECTOR(1 downto 0) := "00"; 
signal SPositionData                                                  : word_vector(1 downto 0):= (others => x"0000");
signal SHallEffectA,SHallEffectB,SHallEffectC                         : STD_LOGIC := '0';
signal SHallEffectAdeb1,SHallEffectAdeb2,SHallEffectAinit             : STD_LOGIC := '0';
signal SHallEffectBdeb1,SHallEffectBdeb2,SHallEffectBinit             : STD_LOGIC := '0';
signal SHallEffectCdeb1,SHallEffectCdeb2,SHallEffectCinit             : STD_LOGIC := '0';
signal SHallEffectAdeb3,SHallEffectAdeb4,SHallEffectBdeb3,SHallEffectBdeb4,SHallEffectCdeb3,SHallEffectCdeb4 : std_logic := '0';
signal SHallEffectCdeb5, SHallEffectBdeb5, SHallEffectAdeb5 : std_logic := '0';  
signal SHighSideA,SLowSideA,SHighSideB,SLowSideB,SHighSideC,SLowSideC : STD_LOGIC := '0';   
signal SUartCBitUpdate,SMainCBitUpdate                                : STD_LOGIC_VECTOR(1 downto 0) := "00"; 
signal SMotorCBitUpdate                                               : STD_LOGIC := '0'; 
signal SCBitRamDataIn           : byte_vector (255 downto 0);
signal SClk12_5Mhz              : STD_LOGIC:= '0';
signal SClk2_5Mhz               : STD_LOGIC:= '0';
signal SClk500Khz               : STD_LOGIC:= '0';
signal SClk1Mhz                 : STD_LOGIC:= '0';
signal SClk10Mhz                : STD_LOGIC:= '0';
signal SClk1hz                  : STD_LOGIC:= '0';
signal SCommand                                                       : byte_vector(1 downto 0):= (others => x"00");
signal SConfigData                                                  : byte_vector(53 downto 0):= (others => x"00");

signal SReadPhysicalAddress     : STD_LOGIC_VECTOR(11 downto 0);

signal SResetWaitCounter        : integer range 0 to 5000000 := 0;
signal SLEDWaitCounter          : integer range 0 to 2500000 := 0;
signal SMosCounter              : integer range 0 to 2500000 := 0;
signal SLED                     : STD_LOGIC:= '0';
signal PIReset                  : STD_LOGIC:= '1';
signal STemperatureOK           : STD_LOGIC_VECTOR(1 downto 0);

signal SADCDataReady            : STD_LOGIC_VECTOR(5 downto 0);
signal SADCData                 : word_vector(5 downto 0);
signal SPgbeDataReg             : word_vector(31 downto 0);
signal SADCData0CurrentIn       : STD_LOGIC_VECTOR(15 downto 0);
signal SADCData3CurrentOutA     : STD_LOGIC_VECTOR(15 downto 0);
signal SADCData4CurrentOutB     : STD_LOGIC_VECTOR(15 downto 0);
signal SADCData5CurrentOutC     : STD_LOGIC_VECTOR(15 downto 0);
signal SADCData1VoltageIn       : STD_LOGIC_VECTOR(15 downto 0);
signal SADCData2VoltageOut      : STD_LOGIC_VECTOR(15 downto 0);
signal STempData                : word_vector(1 downto 0);
signal SPgbeData                : STD_LOGIC_VECTOR(15 downto 0) := x"0000"; 
signal SADCEnable               : STD_LOGIC_VECTOR(5 downto 0)  := "111111";    

signal  SReceiveCmdRdDpra       : STD_LOGIC_VECTOR(5 downto 0);
signal  SReceiveCmdRdDpo        : STD_LOGIC_VECTOR(15 downto 0);
signal  STransmitBufWrAddr      : STD_LOGIC_VECTOR(5 downto 0);
signal  STransmitBufWrData      : STD_LOGIC_VECTOR(15 downto 0);
signal  STransmitBufWrEn        : STD_LOGIC:= '0';
signal  SDramAddr               : STD_LOGIC_VECTOR(7 downto 0);
signal  SDramDOut               : STD_LOGIC_VECTOR(15 downto 0);
signal  SDramDIn                : STD_LOGIC_VECTOR(15 downto 0);
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
signal utcSecIn_s               : STD_LOGIC_VECTOR (31 downto 0);
signal utcMiliSecIn_s           : STD_LOGIC_VECTOR (31 downto 0);
signal utcSecOut_s              : STD_LOGIC_VECTOR (31 downto 0);
signal utcMiliSecOut_s          : STD_LOGIC_VECTOR (31 downto 0);
signal SUTCError                : STD_LOGIC := '0';
signal utc_wr_s                 : STD_LOGIC := '0';
signal SLogUTC                  : STD_LOGIC_VECTOR(31 downto 0);
signal SBaseAddrRead            : STD_LOGIC_VECTOR (15 downto 0);
signal SLogReadMode             : STD_LOGIC;
signal SReadRequest             : STD_LOGIC;
signal SEraseRequest            : STD_LOGIC;
signal SFrameRead               : STD_LOGIC;
signal SAgeing                  : STD_LOGIC_VECTOR (31 downto 0);
signal SConfRamAddr             : STD_LOGIC_VECTOR (9 downto 0);
signal SConfRamData             : STD_LOGIC_VECTOR (7 downto 0);
signal SConfRamWE               : STD_LOGIC_VECTOR (0 downto 0);
signal SShaft_Position          : STD_LOGIC_VECTOR (13 downto 0);
signal SSetupMode               : STD_LOGIC;
signal SMsgType                 : STD_LOGIC_VECTOR (3 downto 0);
signal Ssinyal                  : STD_LOGIC;
signal SDurum                   : STD_LOGIC_VECTOR (7 downto 0);
signal SReceivedData            : byte_vector (63 downto 0);
signal SFiltedPosition          : std_logic_vector(15 DOWNTO 0); 
signal SMotorControlReset       : STD_LOGIC:= '0';
signal SSpeedtime               : std_logic_vector(23 DOWNTO 0) := x"000000";
signal SPeriodCounter           : std_logic_vector(23 DOWNTO 0) := x"000000";
signal SSpeed                   : std_logic_vector(23 DOWNTO 0) := x"000000";
signal SConvertCounter          : std_logic_vector(23 DOWNTO 0) := x"000000";
signal SSpeedCounter            : std_logic_vector(23 DOWNTO 0) := x"000000";
signal SSpeedDataEn             : STD_LOGIC:= '0';
signal SPrevHallEffectA         : STD_LOGIC:= '0';
signal SMotorRotate             : STD_LOGIC;
signal SReceiveUTC              : byte_vector (15 downto 0);
signal PositionSpeed_res        : STD_LOGIC:= '0';
signal SPreMotorRotate          : STD_LOGIC:= '0';
signal Pos_sature               : STD_LOGIC:= '0';
signal Speed_sature             : STD_LOGIC:= '0';
signal Position_res             : STD_LOGIC:= '0';
signal Speed_res                : STD_LOGIC:= '0';
signal SResCounter              : integer range 0 to 501 := 0;



begin

SReset        <= PIReset;
POLED         <= SLED;
--SUartRxd    <= PIUartRxd;
--POUartTxd   <= SUartTxd;     
--POUartTxdEn <= SUartTxdEn;    
--POUartRxdEn <= SUartRxdEn; 
--POClk1Mhz <= SClk1Mhz;

--POSinyal  <= SSinyal;
SDurum(4 downto 2) <= "000";
SDurum (7 downto 5) <= "000";
--------------  Hall Effect Ports   --------------------
SHallEffectAinit    <= PIHallEffectA;
SHallEffectBinit    <= PIHallEffectB; 
SHallEffectCinit    <= PIHallEffectC; 
--------------  Hall Effect Ports   --------------------     
--------------  Mosfet Driver Ports --------------------

Debounce_HALL_Sensors:process (PIReset, SClk500Khz)
   begin
   if PIReset = '1' then
     SHallEffectAdeb1     <= SHallEffectAinit;
     SHallEffectAdeb2     <= SHallEffectAinit;
     SHallEffectAdeb3     <= SHallEffectAinit;
     SHallEffectAdeb4     <= SHallEffectAinit;
     SHallEffectAdeb5     <= SHallEffectAinit;
     SHallEffectA         <= SHallEffectAinit;

     SHallEffectBdeb1     <= SHallEffectBinit;
     SHallEffectBdeb2     <= SHallEffectBinit;
     SHallEffectBdeb3     <= SHallEffectBinit;
     SHallEffectBdeb4     <= SHallEffectBinit;
     SHallEffectBdeb5     <= SHallEffectBinit;
     SHallEffectB         <= SHallEffectBinit;

     SHallEffectCdeb1     <= SHallEffectCinit;
     SHallEffectCdeb2     <= SHallEffectCinit;
     SHallEffectCdeb3     <= SHallEffectCinit;
     SHallEffectCdeb4     <= SHallEffectCinit;
     SHallEffectCdeb5     <= SHallEffectCinit;
     SHallEffectC         <= SHallEffectCinit;

   elsif rising_edge(SClk500Khz)then
     SHallEffectAdeb1     <= SHallEffectAinit;
     SHallEffectAdeb2     <= SHallEffectAdeb1;
     SHallEffectAdeb3     <= SHallEffectAdeb2;
     SHallEffectAdeb4     <= SHallEffectAdeb3;
     SHallEffectAdeb5     <= SHallEffectAdeb4;

     SHallEffectBdeb1     <= SHallEffectBinit;
     SHallEffectBdeb2     <= SHallEffectBdeb1;
     SHallEffectBdeb3     <= SHallEffectBdeb2;
     SHallEffectBdeb4     <= SHallEffectBdeb3;
     SHallEffectBdeb5     <= SHallEffectBdeb4;

     SHallEffectCdeb1     <= SHallEffectCinit;
     SHallEffectCdeb2     <= SHallEffectCdeb1;
     SHallEffectCdeb3     <= SHallEffectCdeb2;
     SHallEffectCdeb4     <= SHallEffectCdeb3;
     SHallEffectCdeb5     <= SHallEffectCdeb4;

     if SHallEffectAdeb5 = SHallEffectAdeb4 then
        SHallEffectA <= SHallEffectAdeb4;   
     elsif SHallEffectAdeb4 = SHallEffectAdeb3 then
        SHallEffectA <= SHallEffectAdeb3;
     elsif SHallEffectAdeb3 = SHallEffectAdeb2 then
        SHallEffectA <= SHallEffectAdeb2;   
     elsif SHallEffectAdeb2 = SHallEffectAdeb1 then
        SHallEffectA <= SHallEffectAdeb1;
     elsif SHallEffectAdeb1 = SHallEffectAinit then
        SHallEffectA <= SHallEffectAinit;
     else 
        SHallEffectA <= SHallEffectAdeb5;
     end if;

     if SHallEffectBdeb5 = SHallEffectBdeb4 then
        SHallEffectB <= SHallEffectBdeb4;
     elsif SHallEffectBdeb4 = SHallEffectBdeb3 then
        SHallEffectB <= SHallEffectBdeb3;
     elsif SHallEffectBdeb3 = SHallEffectBdeb2 then
        SHallEffectB <= SHallEffectBdeb2;
     elsif SHallEffectBdeb2 = SHallEffectBdeb1 then
        SHallEffectB <= SHallEffectBdeb1;
     elsif SHallEffectBdeb1 = SHallEffectBinit then
        SHallEffectB <= SHallEffectBinit;
     else 
        SHallEffectB <= SHallEffectBdeb5;
     end if;

     if SHallEffectCdeb5 = SHallEffectCdeb4 then
        SHallEffectC <= SHallEffectCdeb4;
     elsif SHallEffectCdeb4 = SHallEffectCdeb3 then
        SHallEffectC <= SHallEffectCdeb3;
     elsif SHallEffectCdeb3 = SHallEffectCdeb2 then
            SHallEffectC <= SHallEffectCdeb2;
     elsif SHallEffectCdeb2 = SHallEffectCdeb1 then
            SHallEffectC <= SHallEffectCdeb1;
     elsif SHallEffectCdeb1 = SHallEffectCinit then
        SHallEffectC <= SHallEffectCinit;
     else 
        SHallEffectC <= SHallEffectCdeb5;
     end if;
   end if;
end process; 
process (PIReset,SHighSideA,SLowSideA,SHighSideB,SLowSideB,SHighSideC,SLowSideC)
   begin
   if PIReset = '1' then
        POHighSideA <= '0';
        POLowSideA  <= '1';
        POHighSideB <= '0';
        POLowSideB  <= '1';
        POHighSideC <= '0';
        POLowSideC  <= '1';

   else
        POHighSideA <= SHighSideA;  
        POLowSideA  <= SLowSideA;   
        POHighSideB <= SHighSideB;  
        POLowSideB  <= SLowSideB;   
        POHighSideC <= SHighSideC;  
        POLowSideC  <= SLowSideC;
   
   end if;
end process; 
         
--------------  Mosfet Driver Ports --------------------   
SLogUTC<=utcSecOut_s(15 downto 0) & utcMiliSecOut_s(31 downto 16);

--POUartChEnable<='1';
SCfgOk<='1';
------------------------------------------------------------------------Degisiklik yapilacak deneme kodlar? asagidadir.-----------------------
--POUartTxdEn1 <= '1';
--POUartTxdEn2 <= '1';

POM1553B_RTA <= "00001";
POM1553B_RTAP <= '0';

SConfigValueReady <= '1';
SConfigValueOk    <= '1';

process (SClk)
   begin
   if rising_edge (SClk) then
      if SResetWaitCounter = 5000000 then --for 100ms
         PIReset<='0';
      else
         PIReset<='1';
         SResetWaitCounter<=SResetWaitCounter+1;
      end if;
   end if;   
end process;

process (SClk2_5Mhz,PIReset)
   begin
   if PIReset = '0' then
   if rising_edge (SClk2_5Mhz) then
      if SLEDWaitCounter = 2500000 then --for 100ms
         SLED <= not SLED;
         SLEDWaitCounter <= 0;
      else
         SLED<=SLED;
         SLEDWaitCounter<=SLEDWaitCounter+1;
      end if;
   end if;   
   else
    SLED<='0';
    SLEDWaitCounter <= 0;
    end if;
end process;         

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

LMProcess1553 : process_1553 
Port Map(  
    PIClk                => SClk,   
    reset                => SReset,
    receive_cmd_r_dpra   => SReceiveRamAddrCh1,
    receive_cmd_r_dpo    => SReceiveRamDataCh1,
    transmit_buf_r_a     => STransmitRamAddrCh1, 
    transmit_buf_r_d     => STransmitRamDataCh1,
    transmit_buf_r_we    => STransmitRamWECh1,
    dram_addr            => SDramAddr,
    dram_dout            => SDramDOut,
    dram_din             => SDramDIn,
    modules_en           => SModulesEn,
    clr_err_flg          => SClrErrFlg,
   process_ok            => SProcessOk,
   rx_ready_1553         => SRxReady1553,
   config_value_ok       => SConfigValueOk,
   config_value_ready    => SConfigValueReady
  ); 


LGUart : for i in 0 to 1 generate 
LUartModule: MUart
  Port map (    PIClk                   => SClk,
                PIReset                 => SReset,
---------- 'Uart Module <--> Main Process Module' Ports --------------
                PIModuleEnable          => SSystemEn(i),            
                PITxDataReadyInRAM      => SCommandReady(i),        
                POTxDataFromMainOK      => SCommandReadyOk(i),      
                PORxDataReadyInRAM      => SResponseReady(i),   
                PIRxDataToMainOK        => SResponseReadyOk(i),  
                POPhysicalAddress       => SReadPhysicalAddress(6*i+5 downto 6*i),
                PISetupMode             => SSetupMode,
---------- 'Uart Module <--> Main Process Module' Ports --------------
---------- CBIT Ports --------------
                PIClearErrFlag          =>  SClearError(i),
                POCBitResult            =>  SUartCBitResult(i),
                POCBitResultUpdate      =>  SUartCBitUpdate(i),
---------- CBIT Ports --------------    
---------- PBIT Ports --------------    
                POPBitResult            => SUartPBitResult(i),  
---------- PBIT Ports --------------    
---------- Configuration Ports --------------
                PICfgEn                 => '0',
                PICfgData               => SCfgData,
---------- Configuration Ports --------------                   
---------- Uart Ports --------------                    
                POTXD                   => POUartTxd(i),
                PIRXD                   => PIUartRxd(i),
                POTxdEn                 => POUartTxdEn(i),
                PORxdEn                 => POUartRxdEn(i),
---------- Uart Ports --------------    
            
---------- 'Uart Module <--> Main Process Module' Receive Ram Ports --------------              
                PORAMWrAddr     =>  SUartMainRRamPAAddrIn(8*i+7 downto 8*i),        
                PORAMWrData     =>  SUartMainRRamDataIn(i),
                PORAMWE         =>  SUartMainRRamPAEn(i),   
---------- 'Uart Module <--> Main Process Module' Receive Ram Ports --------------

---------- 'Uart Module <--> Main Process Module' Transmit Ram Ports --------------             
                PORdAddr        =>  SUartMainTRamPBAddrIn(8*i+7 downto 8*i),        
                PIRdData        =>  SUartMainTRamDataOut(i),
                PORdEnable      =>  SUartMainTRamPBEn(i)            
---------- 'Uart Module <--> Main Process Module' Transmit Ram Ports --------------     
            );
end generate;
---------- Uart Module --------------   

---------- Clk Divider Module --------------
    
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

---------- Main Process Module --------------   
LGUartMain : for i in 0 to 1 generate 
LMainProcessModule: MainProcessModule
  Port Map (    PIClk                   => SClk,
                PIReset                 => SReset,
                PICfgOk                 => SCfgOk,
                POSystemEn              => SSystemEn(i),
            
---------- 'Uart Module <--> Main Process Module' Ports --------------
                POTxDataReadyInRAM      => SCommandReady(i),    
                PITxDataFromMainOK      => SCommandReadyOk(i), 
                PIRxDataReadyInRAM      => SResponseReady(i),   
                PORxDataToMainOK        => SResponseReadyOk(i),
---------- 'Uart Module <--> Main Process Module' Ports --------------

---------- CBIT Ports --------------
                POClearError            => SClearError(i),
                POCBitResult            => SMainCBitResult(i),
                POCBitResultUpdate      => SMainCBitUpdate(i),
---------- CBIT Ports --------------    

---------- PBIT Ports --------------    
                POPBitResult            => SMainPBitResult(i),  
---------- PBIT Ports --------------        
                                
---------- 'Uart Module <--> Main Process Module' Receive Ram Ports --------------              
                POUartMainRRamEn        => SUartMainRRamPBEn(i),            
                PIUartMainRRamDataOut   => SUartMainRRamDataOut(i), 
                POUartMainRRamAddrIn    => SUartMainRRamPBAddrIn(8*i+7 downto 8*i),             
---------- 'Uart Module <--> Main Process Module' Receive Ram Ports --------------

---------- 'Uart Module <--> Main Process Module' Transmit Ram Ports --------------             
                POUartMainTRamEn        => SUartMainTRamPAEn(i),        
                POUartMainTRamDataIn    => SUartMainTRamDataIn(i),  
                POUartMainTRamAddrIn    => SUartMainTRamPAAddrIn(8*i+7 downto 8*i),
---------- 'Uart Module <--> Main Process Module' Transmit Ram Ports -------------- 
---------- Physical Addres Ports -------------- 
                PIPhysicalAddress       => PIPhysicalAddress,
                PIReadPhysicalAddress   => SReadPhysicalAddress(5 downto 0),
                PISetupMode             => SSetupMode,
                POMsgType               => SMsgType(2*i+1 downto 2*i),
---------- Physical Addres Ports -------------- 
---------- 'CBIT Module <--> Main Process Module' Ram Ports --------------              
                POCBitMainRamEn         => SCBitMainRamPBEn(i), 
                PICBitMainRamDataOut    => SCBitMainRamDataOut, 
                POCBitMainRamAddrIn     => SCBitMainRamPBAddrIn(8*i+7 downto 8*i),              
---------- 'CUart Module <--> Main Process Module' Ram Ports --------------

---------- 'PBIT Module <--> Main Process Module' Ram Ports --------------              
                POPBitMainRamEn         => SPBitMainRamPBEn(i), 
                PIPBitMainRamDataOut    => SPBitMainRamDataOut,     
                POPBitMainRamAddrIn     => SPBitMainRamPBAddrIn(8*i+7 downto 8*i),                  
---------- 'PUart Module <--> Main Process Module' Ram Ports -------------- 
          --      POSDebug  => open,--SDenemeSinyal(8*i+7 downto 8*i),--------------- silinecek
---------- 'Motor Control Module <--> Main Process Module' Ports -------------- 
                PIPositionOk            =>  SPositionOk,
                POReceivedData          =>  SReceivedData(32*i+31 downto 32*i), 
                POCommand               =>  SCommand(i),
                POConfigData            =>  SConfigData(27*i+26 downto 27*i),	
                POReceiveUTC            =>  SReceiveUTC(8*i+7 downto 8*i),
                POPositionUpdate        =>  SPositionUpdate(i),
                POPositionData          =>  SPositionData(i)            
---------- 'Motor Control Module <--> Main Process Module' Ports --------------         
            );
 end generate;        
---------- Main Process Module --------------
---------- Uart <--> Main Receive Ram Module -------------- 
LGUartRxRam : for i in 0 to 1 generate 
LUartMainRxRamModule: RamModule
  Port Map (    PIClk           =>  SClk,           
                PIReset         =>  SReset,         
---------- PA Ram Ports --------------              
                PIRamPAEn       =>  SUartMainRRamPAEn(i),
                PIRamDataIn     =>  SUartMainRRamDataIn(i),
                PIRamPAAddrIn   =>  SUartMainRRamPAAddrIn(8*i+7 downto 8*i),
---------- PA Ram Ports --------------
---------- PB Ram Ports --------------              
                PIRamPBEn       =>  SUartMainRRamPBEn(i),
                PORamDataOut    =>  SUartMainRRamDataOut(i),        
                PIRamPBAddrIn   =>  SUartMainRRamPBAddrIn(8*i+7 downto 8*i)                 
---------- PB Ram Ports --------------
            );
end generate;
---------- Uart <--> Main Receive Ram Module --------------
---------- Uart <--> Main Transmit Ram Module --------------    
LGUartTxRam : for i in 0 to 1 generate 
LUartMainTxRamModule: RamModule
  Port Map (    PIClk           =>  SClk,           
                PIReset         =>  SReset,         
---------- PA Ram Ports --------------              
                PIRamPAEn       =>  SUartMainTRamPAEn(i),       
                PIRamDataIn     =>  SUartMainTRamDataIn(i),     
                PIRamPAAddrIn   =>  SUartMainTRamPAAddrIn(8*i+7 downto 8*i),                
---------- PA Ram Ports --------------
---------- PB Ram Ports --------------              
                PIRamPBEn       =>  SUartMainTRamPBEn(i),   
                PORamDataOut    =>  SUartMainTRamDataOut(i),    
                PIRamPBAddrIn   =>  SUartMainTRamPBAddrIn(8*i+7 downto 8*i)             
---------- PB Ram Ports --------------
            );
end generate;
---------- Uart <--> Main Transmit Ram Module --------------
---------- CBit Ram Module --------------   
LCBitDRamModule : DRAMModule 
        Port Map( PIClk       =>    SClk,   
              PIReset         =>    SReset,
---------- PA Ram Ports --------------  
              PIRamDataIn     =>    SCBitRamDataIn,             
---------- PA Ram Ports --------------
---------- PB Ram Ports --------------              
              PIRamPBEn       =>    SCBitMainRamPBEn(0),         
              PORamDataOut    =>    SCBitMainRamDataOut,    
              PIRamPBAddrIn   =>    SCBitMainRamPBAddrIn(7 downto 0)                
---------- PB Ram Ports --------------
            );
---------- CBit Ram Module --------------       
      
---------- PBit Ram Module --------------
LPBitRamModule: RamModule
  Port Map (PIClk           =>  SClk,           
            PIReset         =>  SReset,         
---------- PA Ram Ports --------------              
            PIRamPAEn       =>  SPBitRamPAEn,   
            PIRamDataIn     =>  SPBitRamDataIn, 
            PIRamPAAddrIn   =>  SPBitRamPAAddrIn,               
---------- PA Ram Ports --------------
---------- PB Ram Ports --------------              
            PIRamPBEn       =>  SPBitMainRamPBEn(0),
            PORamDataOut    =>  SPBitMainRamDataOut,
            PIRamPBAddrIn   =>  SPBitMainRamPBAddrIn(7 downto 0)
---------- PB Ram Ports --------------
            );
---------- PBit Ram Module --------------


--SDenemeSinyal <= SHallEffectA&SHallEffectB&SHallEffectC&SPgbeData(12 downto 0);
---------- BIT Result Module -------------- 
LBitResultModule: BitResultModule
  Port Map (    PIClk                    => SClk,   
                PIReset                  => SReset,
                PIModuleEn               => SSystemEn(0),
---------- CBIT Ports --------------       
                PIUartCBitResult         => SUartCBitResult(0),                     
                PIMainCBitResult         => SMainCBitResult(0),         
                PIMotorControlCBitResult => SMotorControlCBitResult,
                PIUartCBitUpdate         => SUartCBitUpdate(0),        
                PIMainCBitUpdate         => SMainCBitUpdate(0),     
                PIMotorCBitUpdate        => SMotorCBitUpdate,    
            
---------- CBIT Ports --------------    
---------- PBIT Ports --------------    
                PIUartPBitResult         => SUartPBitResult(0),                     
                PIMainPBitResult         => SMainCBitResult(0),                 
                PIMotorControlPBitResult => SMotorControlCBitResult,    
---------- PBIT Ports --------------    
---------- 'BIT Module <--> CBIT RAM Module' Ports --------------
                POBitCBitRamDataIn       => SCBitRamDataIn,                     
---------- 'BIT Module <--> CBIT RAM Module' Ports --------------   
---------- 'BIT Module <--> PBIT RAM Module' Ports --------------               
                POBitPBitRamEn           => SPBitRamPAEn,   
                POBitPBitRamDataIn       => SPBitRamDataIn, 
                POBitPBitRamAddrIn       => SPBitRamPAAddrIn,               
---------- 'BIT Module <--> PBIT RAM Module' Ports --------------   
----------- BIT Module <--> ADC Module Ports --------------------
                PI1553Cbit               => cbit_1553_1_result,
                PIPGBEData               => SPgbeData,--SFiltedPosition,--SPgbeData,--SDenemeSinyal,
                PICIAdcData              => SADCData0CurrentIn,
                PIVIAdcData              => SADCData1VoltageIn,
                PIVOAdcData              => SADCData2VoltageOut,
                PICOAAdcData             => SADCData3CurrentOutA,
                PICOBAdcData             => SADCData4CurrentOutB,
                PICOCAdcData             => SADCData5CurrentOutC,
                PITempData1              => STempData(0),
                PITempData2              => STempData(1),
                PIPgbeDataReg            => SPgbeDataReg, 
                PIDurum                  => SDurum,
                PISDenemeSinyal          => SDenemeSinyal,
                PIReceivedData          =>  SReceivedData(31 downto 0), 

--        PIClk12_5Mhz      => SClk12_5Mhz,
--        POAdcConv         => POAdcConv(2 downto 0),
--        PIAdcSdo          => PIAdcSdo(2 downto 0),
--        POAdcSck          => POAdcSck(2 downto 0)
----------- BIT Module <--> ADC Module Ports --------------------
----------- BIT Module <--> Main Process Ports --------------------
                PISetupMode             => SSetupMode,
                PIMsgType               => SMsgType(1 downto 0)
----------- BIT Module <--> Main Process Ports --------------------
             
            );
---------- BIT Result Module --------------
SClk <= PIClk;

--process (SResponseReady,SReset)
--begin
   --if SReset = '1' then
   --SDenemeSinyal <=x"0000";
   --else
    --if SResponseReady /= "00" then 
        --SDenemeSinyal <= SResponseReady& x"000"& "00";
    --end if;
    --end if;
--end process;

LGTemp : for i in 0 to 1 generate
LMTemperature : MTemperature 
Port Map(  PIClk             => SClk500Khz,
           PIReset           => SReset,
           POTempSCK         => POTmpSck(i),    
           POTempCS          => POTmpCs(i),     
           POTempMOSI        => POTmpMosi(i),   
           PITempMISO        => PITmpMiso(i),   
      --   PIClrErrorFlag    => 
           POTempData        => STempData(i),
           POTempOK          => STemperatureOK(i)
  ); 
end generate;
 
LGNVM : for i in 0 to 1 generate 
LMLog:MLog   
   Port Map( PIClk           => SClk,  
             PIClk500Khz     => SClk500Khz,  
             PIReset         => SReset,  
             PIClk1Hz        => SClk1hz, 
             PIModuleEnable  => '1',
             PIMISO          => PILogMISO(i),
             POMOSI          => POLogMOSI(i), 
             POCS            => POLogCS(i),   
             POSCK           => POLogSCK(i),  
             PIBitResults    => SCBitRamDataIn,
             PIUtc           => SLogUTC,
             POFlashReset    => open,
             PIBaseAddrRead  => SBaseAddrRead,
             PILogReadMode   => SLogReadMode,     
             PIReadRequest   => SReadRequest,
             PIEraseRequest  => SEraseRequest,
             POConfRamAddr   => SConfRamAddr, 
             POConfRamData   => SConfRamData, 
             POConfRamWE     => SConfRamWE(0),   
             POFrameRead     => SFrameRead,
             POAgeingCounter => SAgeing
           ); 
end generate;

utc_module: UTC PORT MAP(
        utcWR                       => utc_wr_s,
        utcCLK                      => SClk,
        utcRESET                    => PIReset,
        PIClrErrFlg                 => SClrErrFlg,
        utcSecIn                    => utcSecIn_s,
        utcMiliSecIn                => utcMiliSecIn_s,
        utcSecOut                   => utcSecOut_s,
        utcMiliSecOut               => utcMiliSecOut_s,
        POUTCError                  => SUTCError
    );

SADCData0CurrentIn   <= SADCData(0);           
SADCData1VoltageIn   <= SADCData(1);
SADCData2VoltageOut  <= SADCData(2);
SADCData3CurrentOutA(11 downto 0) <= SADCData(3)(11 downto 0)-x"800" when SMotorRotate = '0' else
                                     x"800";
SADCData4CurrentOutB(11 downto 0) <= SADCData(4)(11 downto 0)-x"800" when SMotorRotate = '0' else
                                     x"800";
SADCData5CurrentOutC(11 downto 0) <= SADCData(5)(11 downto 0)-x"800" when SMotorRotate = '0' else
                                     x"800";
SADCData3CurrentOutA(15 downto 12)<= x"0";
SADCData4CurrentOutB(15 downto 12)<= x"0"; 
SADCData5CurrentOutC(15 downto 12)<= x"0"; 

process (SReset,SHighSideC,SHighSideB,SHighSideA)
   begin
   if SReset = '1' then
    SADCEnable <= "111111";
   else
    SADCEnable <= SHighSideC & SHighSideB & SHighSideA & SReset & SReset & SReset;  
   end if;
end process;  


--process (SReset,SClk500Khz)
   --begin
   --if SReset = '1' then
    --SSinyal <= '1';
   --elsif rising_edge (SClk500Khz) then
     --if SMosCounter = 1000 then
        --SSinyal <= not SSinyal;
        --SMosCounter <= 0;
     --else
        --SMosCounter <= SMosCounter+1;
        --SSinyal <= SSinyal;
     --end if;
   --end if;
--end process;  


LGADC : for i in 0 to 5 generate
LMADCController: MADCController
  Port Map(  PIClk          => SClk,
             PIClk12M5Hz    => SClk10Mhz,
             PIReset        => SReset,
             PIADCEnable    => SADCEnable(i),
             POCNV          => POAdcConv(i),  
             POSCLK         => POAdcSck(i),  
             PISData        => PIAdcSdo(i), 
             POADCDataReady => SADCDataReady(i),
             POADCData      => SADCData(i)       
          );
end generate;

SPgbeData(15 downto 14) <= "00";

LMPGBEController: MPGBEController
  Port Map(    PIClk           => SClk,
               PIReset         => SReset,
               POPgbeSck       => POPgbeSck,   
               POPgbeCs        => POPgbeCs,   
               POPgbeWR        => POPgbeWR, 
               POPgbeOE        => POPgbeOE, 
               POPgbeAddress   => POPgbeAddress,
               PIOADCData      => PIOPGBEData, 
               POPgbeDataReg   => SPgbeDataReg, 
               POPgbeData      => SPgbeData(13 downto 0)
          );

--SStHall <= SHallEffectA&SHallEffectB&SHallEffectC;

--process(SClk1hz,SReset)
--begin
    --if SReset = '1' then
        --SShaft_Position <= "01"&x"CFD";
    --elsif rising_edge(SClk1hz) then
       --if SShaft_Position = "01"&x"FFF" then 
            --SShaft_Position <= SShaft_Position;
        --else
            --SShaft_Position <= SShaft_Position + 77;
        --end if;
            --
    --end if;
--end process;

LMMotorController: Motor_Controller
  PORT Map( clk                => SClk1Mhz,   
            reset              => SMotorControlReset,--SReset,
            clk_enable         => '1',
            Shaft_Position     => '0'&SPgbeData(12 downto 0),  -- sfix14---00F  --SShaft_Position,--
            Pos_Demand         => SPositionData(0)(13 downto 0), --"00"&x"D50",--"01"&x"FFF",  -- sfix14
            Hall_A             => SHallEffectA,
            Hall_B             => SHallEffectB,
            Hall_C             => SHallEffectC,
            ia                 => SADCData3CurrentOutA(11 downto 0),   -- sfix12
            ib                 => SADCData4CurrentOutB(11 downto 0),   -- sfix12
            ic                 => SADCData5CurrentOutC(11 downto 0),   -- sfix12
            ce_out_0           => open,
            ce_out_1           => open,
            I_a_ref            => open,
            I_b_ref            => open,
            I_c_ref            => open,
            Hin_A              => SHighSideA,
            Lin_A              => SLowSideA ,
            Hin_B              => SHighSideB,
            Lin_B              => SLowSideB ,
            Hin_C              => SHighSideC,
            Lin_C              => SLowSideC,
            Ara_deger          => SDenemeSinyal(0)(7 downto 0),
            posFilted          => SDenemeSinyal(3)(13 downto 0),--SFiltedPosition(13 downto 0),  
            --Speed              => SDenemeSinyal(1)(8 downto 0),
            posFilted_ref      => SDenemeSinyal(2)(13 downto 0),
            Motor_durum        => SMotorRotate,
            Hiz                => SSpeed(8 downto 0),  
            Direction          => SDirection,
            Pos_sature         => Position_res,     
            Speed_sature       => Speed_res,
            Position_res       => Position_res,
            Speed_res          => Speed_res,
            Position_P_virgul  => SReceiveUTC(0)(2 downto 0),   
            Position_P_deger   => SReceiveUTC(0)(7 downto 3),   
            Position_I_virgul  => SReceiveUTC(1)(2 downto 0),   
            Position_I_deger   => SReceiveUTC(1)(7 downto 3),   
            Position_D_virgul  => SReceiveUTC(2)(2 downto 0),   
            Position_D_deger   => SReceiveUTC(2)(7 downto 3),   
            Speed_P_virgul     => SReceiveUTC(3)(2 downto 0),   
            Speed_P_deger      => SReceiveUTC(3)(7 downto 3),   
            Speed_I_virgul     => SReceiveUTC(4)(2 downto 0),   
            Speed_I_deger      => SReceiveUTC(4)(7 downto 3),   
            Speed_D_virgul     => SReceiveUTC(5)(2 downto 0),   
            Speed_D_deger      => SReceiveUTC(5)(7 downto 3)    
            );


SDenemeSinyal(1)(15 downto 9) <= "0110011" ;
SDenemeSinyal(0)(15 downto 8)  <= SSpeed(7 downto 0) ;
SDenemeSinyal(2)(15 downto 14) <=  "00";
SDenemeSinyal(3)(15 downto 14) <=  "00";

Conversion_TimetoSpeed: process (SClk,SReset)
   begin
   if SReset = '1' then
        SSpeed <= x"000000";
        SConvertCounter <= x"000000";
        SSpeedCounter <= x"000000";
   elsif rising_edge (SClk) then
      if SSpeedtime /= x"000000" then

        if SConvertCounter >= x"07A120" then
            SConvertCounter <= x"000000";
            SSpeed <= SSpeedCounter;
            SSpeedCounter <= x"000000";
        else
            SSpeedCounter <= SSpeedCounter+1;
            SConvertCounter <= SConvertCounter + SSpeedtime;
        end if;
       else
        SSpeed <= x"000000";
        SConvertCounter <= x"000000";
        SSpeedCounter <= x"000000";

       end if;
   end if;   
end process;

process (SClk500Khz,SReset)
begin
     if SReset = '1' then
          SResCounter <= 0;
          PositionSpeed_res <= '0';
    elsif rising_edge (SClk500Khz) then
        SPreMotorRotate <= SMotorRotate;
        if SPreMotorRotate = '0' and SMotorRotate = '1' then
            SResCounter <= 0;
        else
            if SResCounter > 500 then
                PositionSpeed_res <= '0';
                SResCounter <= 501;
            else
                PositionSpeed_res <= '1';
                SResCounter <= SResCounter + 1;
            end if;
        end if;
    end if;
end process;

PeriodofSpeed_Sensor: process (SClk500Khz,SReset)
   begin
   if SReset = '1' then
      SSpeedtime <= x"000000";
      SPeriodCounter <= x"000000";
      SSpeedDataEn  <= '0';
      SPrevHallEffectA <= SHallEffectA;
   elsif rising_edge (SClk500Khz) then
        SPrevHallEffectA <= SHallEffectA;
      if SMotorRotate = '0' then
        if SPrevHallEffectA = '0' and SHallEffectA = '1' then
          if SSpeedDataEn = '1' then
            SSpeedtime <= SPeriodCounter;
            SPeriodCounter <= x"000000";
            SSpeedDataEn <= '1';
          else
            SPeriodCounter <= x"000000";
            SSpeedDataEn <= '1';
          end if;
        else
            SPeriodCounter <= SPeriodCounter + 1;
        end if;
      else  
      SSpeedDataEn  <= '0';
      SSpeedtime    <= x"000000";
      SPeriodCounter <= x"000000";
      end if;
   end if;   
end process;

process(SClk,SReset)
begin
    if SReset = '1' then
        SDirection <= '0';
        StDirection <= StIdle;
    elsif rising_edge (SClk) then
        case StDirection is
            when StIdle =>
                if SHallEffectA = '1' then
                    StDirection <= StHallA;
                    StPreDirection <= StIdle;
                elsif SHallEffectB = '1' then
                    StDirection <= StHallB;
                    StPreDirection <= StIdle;
                elsif SHallEffectC = '1' then
                    StDirection <= StHallC;
                    StPreDirection <= StIdle;
                else
                    StDirection <= StIdle;
                    StPreDirection <= StIdle;
                end if;
            when StHallA =>
                if StPreDirection = StHallB then
                    SDirection <= '1';
                elsif StPreDirection = StHallC then
                    SDirection <= '0';
                else
                    SDirection <= SDirection;
                end if;
                if SHallEffectA = '1' then
                    StDirection <= StHallA;
                    StPreDirection <= StHallA;
                elsif SHallEffectB = '1' then
                    StDirection <= StHallB;
                    StPreDirection <= StHallA;
                elsif SHallEffectC = '1' then
                    StDirection <= StHallC;
                    StPreDirection <= StHallA;
                else
                    StDirection <= StHallA;
                    StPreDirection <= StHallA;
                end if;
            when StHallB =>
                if StPreDirection = StHallC then
                    SDirection <= '1';
                elsif StPreDirection = StHallA then
                    SDirection <= '0';
                else
                    SDirection <= SDirection;
                end if;
                if SHallEffectA = '1' then
                    StDirection <= StHallA;
                    StPreDirection <= StHallB;
                elsif SHallEffectB = '1' then
                    StDirection <= StHallB;
                    StPreDirection <= StHallB;
                elsif SHallEffectC = '1' then
                    StDirection <= StHallC;
                    StPreDirection <= StHallB;
                else
                    StDirection <= StHallB;
                    StPreDirection <= StHallB;
                end if;
            when StHallC =>
                if StPreDirection = StHallA then
                    SDirection <= '1';
                elsif StPreDirection = StHallB then
                    SDirection <= '0';
                else
                    SDirection <= SDirection;
                end if;
                if SHallEffectA = '1' then
                    StDirection <= StHallA;
                    StPreDirection <= StHallC;
                elsif SHallEffectB = '1' then
                    StDirection <= StHallB;
                    StPreDirection <= StHallC;
                elsif SHallEffectC = '1' then
                    StDirection <= StHallC;
                    StPreDirection <= StHallC;
                else
                    StDirection <= StHallC;
                    StPreDirection <= StHallC;
                end if;
            when others =>
                SDirection <= '0';
                StDirection <= StIdle;
        end case;
    end if;
end process;

Operation_Modes: process (SClk,SReset,PIPhysicalAddress)
   begin
   if SReset = '1' then
     if PIPhysicalAddress = x"B5" then
        SSetupMode <= '1';
        SStOpMode <= StSetup;
     else
        SSetupMode <= '0';
        SStOpMode <= StFloat;
     end if;
        SMotorControlReset <= '1';
   elsif rising_edge (SClk) then
      case SStOpMode is
      when StFloat =>
        if SDurum (7 downto 5) > "000" then 
            SStOpMode <= StFloat;
            SDurum(1 downto 0) <= "10";
        elsif SCommand(0)(1 downto 0)= "01"then
            SStOpMode <= StNormal;
        else   
            SStOpMode <= StFloat;
            SDurum(1 downto 0) <= "10";
        end if;
         SMotorControlReset <= '1';
      when StNormal =>
        if SDurum (7 downto 5) > "000" then 
            SStOpMode <= StFloat;
        elsif SCommand(0)(1 downto 0) = "10" then
            SStOpMode <= StFloat;
        else
            SStOpMode <= StNormal;
            SDurum(1 downto 0) <= "01";
        end if;
         SMotorControlReset <= '0';
      when StSetup =>
            SStOpMode <= StSetup;
            SSetupMode <= '1';
            SMotorControlReset <= '1';
      end case;
   end if;   
end process;


end Behavioral;
