----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:47:18 02/10/2010 
-- Design Name: 
-- Module Name:    TopMod_1553Controller - Behavioral 
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

entity TopMod_1553Controller is

	port (	PIODataBus	        : inout std_logic_vector(15 downto 0);
          PORegAddr           : out std_logic_vector(3 downto 0);
          POSTR		            : out std_logic;
          POCS			          : out std_logic;
          PORW			          : out std_logic;
          POBCStart           : out std_logic;
          POMR		            : out std_logic;
          PIError	            : in std_logic;
          PIValMess           : in std_logic;
          PIRFlag	            : in std_logic;
          PIRCVA		          : in std_logic;
          PIRCVB		          : in std_logic;
          PIFFEmpty           : in std_logic;
          RCVCMDA	            : in std_logic;
          RCVCMDB	            : in std_logic;				
          PORxDpData	        : out std_logic_vector(15 downto 0);
          PORxDpAddr	        : out std_logic_vector(5 downto 0); -- özgür may 07.12.2010 32 word rcv data
          POTxDpAddr	        : out std_logic_vector(5 downto 0); -- özgür may 07.12.2010 32 word rcv data
          PITxDpData	        : in std_logic_vector(15 downto 0);
          POWrEna		          : out std_logic_vector(0 downto 0);
          PORxReady1553		    : out std_logic;
          process_ok			    : in std_logic;
          PIBusyInOth		      : in std_logic;
          PIConfigValueReady  : in std_logic;
          config_value_ok     : in std_logic;
          PIClrErrFlg		      : in  std_logic;
          PORcvCmd				    : out std_logic;
          POErrorReg				  : out std_logic_vector(7 downto 0);
          POPBitErrorReg		  : out std_logic_vector(7 downto 0);
          PIClk50MHz 			    : in std_logic
			);

end TopMod_1553Controller;

architecture Behavioral of TopMod_1553Controller is

COMPONENT MainController
	PORT( POMR 				        : out std_logic;
        PODataIn			      : out std_logic_vector(15 downto 0);
        PORWAddr			      : out std_logic_vector(3 downto 0);
        PORdHI				      : out std_logic;
        POWrHI				      : out std_logic;
        PORxDpData		      : out std_logic_vector(15 downto 0);
        PORxDpAddr		      : out std_logic_vector(5 downto 0); -- 32 Words
        POWrEnable 			    : out std_logic_vector(0 downto 0);
        POTxDpAddr		      : out std_logic_vector(5 downto 0); -- 32 Words
        POErrorReg			    : out std_logic_vector(7 downto 0);
        POPBitErrorReg	    : out std_logic_vector(7 downto 0);
        PORxReady1553       : out std_logic;
        PIError				      : in std_logic;
        PIValMess			      : in std_logic;
        PIRFlag				      : in std_logic;
        PIRCVA				      : in std_logic;
        PIRCVB				      : in std_logic;
        PIFFEmpty			      : in std_logic;
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
	END COMPONENT;

	COMPONENT HI6110bus_controller
	PORT( PIODataBus  : inout std_logic_vector(15 downto 0);
        PIDataIn    : in    std_logic_vector(15 downto 0);
        PIClk50MHz  : in    std_logic;
        PISyncReset : in    std_logic;
        PIWrHI      : in    std_logic;
        PIRdHI 	    : in    std_logic;
        PIRWAddr    : in    std_logic_vector(3 downto 0);
        PODataOut   : out   std_logic_vector(15 downto 0);
        PORegAddr   : out   std_logic_vector(3 downto 0);
        POStr       : out   std_logic;
        PORW        : out   std_logic;
        POCS        : out   std_logic;
        PORWDone	  : out   std_logic
      );
  END COMPONENT;
	

----------------------- Signal definitions ------------------------------
signal SDataIn	    : std_logic_vector(15 downto 0);
signal SDataOut	    : std_logic_vector(15 downto 0);
signal SRWAddr	    : std_logic_vector(3 downto 0);
signal SRdHI		    : std_logic;
signal SWrHI		    : std_logic;
signal SRWDone	    : std_logic;
signal SSyncReset	  : std_logic;
signal SCount       : integer range 0 to 104 := 0;


begin

	LMainCont: MainController 
  PORT MAP( POMR 				      => POMR,
            PODataIn			    => SDataIn,
            PORWAddr			    => SRWAddr,
            PORdHI				    => SRdHI,
            POWrHI				    => SWrHI,
            PORxDpData		    => PORxDpData,
            PORxDpAddr		    => PORxDpAddr,
            POWrEnable 			  => POWrEna,
            POTxDpAddr		    => POTxDpAddr,
            POErrorReg			  => POErrorReg,
            POPBitErrorReg	  => POPBitErrorReg,            
            PORxReady1553     => PORxReady1553,
            PIError				    => PIError,
            PIValMess			    => PIValMess,
            PIRFlag				    => PIRFlag,
            PIRCVA				    => PIRCVA,
            PIRCVB				    => PIRCVB,
            PIFFEmpty			    => PIFFEmpty,
            PIDataOut 		    => SDataOut,
            PIRWDone			    => SRWDone,
            PIProcessOK		    => '1',
            PIBusyInOth		    => PIBusyInOth,
            PIClrErrFlg		    => PIClrErrFlg,
            PITxDpData		    => PITxDpData,
            PIClk50MHz		    => PIClk50MHz,
            PORcvCmd			    => PORcvCmd,
            PISyncReset		    => SSyncReset
          );

	
		LBusCont: HI6110bus_controller 
    PORT MAP(	PIODataBus   => PIODataBus,
              PIDataIn     => SDataIn,
              PIClk50MHz   => PIClk50MHz,
              PISyncReset  => SSyncReset,
              PIWrHI       => SWrHI,
              PIRdHI 	     => SRdHI,
              PIRWAddr     => SRWAddr,
              PODataOut    => SDataOut,
              PORegAddr    => PORegAddr,
              POStr        => POSTR,
              PORW         => PORW,
              POCS         => POCS,
              PORWDone	   => SRWDone          
            );
            
	
	POBCStart <= '0';
  
process(PIClk50MHz)
begin
	if PIClk50MHz'event and PIClk50MHz = '1' then		
		if SCount < 100 then
			SSyncReset <= '1';
			SCount <= SCount + 1;
		elsif SCount = 100 then
			if PIConfigValueReady = '1' then
				SSyncReset <= '0';
				SCount <= 103;
			else
				SSyncReset <= '1';
			end if;
		else
			SSyncReset <= '0';
			SCount <= 103;
		end if;
	end if;
end process;

end Behavioral;

