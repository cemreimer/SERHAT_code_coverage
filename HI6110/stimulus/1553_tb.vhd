----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Fri Jan 27 11:05:03 2017
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: 1553_tb.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::IGLOO2> <Die::M2GL025> <Package::484 FBGA>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity 1553_tb is
end 1553_tb;

architecture behavioral of 1553_tb is

    constant SYSCLK_PERIOD : time := 100 ns; -- 10MHZ

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component HI6110
        -- ports
        port( 
            -- Inputs
            PISTR : in std_logic;
            PIRW : in std_logic;
            PICS : in std_logic;
            PIRegAddr : in std_logic_vector(3 downto 0);
            PICLK : in std_logic;
            PIBCSTART : in std_logic;
            PIMR : in std_logic;
            PIBUSA : in std_logic;
            PIBUSB : in std_logic;
            PICMD : in std_logic_vector(15 downto 0);
            PIRTA : in std_logic_vector(4 downto 0);
            PIRTAP : in std_logic;
            PIERR : in std_logic_vector(8 downto 0);

            -- Outputs
            POERROR : out std_logic;
            POVALMESS : out std_logic;
            PORCVA : out std_logic;
            PORCVB : out std_logic;

            -- Inouts
            PIOWORD : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[31]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[30]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[29]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[28]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[27]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[26]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[25]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[24]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[23]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[22]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[21]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[20]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[19]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[18]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[17]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[16]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[15]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[14]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[13]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[12]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[11]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[10]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[9]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[8]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[7]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[6]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[5]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[4]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[3]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[2]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[1]\ : inout std_logic_vector(15 downto 0);
            \PIODATAWORD[0]\ : inout std_logic_vector(15 downto 0)

        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
            wait;
        end if;
    end process;

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  HI6110
    HI6110_0 : HI6110
        -- port map
        port map( 
            -- Inputs
            PISTR => '0',
            PIRW => '0',
            PICS => '0',
            PIRegAddr => (others=> '0'),
            PICLK => SYSCLK,
            PIBCSTART => '0',
            PIMR => '0',
            PIBUSA => '0',
            PIBUSB => '0',
            PICMD => (others=> '0'),
            PIRTA => (others=> '0'),
            PIRTAP => '0',
            PIERR => (others=> '0'),

            -- Outputs
            POERROR =>  open,
            POVALMESS =>  open,
            PORCVA =>  open,
            PORCVB =>  open,

            -- Inouts
            PIOWORD => open,
            \PIODATAWORD[31]\ => open,
            \PIODATAWORD[30]\ => open,
            \PIODATAWORD[29]\ => open,
            \PIODATAWORD[28]\ => open,
            \PIODATAWORD[27]\ => open,
            \PIODATAWORD[26]\ => open,
            \PIODATAWORD[25]\ => open,
            \PIODATAWORD[24]\ => open,
            \PIODATAWORD[23]\ => open,
            \PIODATAWORD[22]\ => open,
            \PIODATAWORD[21]\ => open,
            \PIODATAWORD[20]\ => open,
            \PIODATAWORD[19]\ => open,
            \PIODATAWORD[18]\ => open,
            \PIODATAWORD[17]\ => open,
            \PIODATAWORD[16]\ => open,
            \PIODATAWORD[15]\ => open,
            \PIODATAWORD[14]\ => open,
            \PIODATAWORD[13]\ => open,
            \PIODATAWORD[12]\ => open,
            \PIODATAWORD[11]\ => open,
            \PIODATAWORD[10]\ => open,
            \PIODATAWORD[9]\ => open,
            \PIODATAWORD[8]\ => open,
            \PIODATAWORD[7]\ => open,
            \PIODATAWORD[6]\ => open,
            \PIODATAWORD[5]\ => open,
            \PIODATAWORD[4]\ => open,
            \PIODATAWORD[3]\ => open,
            \PIODATAWORD[2]\ => open,
            \PIODATAWORD[1]\ => open,
            \PIODATAWORD[0]\ => open

        );

end behavioral;

