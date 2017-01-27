-- Version: v11.7 SP2 11.7.2.2

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity TopModule is

    port( PIERR        : in    std_logic_vector(8 downto 0);
          PIRTA        : in    std_logic_vector(4 downto 0);
          PICMD        : in    std_logic_vector(15 downto 0);
          PIODATAWORD  : in    std_logic_vector(511 downto 0);
          PIClk        : in    std_logic;
          PIReset      : in    std_logic;
          PIClk_HI6110 : in    std_logic;
          PIRTAP       : in    std_logic;
          PIBUSA       : in    std_logic;
          PIBUSB       : in    std_logic
        );

end TopModule;

architecture DEF_ARCH of TopModule is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal GND_net_1, VCC_net_1 : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    

end DEF_ARCH; 
