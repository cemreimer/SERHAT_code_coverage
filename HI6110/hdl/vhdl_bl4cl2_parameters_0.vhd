------------------------------------------------------------------------------
-- Copyright (c) 2005-2007 Xilinx, Inc.
-- This design is confidential and proprietary of Xilinx, All Rights Reserved.
------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /   Vendor		    : Xilinx
-- \   \   \/    Version	    : $Name: mig_v2_0_b1 $
--  \   \        Application	    : MIG
--  /   /        Filename	    : vhdl_bl4cl2_parameters_0.vhd
-- /___/   /\    Date Last Modified : $Date: 2007/08/17 06:49:45 $
-- \   \  /  \   Date Created       : Mon May 2 2005
--  \___\/\___\
-- Device      : Spartan-3/3E/3A/3A-DSP
-- Design Name : DDR SDRAM
-- Purpose     : This module has the parameters used in the design.
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--library UNISIM;
--use UNISIM.VCOMPONENTS.all;

package vhdl_bl4cl2_parameters_0 is

constant   DATA_WIDTH                                : INTEGER   :=  16;
constant   DATA_STROBE_WIDTH                         : INTEGER   :=  2;
constant   DATA_MASK_WIDTH                           : INTEGER   :=  2;
constant   CLK_WIDTH                                 : INTEGER   :=  1;
constant   FIFO_16                                   : INTEGER   :=  1;
constant   ROW_ADDRESS                               : INTEGER   :=  13;
constant   MEMORY_WIDTH                              : INTEGER   :=  8;
constant   DATABITSPERREADCLOCK                      : INTEGER   :=  8;
constant   DATABITSPERMASK                           : INTEGER   :=  8;
constant   NO_OF_CS                                  : INTEGER   :=  1;
constant   DATA_MASK                                 : INTEGER   :=  1;
constant   MASK_DISABLE                              : INTEGER   :=  0;
constant   RESET_PORT                                : INTEGER   :=  0;
constant   CKE_WIDTH                                 : INTEGER   :=  1;
constant   REGISTERED                                : INTEGER   :=  0;
constant   COL_AP_WIDTH                              : INTEGER   :=  11;
constant   PARAM_WIDTH                               : INTEGER   :=  1;
constant   into2                                     : INTEGER   :=  2;
constant   WRITE_PIPE_ITR                            : INTEGER   :=  1;
constant   COLUMN_ADDRESS                            : INTEGER   :=  10;
constant   BANK_ADDRESS                              : INTEGER   :=  2;
constant   LOAD_MODE_REGISTER                        : std_logic_vector(12 downto 0) := "0000000100010";

constant   EXT_LOAD_MODE_REGISTER                    : std_logic_vector(12 downto 0) := "0000000000000";

constant   RESET_ACTIVE_LOW                          : std_logic := '0'; -- SPARTAN-3E STARTER KIT
constant   RFC_COUNT_VALUE                           : std_logic_vector(5 downto 0) := "001111";
constant   MAX_REF_WIDTH                             : INTEGER   :=  11;
constant   MAX_REF_CNT                               : std_logic_vector(10 downto 0) := "10000000001";

end vhdl_bl4cl2_parameters_0 ;
