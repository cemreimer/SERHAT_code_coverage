--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: 1553_coverage_tb.vhd
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

----third party libs----
use work.types.all;

entity coverage_1553_tb is
end coverage_1553_tb;

architecture architecture_coverage_1553_tb of coverage_1553_tb is
   component TopModule
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
end component;

signal PIReset:std_logic:='1';
signal PIRTAP, PIBUSA, PIBUSB: std_logic;
signal PIClk, PIClk_HI6110 :std_logic:='0';
signal PIRTA: std_logic_vector(4 downto 0);
signal PIERR: std_logic_vector(8 downto 0);
signal PICMD: std_logic_vector(15 downto 0);
signal PIODATAWORD: word_vector(31 downto 0);
---command generator---
signal RTA: std_logic_vector(4 downto 0);
signal TR: std_logic;
signal Subaddr: std_logic_vector(4 downto 0);
signal DLC: std_logic_vector(4 downto 0);
---time variables---
constant sys_clock_period:time:= 20 ns;
constant sys_HI6110_period:time:= 10 ns;

begin

   top_module: TopModule
port map(
                 PIClk          => PIClk,
                 PIReset        => PIReset,
                 PIClk_HI6110   => PIClk_HI6110,
                 PIERR          => PIERR,
                 PIRTA          => PIRTA,
                 PIRTAP         => PIRTAP,
                 PICMD          => PICMD,
                 PIODATAWORD    => PIODATAWORD,
                 PIBUSA         => PIBUSA,
                 PIBUSB         => PIBUSB
);

PIClk <= not PIClk after sys_clock_period/2;
PIClk_HI6110 <= not PIClk_HI6110 after sys_HI6110_period;

PIReset <= '0' after 20 ns;
PIERR <= "000000000";
PIRTA <= "00011";
PIRTAP <= '1';

PICMD <= RTA & TR & Subaddr & DLC;

 bus_1553 : process
              begin		
               RTA <= "00011";
               TR <= '0';
               Subaddr <= "00011";
               DLC <= "00011";
               PIBUSA <= '1';
               PIODATAWORD <= (others=>x"DEAD"); 
               wait for 100 ns;
               PIBUSA <= '0';
               wait;
           end process;

end architecture_coverage_1553_tb;