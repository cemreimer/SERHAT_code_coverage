-- Version: v11.7 SP2 11.7.2.2

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity HI6110 is

    port( PIOWORD     : inout std_logic_vector(15 downto 0) := (others => 'Z');
          PIRegAddr   : in    std_logic_vector(3 downto 0);
          PIODATAWORD : in    std_logic_vector(511 downto 0);
          PICMD       : in    std_logic_vector(15 downto 0);
          PIRTA       : in    std_logic_vector(4 downto 0);
          PIERR       : in    std_logic_vector(8 downto 0);
          PISTR       : in    std_logic;
          PIRW        : in    std_logic;
          PICS        : in    std_logic;
          PICLK       : in    std_logic;
          PIBCSTART   : in    std_logic;
          PIMR        : in    std_logic;
          POERROR     : out   std_logic;
          POVALMESS   : out   std_logic;
          PIBUSA      : in    std_logic;
          PIBUSB      : in    std_logic;
          PORCVA      : out   std_logic;
          PORCVB      : out   std_logic;
          PIRTAP      : in    std_logic
        );

end HI6110;

architecture DEF_ARCH of HI6110 is 

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component INBUF
    generic (IOSTD:string := "");

    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component BIBUF
    generic (IOSTD:string := "");

    port( PAD : inout   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component OUTBUF
    generic (IOSTD:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal un1_pibusa_0_a2, un1_pibusb_0_a2, \SActA\, \SActB\, 
        \SPrevSTR\, \SPrevErrorTimerFlag\, \SCOMMWORD[0]_net_1\, 
        \SCTRL[6]_net_1\, \RXFIFOloaded\, VCC_net_1, GND_net_1, 
        \SErrorTimerFlag\, \H6110_states[5]_net_1\, 
        \H6110_states[3]_net_1\, \H6110_states[1]_net_1\, 
        \PIOWORD_cl[15]\, \PIOWORD_cl_31[15]\, 
        \H6110_states[6]_net_1\, RF0STAT_1, \SCOMMWORD[10]_net_1\, 
        RF1STAT_1, \RXFIFOcount[0]_net_1\, \RXFIFOcount[1]_net_1\, 
        \RXFIFOcount[2]_net_1\, \RXFIFOcount[3]_net_1\, 
        \RXFIFOcount[4]_net_1\, \SCOMMWORD[1]_net_1\, 
        \SCOMMWORD[2]_net_1\, \SCOMMWORD[3]_net_1\, 
        \SCOMMWORD[4]_net_1\, \SCOMMWORD[5]_net_1\, 
        \SCOMMWORD[6]_net_1\, \SCOMMWORD[7]_net_1\, 
        \SCOMMWORD[8]_net_1\, \SCOMMWORD[9]_net_1\, 
        \SCOMMWORD[11]_net_1\, \SCOMMWORD[12]_net_1\, 
        \SCOMMWORD[13]_net_1\, \SCOMMWORD[14]_net_1\, 
        \SCOMMWORD[15]_net_1\, \SErrorCounter[0]_net_1\, 
        \SErrorCounter[1]_net_1\, \SErrorCounter[2]_net_1\, 
        \SErrorCounter[3]_net_1\, \SErrorCounter[4]_net_1\, 
        \SErrorCounter[5]_net_1\, \SErrorCounter[6]_net_1\, 
        \SErrorCounter[7]_net_1\, \PIOWORD_1[0]_net_1\, 
        \PIOWORD_1[1]_net_1\, \PIOWORD_1[2]_net_1\, 
        \PIOWORD_1[3]_net_1\, \PIOWORD_1[4]_net_1\, 
        \PIOWORD_1[5]_net_1\, \PIOWORD_1[6]_net_1\, 
        \PIOWORD_1[7]_net_1\, \PIOWORD_1[8]_net_1\, 
        \PIOWORD_1[9]_net_1\, \PIOWORD_1[10]_net_1\, 
        \PIOWORD_1[11]_net_1\, \PIOWORD_1[12]_net_1\, 
        \PIOWORD_1[13]_net_1\, \PIOWORD_1[14]_net_1\, 
        \PIOWORD_1[15]_net_1\, SCTRL_1_sqmuxa, \SCTRL[0]_net_1\, 
        \SCTRL[1]_net_1\, \SCTRL[2]_net_1\, \SCTRL[3]_net_1\, 
        \SCTRL[4]_net_1\, \SCTRL[5]_net_1\, \SCTRL[7]_net_1\, 
        \SCTRL[8]_net_1\, \SCTRL[9]_net_1\, \SCTRL[10]_net_1\, 
        \SCTRL[11]_net_1\, \SCTRL[12]_net_1\, \SCTRL[13]_net_1\, 
        \SCTRL[14]_net_1\, \SCTRL[15]_net_1\, \SPRTYERR\, 
        RcvaSTAT_1_sqmuxa, \PIOWORD_cl_44[15]\, 
        \PIOWORD_cl_48[15]\, RcvaSTAT_3, RcvbSTAT_3, 
        \SRXFIFO_0[0]_net_1\, \SRXFIFO_1[0]_net_1\, 
        \SRXFIFO_2[0]_net_1\, \SRXFIFO_3[0]_net_1\, 
        \SRXFIFO_4[0]_net_1\, \SRXFIFO_5[0]_net_1\, 
        \SRXFIFO_6[0]_net_1\, \SRXFIFO_7[0]_net_1\, 
        \SRXFIFO_8[0]_net_1\, \SRXFIFO_9[0]_net_1\, 
        \SRXFIFO_10[0]_net_1\, \SRXFIFO_11[0]_net_1\, 
        \SRXFIFO_12[0]_net_1\, \SRXFIFO_13[0]_net_1\, 
        \SRXFIFO_14[0]_net_1\, \SRXFIFO_15[0]_net_1\, 
        \SRXFIFO_16[0]_net_1\, \SRXFIFO_17[0]_net_1\, 
        \SRXFIFO_18[0]_net_1\, \SRXFIFO_19[0]_net_1\, 
        \SRXFIFO_20[0]_net_1\, \SRXFIFO_21[0]_net_1\, 
        \SRXFIFO_22[0]_net_1\, \SRXFIFO_23[0]_net_1\, 
        \SRXFIFO_24[0]_net_1\, \SRXFIFO_25[0]_net_1\, 
        \SRXFIFO_26[0]_net_1\, \SRXFIFO_27[0]_net_1\, 
        \SRXFIFO_28[0]_net_1\, \SRXFIFO_29[0]_net_1\, 
        \SRXFIFO_30[0]_net_1\, \SRXFIFO_31[0]_net_1\, 
        \SRXFIFO_0[1]_net_1\, \SRXFIFO_0[2]_net_1\, 
        \SRXFIFO_0[3]_net_1\, \SRXFIFO_0[4]_net_1\, 
        \SRXFIFO_0[5]_net_1\, \SRXFIFO_0[6]_net_1\, 
        \SRXFIFO_0[7]_net_1\, \SRXFIFO_0[8]_net_1\, 
        \SRXFIFO_0[9]_net_1\, \SRXFIFO_0[10]_net_1\, 
        \SRXFIFO_0[11]_net_1\, \SRXFIFO_0[12]_net_1\, 
        \SRXFIFO_0[13]_net_1\, \SRXFIFO_0[14]_net_1\, 
        \SRXFIFO_0[15]_net_1\, \SRXFIFO_1[1]_net_1\, 
        \SRXFIFO_1[2]_net_1\, \SRXFIFO_1[3]_net_1\, 
        \SRXFIFO_1[4]_net_1\, \SRXFIFO_1[5]_net_1\, 
        \SRXFIFO_1[6]_net_1\, \SRXFIFO_1[7]_net_1\, 
        \SRXFIFO_1[8]_net_1\, \SRXFIFO_1[9]_net_1\, 
        \SRXFIFO_1[10]_net_1\, \SRXFIFO_1[11]_net_1\, 
        \SRXFIFO_1[12]_net_1\, \SRXFIFO_1[13]_net_1\, 
        \SRXFIFO_1[14]_net_1\, \SRXFIFO_1[15]_net_1\, 
        \SRXFIFO_2[1]_net_1\, \SRXFIFO_2[2]_net_1\, 
        \SRXFIFO_2[3]_net_1\, \SRXFIFO_2[4]_net_1\, 
        \SRXFIFO_2[5]_net_1\, \SRXFIFO_2[6]_net_1\, 
        \SRXFIFO_2[7]_net_1\, \SRXFIFO_2[8]_net_1\, 
        \SRXFIFO_2[9]_net_1\, \SRXFIFO_2[10]_net_1\, 
        \SRXFIFO_2[11]_net_1\, \SRXFIFO_2[12]_net_1\, 
        \SRXFIFO_2[13]_net_1\, \SRXFIFO_2[14]_net_1\, 
        \SRXFIFO_2[15]_net_1\, \SRXFIFO_3[1]_net_1\, 
        \SRXFIFO_3[2]_net_1\, \SRXFIFO_3[3]_net_1\, 
        \SRXFIFO_3[4]_net_1\, \SRXFIFO_3[5]_net_1\, 
        \SRXFIFO_3[6]_net_1\, \SRXFIFO_3[7]_net_1\, 
        \SRXFIFO_3[8]_net_1\, \SRXFIFO_3[9]_net_1\, 
        \SRXFIFO_3[10]_net_1\, \SRXFIFO_3[11]_net_1\, 
        \SRXFIFO_3[12]_net_1\, \SRXFIFO_3[13]_net_1\, 
        \SRXFIFO_3[14]_net_1\, \SRXFIFO_3[15]_net_1\, 
        \SRXFIFO_4[1]_net_1\, \SRXFIFO_4[2]_net_1\, 
        \SRXFIFO_4[3]_net_1\, \SRXFIFO_4[4]_net_1\, 
        \SRXFIFO_4[5]_net_1\, \SRXFIFO_4[6]_net_1\, 
        \SRXFIFO_4[7]_net_1\, \SRXFIFO_4[8]_net_1\, 
        \SRXFIFO_4[9]_net_1\, \SRXFIFO_4[10]_net_1\, 
        \SRXFIFO_4[11]_net_1\, \SRXFIFO_4[12]_net_1\, 
        \SRXFIFO_4[13]_net_1\, \SRXFIFO_4[14]_net_1\, 
        \SRXFIFO_4[15]_net_1\, \SRXFIFO_5[1]_net_1\, 
        \SRXFIFO_5[2]_net_1\, \SRXFIFO_5[3]_net_1\, 
        \SRXFIFO_5[4]_net_1\, \SRXFIFO_5[5]_net_1\, 
        \SRXFIFO_5[6]_net_1\, \SRXFIFO_5[7]_net_1\, 
        \SRXFIFO_5[8]_net_1\, \SRXFIFO_5[9]_net_1\, 
        \SRXFIFO_5[10]_net_1\, \SRXFIFO_5[11]_net_1\, 
        \SRXFIFO_5[12]_net_1\, \SRXFIFO_5[13]_net_1\, 
        \SRXFIFO_5[14]_net_1\, \SRXFIFO_5[15]_net_1\, 
        \SRXFIFO_6[1]_net_1\, \SRXFIFO_6[2]_net_1\, 
        \SRXFIFO_6[3]_net_1\, \SRXFIFO_6[4]_net_1\, 
        \SRXFIFO_6[5]_net_1\, \SRXFIFO_6[6]_net_1\, 
        \SRXFIFO_6[7]_net_1\, \SRXFIFO_6[8]_net_1\, 
        \SRXFIFO_6[9]_net_1\, \SRXFIFO_6[10]_net_1\, 
        \SRXFIFO_6[11]_net_1\, \SRXFIFO_6[12]_net_1\, 
        \SRXFIFO_6[13]_net_1\, \SRXFIFO_6[14]_net_1\, 
        \SRXFIFO_6[15]_net_1\, \SRXFIFO_7[1]_net_1\, 
        \SRXFIFO_7[2]_net_1\, \SRXFIFO_7[3]_net_1\, 
        \SRXFIFO_7[4]_net_1\, \SRXFIFO_7[5]_net_1\, 
        \SRXFIFO_7[6]_net_1\, \SRXFIFO_7[7]_net_1\, 
        \SRXFIFO_7[8]_net_1\, \SRXFIFO_7[9]_net_1\, 
        \SRXFIFO_7[10]_net_1\, \SRXFIFO_7[11]_net_1\, 
        \SRXFIFO_7[12]_net_1\, \SRXFIFO_7[13]_net_1\, 
        \SRXFIFO_7[14]_net_1\, \SRXFIFO_7[15]_net_1\, 
        \SRXFIFO_8[1]_net_1\, \SRXFIFO_8[2]_net_1\, 
        \SRXFIFO_8[3]_net_1\, \SRXFIFO_8[4]_net_1\, 
        \SRXFIFO_8[5]_net_1\, \SRXFIFO_8[6]_net_1\, 
        \SRXFIFO_8[7]_net_1\, \SRXFIFO_8[8]_net_1\, 
        \SRXFIFO_8[9]_net_1\, \SRXFIFO_8[10]_net_1\, 
        \SRXFIFO_8[11]_net_1\, \SRXFIFO_8[12]_net_1\, 
        \SRXFIFO_8[13]_net_1\, \SRXFIFO_8[14]_net_1\, 
        \SRXFIFO_8[15]_net_1\, \SRXFIFO_9[1]_net_1\, 
        \SRXFIFO_9[2]_net_1\, \SRXFIFO_9[3]_net_1\, 
        \SRXFIFO_9[4]_net_1\, \SRXFIFO_9[5]_net_1\, 
        \SRXFIFO_9[6]_net_1\, \SRXFIFO_9[7]_net_1\, 
        \SRXFIFO_9[8]_net_1\, \SRXFIFO_9[9]_net_1\, 
        \SRXFIFO_9[10]_net_1\, \SRXFIFO_9[11]_net_1\, 
        \SRXFIFO_9[12]_net_1\, \SRXFIFO_9[13]_net_1\, 
        \SRXFIFO_9[14]_net_1\, \SRXFIFO_9[15]_net_1\, 
        \SRXFIFO_10[1]_net_1\, \SRXFIFO_10[2]_net_1\, 
        \SRXFIFO_10[3]_net_1\, \SRXFIFO_10[4]_net_1\, 
        \SRXFIFO_10[5]_net_1\, \SRXFIFO_10[6]_net_1\, 
        \SRXFIFO_10[7]_net_1\, \SRXFIFO_10[8]_net_1\, 
        \SRXFIFO_10[9]_net_1\, \SRXFIFO_10[10]_net_1\, 
        \SRXFIFO_10[11]_net_1\, \SRXFIFO_10[12]_net_1\, 
        \SRXFIFO_10[13]_net_1\, \SRXFIFO_10[14]_net_1\, 
        \SRXFIFO_10[15]_net_1\, \SRXFIFO_11[1]_net_1\, 
        \SRXFIFO_11[2]_net_1\, \SRXFIFO_11[3]_net_1\, 
        \SRXFIFO_11[4]_net_1\, \SRXFIFO_11[5]_net_1\, 
        \SRXFIFO_11[6]_net_1\, \SRXFIFO_11[7]_net_1\, 
        \SRXFIFO_11[8]_net_1\, \SRXFIFO_11[9]_net_1\, 
        \SRXFIFO_11[10]_net_1\, \SRXFIFO_11[11]_net_1\, 
        \SRXFIFO_11[12]_net_1\, \SRXFIFO_11[13]_net_1\, 
        \SRXFIFO_11[14]_net_1\, \SRXFIFO_11[15]_net_1\, 
        \SRXFIFO_12[1]_net_1\, \SRXFIFO_12[2]_net_1\, 
        \SRXFIFO_12[3]_net_1\, \SRXFIFO_12[4]_net_1\, 
        \SRXFIFO_12[5]_net_1\, \SRXFIFO_12[6]_net_1\, 
        \SRXFIFO_12[7]_net_1\, \SRXFIFO_12[8]_net_1\, 
        \SRXFIFO_12[9]_net_1\, \SRXFIFO_12[10]_net_1\, 
        \SRXFIFO_12[11]_net_1\, \SRXFIFO_12[12]_net_1\, 
        \SRXFIFO_12[13]_net_1\, \SRXFIFO_12[14]_net_1\, 
        \SRXFIFO_12[15]_net_1\, \SRXFIFO_13[1]_net_1\, 
        \SRXFIFO_13[2]_net_1\, \SRXFIFO_13[3]_net_1\, 
        \SRXFIFO_13[4]_net_1\, \SRXFIFO_13[5]_net_1\, 
        \SRXFIFO_13[6]_net_1\, \SRXFIFO_13[7]_net_1\, 
        \SRXFIFO_13[8]_net_1\, \SRXFIFO_13[9]_net_1\, 
        \SRXFIFO_13[10]_net_1\, \SRXFIFO_13[11]_net_1\, 
        \SRXFIFO_13[12]_net_1\, \SRXFIFO_13[13]_net_1\, 
        \SRXFIFO_13[14]_net_1\, \SRXFIFO_13[15]_net_1\, 
        \SRXFIFO_14[1]_net_1\, \SRXFIFO_14[2]_net_1\, 
        \SRXFIFO_14[3]_net_1\, \SRXFIFO_14[4]_net_1\, 
        \SRXFIFO_14[5]_net_1\, \SRXFIFO_14[6]_net_1\, 
        \SRXFIFO_14[7]_net_1\, \SRXFIFO_14[8]_net_1\, 
        \SRXFIFO_14[9]_net_1\, \SRXFIFO_14[10]_net_1\, 
        \SRXFIFO_14[11]_net_1\, \SRXFIFO_14[12]_net_1\, 
        \SRXFIFO_14[13]_net_1\, \SRXFIFO_14[14]_net_1\, 
        \SRXFIFO_14[15]_net_1\, \SRXFIFO_15[1]_net_1\, 
        \SRXFIFO_15[2]_net_1\, \SRXFIFO_15[3]_net_1\, 
        \SRXFIFO_15[4]_net_1\, \SRXFIFO_15[5]_net_1\, 
        \SRXFIFO_15[6]_net_1\, \SRXFIFO_15[7]_net_1\, 
        \SRXFIFO_15[8]_net_1\, \SRXFIFO_15[9]_net_1\, 
        \SRXFIFO_15[10]_net_1\, \SRXFIFO_15[11]_net_1\, 
        \SRXFIFO_15[12]_net_1\, \SRXFIFO_15[13]_net_1\, 
        \SRXFIFO_15[14]_net_1\, \SRXFIFO_15[15]_net_1\, 
        \SRXFIFO_16[1]_net_1\, \SRXFIFO_16[2]_net_1\, 
        \SRXFIFO_16[3]_net_1\, \SRXFIFO_16[4]_net_1\, 
        \SRXFIFO_16[5]_net_1\, \SRXFIFO_16[6]_net_1\, 
        \SRXFIFO_16[7]_net_1\, \SRXFIFO_16[8]_net_1\, 
        \SRXFIFO_16[9]_net_1\, \SRXFIFO_16[10]_net_1\, 
        \SRXFIFO_16[11]_net_1\, \SRXFIFO_16[12]_net_1\, 
        \SRXFIFO_16[13]_net_1\, \SRXFIFO_16[14]_net_1\, 
        \SRXFIFO_16[15]_net_1\, \SRXFIFO_17[1]_net_1\, 
        \SRXFIFO_17[2]_net_1\, \SRXFIFO_17[3]_net_1\, 
        \SRXFIFO_17[4]_net_1\, \SRXFIFO_17[5]_net_1\, 
        \SRXFIFO_17[6]_net_1\, \SRXFIFO_17[7]_net_1\, 
        \SRXFIFO_17[8]_net_1\, \SRXFIFO_17[9]_net_1\, 
        \SRXFIFO_17[10]_net_1\, \SRXFIFO_17[11]_net_1\, 
        \SRXFIFO_17[12]_net_1\, \SRXFIFO_17[13]_net_1\, 
        \SRXFIFO_17[14]_net_1\, \SRXFIFO_17[15]_net_1\, 
        \SRXFIFO_18[1]_net_1\, \SRXFIFO_18[2]_net_1\, 
        \SRXFIFO_18[3]_net_1\, \SRXFIFO_18[4]_net_1\, 
        \SRXFIFO_18[5]_net_1\, \SRXFIFO_18[6]_net_1\, 
        \SRXFIFO_18[7]_net_1\, \SRXFIFO_18[8]_net_1\, 
        \SRXFIFO_18[9]_net_1\, \SRXFIFO_18[10]_net_1\, 
        \SRXFIFO_18[11]_net_1\, \SRXFIFO_18[12]_net_1\, 
        \SRXFIFO_18[13]_net_1\, \SRXFIFO_18[14]_net_1\, 
        \SRXFIFO_18[15]_net_1\, \SRXFIFO_19[1]_net_1\, 
        \SRXFIFO_19[2]_net_1\, \SRXFIFO_19[3]_net_1\, 
        \SRXFIFO_19[4]_net_1\, \SRXFIFO_19[5]_net_1\, 
        \SRXFIFO_19[6]_net_1\, \SRXFIFO_19[7]_net_1\, 
        \SRXFIFO_19[8]_net_1\, \SRXFIFO_19[9]_net_1\, 
        \SRXFIFO_19[10]_net_1\, \SRXFIFO_19[11]_net_1\, 
        \SRXFIFO_19[12]_net_1\, \SRXFIFO_19[13]_net_1\, 
        \SRXFIFO_19[14]_net_1\, \SRXFIFO_19[15]_net_1\, 
        \SRXFIFO_20[1]_net_1\, \SRXFIFO_20[2]_net_1\, 
        \SRXFIFO_20[3]_net_1\, \SRXFIFO_20[4]_net_1\, 
        \SRXFIFO_20[5]_net_1\, \SRXFIFO_20[6]_net_1\, 
        \SRXFIFO_20[7]_net_1\, \SRXFIFO_20[8]_net_1\, 
        \SRXFIFO_20[9]_net_1\, \SRXFIFO_20[10]_net_1\, 
        \SRXFIFO_20[11]_net_1\, \SRXFIFO_20[12]_net_1\, 
        \SRXFIFO_20[13]_net_1\, \SRXFIFO_20[14]_net_1\, 
        \SRXFIFO_20[15]_net_1\, \SRXFIFO_21[1]_net_1\, 
        \SRXFIFO_21[2]_net_1\, \SRXFIFO_21[3]_net_1\, 
        \SRXFIFO_21[4]_net_1\, \SRXFIFO_21[5]_net_1\, 
        \SRXFIFO_21[6]_net_1\, \SRXFIFO_21[7]_net_1\, 
        \SRXFIFO_21[8]_net_1\, \SRXFIFO_21[9]_net_1\, 
        \SRXFIFO_21[10]_net_1\, \SRXFIFO_21[11]_net_1\, 
        \SRXFIFO_21[12]_net_1\, \SRXFIFO_21[13]_net_1\, 
        \SRXFIFO_21[14]_net_1\, \SRXFIFO_21[15]_net_1\, 
        \SRXFIFO_22[1]_net_1\, \SRXFIFO_22[2]_net_1\, 
        \SRXFIFO_22[3]_net_1\, \SRXFIFO_22[4]_net_1\, 
        \SRXFIFO_22[5]_net_1\, \SRXFIFO_22[6]_net_1\, 
        \SRXFIFO_22[7]_net_1\, \SRXFIFO_22[8]_net_1\, 
        \SRXFIFO_22[9]_net_1\, \SRXFIFO_22[10]_net_1\, 
        \SRXFIFO_22[11]_net_1\, \SRXFIFO_22[12]_net_1\, 
        \SRXFIFO_22[13]_net_1\, \SRXFIFO_22[14]_net_1\, 
        \SRXFIFO_22[15]_net_1\, \SRXFIFO_23[1]_net_1\, 
        \SRXFIFO_23[2]_net_1\, \SRXFIFO_23[3]_net_1\, 
        \SRXFIFO_23[4]_net_1\, \SRXFIFO_23[5]_net_1\, 
        \SRXFIFO_23[6]_net_1\, \SRXFIFO_23[7]_net_1\, 
        \SRXFIFO_23[8]_net_1\, \SRXFIFO_23[9]_net_1\, 
        \SRXFIFO_23[10]_net_1\, \SRXFIFO_23[11]_net_1\, 
        \SRXFIFO_23[12]_net_1\, \SRXFIFO_23[13]_net_1\, 
        \SRXFIFO_23[14]_net_1\, \SRXFIFO_23[15]_net_1\, 
        \SRXFIFO_24[1]_net_1\, \SRXFIFO_24[2]_net_1\, 
        \SRXFIFO_24[3]_net_1\, \SRXFIFO_24[4]_net_1\, 
        \SRXFIFO_24[5]_net_1\, \SRXFIFO_24[6]_net_1\, 
        \SRXFIFO_24[7]_net_1\, \SRXFIFO_24[8]_net_1\, 
        \SRXFIFO_24[9]_net_1\, \SRXFIFO_24[10]_net_1\, 
        \SRXFIFO_24[11]_net_1\, \SRXFIFO_24[12]_net_1\, 
        \SRXFIFO_24[13]_net_1\, \SRXFIFO_24[14]_net_1\, 
        \SRXFIFO_24[15]_net_1\, \SRXFIFO_25[1]_net_1\, 
        \SRXFIFO_25[2]_net_1\, \SRXFIFO_25[3]_net_1\, 
        \SRXFIFO_25[4]_net_1\, \SRXFIFO_25[5]_net_1\, 
        \SRXFIFO_25[6]_net_1\, \SRXFIFO_25[7]_net_1\, 
        \SRXFIFO_25[8]_net_1\, \SRXFIFO_25[9]_net_1\, 
        \SRXFIFO_25[10]_net_1\, \SRXFIFO_25[11]_net_1\, 
        \SRXFIFO_25[12]_net_1\, \SRXFIFO_25[13]_net_1\, 
        \SRXFIFO_25[14]_net_1\, \SRXFIFO_25[15]_net_1\, 
        \SRXFIFO_26[1]_net_1\, \SRXFIFO_26[2]_net_1\, 
        \SRXFIFO_26[3]_net_1\, \SRXFIFO_26[4]_net_1\, 
        \SRXFIFO_26[5]_net_1\, \SRXFIFO_26[6]_net_1\, 
        \SRXFIFO_26[7]_net_1\, \SRXFIFO_26[8]_net_1\, 
        \SRXFIFO_26[9]_net_1\, \SRXFIFO_26[10]_net_1\, 
        \SRXFIFO_26[11]_net_1\, \SRXFIFO_26[12]_net_1\, 
        \SRXFIFO_26[13]_net_1\, \SRXFIFO_26[14]_net_1\, 
        \SRXFIFO_26[15]_net_1\, \SRXFIFO_27[1]_net_1\, 
        \SRXFIFO_27[2]_net_1\, \SRXFIFO_27[3]_net_1\, 
        \SRXFIFO_27[4]_net_1\, \SRXFIFO_27[5]_net_1\, 
        \SRXFIFO_27[6]_net_1\, \SRXFIFO_27[7]_net_1\, 
        \SRXFIFO_27[8]_net_1\, \SRXFIFO_27[9]_net_1\, 
        \SRXFIFO_27[10]_net_1\, \SRXFIFO_27[11]_net_1\, 
        \SRXFIFO_27[12]_net_1\, \SRXFIFO_27[13]_net_1\, 
        \SRXFIFO_27[14]_net_1\, \SRXFIFO_27[15]_net_1\, 
        \SRXFIFO_28[1]_net_1\, \SRXFIFO_28[2]_net_1\, 
        \SRXFIFO_28[3]_net_1\, \SRXFIFO_28[4]_net_1\, 
        \SRXFIFO_28[5]_net_1\, \SRXFIFO_28[6]_net_1\, 
        \SRXFIFO_28[7]_net_1\, \SRXFIFO_28[8]_net_1\, 
        \SRXFIFO_28[9]_net_1\, \SRXFIFO_28[10]_net_1\, 
        \SRXFIFO_28[11]_net_1\, \SRXFIFO_28[12]_net_1\, 
        \SRXFIFO_28[13]_net_1\, \SRXFIFO_28[14]_net_1\, 
        \SRXFIFO_28[15]_net_1\, \SRXFIFO_29[1]_net_1\, 
        \SRXFIFO_29[2]_net_1\, \SRXFIFO_29[3]_net_1\, 
        \SRXFIFO_29[4]_net_1\, \SRXFIFO_29[5]_net_1\, 
        \SRXFIFO_29[6]_net_1\, \SRXFIFO_29[7]_net_1\, 
        \SRXFIFO_29[8]_net_1\, \SRXFIFO_29[9]_net_1\, 
        \SRXFIFO_29[10]_net_1\, \SRXFIFO_29[11]_net_1\, 
        \SRXFIFO_29[12]_net_1\, \SRXFIFO_29[13]_net_1\, 
        \SRXFIFO_29[14]_net_1\, \SRXFIFO_29[15]_net_1\, 
        \SRXFIFO_30[1]_net_1\, \SRXFIFO_30[2]_net_1\, 
        \SRXFIFO_30[3]_net_1\, \SRXFIFO_30[4]_net_1\, 
        \SRXFIFO_30[5]_net_1\, \SRXFIFO_30[6]_net_1\, 
        \SRXFIFO_30[7]_net_1\, \SRXFIFO_30[8]_net_1\, 
        \SRXFIFO_30[9]_net_1\, \SRXFIFO_30[10]_net_1\, 
        \SRXFIFO_30[11]_net_1\, \SRXFIFO_30[12]_net_1\, 
        \SRXFIFO_30[13]_net_1\, \SRXFIFO_30[14]_net_1\, 
        \SRXFIFO_30[15]_net_1\, \SRXFIFO_31[1]_net_1\, 
        \SRXFIFO_31[2]_net_1\, \SRXFIFO_31[3]_net_1\, 
        \SRXFIFO_31[4]_net_1\, \SRXFIFO_31[5]_net_1\, 
        \SRXFIFO_31[6]_net_1\, \SRXFIFO_31[7]_net_1\, 
        \SRXFIFO_31[8]_net_1\, \SRXFIFO_31[9]_net_1\, 
        \SRXFIFO_31[10]_net_1\, \SRXFIFO_31[11]_net_1\, 
        \SRXFIFO_31[12]_net_1\, \SRXFIFO_31[13]_net_1\, 
        \SRXFIFO_31[14]_net_1\, \SRXFIFO_31[15]_net_1\, 
        SRXMODEDATAWORD_1_sqmuxa, \H6110_states[4]_net_1\, 
        sprtycheck, SBUSAWORD_0_sqmuxa, SBUSBWORD_1_sqmuxa, 
        SRXFIFO_0_0_sqmuxa, \H6110_states[2]_net_1\, 
        \H6110_states[0]_net_1\, \IdleSTAT\, \RF0STAT\, \RF1STAT\, 
        \SRXMODEDATAWORD[0]_net_1\, \SBUSAWORD[0]_net_1\, 
        \SBUSBWORD[0]_net_1\, \SRXMODEDATAWORD[1]_net_1\, 
        \SBUSAWORD[1]_net_1\, \SBUSBWORD[1]_net_1\, 
        \SRXMODEDATAWORD[2]_net_1\, \SBUSAWORD[2]_net_1\, 
        \SBUSBWORD[2]_net_1\, \SRXMODEDATAWORD[3]_net_1\, 
        \FfemptySTAT\, \SBUSAWORD[3]_net_1\, \SBUSBWORD[3]_net_1\, 
        \SRXMODEDATAWORD[4]_net_1\, \SBUSAWORD[4]_net_1\, 
        \SBUSBWORD[4]_net_1\, \SRXMODEDATAWORD[5]_net_1\, 
        \SBUSAWORD[5]_net_1\, \SBUSBWORD[5]_net_1\, 
        \SRXMODEDATAWORD[6]_net_1\, \SBUSAWORD[6]_net_1\, 
        \SBUSBWORD[6]_net_1\, \SRXMODEDATAWORD[7]_net_1\, 
        \SBUSAWORD[7]_net_1\, \SBUSBWORD[7]_net_1\, 
        \SRXMODEDATAWORD[8]_net_1\, \SBUSAWORD[8]_net_1\, 
        \SBUSBWORD[8]_net_1\, \SRXMODEDATAWORD[9]_net_1\, 
        \SBUSAWORD[9]_net_1\, \SBUSBWORD[9]_net_1\, 
        \SRXMODEDATAWORD[10]_net_1\, \SBUSAWORD[10]_net_1\, 
        \SBUSBWORD[10]_net_1\, \SRXMODEDATAWORD[11]_net_1\, 
        \SBUSAWORD[11]_net_1\, \SBUSBWORD[11]_net_1\, 
        \SRXMODEDATAWORD[12]_net_1\, \SBUSAWORD[12]_net_1\, 
        \SBUSBWORD[12]_net_1\, \SRXMODEDATAWORD[13]_net_1\, 
        \SBUSAWORD[13]_net_1\, \SBUSBWORD[13]_net_1\, 
        \SRXMODEDATAWORD[14]_net_1\, \SBUSAWORD[14]_net_1\, 
        \SBUSBWORD[14]_net_1\, \SRXMODEDATAWORD[15]_net_1\, 
        \SBUSAWORD[15]_net_1\, \SBUSBWORD[15]_net_1\, 
        \SRXMODEDATAWORD_1[0]\, \SRXMODEDATAWORD_1[1]\, 
        \SRXMODEDATAWORD_1[2]\, \SRXMODEDATAWORD_1[3]\, 
        \SRXMODEDATAWORD_1[4]\, \SRXMODEDATAWORD_1[5]\, 
        \SRXMODEDATAWORD_1[6]\, \SRXMODEDATAWORD_1[7]\, 
        \SRXMODEDATAWORD_1[8]\, \SRXMODEDATAWORD_1[9]\, 
        \SRXMODEDATAWORD_1[10]\, \SRXMODEDATAWORD_1[11]\, 
        \SRXMODEDATAWORD_1[12]\, \SRXMODEDATAWORD_1[13]\, 
        \SRXMODEDATAWORD_1[14]\, \SRXMODEDATAWORD_1[15]\, 
        \error_states[0]_net_1\, \error_states[1]_net_1\, 
        RXFIFOcounte, \error_states_ns[0]\, \H6110_states_ns[1]\, 
        \H6110_states_ns[5]\, \H6110_states_ns[4]\, 
        \un1_SCOMMWORD_u[15]\, \un1_SCOMMWORD_1_RNITM6R1[4]\, 
        \un1_SCOMMWORD_u_0[9]\, \un1_SCOMMWORD_u[10]\, 
        \un1_SCOMMWORD_u_0[13]\, \un1_SCOMMWORD_u_0[14]\, N_84, 
        N_85, N_90, N_100, N_210, N_211, N_213, N_214, N_61, 
        PISTR_c, PIRW_c, PICS_c, \PIRegAddr_c[0]\, 
        \PIRegAddr_c[1]\, \PIRegAddr_c[2]\, \PIRegAddr_c[3]\, 
        PICLK_c, PIMR_c, PIBUSA_c, PIBUSB_c, \PIODATAWORD_c[0]\, 
        \PIODATAWORD_c[1]\, \PIODATAWORD_c[2]\, 
        \PIODATAWORD_c[3]\, \PIODATAWORD_c[4]\, 
        \PIODATAWORD_c[5]\, \PIODATAWORD_c[6]\, 
        \PIODATAWORD_c[7]\, \PIODATAWORD_c[8]\, 
        \PIODATAWORD_c[9]\, \PIODATAWORD_c[10]\, 
        \PIODATAWORD_c[11]\, \PIODATAWORD_c[12]\, 
        \PIODATAWORD_c[13]\, \PIODATAWORD_c[14]\, 
        \PIODATAWORD_c[15]\, \PIODATAWORD_c[16]\, 
        \PIODATAWORD_c[17]\, \PIODATAWORD_c[18]\, 
        \PIODATAWORD_c[19]\, \PIODATAWORD_c[20]\, 
        \PIODATAWORD_c[21]\, \PIODATAWORD_c[22]\, 
        \PIODATAWORD_c[23]\, \PIODATAWORD_c[24]\, 
        \PIODATAWORD_c[25]\, \PIODATAWORD_c[26]\, 
        \PIODATAWORD_c[27]\, \PIODATAWORD_c[28]\, 
        \PIODATAWORD_c[29]\, \PIODATAWORD_c[30]\, 
        \PIODATAWORD_c[31]\, \PIODATAWORD_c[32]\, 
        \PIODATAWORD_c[33]\, \PIODATAWORD_c[34]\, 
        \PIODATAWORD_c[35]\, \PIODATAWORD_c[36]\, 
        \PIODATAWORD_c[37]\, \PIODATAWORD_c[38]\, 
        \PIODATAWORD_c[39]\, \PIODATAWORD_c[40]\, 
        \PIODATAWORD_c[41]\, \PIODATAWORD_c[42]\, 
        \PIODATAWORD_c[43]\, \PIODATAWORD_c[44]\, 
        \PIODATAWORD_c[45]\, \PIODATAWORD_c[46]\, 
        \PIODATAWORD_c[47]\, \PIODATAWORD_c[48]\, 
        \PIODATAWORD_c[49]\, \PIODATAWORD_c[50]\, 
        \PIODATAWORD_c[51]\, \PIODATAWORD_c[52]\, 
        \PIODATAWORD_c[53]\, \PIODATAWORD_c[54]\, 
        \PIODATAWORD_c[55]\, \PIODATAWORD_c[56]\, 
        \PIODATAWORD_c[57]\, \PIODATAWORD_c[58]\, 
        \PIODATAWORD_c[59]\, \PIODATAWORD_c[60]\, 
        \PIODATAWORD_c[61]\, \PIODATAWORD_c[62]\, 
        \PIODATAWORD_c[63]\, \PIODATAWORD_c[64]\, 
        \PIODATAWORD_c[65]\, \PIODATAWORD_c[66]\, 
        \PIODATAWORD_c[67]\, \PIODATAWORD_c[68]\, 
        \PIODATAWORD_c[69]\, \PIODATAWORD_c[70]\, 
        \PIODATAWORD_c[71]\, \PIODATAWORD_c[72]\, 
        \PIODATAWORD_c[73]\, \PIODATAWORD_c[74]\, 
        \PIODATAWORD_c[75]\, \PIODATAWORD_c[76]\, 
        \PIODATAWORD_c[77]\, \PIODATAWORD_c[78]\, 
        \PIODATAWORD_c[79]\, \PIODATAWORD_c[80]\, 
        \PIODATAWORD_c[81]\, \PIODATAWORD_c[82]\, 
        \PIODATAWORD_c[83]\, \PIODATAWORD_c[84]\, 
        \PIODATAWORD_c[85]\, \PIODATAWORD_c[86]\, 
        \PIODATAWORD_c[87]\, \PIODATAWORD_c[88]\, 
        \PIODATAWORD_c[89]\, \PIODATAWORD_c[90]\, 
        \PIODATAWORD_c[91]\, \PIODATAWORD_c[92]\, 
        \PIODATAWORD_c[93]\, \PIODATAWORD_c[94]\, 
        \PIODATAWORD_c[95]\, \PIODATAWORD_c[96]\, 
        \PIODATAWORD_c[97]\, \PIODATAWORD_c[98]\, 
        \PIODATAWORD_c[99]\, \PIODATAWORD_c[100]\, 
        \PIODATAWORD_c[101]\, \PIODATAWORD_c[102]\, 
        \PIODATAWORD_c[103]\, \PIODATAWORD_c[104]\, 
        \PIODATAWORD_c[105]\, \PIODATAWORD_c[106]\, 
        \PIODATAWORD_c[107]\, \PIODATAWORD_c[108]\, 
        \PIODATAWORD_c[109]\, \PIODATAWORD_c[110]\, 
        \PIODATAWORD_c[111]\, \PIODATAWORD_c[112]\, 
        \PIODATAWORD_c[113]\, \PIODATAWORD_c[114]\, 
        \PIODATAWORD_c[115]\, \PIODATAWORD_c[116]\, 
        \PIODATAWORD_c[117]\, \PIODATAWORD_c[118]\, 
        \PIODATAWORD_c[119]\, \PIODATAWORD_c[120]\, 
        \PIODATAWORD_c[121]\, \PIODATAWORD_c[122]\, 
        \PIODATAWORD_c[123]\, \PIODATAWORD_c[124]\, 
        \PIODATAWORD_c[125]\, \PIODATAWORD_c[126]\, 
        \PIODATAWORD_c[127]\, \PIODATAWORD_c[128]\, 
        \PIODATAWORD_c[129]\, \PIODATAWORD_c[130]\, 
        \PIODATAWORD_c[131]\, \PIODATAWORD_c[132]\, 
        \PIODATAWORD_c[133]\, \PIODATAWORD_c[134]\, 
        \PIODATAWORD_c[135]\, \PIODATAWORD_c[136]\, 
        \PIODATAWORD_c[137]\, \PIODATAWORD_c[138]\, 
        \PIODATAWORD_c[139]\, \PIODATAWORD_c[140]\, 
        \PIODATAWORD_c[141]\, \PIODATAWORD_c[142]\, 
        \PIODATAWORD_c[143]\, \PIODATAWORD_c[144]\, 
        \PIODATAWORD_c[145]\, \PIODATAWORD_c[146]\, 
        \PIODATAWORD_c[147]\, \PIODATAWORD_c[148]\, 
        \PIODATAWORD_c[149]\, \PIODATAWORD_c[150]\, 
        \PIODATAWORD_c[151]\, \PIODATAWORD_c[152]\, 
        \PIODATAWORD_c[153]\, \PIODATAWORD_c[154]\, 
        \PIODATAWORD_c[155]\, \PIODATAWORD_c[156]\, 
        \PIODATAWORD_c[157]\, \PIODATAWORD_c[158]\, 
        \PIODATAWORD_c[159]\, \PIODATAWORD_c[160]\, 
        \PIODATAWORD_c[161]\, \PIODATAWORD_c[162]\, 
        \PIODATAWORD_c[163]\, \PIODATAWORD_c[164]\, 
        \PIODATAWORD_c[165]\, \PIODATAWORD_c[166]\, 
        \PIODATAWORD_c[167]\, \PIODATAWORD_c[168]\, 
        \PIODATAWORD_c[169]\, \PIODATAWORD_c[170]\, 
        \PIODATAWORD_c[171]\, \PIODATAWORD_c[172]\, 
        \PIODATAWORD_c[173]\, \PIODATAWORD_c[174]\, 
        \PIODATAWORD_c[175]\, \PIODATAWORD_c[176]\, 
        \PIODATAWORD_c[177]\, \PIODATAWORD_c[178]\, 
        \PIODATAWORD_c[179]\, \PIODATAWORD_c[180]\, 
        \PIODATAWORD_c[181]\, \PIODATAWORD_c[182]\, 
        \PIODATAWORD_c[183]\, \PIODATAWORD_c[184]\, 
        \PIODATAWORD_c[185]\, \PIODATAWORD_c[186]\, 
        \PIODATAWORD_c[187]\, \PIODATAWORD_c[188]\, 
        \PIODATAWORD_c[189]\, \PIODATAWORD_c[190]\, 
        \PIODATAWORD_c[191]\, \PIODATAWORD_c[192]\, 
        \PIODATAWORD_c[193]\, \PIODATAWORD_c[194]\, 
        \PIODATAWORD_c[195]\, \PIODATAWORD_c[196]\, 
        \PIODATAWORD_c[197]\, \PIODATAWORD_c[198]\, 
        \PIODATAWORD_c[199]\, \PIODATAWORD_c[200]\, 
        \PIODATAWORD_c[201]\, \PIODATAWORD_c[202]\, 
        \PIODATAWORD_c[203]\, \PIODATAWORD_c[204]\, 
        \PIODATAWORD_c[205]\, \PIODATAWORD_c[206]\, 
        \PIODATAWORD_c[207]\, \PIODATAWORD_c[208]\, 
        \PIODATAWORD_c[209]\, \PIODATAWORD_c[210]\, 
        \PIODATAWORD_c[211]\, \PIODATAWORD_c[212]\, 
        \PIODATAWORD_c[213]\, \PIODATAWORD_c[214]\, 
        \PIODATAWORD_c[215]\, \PIODATAWORD_c[216]\, 
        \PIODATAWORD_c[217]\, \PIODATAWORD_c[218]\, 
        \PIODATAWORD_c[219]\, \PIODATAWORD_c[220]\, 
        \PIODATAWORD_c[221]\, \PIODATAWORD_c[222]\, 
        \PIODATAWORD_c[223]\, \PIODATAWORD_c[224]\, 
        \PIODATAWORD_c[225]\, \PIODATAWORD_c[226]\, 
        \PIODATAWORD_c[227]\, \PIODATAWORD_c[228]\, 
        \PIODATAWORD_c[229]\, \PIODATAWORD_c[230]\, 
        \PIODATAWORD_c[231]\, \PIODATAWORD_c[232]\, 
        \PIODATAWORD_c[233]\, \PIODATAWORD_c[234]\, 
        \PIODATAWORD_c[235]\, \PIODATAWORD_c[236]\, 
        \PIODATAWORD_c[237]\, \PIODATAWORD_c[238]\, 
        \PIODATAWORD_c[239]\, \PIODATAWORD_c[240]\, 
        \PIODATAWORD_c[241]\, \PIODATAWORD_c[242]\, 
        \PIODATAWORD_c[243]\, \PIODATAWORD_c[244]\, 
        \PIODATAWORD_c[245]\, \PIODATAWORD_c[246]\, 
        \PIODATAWORD_c[247]\, \PIODATAWORD_c[248]\, 
        \PIODATAWORD_c[249]\, \PIODATAWORD_c[250]\, 
        \PIODATAWORD_c[251]\, \PIODATAWORD_c[252]\, 
        \PIODATAWORD_c[253]\, \PIODATAWORD_c[254]\, 
        \PIODATAWORD_c[255]\, \PIODATAWORD_c[256]\, 
        \PIODATAWORD_c[257]\, \PIODATAWORD_c[258]\, 
        \PIODATAWORD_c[259]\, \PIODATAWORD_c[260]\, 
        \PIODATAWORD_c[261]\, \PIODATAWORD_c[262]\, 
        \PIODATAWORD_c[263]\, \PIODATAWORD_c[264]\, 
        \PIODATAWORD_c[265]\, \PIODATAWORD_c[266]\, 
        \PIODATAWORD_c[267]\, \PIODATAWORD_c[268]\, 
        \PIODATAWORD_c[269]\, \PIODATAWORD_c[270]\, 
        \PIODATAWORD_c[271]\, \PIODATAWORD_c[272]\, 
        \PIODATAWORD_c[273]\, \PIODATAWORD_c[274]\, 
        \PIODATAWORD_c[275]\, \PIODATAWORD_c[276]\, 
        \PIODATAWORD_c[277]\, \PIODATAWORD_c[278]\, 
        \PIODATAWORD_c[279]\, \PIODATAWORD_c[280]\, 
        \PIODATAWORD_c[281]\, \PIODATAWORD_c[282]\, 
        \PIODATAWORD_c[283]\, \PIODATAWORD_c[284]\, 
        \PIODATAWORD_c[285]\, \PIODATAWORD_c[286]\, 
        \PIODATAWORD_c[287]\, \PIODATAWORD_c[288]\, 
        \PIODATAWORD_c[289]\, \PIODATAWORD_c[290]\, 
        \PIODATAWORD_c[291]\, \PIODATAWORD_c[292]\, 
        \PIODATAWORD_c[293]\, \PIODATAWORD_c[294]\, 
        \PIODATAWORD_c[295]\, \PIODATAWORD_c[296]\, 
        \PIODATAWORD_c[297]\, \PIODATAWORD_c[298]\, 
        \PIODATAWORD_c[299]\, \PIODATAWORD_c[300]\, 
        \PIODATAWORD_c[301]\, \PIODATAWORD_c[302]\, 
        \PIODATAWORD_c[303]\, \PIODATAWORD_c[304]\, 
        \PIODATAWORD_c[305]\, \PIODATAWORD_c[306]\, 
        \PIODATAWORD_c[307]\, \PIODATAWORD_c[308]\, 
        \PIODATAWORD_c[309]\, \PIODATAWORD_c[310]\, 
        \PIODATAWORD_c[311]\, \PIODATAWORD_c[312]\, 
        \PIODATAWORD_c[313]\, \PIODATAWORD_c[314]\, 
        \PIODATAWORD_c[315]\, \PIODATAWORD_c[316]\, 
        \PIODATAWORD_c[317]\, \PIODATAWORD_c[318]\, 
        \PIODATAWORD_c[319]\, \PIODATAWORD_c[320]\, 
        \PIODATAWORD_c[321]\, \PIODATAWORD_c[322]\, 
        \PIODATAWORD_c[323]\, \PIODATAWORD_c[324]\, 
        \PIODATAWORD_c[325]\, \PIODATAWORD_c[326]\, 
        \PIODATAWORD_c[327]\, \PIODATAWORD_c[328]\, 
        \PIODATAWORD_c[329]\, \PIODATAWORD_c[330]\, 
        \PIODATAWORD_c[331]\, \PIODATAWORD_c[332]\, 
        \PIODATAWORD_c[333]\, \PIODATAWORD_c[334]\, 
        \PIODATAWORD_c[335]\, \PIODATAWORD_c[336]\, 
        \PIODATAWORD_c[337]\, \PIODATAWORD_c[338]\, 
        \PIODATAWORD_c[339]\, \PIODATAWORD_c[340]\, 
        \PIODATAWORD_c[341]\, \PIODATAWORD_c[342]\, 
        \PIODATAWORD_c[343]\, \PIODATAWORD_c[344]\, 
        \PIODATAWORD_c[345]\, \PIODATAWORD_c[346]\, 
        \PIODATAWORD_c[347]\, \PIODATAWORD_c[348]\, 
        \PIODATAWORD_c[349]\, \PIODATAWORD_c[350]\, 
        \PIODATAWORD_c[351]\, \PIODATAWORD_c[352]\, 
        \PIODATAWORD_c[353]\, \PIODATAWORD_c[354]\, 
        \PIODATAWORD_c[355]\, \PIODATAWORD_c[356]\, 
        \PIODATAWORD_c[357]\, \PIODATAWORD_c[358]\, 
        \PIODATAWORD_c[359]\, \PIODATAWORD_c[360]\, 
        \PIODATAWORD_c[361]\, \PIODATAWORD_c[362]\, 
        \PIODATAWORD_c[363]\, \PIODATAWORD_c[364]\, 
        \PIODATAWORD_c[365]\, \PIODATAWORD_c[366]\, 
        \PIODATAWORD_c[367]\, \PIODATAWORD_c[368]\, 
        \PIODATAWORD_c[369]\, \PIODATAWORD_c[370]\, 
        \PIODATAWORD_c[371]\, \PIODATAWORD_c[372]\, 
        \PIODATAWORD_c[373]\, \PIODATAWORD_c[374]\, 
        \PIODATAWORD_c[375]\, \PIODATAWORD_c[376]\, 
        \PIODATAWORD_c[377]\, \PIODATAWORD_c[378]\, 
        \PIODATAWORD_c[379]\, \PIODATAWORD_c[380]\, 
        \PIODATAWORD_c[381]\, \PIODATAWORD_c[382]\, 
        \PIODATAWORD_c[383]\, \PIODATAWORD_c[384]\, 
        \PIODATAWORD_c[385]\, \PIODATAWORD_c[386]\, 
        \PIODATAWORD_c[387]\, \PIODATAWORD_c[388]\, 
        \PIODATAWORD_c[389]\, \PIODATAWORD_c[390]\, 
        \PIODATAWORD_c[391]\, \PIODATAWORD_c[392]\, 
        \PIODATAWORD_c[393]\, \PIODATAWORD_c[394]\, 
        \PIODATAWORD_c[395]\, \PIODATAWORD_c[396]\, 
        \PIODATAWORD_c[397]\, \PIODATAWORD_c[398]\, 
        \PIODATAWORD_c[399]\, \PIODATAWORD_c[400]\, 
        \PIODATAWORD_c[401]\, \PIODATAWORD_c[402]\, 
        \PIODATAWORD_c[403]\, \PIODATAWORD_c[404]\, 
        \PIODATAWORD_c[405]\, \PIODATAWORD_c[406]\, 
        \PIODATAWORD_c[407]\, \PIODATAWORD_c[408]\, 
        \PIODATAWORD_c[409]\, \PIODATAWORD_c[410]\, 
        \PIODATAWORD_c[411]\, \PIODATAWORD_c[412]\, 
        \PIODATAWORD_c[413]\, \PIODATAWORD_c[414]\, 
        \PIODATAWORD_c[415]\, \PIODATAWORD_c[416]\, 
        \PIODATAWORD_c[417]\, \PIODATAWORD_c[418]\, 
        \PIODATAWORD_c[419]\, \PIODATAWORD_c[420]\, 
        \PIODATAWORD_c[421]\, \PIODATAWORD_c[422]\, 
        \PIODATAWORD_c[423]\, \PIODATAWORD_c[424]\, 
        \PIODATAWORD_c[425]\, \PIODATAWORD_c[426]\, 
        \PIODATAWORD_c[427]\, \PIODATAWORD_c[428]\, 
        \PIODATAWORD_c[429]\, \PIODATAWORD_c[430]\, 
        \PIODATAWORD_c[431]\, \PIODATAWORD_c[432]\, 
        \PIODATAWORD_c[433]\, \PIODATAWORD_c[434]\, 
        \PIODATAWORD_c[435]\, \PIODATAWORD_c[436]\, 
        \PIODATAWORD_c[437]\, \PIODATAWORD_c[438]\, 
        \PIODATAWORD_c[439]\, \PIODATAWORD_c[440]\, 
        \PIODATAWORD_c[441]\, \PIODATAWORD_c[442]\, 
        \PIODATAWORD_c[443]\, \PIODATAWORD_c[444]\, 
        \PIODATAWORD_c[445]\, \PIODATAWORD_c[446]\, 
        \PIODATAWORD_c[447]\, \PIODATAWORD_c[448]\, 
        \PIODATAWORD_c[449]\, \PIODATAWORD_c[450]\, 
        \PIODATAWORD_c[451]\, \PIODATAWORD_c[452]\, 
        \PIODATAWORD_c[453]\, \PIODATAWORD_c[454]\, 
        \PIODATAWORD_c[455]\, \PIODATAWORD_c[456]\, 
        \PIODATAWORD_c[457]\, \PIODATAWORD_c[458]\, 
        \PIODATAWORD_c[459]\, \PIODATAWORD_c[460]\, 
        \PIODATAWORD_c[461]\, \PIODATAWORD_c[462]\, 
        \PIODATAWORD_c[463]\, \PIODATAWORD_c[464]\, 
        \PIODATAWORD_c[465]\, \PIODATAWORD_c[466]\, 
        \PIODATAWORD_c[467]\, \PIODATAWORD_c[468]\, 
        \PIODATAWORD_c[469]\, \PIODATAWORD_c[470]\, 
        \PIODATAWORD_c[471]\, \PIODATAWORD_c[472]\, 
        \PIODATAWORD_c[473]\, \PIODATAWORD_c[474]\, 
        \PIODATAWORD_c[475]\, \PIODATAWORD_c[476]\, 
        \PIODATAWORD_c[477]\, \PIODATAWORD_c[478]\, 
        \PIODATAWORD_c[479]\, \PIODATAWORD_c[480]\, 
        \PIODATAWORD_c[481]\, \PIODATAWORD_c[482]\, 
        \PIODATAWORD_c[483]\, \PIODATAWORD_c[484]\, 
        \PIODATAWORD_c[485]\, \PIODATAWORD_c[486]\, 
        \PIODATAWORD_c[487]\, \PIODATAWORD_c[488]\, 
        \PIODATAWORD_c[489]\, \PIODATAWORD_c[490]\, 
        \PIODATAWORD_c[491]\, \PIODATAWORD_c[492]\, 
        \PIODATAWORD_c[493]\, \PIODATAWORD_c[494]\, 
        \PIODATAWORD_c[495]\, \PIODATAWORD_c[496]\, 
        \PIODATAWORD_c[497]\, \PIODATAWORD_c[498]\, 
        \PIODATAWORD_c[499]\, \PIODATAWORD_c[500]\, 
        \PIODATAWORD_c[501]\, \PIODATAWORD_c[502]\, 
        \PIODATAWORD_c[503]\, \PIODATAWORD_c[504]\, 
        \PIODATAWORD_c[505]\, \PIODATAWORD_c[506]\, 
        \PIODATAWORD_c[507]\, \PIODATAWORD_c[508]\, 
        \PIODATAWORD_c[509]\, \PIODATAWORD_c[510]\, 
        \PIODATAWORD_c[511]\, \PICMD_c[0]\, \PICMD_c[1]\, 
        \PICMD_c[2]\, \PICMD_c[3]\, \PICMD_c[4]\, \PICMD_c[5]\, 
        \PICMD_c[6]\, \PICMD_c[7]\, \PICMD_c[8]\, \PICMD_c[9]\, 
        \PICMD_c[10]\, \PICMD_c[11]\, \PICMD_c[12]\, 
        \PICMD_c[13]\, \PICMD_c[14]\, \PICMD_c[15]\, \PIRTA_c[0]\, 
        \PIRTA_c[1]\, \PIRTA_c[2]\, \PIRTA_c[3]\, \PIRTA_c[4]\, 
        PIRTAP_c, \PIERR_c[0]\, \PIERR_c[1]\, \PIERR_c[2]\, 
        \PIERR_c[3]\, \PIERR_c[4]\, \PIERR_c[5]\, \PIERR_c[6]\, 
        \PIERR_c[7]\, \PIERR_c[8]\, \PIOWORD_in[0]\, 
        \PIOWORD_in[1]\, \PIOWORD_in[2]\, \PIOWORD_in[3]\, 
        \PIOWORD_in[4]\, \PIOWORD_in[5]\, \PIOWORD_in[6]\, 
        \PIOWORD_in[7]\, \PIOWORD_in[8]\, \PIOWORD_in[9]\, 
        \PIOWORD_in[10]\, \PIOWORD_in[11]\, \PIOWORD_in[12]\, 
        \PIOWORD_in[13]\, \PIOWORD_in[14]\, \PIOWORD_in[15]\, 
        POERROR_c, POVALMESS_c, PORCVA_c, PORCVB_c, 
        un1_errorstat5, N_212, RXFIFOcount_n4, RXFIFOcount_n1, 
        RXFIFOcount_n2, N_4397, N_3176, N_3190, RXFIFOcount_n3, 
        N_3281, N_3326, N_3282, N_3327, N_3386, N_3431, N_3387, 
        N_3432, N_3506, N_3551, N_3507, N_3552, N_3611, N_3656, 
        N_3612, N_3657, \PIOWORD_4[11]\, \PIOWORD_4[12]\, N_4596, 
        N_4597, N_177, N_180, RXFIFOcount_c2, N_4406, 
        \un9_sdatawordlen_1.CO1_1_net_1\, 
        \FFempty_flag_generator.un45_sregaddr\, 
        \FFempty_flag_generator.un45_sregaddr.ALTB[1]_net_1\, 
        N_4492, N_2544, N_2592, N_4493, N_2656, N_2704, N_4490, 
        N_2784, N_2832, N_2896, N_2944, N_3285, N_3330, N_3390, 
        N_3435, N_3510, N_3555, N_3615, N_3660, \PIOWORD_4[6]\, 
        N_72, N_57, N_168, N_191, N_194, N_162, N_3292, N_3337, 
        N_3397, N_3442, N_3622, N_4496, un8_scmd_NE, N_95, N_64, 
        N_4593, N_4594, SRXMODEDATAWORD_0_sqmuxa, N_200, N_167, 
        N_169, N_170, N_208, N_206, N_205, N_203, N_4586, N_198, 
        N_4590, N_189, N_4591, N_185, N_4592, N_174, N_171, 
        N_4598, N_4599, N_1120, N_70, N_4499, \PIOWORD_4[15]\, 
        N_2499, N_3064, \PIOWORD_4[4]\, N_4527, \PIOWORD_4[10]\, 
        N_3159, N_4539, N_4542, N_4546, N_4549, N_4554, N_4557, 
        N_4561, N_4564, \PIOWORD_4[0]\, N_77, N_79, N_4583, N_74, 
        N_4587, N_75, N_63_i, \PIOWORD_4[14]\, \PIOWORD_4[13]\, 
        \PIOWORD_4[9]\, \PIOWORD_4[8]\, \PIOWORD_4[7]\, 
        \PIOWORD_4[5]\, \PIOWORD_4[3]\, \PIOWORD_4[2]\, 
        \PIOWORD_4[1]\, N_3624, N_3669, N_3623, N_3668, N_3667, 
        N_3621, N_3666, N_3620, N_3665, N_3619, N_3664, N_3618, 
        N_3663, N_3617, N_3662, N_3616, N_3661, N_3614, N_3659, 
        N_3613, N_3658, N_3610, N_3655, N_3519, N_3564, N_3518, 
        N_3563, N_3517, N_3562, N_3516, N_3561, N_3515, N_3560, 
        N_3514, N_3559, N_3513, N_3558, N_3512, N_3557, N_3511, 
        N_3556, N_3509, N_3554, N_3508, N_3553, N_3505, N_3550, 
        N_3399, N_3444, N_3398, N_3443, N_3396, N_3441, N_3395, 
        N_3440, N_3394, N_3439, N_3393, N_3438, N_3392, N_3437, 
        N_3391, N_3436, N_3389, N_3434, N_3388, N_3433, N_3385, 
        N_3430, N_3294, N_3339, N_3293, N_3338, N_3291, N_3336, 
        N_3290, N_3335, N_3289, N_3334, N_3288, N_3333, N_3287, 
        N_3332, N_3286, N_3331, N_3284, N_3329, N_3283, N_3328, 
        N_3280, N_3325, N_2950, N_2902, N_2949, N_2901, N_2948, 
        N_2900, N_2947, N_2899, N_2946, N_2898, N_2945, N_2897, 
        N_2943, N_2895, N_2942, N_2894, N_2941, N_2893, N_2940, 
        N_2892, N_2939, N_2891, N_2938, N_2890, N_2937, N_2889, 
        N_2936, N_2888, N_2935, N_2887, N_2838, N_2790, N_2837, 
        N_2789, N_2836, N_2788, N_2835, N_2787, N_2834, N_2786, 
        N_2833, N_2785, N_2831, N_2783, N_2830, N_2782, N_2829, 
        N_2781, N_2828, N_2780, N_2827, N_2779, N_2826, N_2778, 
        N_2825, N_2777, N_2824, N_2776, N_2823, N_2775, N_2710, 
        N_2662, N_2709, N_2661, N_2708, N_2660, N_2707, N_2659, 
        N_2706, N_2658, N_2705, N_2657, N_2703, N_2655, N_2702, 
        N_2654, N_2701, N_2653, N_2700, N_2652, N_2699, N_2651, 
        N_2698, N_2650, N_2697, N_2649, N_2696, N_2648, N_2695, 
        N_2647, N_2598, N_2550, N_2597, N_2549, N_2596, N_2548, 
        N_2595, N_2547, N_2594, N_2546, N_2593, N_2545, N_2591, 
        N_2543, N_2590, N_2542, N_2589, N_2541, N_2588, N_2540, 
        N_2587, N_2539, N_2586, N_2538, N_2585, N_2537, N_2584, 
        N_2536, N_2583, N_2535, \un1_SCOMMWORD_4_i_m3_d[1]\, 
        pioword29, N_231, \un9_sdatawordlen_1.CO3_i\, 
        \SErrorCounter_cry[0]_net_1\, \SErrorCounter_s[0]\, 
        \SErrorCounter_cry[1]_net_1\, \SErrorCounter_s[1]\, 
        \SErrorCounter_cry[2]_net_1\, \SErrorCounter_s[2]\, 
        \SErrorCounter_cry[3]_net_1\, \SErrorCounter_s[3]\, 
        \SErrorCounter_cry[4]_net_1\, \SErrorCounter_s[4]\, 
        \SErrorCounter_cry[5]_net_1\, \SErrorCounter_s[5]\, 
        \SErrorCounter_cry[6]_net_1\, \SErrorCounter_s[6]\, 
        \SErrorCounter_s[7]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un12_serr_0_a2_0_o2_3_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.sprtycheck_3_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_0_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_1_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_o2_1[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_1[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_2[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0[9]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_1[9]_net_1\, 
        PIMR_c_i_0, N_2474_i_0, N_2480_i_0, N_2453_i_0, N_46_i_0, 
        un1_H6110_states_3_i_0, N_4577_i_0, N_73_i_0, N_44_i_0, 
        N_1131_i_0, N_16_i_0, N_4489_i_0, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_3\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_4\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_5\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_6\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_7\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_8\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_9\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_10\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_19\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_20\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_21\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_22\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_27\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_28\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_29\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_30\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_19\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_20\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_21\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_22\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_51\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_52\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_53\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_54\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_55\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_56\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_57\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_58\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_55\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_56\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_57\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_58\, 
        \SRXMODEDATAWORD_1_31_am[4]\, 
        \SRXMODEDATAWORD_1_31_bm[4]\, 
        \SRXMODEDATAWORD_1_31_am[9]\, 
        \SRXMODEDATAWORD_1_31_bm[9]\, 
        \SRXMODEDATAWORD_1_31_am[15]\, 
        \SRXMODEDATAWORD_1_31_bm[15]\, 
        \SRXMODEDATAWORD_1_31_am[14]\, 
        \SRXMODEDATAWORD_1_31_bm[14]\, 
        \SRXMODEDATAWORD_1_31_am[13]\, 
        \SRXMODEDATAWORD_1_31_bm[13]\, 
        \SRXMODEDATAWORD_1_31_am[12]\, 
        \SRXMODEDATAWORD_1_31_bm[12]\, 
        \SRXMODEDATAWORD_1_31_am[11]\, 
        \SRXMODEDATAWORD_1_31_bm[11]\, 
        \SRXMODEDATAWORD_1_31_am[10]\, 
        \SRXMODEDATAWORD_1_31_bm[10]\, 
        \SRXMODEDATAWORD_1_31_am[8]\, 
        \SRXMODEDATAWORD_1_31_bm[8]\, 
        \SRXMODEDATAWORD_1_31_am[7]\, 
        \SRXMODEDATAWORD_1_31_bm[7]\, 
        \SRXMODEDATAWORD_1_31_am[6]\, 
        \SRXMODEDATAWORD_1_31_bm[6]\, 
        \SRXMODEDATAWORD_1_31_am[5]\, 
        \SRXMODEDATAWORD_1_31_bm[5]\, 
        \SRXMODEDATAWORD_1_31_am[3]\, 
        \SRXMODEDATAWORD_1_31_bm[3]\, 
        \SRXMODEDATAWORD_1_31_am[2]\, 
        \SRXMODEDATAWORD_1_31_bm[2]\, 
        \SRXMODEDATAWORD_1_31_am[1]\, 
        \SRXMODEDATAWORD_1_31_bm[1]\, 
        \SRXMODEDATAWORD_1_31_am[0]\, 
        \SRXMODEDATAWORD_1_31_bm[0]\, \ALTB_bm[4]\, 
        \PIOWORD_4_31_am[11]\, \PIOWORD_4_31_bm[11]\, 
        \PIOWORD_4_31_am[12]\, \PIOWORD_4_31_bm[12]\, 
        \PIOWORD_4_31_am[6]\, \PIOWORD_4_31_bm[6]\, 
        \PIOWORD_4_31_am[0]\, \PIOWORD_4_31_bm[0]\, 
        \PIOWORD_4_31_am[15]\, \PIOWORD_4_31_bm[15]\, 
        \PIOWORD_4_31_am[14]\, \PIOWORD_4_31_bm[14]\, 
        \PIOWORD_4_31_am[13]\, \PIOWORD_4_31_bm[13]\, 
        \PIOWORD_4_31_am[10]\, \PIOWORD_4_31_bm[10]\, 
        \PIOWORD_4_31_am[9]\, \PIOWORD_4_31_bm[9]\, 
        \PIOWORD_4_31_am[8]\, \PIOWORD_4_31_bm[8]\, 
        \PIOWORD_4_31_am[7]\, \PIOWORD_4_31_bm[7]\, 
        \PIOWORD_4_31_am[5]\, \PIOWORD_4_31_bm[5]\, 
        \PIOWORD_4_31_am[4]\, \PIOWORD_4_31_bm[4]\, 
        \PIOWORD_4_31_am[3]\, \PIOWORD_4_31_bm[3]\, 
        \PIOWORD_4_31_am[2]\, \PIOWORD_4_31_bm[2]\, 
        \PIOWORD_4_31_am[1]\, \PIOWORD_4_31_bm[1]\, 
        sprtycheck_i_0, SErrorCounter_cry_cy, 
        \FFempty_flag_generator.un45_sregaddr.ALTB_ns_1[4]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[5]\, 
        \un9_sdatawordlen_1.un1_SCOMMWORD_4_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m2_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[7]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_13_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m2_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[2]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_21_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[14]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_25_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[4]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[0]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_28_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[9]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_10_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[6]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_6_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[10]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_18_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[2]\, 
        \un9_sdatawordlen_1.un1_SCOMMWORD_4_1_1[10]\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_3_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[9]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[6]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[8]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[11]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[14]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[10]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[5]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[7]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[1]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[12]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[0]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[13]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[3]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[2]\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[15]\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0_1[9]_net_1\, 
        \un9_sdatawordlen_1.H6110_states_tr5_i_o2_1_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_cl_48_0_1_0[15]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.m8_1_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[2]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[2]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[3]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[3]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[4]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[4]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[5]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[5]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[7]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[7]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[8]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[8]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[9]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[9]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[10]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[10]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[13]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[13]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[14]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[14]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[15]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[15]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[0]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[0]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[6]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[6]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[12]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[12]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[11]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[11]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[0]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[0]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[1]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[2]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[2]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[3]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[3]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[5]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[5]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[6]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[6]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[7]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[7]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[8]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[8]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[10]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[10]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[11]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[11]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[12]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[12]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[13]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[13]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[14]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[14]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[15]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[15]_net_1\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_1[9]_net_1\, 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_1[9]_net_1\, 
        \un9_sdatawordlen_1.un1_SCOMMWORD_u_1[4]_net_1\, 
        \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_1[4]_net_1\, 
        \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_0[4]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[4]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[4]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_ns_1[6]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[0]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[7]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[3]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[5]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[8]_net_1\, 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[2]_net_1\, 
        \SErrorCounter_cry_cy_Y[0]\, \un1_PIOWORD_cl_i_0_i[15]\, 
        \PICLK_ibuf\, \PIMR_ibuf\ : std_logic;

begin 


    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[7]_net_1\, B => 
        \SRXFIFO_10[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[7]\, 
        Y => N_3391);
    
    \PIODATAWORD_ibuf[126]\ : INBUF
      port map(PAD => PIODATAWORD(126), Y => \PIODATAWORD_c[126]\);
    
    PIBUSB_ibuf : INBUF
      port map(PAD => PIBUSB, Y => PIBUSB_c);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[24]\, B => \PIODATAWORD_c[40]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[8]\);
    
    \SRXFIFO_18[10]\ : SLE
      port map(D => \PIODATAWORD_c[298]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[10]_net_1\);
    
    \PIOWORD_1[15]\ : SLE
      port map(D => \un1_SCOMMWORD_u[15]\, CLK => PICLK_c, EN => 
        pioword29, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[15]_net_1\);
    
    \PIODATAWORD_ibuf[316]\ : INBUF
      port map(PAD => PIODATAWORD(316), Y => \PIODATAWORD_c[316]\);
    
    \PIODATAWORD_ibuf[227]\ : INBUF
      port map(PAD => PIODATAWORD(227), Y => \PIODATAWORD_c[227]\);
    
    \PIODATAWORD_ibuf[108]\ : INBUF
      port map(PAD => PIODATAWORD(108), Y => \PIODATAWORD_c[108]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1_0_RNO[3]\ : 
        CFG4
      generic map(INIT => x"3B38")

      port map(A => \SCOMMWORD[3]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m2_1_1[3]\, 
        C => \PIRegAddr_c[1]\, D => \SBUSAWORD[3]_net_1\, Y => 
        N_77);
    
    \SRXFIFO_24[7]\ : SLE
      port map(D => \PIODATAWORD_c[391]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[7]_net_1\);
    
    \SRXFIFO_16[3]\ : SLE
      port map(D => \PIODATAWORD_c[259]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[3]_net_1\);
    
    \PIODATAWORD_ibuf[362]\ : INBUF
      port map(PAD => PIODATAWORD(362), Y => \PIODATAWORD_c[362]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[12]_net_1\, B => 
        \SRXFIFO_3[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[12]\);
    
    \SRXFIFO_10[11]\ : SLE
      port map(D => \PIODATAWORD_c[171]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[11]_net_1\);
    
    \PIOWORD_iobuf[14]\ : BIBUF
      port map(PAD => PIOWORD(14), D => \PIOWORD_1[14]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[12]_net_1\, B => 
        \SRXFIFO_2[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[12]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[9]_net_1\, B => 
        \SRXFIFO_15[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[9]\, 
        Y => N_3663);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_6[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[84]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_4\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[6]\, 
        C => \PIODATAWORD_c[438]\, D => \PIODATAWORD_c[390]\, Y
         => N_2941);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_RNO_0[9]\ : 
        CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[137]\, B => 
        \PIODATAWORD_c[169]\, C => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_21_1_1[9]\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_2832);
    
    \SRXFIFO_18[1]\ : SLE
      port map(D => \PIODATAWORD_c[289]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[15]_net_1\, B => 
        \SRXFIFO_1[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[15]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[3]_net_1\, B => 
        \SRXFIFO_15[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[3]\, 
        Y => N_3657);
    
    \SRXFIFO_14[3]\ : SLE
      port map(D => \PIODATAWORD_c[227]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[3]_net_1\);
    
    \PIODATAWORD_ibuf[491]\ : INBUF
      port map(PAD => PIODATAWORD(491), Y => \PIODATAWORD_c[491]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[0]\, 
        C => \PIODATAWORD_c[496]\, D => \PIODATAWORD_c[448]\, Y
         => N_2695);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[4]_net_1\, B => 
        \SRXFIFO_7[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[4]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[7]_net_1\, B => 
        \SRXFIFO_0[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[7]\);
    
    \PIODATAWORD_ibuf[406]\ : INBUF
      port map(PAD => PIODATAWORD(406), Y => \PIODATAWORD_c[406]\);
    
    \PIODATAWORD_ibuf[209]\ : INBUF
      port map(PAD => PIODATAWORD(209), Y => \PIODATAWORD_c[209]\);
    
    \FFempty_flag_generator.un45_sregaddr.ALTB[1]\ : CFG4
      generic map(INIT => x"3107")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => \SCOMMWORD[0]_net_1\, D => 
        \SCOMMWORD[1]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.ALTB[1]_net_1\);
    
    \SRXFIFO_26[10]\ : SLE
      port map(D => \PIODATAWORD_c[426]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[13]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2788, C => N_2548, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[13]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[13]\);
    
    \un9_sdatawordlen_1.H6110_states_tr5_i_a2_0_o2\ : CFG4
      generic map(INIT => x"FFFB")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.un12_serr_0_a2_0_o2_3_net_1\, 
        B => N_1120, C => \PIERR_c[2]\, D => \PIERR_c[3]\, Y => 
        N_70);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[466]\, B => 
        \PIODATAWORD_c[482]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[2]\);
    
    \SRXFIFO_21[14]\ : SLE
      port map(D => \PIODATAWORD_c[350]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[14]_net_1\);
    
    \SBUSBWORD[1]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[1]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[1]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0[12]\ : 
        CFG4
      generic map(INIT => x"7340")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, C
         => N_4597, D => N_177, Y => N_3190);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[144]\, B => 
        \PIODATAWORD_c[160]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[0]\);
    
    \PIODATAWORD_ibuf[61]\ : INBUF
      port map(PAD => PIODATAWORD(61), Y => \PIODATAWORD_c[61]\);
    
    \PIODATAWORD_ibuf[132]\ : INBUF
      port map(PAD => PIODATAWORD(132), Y => \PIODATAWORD_c[132]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[0]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2583, D => N_2823, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[0]_net_1\);
    
    \SRXFIFO_31[8]\ : SLE
      port map(D => \PIODATAWORD_c[504]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[8]_net_1\);
    
    \SRXFIFO_26[4]\ : SLE
      port map(D => \PIODATAWORD_c[420]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_30\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_29\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_28\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_27\, 
        Y => N_2699);
    
    \PIODATAWORD_ibuf[425]\ : INBUF
      port map(PAD => PIODATAWORD(425), Y => \PIODATAWORD_c[425]\);
    
    \PIODATAWORD_ibuf[380]\ : INBUF
      port map(PAD => PIODATAWORD(380), Y => \PIODATAWORD_c[380]\);
    
    \SRXFIFO_13[2]\ : SLE
      port map(D => \PIODATAWORD_c[210]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[2]_net_1\);
    
    \SRXFIFO_23[11]\ : SLE
      port map(D => \PIODATAWORD_c[379]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[15]_net_1\, B => 
        \SRXFIFO_12[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[15]\, 
        Y => N_3339);
    
    RXFIFOloaded : SLE
      port map(D => \H6110_states[1]_net_1\, CLK => PICLK_c, EN
         => un1_H6110_states_3_i_0, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \RXFIFOloaded\);
    
    \PIOWORD_1[4]\ : SLE
      port map(D => \un1_SCOMMWORD_1_RNITM6R1[4]\, CLK => PICLK_c, 
        EN => pioword29, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[414]\, B => 
        \PIODATAWORD_c[430]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[1]_net_1\, B => 
        \SRXFIFO_2[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[1]\);
    
    \SRXFIFO_5[11]\ : SLE
      port map(D => \PIODATAWORD_c[91]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[11]_net_1\);
    
    \SRXFIFO_28[4]\ : SLE
      port map(D => \PIODATAWORD_c[452]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[4]_net_1\);
    
    \PIODATAWORD_ibuf[87]\ : INBUF
      port map(PAD => PIODATAWORD(87), Y => \PIODATAWORD_c[87]\);
    
    \PIODATAWORD_ibuf[280]\ : INBUF
      port map(PAD => PIODATAWORD(280), Y => \PIODATAWORD_c[280]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[221]\, B => 
        \PIODATAWORD_c[237]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[13]_net_1\, B => 
        \SRXFIFO_6[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[13]\);
    
    \SRXFIFO_18[11]\ : SLE
      port map(D => \PIODATAWORD_c[299]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[11]_net_1\);
    
    \SCOMMWORD[6]\ : SLE
      port map(D => \PICMD_c[6]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[6]_net_1\);
    
    \un9_sdatawordlen_1.SBUSAWORD_0_sqmuxa\ : CFG4
      generic map(INIT => x"0200")

      port map(A => SRXMODEDATAWORD_0_sqmuxa, B => N_1120, C => 
        \SActB\, D => \SActA\, Y => SBUSAWORD_0_sqmuxa);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[11]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2594, D => N_2834, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[1]\, 
        C => \PIODATAWORD_c[305]\, D => \PIODATAWORD_c[257]\, Y
         => N_2888);
    
    \PIODATAWORD_ibuf[84]\ : INBUF
      port map(PAD => PIODATAWORD(84), Y => \PIODATAWORD_c[84]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[10]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[10]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[10]\, Y => 
        \SRXMODEDATAWORD_1[10]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[277]\, B => 
        \PIODATAWORD_c[293]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[5]\);
    
    \SRXFIFO_6[14]\ : SLE
      port map(D => \PIODATAWORD_c[110]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[14]_net_1\);
    
    \PIODATAWORD_ibuf[25]\ : INBUF
      port map(PAD => PIODATAWORD(25), Y => \PIODATAWORD_c[25]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[7]\, 
        C => \PIODATAWORD_c[247]\, D => \PIODATAWORD_c[199]\, Y
         => N_2590);
    
    \PIODATAWORD_ibuf[497]\ : INBUF
      port map(PAD => PIODATAWORD(497), Y => \PIODATAWORD_c[497]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[3]\, 
        C => \PIODATAWORD_c[179]\, D => \PIODATAWORD_c[131]\, Y
         => N_2826);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[11]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3665, C => 
        N_3620, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[11]_net_1\, 
        Y => \PIOWORD_4_31_bm[11]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[5]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3659, C => 
        N_3614, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[5]_net_1\, 
        Y => \PIOWORD_4_31_bm[5]\);
    
    \PIODATAWORD_ibuf[482]\ : INBUF
      port map(PAD => PIODATAWORD(482), Y => \PIODATAWORD_c[482]\);
    
    \SRXFIFO_25[3]\ : SLE
      port map(D => \PIODATAWORD_c[403]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[3]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[5]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3329, D => N_3284, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[5]_net_1\);
    
    \PIODATAWORD_ibuf[256]\ : INBUF
      port map(PAD => PIODATAWORD(256), Y => \PIODATAWORD_c[256]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3[7]\ : 
        CFG4
      generic map(INIT => x"20FD")

      port map(A => N_162, B => \PIRegAddr_c[0]\, C => N_4591, D
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[7]_net_1\, 
        Y => N_211);
    
    \H6110_states[3]\ : SLE
      port map(D => N_100, CLK => PICLK_c, EN => VCC_net_1, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \H6110_states[3]_net_1\);
    
    \PIODATAWORD_ibuf[138]\ : INBUF
      port map(PAD => PIODATAWORD(138), Y => \PIODATAWORD_c[138]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SCOMMWORD[6]_net_1\, D => \SRXMODEDATAWORD[6]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[6]\);
    
    \PIODATAWORD_ibuf[112]\ : INBUF
      port map(PAD => PIODATAWORD(112), Y => \PIODATAWORD_c[112]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[11]_net_1\, B => 
        \SRXFIFO_12[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[11]\, 
        Y => N_3335);
    
    \SBUSAWORD[15]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[15]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[15]_net_1\);
    
    \SRXFIFO_7[8]\ : SLE
      port map(D => \PIODATAWORD_c[120]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_5[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[340]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_56\);
    
    \PIOWORD_cl_12[15]\ : SLE
      port map(D => \PIOWORD_cl_44[15]\, CLK => PICLK_c, EN => 
        VCC_net_1, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_cl[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[29]\, B => \PIODATAWORD_c[45]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[13]\);
    
    \PIODATAWORD_ibuf[511]\ : INBUF
      port map(PAD => PIODATAWORD(511), Y => \PIODATAWORD_c[511]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[10]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2705, D => N_2945, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_6[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[68]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_56\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[6]\, 
        C => \PIODATAWORD_c[182]\, D => \PIODATAWORD_c[134]\, Y
         => N_2829);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_cl_44_0_a2_0_1[15]\ : 
        CFG3
      generic map(INIT => x"FD")

      port map(A => PISTR_c, B => PIRW_c, C => PICS_c, Y => 
        pioword29);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1_0[3]\ : 
        CFG3
      generic map(INIT => x"1D")

      port map(A => N_77, B => N_162, C => N_75, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[3]_net_1\);
    
    \SRXFIFO_21[0]\ : SLE
      port map(D => \PIODATAWORD_c[336]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[0]_net_1\);
    
    \PIODATAWORD_ibuf[95]\ : INBUF
      port map(PAD => PIODATAWORD(95), Y => \PIODATAWORD_c[95]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[28]\, B => \PIODATAWORD_c[44]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[464]\, B => 
        \PIODATAWORD_c[480]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[0]\);
    
    \PIOWORD_1[0]\ : SLE
      port map(D => N_84, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[0]_net_1\);
    
    \PIODATAWORD_ibuf[388]\ : INBUF
      port map(PAD => PIODATAWORD(388), Y => \PIODATAWORD_c[388]\);
    
    \SRXFIFO_9[4]\ : SLE
      port map(D => \PIODATAWORD_c[148]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[4]_net_1\);
    
    \SRXFIFO_18[2]\ : SLE
      port map(D => \PIODATAWORD_c[290]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[2]_net_1\);
    
    \PIODATAWORD_ibuf[436]\ : INBUF
      port map(PAD => PIODATAWORD(436), Y => \PIODATAWORD_c[436]\);
    
    \PIODATAWORD_ibuf[239]\ : INBUF
      port map(PAD => PIODATAWORD(239), Y => \PIODATAWORD_c[239]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[347]\, B => 
        \PIODATAWORD_c[363]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[11]\);
    
    \SRXFIFO_17[8]\ : SLE
      port map(D => \PIODATAWORD_c[280]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[8]_net_1\);
    
    \SRXFIFO_15[8]\ : SLE
      port map(D => \PIODATAWORD_c[248]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[8]_net_1\);
    
    \SCTRL[0]\ : SLE
      port map(D => \PIOWORD_in[0]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[0]_net_1\);
    
    \SRXFIFO_15[14]\ : SLE
      port map(D => \PIODATAWORD_c[254]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[14]_net_1\);
    
    \PIODATAWORD_ibuf[386]\ : INBUF
      port map(PAD => PIODATAWORD(386), Y => \PIODATAWORD_c[386]\);
    
    \PIODATAWORD_ibuf[143]\ : INBUF
      port map(PAD => PIODATAWORD(143), Y => \PIODATAWORD_c[143]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[6]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3435, C => 
        N_3390, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[6]_net_1\, 
        Y => \PIOWORD_4_31_am[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[14]_net_1\, B => 
        \SRXFIFO_7[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[210]\, B => 
        \PIODATAWORD_c[226]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[3]_net_1\, B => 
        \SRXFIFO_4[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[3]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[9]_net_1\, B => 
        \SRXFIFO_6[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[9]\);
    
    \PIODATAWORD_ibuf[471]\ : INBUF
      port map(PAD => PIODATAWORD(471), Y => \PIODATAWORD_c[471]\);
    
    \PIODATAWORD_ibuf[157]\ : INBUF
      port map(PAD => PIODATAWORD(157), Y => \PIODATAWORD_c[157]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[132]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_10\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[342]\, B => 
        \PIODATAWORD_c[358]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[6]\);
    
    \SRXFIFO_6[9]\ : SLE
      port map(D => \PIODATAWORD_c[105]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[9]_net_1\);
    
    \SRXFIFO_0[8]\ : SLE
      port map(D => \PIODATAWORD_c[8]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[6]\, 
        C => \PIODATAWORD_c[118]\, D => \PIODATAWORD_c[70]\, Y
         => N_2541);
    
    \PIODATAWORD_ibuf[190]\ : INBUF
      port map(PAD => PIODATAWORD(190), Y => \PIODATAWORD_c[190]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[19]\, B => \PIODATAWORD_c[35]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[3]\);
    
    PIMR_ibuf_RNITGAD_0 : CFG1
      generic map(INIT => "01")

      port map(A => PIMR_c, Y => PIMR_c_i_0);
    
    \PICMD_ibuf[2]\ : INBUF
      port map(PAD => PICMD(2), Y => \PICMD_c[2]\);
    
    \SRXFIFO_14[13]\ : SLE
      port map(D => \PIODATAWORD_c[237]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[1]_net_1\, B => 
        \SRXFIFO_1[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[1]\);
    
    \PIODATAWORD_ibuf[59]\ : INBUF
      port map(PAD => PIODATAWORD(59), Y => \PIODATAWORD_c[59]\);
    
    \PIODATAWORD_ibuf[118]\ : INBUF
      port map(PAD => PIODATAWORD(118), Y => \PIODATAWORD_c[118]\);
    
    \RXFIFOcount[1]\ : SLE
      port map(D => RXFIFOcount_n1, CLK => PICLK_c, EN => 
        RXFIFOcounte, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \RXFIFOcount[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[478]\, B => 
        \PIODATAWORD_c[494]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[14]\);
    
    \FFempty_flag_generator.un45_sregaddr.RXFIFOcount_n1\ : CFG4
      generic map(INIT => x"1400")

      port map(A => \RXFIFOloaded\, B => \RXFIFOcount[0]_net_1\, 
        C => \RXFIFOcount[1]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr\, Y => 
        RXFIFOcount_n1);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[9]_net_1\, B => 
        \SRXFIFO_8[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[9]\, 
        Y => N_3288);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[8]\, 
        C => \PIODATAWORD_c[440]\, D => \PIODATAWORD_c[392]\, Y
         => N_2943);
    
    
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_1[1]\ : 
        CFG4
      generic map(INIT => x"B3A0")

      port map(A => RcvaSTAT_1_sqmuxa, B => N_63_i, C => 
        \H6110_states[4]_net_1\, D => \H6110_states[5]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_1[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[10]\, 
        C => \PIODATAWORD_c[314]\, D => \PIODATAWORD_c[266]\, Y
         => N_2897);
    
    \SRXFIFO_8[10]\ : SLE
      port map(D => \PIODATAWORD_c[138]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[10]_net_1\);
    
    PIMR_ibuf : INBUF
      port map(PAD => PIMR, Y => \PIMR_ibuf\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[13]\, 
        C => \PIODATAWORD_c[253]\, D => \PIODATAWORD_c[205]\, Y
         => N_2596);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[8]_net_1\, B => 
        \SRXFIFO_2[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[8]\);
    
    \SRXFIFO_30[3]\ : SLE
      port map(D => \PIODATAWORD_c[483]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[3]_net_1\);
    
    \SRXFIFO_24[4]\ : SLE
      port map(D => \PIODATAWORD_c[388]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO[5]\ : 
        CFG4
      generic map(INIT => x"CB0B")

      port map(A => \SBUSBWORD[5]_net_1\, B => \PIRegAddr_c[3]\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[5]\, 
        D => \SBUSAWORD[5]_net_1\, Y => N_167);
    
    \SRXFIFO_8[15]\ : SLE
      port map(D => \PIODATAWORD_c[143]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[15]_net_1\);
    
    \PIODATAWORD_ibuf[416]\ : INBUF
      port map(PAD => PIODATAWORD(416), Y => \PIODATAWORD_c[416]\);
    
    \SRXFIFO_12[5]\ : SLE
      port map(D => \PIODATAWORD_c[197]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[5]_net_1\);
    
    \PIODATAWORD_ibuf[219]\ : INBUF
      port map(PAD => PIODATAWORD(219), Y => \PIODATAWORD_c[219]\);
    
    \SRXFIFO_4[0]\ : SLE
      port map(D => \PIODATAWORD_c[64]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[0]_net_1\);
    
    \PIODATAWORD_ibuf[459]\ : INBUF
      port map(PAD => PIODATAWORD(459), Y => \PIODATAWORD_c[459]\);
    
    \PIODATAWORD_ibuf[26]\ : INBUF
      port map(PAD => PIODATAWORD(26), Y => \PIODATAWORD_c[26]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[13]\, 
        C => \PIODATAWORD_c[125]\, D => \PIODATAWORD_c[77]\, Y
         => N_2548);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[1]\, 
        C => \PIODATAWORD_c[497]\, D => \PIODATAWORD_c[449]\, Y
         => N_2696);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[6]_net_1\, B => 
        \SRXFIFO_5[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[6]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[10]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3439, C => 
        N_3394, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[10]_net_1\, 
        Y => \PIOWORD_4_31_am[10]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_o2[9]\ : 
        CFG2
      generic map(INIT => x"7")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[1]\, Y
         => N_64);
    
    \PIOWORD_iobuf[11]\ : BIBUF
      port map(PAD => PIOWORD(11), D => \PIOWORD_1[11]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[11]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1[9]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[9]_net_1\, B => \PIOWORD_4[9]\, C => 
        \PIRegAddr_c[3]\, Y => N_4594);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[5]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[5]\, C => \PIOWORD_4_31_am[5]\, Y => 
        \PIOWORD_4[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[465]\, B => 
        \PIODATAWORD_c[481]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[1]\);
    
    \SRXFIFO_27[14]\ : SLE
      port map(D => \PIODATAWORD_c[446]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[12]\, 
        C => \PIODATAWORD_c[124]\, D => \PIODATAWORD_c[76]\, Y
         => N_2547);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[8]_net_1\, B => 
        \SRXFIFO_7[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[8]\);
    
    \PIRTA_ibuf[3]\ : INBUF
      port map(PAD => PIRTA(3), Y => \PIRTA_c[3]\);
    
    \PIODATAWORD_ibuf[243]\ : INBUF
      port map(PAD => PIODATAWORD(243), Y => \PIODATAWORD_c[243]\);
    
    \SRXFIFO_5[8]\ : SLE
      port map(D => \PIODATAWORD_c[88]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[8]_net_1\);
    
    \SRXFIFO_2[1]\ : SLE
      port map(D => \PIODATAWORD_c[33]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[1]_net_1\);
    
    \PIODATAWORD_ibuf[477]\ : INBUF
      port map(PAD => PIODATAWORD(477), Y => \PIODATAWORD_c[477]\);
    
    \PIODATAWORD_ibuf[397]\ : INBUF
      port map(PAD => PIODATAWORD(397), Y => \PIODATAWORD_c[397]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[5]_net_1\, B => 
        \SRXFIFO_7[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[5]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[5]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3554, D => N_3509, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[5]_net_1\);
    
    \PIODATAWORD_ibuf[421]\ : INBUF
      port map(PAD => PIODATAWORD(421), Y => \PIODATAWORD_c[421]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[91]\, B => 
        \PIODATAWORD_c[107]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[11]\);
    
    \un9_sdatawordlen_1.H6110_states_ns_0[5]\ : CFG4
      generic map(INIT => x"2F22")

      port map(A => \H6110_states[2]_net_1\, B => 
        \SCOMMWORD[10]_net_1\, C => N_70, D => 
        \H6110_states[1]_net_1\, Y => \H6110_states_ns[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[7]_net_1\, B => 
        \SRXFIFO_13[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[7]\, 
        Y => N_3556);
    
    \PIODATAWORD_ibuf[509]\ : INBUF
      port map(PAD => PIODATAWORD(509), Y => \PIODATAWORD_c[509]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_5[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[324]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_20\);
    
    \SRXFIFO_22[12]\ : SLE
      port map(D => \PIODATAWORD_c[364]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[12]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_pibusb_0_a2\ : CFG2
      generic map(INIT => x"4")

      port map(A => PIBUSA_c, B => PIBUSB_c, Y => un1_pibusb_0_a2);
    
    \SRXFIFO_26[8]\ : SLE
      port map(D => \PIODATAWORD_c[424]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[26]\, B => \PIODATAWORD_c[42]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[10]\);
    
    \PIODATAWORD_ibuf[266]\ : INBUF
      port map(PAD => PIODATAWORD(266), Y => \PIODATAWORD_c[266]\);
    
    \PIOWORD_cl_16[15]\ : SLE
      port map(D => \PIOWORD_cl_48[15]\, CLK => PICLK_c, EN => 
        pioword29, ALn => PIMR_c_i_0, ADn => GND_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_cl_31[15]\);
    
    \PIODATAWORD_ibuf[503]\ : INBUF
      port map(PAD => PIODATAWORD(503), Y => \PIODATAWORD_c[503]\);
    
    \PIODATAWORD_ibuf[392]\ : INBUF
      port map(PAD => PIODATAWORD(392), Y => \PIODATAWORD_c[392]\);
    
    \SRXFIFO_10[14]\ : SLE
      port map(D => \PIODATAWORD_c[174]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[15]_net_1\, B => 
        \SRXFIFO_11[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[15]\, 
        Y => N_3624);
    
    \SRXFIFO_2[2]\ : SLE
      port map(D => \PIODATAWORD_c[34]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[2]_net_1\);
    
    \SCTRL[10]\ : SLE
      port map(D => \PIOWORD_in[10]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[208]\, B => 
        \PIODATAWORD_c[224]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[0]\);
    
    \FFempty_flag_generator.un45_sregaddr.N_16_i\ : CFG3
      generic map(INIT => x"04")

      port map(A => PIMR_c, B => \H6110_states[3]_net_1\, C => 
        \PIERR_c[1]\, Y => N_16_i_0);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO[14]\ : 
        CFG4
      generic map(INIT => x"3B38")

      port map(A => \SCOMMWORD[14]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[14]\, 
        C => \PIRegAddr_c[1]\, D => \SBUSAWORD[14]_net_1\, Y => 
        N_171);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[282]\, B => 
        \PIODATAWORD_c[298]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[10]\);
    
    \PIODATAWORD_ibuf[96]\ : INBUF
      port map(PAD => PIODATAWORD(96), Y => \PIODATAWORD_c[96]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[13]\, 
        C => \PIODATAWORD_c[61]\, D => \PIODATAWORD_c[13]\, Y => 
        N_2788);
    
    \SRXFIFO_31[3]\ : SLE
      port map(D => \PIODATAWORD_c[499]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[3]_net_1\);
    
    \SRXFIFO_23[3]\ : SLE
      port map(D => \PIODATAWORD_c[371]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[0]_net_1\, B => 
        \SRXFIFO_8[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[0]\, 
        Y => N_4539);
    
    \SRXFIFO_6[8]\ : SLE
      port map(D => \PIODATAWORD_c[104]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[8]_net_1\);
    
    \SRXFIFO_15[0]\ : SLE
      port map(D => \PIODATAWORD_c[240]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[0]_net_1\);
    
    \PIODATAWORD_ibuf[506]\ : INBUF
      port map(PAD => PIODATAWORD(506), Y => \PIODATAWORD_c[506]\);
    
    \PIODATAWORD_ibuf[182]\ : INBUF
      port map(PAD => PIODATAWORD(182), Y => \PIODATAWORD_c[182]\);
    
    \PIODATAWORD_ibuf[15]\ : INBUF
      port map(PAD => PIODATAWORD(15), Y => \PIODATAWORD_c[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[7]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2782, C => N_2542, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[7]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[7]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[15]_net_1\, B => 
        \SRXFIFO_2[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[15]\);
    
    ValmessSTAT : SLE
      port map(D => N_61, CLK => PICLK_c, EN => 
        \H6110_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => POVALMESS_c);
    
    \SRXFIFO_5[4]\ : SLE
      port map(D => \PIODATAWORD_c[84]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[4]_net_1\);
    
    \SRXFIFO_30[14]\ : SLE
      port map(D => \PIODATAWORD_c[494]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[14]_net_1\);
    
    \SRXFIFO_15[2]\ : SLE
      port map(D => \PIODATAWORD_c[242]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[20]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_6\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_1[9]\ : CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2704, D => N_2944, 
        Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_1[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[10]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2593, D => N_2833, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[10]_net_1\);
    
    \SRXFIFO_7[9]\ : SLE
      port map(D => \PIODATAWORD_c[121]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[4]\ : 
        CFG4
      generic map(INIT => x"07C7")

      port map(A => N_2891, B => N_4493, C => N_4490, D => N_2779, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[4]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[8]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3437, C => 
        N_3392, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[8]_net_1\, 
        Y => \PIOWORD_4_31_am[8]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[5]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2588, D => N_2828, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[5]_net_1\);
    
    \SRXMODEDATAWORD[15]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[15]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[15]_net_1\);
    
    \SRXFIFO_13[13]\ : SLE
      port map(D => \PIODATAWORD_c[221]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[10]_net_1\, B => 
        \SRXFIFO_4[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[10]\);
    
    \SRXFIFO_4[13]\ : SLE
      port map(D => \PIODATAWORD_c[77]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[13]_net_1\);
    
    \PIODATAWORD_ibuf[167]\ : INBUF
      port map(PAD => PIODATAWORD(167), Y => \PIODATAWORD_c[167]\);
    
    \PIODATAWORD_ibuf[427]\ : INBUF
      port map(PAD => PIODATAWORD(427), Y => \PIODATAWORD_c[427]\);
    
    \SRXFIFO_3[11]\ : SLE
      port map(D => \PIODATAWORD_c[59]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[11]_net_1\);
    
    \SRXFIFO_2[3]\ : SLE
      port map(D => \PIODATAWORD_c[35]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[3]_net_1\);
    
    \SRXFIFO_26[15]\ : SLE
      port map(D => \PIODATAWORD_c[431]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[15]_net_1\);
    
    \PIODATAWORD_ibuf[20]\ : INBUF
      port map(PAD => PIODATAWORD(20), Y => \PIODATAWORD_c[20]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[8]\, 
        C => \PIODATAWORD_c[184]\, D => \PIODATAWORD_c[136]\, Y
         => N_2831);
    
    \PIODATAWORD_ibuf[67]\ : INBUF
      port map(PAD => PIODATAWORD(67), Y => \PIODATAWORD_c[67]\);
    
    \PIODATAWORD_ibuf[170]\ : INBUF
      port map(PAD => PIODATAWORD(170), Y => \PIODATAWORD_c[170]\);
    
    \FFempty_flag_generator.un45_sregaddr.m8_1\ : CFG4
      generic map(INIT => x"2AAB")

      port map(A => \PICMD_c[15]\, B => \PICMD_c[14]\, C => 
        \PICMD_c[13]\, D => \PICMD_c[11]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.m8_1_net_1\);
    
    \SRXFIFO_29[12]\ : SLE
      port map(D => \PIODATAWORD_c[476]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[12]_net_1\);
    
    \SRXFIFO_18[14]\ : SLE
      port map(D => \PIODATAWORD_c[302]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[14]_net_1\);
    
    \SRXFIFO_24[9]\ : SLE
      port map(D => \PIODATAWORD_c[393]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[9]_net_1\);
    
    \SRXFIFO_16[6]\ : SLE
      port map(D => \PIODATAWORD_c[262]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[6]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[5]_net_1\, B => 
        \SRXFIFO_15[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[5]\, 
        Y => N_3659);
    
    \PIODATAWORD_ibuf[252]\ : INBUF
      port map(PAD => PIODATAWORD(252), Y => \PIODATAWORD_c[252]\);
    
    \SRXFIFO_8[2]\ : SLE
      port map(D => \PIODATAWORD_c[130]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[2]_net_1\);
    
    \PIODATAWORD_ibuf[64]\ : INBUF
      port map(PAD => PIODATAWORD(64), Y => \PIODATAWORD_c[64]\);
    
    \PIOWORD_1[14]\ : SLE
      port map(D => \un1_SCOMMWORD_u_0[14]\, CLK => PICLK_c, EN
         => pioword29, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[14]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[0]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_4564, C => 
        N_4561, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[0]_net_1\, 
        Y => \PIOWORD_4_31_bm[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[2]_net_1\, B => 
        \SRXFIFO_6[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[2]\);
    
    PISTR_ibuf : INBUF
      port map(PAD => PISTR, Y => PISTR_c);
    
    \PIODATAWORD_ibuf[188]\ : INBUF
      port map(PAD => PIODATAWORD(188), Y => \PIODATAWORD_c[188]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_ns[6]\ : 
        CFG4
      generic map(INIT => x"5E0E")

      port map(A => \PIRegAddr_c[0]\, B => \SCTRL[6]_net_1\, C
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_ns_1[6]_net_1\, 
        D => \PIOWORD_4[6]\, Y => N_191);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[14]_net_1\, B => 
        \SRXFIFO_5[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[14]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[2]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3326, D => N_3281, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[2]_net_1\);
    
    \SRXFIFO_16[10]\ : SLE
      port map(D => \PIODATAWORD_c[266]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[10]_net_1\);
    
    RF0STAT : SLE
      port map(D => RF0STAT_1, CLK => PICLK_c, EN => 
        \H6110_states[2]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \RF0STAT\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_2[7]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[7]_net_1\, B => \PIOWORD_4[7]\, C => 
        \PIRegAddr_c[3]\, Y => N_4591);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[10]\, 
        C => \PIODATAWORD_c[122]\, D => \PIODATAWORD_c[74]\, Y
         => N_2545);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[14]_net_1\, B => 
        \SRXFIFO_15[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[14]\, 
        Y => N_3668);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[209]\, B => 
        \PIODATAWORD_c[225]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[13]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3337, D => N_3292, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[13]_net_1\);
    
    \PIODATAWORD_ibuf[254]\ : INBUF
      port map(PAD => PIODATAWORD(254), Y => \PIODATAWORD_c[254]\);
    
    \SRXFIFO_25[11]\ : SLE
      port map(D => \PIODATAWORD_c[411]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[10]\, 
        C => \PIODATAWORD_c[378]\, D => \PIODATAWORD_c[330]\, Y
         => N_2657);
    
    \H6110_states[6]\ : SLE
      port map(D => GND_net_1, CLK => PICLK_c, EN => 
        sprtycheck_i_0, ALn => PIMR_c_i_0, ADn => GND_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \H6110_states[6]_net_1\);
    
    \PIODATAWORD_ibuf[90]\ : INBUF
      port map(PAD => PIODATAWORD(90), Y => \PIODATAWORD_c[90]\);
    
    \PIODATAWORD_ibuf[469]\ : INBUF
      port map(PAD => PIODATAWORD(469), Y => \PIODATAWORD_c[469]\);
    
    \error_states[1]\ : SLE
      port map(D => N_2453_i_0, CLK => PICLK_c, EN => VCC_net_1, 
        ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \error_states[1]_net_1\);
    
    \SRXFIFO_3[2]\ : SLE
      port map(D => \PIODATAWORD_c[50]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_58\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_57\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_56\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_55\, 
        Y => N_2651);
    
    \SRXFIFO_8[3]\ : SLE
      port map(D => \PIODATAWORD_c[131]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[8]_net_1\, B => 
        \SRXFIFO_11[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[8]\, 
        Y => N_3617);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[7]_net_1\, B => 
        \SRXFIFO_12[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[7]\, 
        Y => N_3331);
    
    \SRXFIFO_1[13]\ : SLE
      port map(D => \PIODATAWORD_c[29]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[13]_net_1\);
    
    \SRXFIFO_18[3]\ : SLE
      port map(D => \PIODATAWORD_c[291]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[3]_net_1\);
    
    \PIODATAWORD_ibuf[486]\ : INBUF
      port map(PAD => PIODATAWORD(486), Y => \PIODATAWORD_c[486]\);
    
    \PIODATAWORD_ibuf[289]\ : INBUF
      port map(PAD => PIODATAWORD(289), Y => \PIODATAWORD_c[289]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_6[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[196]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_8\);
    
    \SRXFIFO_21[8]\ : SLE
      port map(D => \PIODATAWORD_c[344]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[8]_net_1\);
    
    RcvaSTAT : SLE
      port map(D => RcvaSTAT_3, CLK => PICLK_c, EN => 
        \H6110_states[4]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => PORCVA_c);
    
    PICLK_ibuf_RNION57 : CLKINT
      port map(A => \PICLK_ibuf\, Y => PICLK_c);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_7[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[484]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_51\);
    
    \PIODATAWORD_ibuf[377]\ : INBUF
      port map(PAD => PIODATAWORD(377), Y => \PIODATAWORD_c[377]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[8]_net_1\, B => 
        \SRXFIFO_1[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[8]\);
    
    \PIODATAWORD_ibuf[6]\ : INBUF
      port map(PAD => PIODATAWORD(6), Y => \PIODATAWORD_c[6]\);
    
    \PIODATAWORD_ibuf[120]\ : INBUF
      port map(PAD => PIODATAWORD(120), Y => \PIODATAWORD_c[120]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[8]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[8]\, C => \PIOWORD_4_31_am[8]\, Y => 
        \PIOWORD_4[8]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[5]_net_1\, B => 
        \SRXFIFO_0[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[5]\);
    
    \SBUSBWORD[3]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[3]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[10]_net_1\, B => 
        \SRXFIFO_7[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[10]\);
    
    \SRXFIFO_7[14]\ : SLE
      port map(D => \PIODATAWORD_c[126]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[14]_net_1\);
    
    \PIODATAWORD_ibuf[372]\ : INBUF
      port map(PAD => PIODATAWORD(372), Y => \PIODATAWORD_c[372]\);
    
    \PIODATAWORD_ibuf[453]\ : INBUF
      port map(PAD => PIODATAWORD(453), Y => \PIODATAWORD_c[453]\);
    
    \SCTRL[3]\ : SLE
      port map(D => \PIOWORD_in[3]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[3]_net_1\);
    
    \PIODATAWORD_ibuf[16]\ : INBUF
      port map(PAD => PIODATAWORD(16), Y => \PIODATAWORD_c[16]\);
    
    \SCOMMWORD[7]\ : SLE
      port map(D => \PICMD_c[7]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[7]_net_1\);
    
    \PICMD_ibuf[6]\ : INBUF
      port map(PAD => PICMD(6), Y => \PICMD_c[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[7]\, 
        C => \PIODATAWORD_c[119]\, D => \PIODATAWORD_c[71]\, Y
         => N_2542);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[4]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_58\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[14]_net_1\, B => 
        \SRXFIFO_8[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[14]\, 
        Y => N_3293);
    
    \SRXFIFO_21[13]\ : SLE
      port map(D => \PIODATAWORD_c[349]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[3]\, 
        C => \PIODATAWORD_c[371]\, D => \PIODATAWORD_c[323]\, Y
         => N_2650);
    
    \SRXFIFO_22[3]\ : SLE
      port map(D => \PIODATAWORD_c[355]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[3]_net_1\);
    
    \PIODATAWORD_ibuf[450]\ : INBUF
      port map(PAD => PIODATAWORD(450), Y => \PIODATAWORD_c[450]\);
    
    \SRXFIFO_16[11]\ : SLE
      port map(D => \PIODATAWORD_c[267]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[11]_net_1\);
    
    \SRXFIFO_9[6]\ : SLE
      port map(D => \PIODATAWORD_c[150]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[6]_net_1\);
    
    \SErrorCounter_cry[0]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[0]_net_1\, D => GND_net_1, FCI => 
        SErrorCounter_cry_cy, S => \SErrorCounter_s[0]\, Y => 
        OPEN, FCO => \SErrorCounter_cry[0]_net_1\);
    
    \SRXFIFO_19[5]\ : SLE
      port map(D => \PIODATAWORD_c[309]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[5]_net_1\);
    
    \PIODATAWORD_ibuf[78]\ : INBUF
      port map(PAD => PIODATAWORD(78), Y => \PIODATAWORD_c[78]\);
    
    \PIODATAWORD_ibuf[241]\ : INBUF
      port map(PAD => PIODATAWORD(241), Y => \PIODATAWORD_c[241]\);
    
    \PIODATAWORD_ibuf[359]\ : INBUF
      port map(PAD => PIODATAWORD(359), Y => \PIODATAWORD_c[359]\);
    
    \PIODATAWORD_ibuf[38]\ : INBUF
      port map(PAD => PIODATAWORD(38), Y => \PIODATAWORD_c[38]\);
    
    \SBUSBWORD[12]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[12]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[83]\, B => \PIODATAWORD_c[99]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[3]\);
    
    \SRXFIFO_5[6]\ : SLE
      port map(D => \PIODATAWORD_c[86]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[6]_net_1\);
    
    \SRXFIFO_0[0]\ : SLE
      port map(D => \PIODATAWORD_c[0]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[0]_net_1\);
    
    \PIODATAWORD_ibuf[353]\ : INBUF
      port map(PAD => PIODATAWORD(353), Y => \PIODATAWORD_c[353]\);
    
    \RXFIFOcount[2]\ : SLE
      port map(D => RXFIFOcount_n2, CLK => PICLK_c, EN => 
        RXFIFOcounte, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \RXFIFOcount[2]_net_1\);
    
    \PIODATAWORD_ibuf[106]\ : INBUF
      port map(PAD => PIODATAWORD(106), Y => \PIODATAWORD_c[106]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_sn_m4_i_o2\ : 
        CFG3
      generic map(INIT => x"F8")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[1]\, C
         => \PIRegAddr_c[2]\, Y => N_162);
    
    \SCTRL[8]\ : SLE
      port map(D => \PIOWORD_in[8]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[8]_net_1\);
    
    \PIODATAWORD_ibuf[327]\ : INBUF
      port map(PAD => PIODATAWORD(327), Y => \PIODATAWORD_c[327]\);
    
    \PIODATAWORD_ibuf[207]\ : INBUF
      port map(PAD => PIODATAWORD(207), Y => \PIODATAWORD_c[207]\);
    
    \SRXFIFO_17[2]\ : SLE
      port map(D => \PIODATAWORD_c[274]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[2]_net_1\);
    
    \SRXFIFO_12[15]\ : SLE
      port map(D => \PIODATAWORD_c[207]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[15]_net_1\);
    
    \SRXFIFO_20[11]\ : SLE
      port map(D => \PIODATAWORD_c[331]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[11]_net_1\);
    
    \SRXFIFO_19[2]\ : SLE
      port map(D => \PIODATAWORD_c[306]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[15]_net_1\, B => 
        \SRXFIFO_14[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[15]\, 
        Y => N_3444);
    
    \SRXFIFO_27[4]\ : SLE
      port map(D => \PIODATAWORD_c[436]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_a2_0_0_0[9]\ : 
        CFG2
      generic map(INIT => x"4")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, Y
         => N_231);
    
    \PIODATAWORD_ibuf[322]\ : INBUF
      port map(PAD => PIODATAWORD(322), Y => \PIODATAWORD_c[322]\);
    
    \SRXFIFO_14[12]\ : SLE
      port map(D => \PIODATAWORD_c[236]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[12]_net_1\);
    
    \PIOWORD_1[12]\ : SLE
      port map(D => N_3190, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[12]_net_1\);
    
    \PIODATAWORD_ibuf[262]\ : INBUF
      port map(PAD => PIODATAWORD(262), Y => \PIODATAWORD_c[262]\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[2]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3551, D => N_3506, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[2]_net_1\);
    
    \PIODATAWORD_ibuf[448]\ : INBUF
      port map(PAD => PIODATAWORD(448), Y => \PIODATAWORD_c[448]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[413]\, B => 
        \PIODATAWORD_c[429]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[13]\);
    
    \SBUSAWORD[10]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[10]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[10]_net_1\);
    
    \PIODATAWORD_ibuf[159]\ : INBUF
      port map(PAD => PIODATAWORD(159), Y => \PIODATAWORD_c[159]\);
    
    \PIOWORD_1[2]\ : SLE
      port map(D => N_214, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[2]_net_1\);
    
    \SRXFIFO_19[7]\ : SLE
      port map(D => \PIODATAWORD_c[311]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[3]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2890, C => N_2650, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[3]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[3]\);
    
    \SRXFIFO_19[8]\ : SLE
      port map(D => \PIODATAWORD_c[312]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO[11]\ : 
        CFG4
      generic map(INIT => x"3B38")

      port map(A => \SCOMMWORD[11]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[11]\, 
        C => \PIRegAddr_c[1]\, D => \SBUSAWORD[11]_net_1\, Y => 
        N_180);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[274]\, B => 
        \PIODATAWORD_c[290]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[2]\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u[10]\ : CFG4
      generic map(INIT => x"7340")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, C
         => N_4527, D => N_3159, Y => \un1_SCOMMWORD_u[10]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[8]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[8]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[8]\, Y => 
        \SRXMODEDATAWORD_1[8]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[4]_net_1\, B => 
        \SRXFIFO_14[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[4]\, 
        Y => N_3433);
    
    \SBUSBWORD[0]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[0]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[0]_net_1\);
    
    \PIODATAWORD_ibuf[264]\ : INBUF
      port map(PAD => PIODATAWORD(264), Y => \PIODATAWORD_c[264]\);
    
    \PIOWORD_1[11]\ : SLE
      port map(D => N_3176, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[11]_net_1\);
    
    \PIODATAWORD_ibuf[10]\ : INBUF
      port map(PAD => PIODATAWORD(10), Y => \PIODATAWORD_c[10]\);
    
    \PIRegAddr_ibuf[2]\ : INBUF
      port map(PAD => PIRegAddr(2), Y => \PIRegAddr_c[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[13]_net_1\, B => 
        \SRXFIFO_14[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[13]\, 
        Y => N_3442);
    
    \SRXFIFO_7[2]\ : SLE
      port map(D => \PIODATAWORD_c[114]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[2]_net_1\);
    
    \SRXFIFO_0[2]\ : SLE
      port map(D => \PIODATAWORD_c[2]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[2]_net_1\);
    
    \PIODATAWORD_ibuf[405]\ : INBUF
      port map(PAD => PIODATAWORD(405), Y => \PIODATAWORD_c[405]\);
    
    \PIODATAWORD_ibuf[296]\ : INBUF
      port map(PAD => PIODATAWORD(296), Y => \PIODATAWORD_c[296]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[1]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[1]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[1]\, Y => 
        \SRXMODEDATAWORD_1[1]\);
    
    \un9_sdatawordlen_1.H6110_states_tr5_i_o2\ : CFG4
      generic map(INIT => x"0810")

      port map(A => \SCOMMWORD[13]_net_1\, B => 
        \SCOMMWORD[15]_net_1\, C => 
        \un9_sdatawordlen_1.H6110_states_tr5_i_o2_1_net_1\, D => 
        \SCOMMWORD[14]_net_1\, Y => N_1120);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[14]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3443, C => 
        N_3398, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[14]_net_1\, 
        Y => \PIOWORD_4_31_am[14]\);
    
    \SRXFIFO_15[7]\ : SLE
      port map(D => \PIODATAWORD_c[247]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[7]_net_1\);
    
    \SRXFIFO_15[1]\ : SLE
      port map(D => \PIODATAWORD_c[241]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[1]_net_1\);
    
    \SRXMODEDATAWORD[12]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[12]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[12]_net_1\);
    
    \SRXFIFO_28[9]\ : SLE
      port map(D => \PIODATAWORD_c[457]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[9]_net_1\);
    
    PIRTAP_ibuf : INBUF
      port map(PAD => PIRTAP, Y => PIRTAP_c);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SCOMMWORD[5]_net_1\, D => \SRXMODEDATAWORD[5]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[5]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[9]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3438, C => 
        N_3393, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[9]_net_1\, 
        Y => \PIOWORD_4_31_am[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[2]_net_1\, B => 
        \SRXFIFO_5[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[0]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2775, C => N_2535, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[0]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[15]\, 
        C => \PIODATAWORD_c[63]\, D => \PIODATAWORD_c[15]\, Y => 
        N_2790);
    
    \SRXFIFO_28[11]\ : SLE
      port map(D => \PIODATAWORD_c[459]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[11]_net_1\);
    
    \SRXFIFO_27[5]\ : SLE
      port map(D => \PIODATAWORD_c[437]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[5]_net_1\);
    
    \SRXFIFO_20[3]\ : SLE
      port map(D => \PIODATAWORD_c[323]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[3]_net_1\);
    
    \SErrorCounter_cry[4]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[4]_net_1\, D => GND_net_1, FCI => 
        \SErrorCounter_cry[3]_net_1\, S => \SErrorCounter_s[4]\, 
        Y => OPEN, FCO => \SErrorCounter_cry[4]_net_1\);
    
    \SRXFIFO_19[15]\ : SLE
      port map(D => \PIODATAWORD_c[319]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[15]_net_1\);
    
    \PIODATAWORD_ibuf[48]\ : INBUF
      port map(PAD => PIODATAWORD(48), Y => \PIODATAWORD_c[48]\);
    
    \SRXFIFO_1[7]\ : SLE
      port map(D => \PIODATAWORD_c[23]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[7]_net_1\);
    
    \SRXFIFO_27[1]\ : SLE
      port map(D => \PIODATAWORD_c[433]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[15]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3339, D => N_3294, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[15]_net_1\);
    
    \SRXMODEDATAWORD[3]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[3]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[3]_net_1\);
    
    \SBUSBWORD[4]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[4]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[4]_net_1\);
    
    \PIODATAWORD_ibuf[463]\ : INBUF
      port map(PAD => PIODATAWORD(463), Y => \PIODATAWORD_c[463]\);
    
    \PIODATAWORD_ibuf[444]\ : INBUF
      port map(PAD => PIODATAWORD(444), Y => \PIODATAWORD_c[444]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[5]_net_1\, B => 
        \SRXFIFO_4[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[5]\);
    
    \SRXFIFO_2[12]\ : SLE
      port map(D => \PIODATAWORD_c[44]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[12]_net_1\);
    
    \SRXFIFO_31[2]\ : SLE
      port map(D => \PIODATAWORD_c[498]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[2]_net_1\);
    
    \PIOWORD_1[3]\ : SLE
      port map(D => N_85, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1_i_m3[5]\ : 
        CFG3
      generic map(INIT => x"B8")

      port map(A => \PIERR_c[5]\, B => \PIRegAddr_c[1]\, C => 
        \RF0STAT\, Y => N_198);
    
    \SRXFIFO_19[4]\ : SLE
      port map(D => \PIODATAWORD_c[308]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[4]_net_1\);
    
    \PIODATAWORD_ibuf[197]\ : INBUF
      port map(PAD => PIODATAWORD(197), Y => \PIODATAWORD_c[197]\);
    
    \PIODATAWORD_ibuf[460]\ : INBUF
      port map(PAD => PIODATAWORD(460), Y => \PIODATAWORD_c[460]\);
    
    \PIODATAWORD_ibuf[136]\ : INBUF
      port map(PAD => PIODATAWORD(136), Y => \PIODATAWORD_c[136]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[13]_net_1\, B => 
        \SRXFIFO_3[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[4]_net_1\, B => 
        \SRXFIFO_10[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[4]\, 
        Y => N_3388);
    
    \SRXFIFO_22[10]\ : SLE
      port map(D => \PIODATAWORD_c[362]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[10]_net_1\);
    
    \PIODATAWORD_ibuf[248]\ : INBUF
      port map(PAD => PIODATAWORD(248), Y => \PIODATAWORD_c[248]\);
    
    \PIODATAWORD_ibuf[237]\ : INBUF
      port map(PAD => PIODATAWORD(237), Y => \PIODATAWORD_c[237]\);
    
    \SRXFIFO_18[7]\ : SLE
      port map(D => \PIODATAWORD_c[295]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[7]_net_1\);
    
    \SRXFIFO_10[1]\ : SLE
      port map(D => \PIODATAWORD_c[161]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[1]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[8]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3332, D => N_3287, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[8]_net_1\);
    
    \PIODATAWORD_ibuf[369]\ : INBUF
      port map(PAD => PIODATAWORD(369), Y => \PIODATAWORD_c[369]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[12]_net_1\, B => 
        \SRXFIFO_15[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[12]\, 
        Y => N_3666);
    
    \PIODATAWORD_ibuf[363]\ : INBUF
      port map(PAD => PIODATAWORD(363), Y => \PIODATAWORD_c[363]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[341]\, B => 
        \PIODATAWORD_c[357]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[5]\);
    
    \SRXFIFO_13[12]\ : SLE
      port map(D => \PIODATAWORD_c[220]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[12]_net_1\);
    
    \PIODATAWORD_ibuf[145]\ : INBUF
      port map(PAD => PIODATAWORD(145), Y => \PIODATAWORD_c[145]\);
    
    \FFempty_flag_generator.un45_sregaddr.N_46_i\ : CFG2
      generic map(INIT => x"2")

      port map(A => \error_states[1]_net_1\, B => PIMR_c, Y => 
        N_46_i_0);
    
    \SRXFIFO_30[6]\ : SLE
      port map(D => \PIODATAWORD_c[486]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[14]_net_1\, B => 
        \SRXFIFO_0[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[14]\);
    
    \SRXFIFO_21[3]\ : SLE
      port map(D => \PIODATAWORD_c[339]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[14]\, 
        C => \PIODATAWORD_c[254]\, D => \PIODATAWORD_c[206]\, Y
         => N_2597);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[1]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2696, D => N_2936, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[1]_net_1\);
    
    \SRXFIFO_15[13]\ : SLE
      port map(D => \PIODATAWORD_c[253]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[13]_net_1\);
    
    \PIODATAWORD_ibuf[245]\ : INBUF
      port map(PAD => PIODATAWORD(245), Y => \PIODATAWORD_c[245]\);
    
    \SRXFIFO_27[13]\ : SLE
      port map(D => \PIODATAWORD_c[445]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[477]\, B => 
        \PIODATAWORD_c[493]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[12]_net_1\, B => 
        \SRXFIFO_11[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[12]\, 
        Y => N_3621);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_4[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[52]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_5\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[12]_net_1\, B => 
        \SRXFIFO_10[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[12]\, 
        Y => N_3396);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[1]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2776, C => N_2536, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[1]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[1]\);
    
    \SRXFIFO_26[1]\ : SLE
      port map(D => \PIODATAWORD_c[417]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[1]_net_1\);
    
    \SRXFIFO_22[9]\ : SLE
      port map(D => \PIODATAWORD_c[361]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[9]_net_1\);
    
    \PIOWORD_1[1]\ : SLE
      port map(D => N_4577_i_0, CLK => PICLK_c, EN => pioword29, 
        ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[1]_net_1\);
    
    \PIODATAWORD_ibuf[499]\ : INBUF
      port map(PAD => PIODATAWORD(499), Y => \PIODATAWORD_c[499]\);
    
    \PIODATAWORD_ibuf[507]\ : INBUF
      port map(PAD => PIODATAWORD(507), Y => \PIODATAWORD_c[507]\);
    
    \PIODATAWORD_ibuf[435]\ : INBUF
      port map(PAD => PIODATAWORD(435), Y => \PIODATAWORD_c[435]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1[11]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[11]_net_1\, B => \PIOWORD_4[11]\, C
         => \PIRegAddr_c[3]\, Y => N_4596);
    
    \PIODATAWORD_ibuf[341]\ : INBUF
      port map(PAD => PIODATAWORD(341), Y => \PIODATAWORD_c[341]\);
    
    \PIODATAWORD_ibuf[169]\ : INBUF
      port map(PAD => PIODATAWORD(169), Y => \PIODATAWORD_c[169]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[8]\ : 
        CFG3
      generic map(INIT => x"1D")

      port map(A => N_170, B => N_162, C => N_185, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[12]_net_1\, B => 
        \SRXFIFO_13[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[12]\, 
        Y => N_3561);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[12]_net_1\, B => 
        \SRXFIFO_9[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[12]\, 
        Y => N_3516);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[15]_net_1\, B => 
        \SRXFIFO_13[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[15]\, 
        Y => N_3564);
    
    ErrorSTAT : SLE
      port map(D => un1_errorstat5, CLK => PICLK_c, EN => 
        N_46_i_0, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        POERROR_c);
    
    \SRXFIFO_0[10]\ : SLE
      port map(D => \PIODATAWORD_c[10]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[10]_net_1\);
    
    \PIODATAWORD_ibuf[116]\ : INBUF
      port map(PAD => PIODATAWORD(116), Y => \PIODATAWORD_c[116]\);
    
    \FFempty_flag_generator.un45_sregaddr.N_4489_i\ : CFG3
      generic map(INIT => x"10")

      port map(A => \RXFIFOloaded\, B => \RXFIFOcount[0]_net_1\, 
        C => \FFempty_flag_generator.un45_sregaddr\, Y => 
        N_4489_i_0);
    
    \SRXFIFO_9[10]\ : SLE
      port map(D => \PIODATAWORD_c[154]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[10]_net_1\);
    
    \PIODATAWORD_ibuf[217]\ : INBUF
      port map(PAD => PIODATAWORD(217), Y => \PIODATAWORD_c[217]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[6]_net_1\, B => 
        \SRXFIFO_3[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[8]\, 
        C => \PIODATAWORD_c[376]\, D => \PIODATAWORD_c[328]\, Y
         => N_2655);
    
    \SRXFIFO_0[15]\ : SLE
      port map(D => \PIODATAWORD_c[15]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[15]_net_1\);
    
    \SCTRL[2]\ : SLE
      port map(D => \PIOWORD_in[2]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[2]_net_1\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_RNO_2[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[153]\, B => 
        \PIODATAWORD_c[185]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_21_1_1[9]\);
    
    \SRXFIFO_29[10]\ : SLE
      port map(D => \PIODATAWORD_c[474]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[10]_net_1\);
    
    \PIODATAWORD_ibuf[276]\ : INBUF
      port map(PAD => PIODATAWORD(276), Y => \PIODATAWORD_c[276]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[3]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[3]\, C => \PIOWORD_4_31_am[3]\, Y => 
        \PIOWORD_4[3]\);
    
    \SRXFIFO_9[15]\ : SLE
      port map(D => \PIODATAWORD_c[159]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[15]_net_1\);
    
    \PIODATAWORD_ibuf[88]\ : INBUF
      port map(PAD => PIODATAWORD(88), Y => \PIODATAWORD_c[88]\);
    
    \RXFIFOcount[4]\ : SLE
      port map(D => RXFIFOcount_n4, CLK => PICLK_c, EN => 
        RXFIFOcounte, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \RXFIFOcount[4]_net_1\);
    
    \PIODATAWORD_ibuf[0]\ : INBUF
      port map(PAD => PIODATAWORD(0), Y => \PIODATAWORD_c[0]\);
    
    \SRXFIFO_31[4]\ : SLE
      port map(D => \PIODATAWORD_c[500]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[343]\, B => 
        \PIODATAWORD_c[359]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[7]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[278]\, B => 
        \PIODATAWORD_c[294]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[6]\);
    
    \SRXFIFO_23[1]\ : SLE
      port map(D => \PIODATAWORD_c[369]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[1]_net_1\);
    
    POERROR_obuf : OUTBUF
      port map(D => POERROR_c, PAD => POERROR);
    
    \PIODATAWORD_ibuf[29]\ : INBUF
      port map(PAD => PIODATAWORD(29), Y => \PIODATAWORD_c[29]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[4]\ : 
        CFG4
      generic map(INIT => x"44FA")

      port map(A => N_4493, B => N_2939, C => N_2827, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[4]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[4]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[472]\, B => 
        \PIODATAWORD_c[488]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[8]\);
    
    \SRXFIFO_22[7]\ : SLE
      port map(D => \PIODATAWORD_c[359]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[7]_net_1\);
    
    \SRXFIFO_16[14]\ : SLE
      port map(D => \PIODATAWORD_c[270]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[14]_net_1\);
    
    \PIODATAWORD_ibuf[355]\ : INBUF
      port map(PAD => PIODATAWORD(355), Y => \PIODATAWORD_c[355]\);
    
    \SBUSBWORD[15]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[15]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[15]_net_1\);
    
    \SRXFIFO_5[13]\ : SLE
      port map(D => \PIODATAWORD_c[93]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[13]_net_1\);
    
    \SRXFIFO_29[1]\ : SLE
      port map(D => \PIODATAWORD_c[465]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[12]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[12]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[12]\, Y => 
        \SRXMODEDATAWORD_1[12]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_RNO_2[9]\ : CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[25]\, B => \PIODATAWORD_c[57]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => \un9_sdatawordlen_1.SRXMODEDATAWORD_1_18_1_1[9]\);
    
    \SRXFIFO_30[9]\ : SLE
      port map(D => \PIODATAWORD_c[489]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[9]_net_1\);
    
    \PIODATAWORD_ibuf[415]\ : INBUF
      port map(PAD => PIODATAWORD(415), Y => \PIODATAWORD_c[415]\);
    
    \FFempty_flag_generator.un45_sregaddr.N_44_i\ : CFG2
      generic map(INIT => x"2")

      port map(A => \H6110_states[5]_net_1\, B => PIMR_c, Y => 
        N_44_i_0);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[8]\, 
        C => \PIODATAWORD_c[248]\, D => \PIODATAWORD_c[200]\, Y
         => N_2591);
    
    \SCOMMWORD[5]\ : SLE
      port map(D => \PICMD_c[5]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[5]_net_1\);
    
    \PIODATAWORD_ibuf[401]\ : INBUF
      port map(PAD => PIODATAWORD(401), Y => \PIODATAWORD_c[401]\);
    
    \FFempty_flag_generator.un45_sregaddr.SCTRL_1_sqmuxa\ : CFG3
      generic map(INIT => x"04")

      port map(A => \SPrevSTR\, B => \PIRegAddr_c[2]\, C => 
        pioword29, Y => SCTRL_1_sqmuxa);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[16]\, B => \PIODATAWORD_c[32]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[6]_net_1\, B => 
        \SRXFIFO_7[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[6]\);
    
    \PIODATAWORD_ibuf[177]\ : INBUF
      port map(PAD => PIODATAWORD(177), Y => \PIODATAWORD_c[177]\);
    
    \SRXFIFO_10[13]\ : SLE
      port map(D => \PIODATAWORD_c[173]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[9]_net_1\, B => 
        \SRXFIFO_11[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[9]\, 
        Y => N_3618);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[8]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3557, D => N_3512, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[8]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[0]_net_1\, B => 
        \SRXFIFO_14[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[0]\, 
        Y => N_4549);
    
    \PIODATAWORD_ibuf[99]\ : INBUF
      port map(PAD => PIODATAWORD(99), Y => \PIODATAWORD_c[99]\);
    
    \SRXFIFO_28[6]\ : SLE
      port map(D => \PIODATAWORD_c[454]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[6]_net_1\);
    
    \SCOMMWORD[3]\ : SLE
      port map(D => \PICMD_c[3]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[3]_net_1\);
    
    \PIODATAWORD_ibuf[144]\ : INBUF
      port map(PAD => PIODATAWORD(144), Y => \PIODATAWORD_c[144]\);
    
    \PIODATAWORD_ibuf[502]\ : INBUF
      port map(PAD => PIODATAWORD(502), Y => \PIODATAWORD_c[502]\);
    
    \PIODATAWORD_ibuf[226]\ : INBUF
      port map(PAD => PIODATAWORD(226), Y => \PIODATAWORD_c[226]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[0]_net_1\, B => 
        \SRXFIFO_6[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[0]\);
    
    \PIODATAWORD_ibuf[75]\ : INBUF
      port map(PAD => PIODATAWORD(75), Y => \PIODATAWORD_c[75]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[337]\, B => 
        \PIODATAWORD_c[353]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[1]\);
    
    \SRXFIFO_24[14]\ : SLE
      port map(D => \PIODATAWORD_c[398]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[14]_net_1\);
    
    \PIODATAWORD_ibuf[292]\ : INBUF
      port map(PAD => PIODATAWORD(292), Y => \PIODATAWORD_c[292]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[8]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2703, D => N_2943, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_4[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[36]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_57\);
    
    \PIODATAWORD_ibuf[35]\ : INBUF
      port map(PAD => PIODATAWORD(35), Y => \PIODATAWORD_c[35]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.error_states_ns_i_0_a2[1]\ : 
        CFG4
      generic map(INIT => x"1333")

      port map(A => \SCTRL[6]_net_1\, B => 
        \error_states[0]_net_1\, C => un1_errorstat5, D => 
        \error_states[1]_net_1\, Y => \error_states_ns[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[6]\, 
        C => \PIODATAWORD_c[502]\, D => \PIODATAWORD_c[454]\, Y
         => N_2701);
    
    \SRXFIFO_6[10]\ : SLE
      port map(D => \PIODATAWORD_c[106]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[13]_net_1\, B => 
        \SRXFIFO_9[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[13]\, 
        Y => N_3517);
    
    \PIODATAWORD_ibuf[141]\ : INBUF
      port map(PAD => PIODATAWORD(141), Y => \PIODATAWORD_c[141]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[12]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[12]\, C => \PIOWORD_4_31_am[12]\, Y => 
        \PIOWORD_4[12]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[3]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3657, C => 
        N_3612, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[3]_net_1\, 
        Y => \PIOWORD_4_31_bm[3]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[2]_net_1\, B => 
        \SRXFIFO_0[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[4]_net_1\, B => 
        \SRXFIFO_5[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[4]\);
    
    \PIOWORD_iobuf[12]\ : BIBUF
      port map(PAD => PIOWORD(12), D => \PIOWORD_1[12]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[12]\);
    
    \PIODATAWORD_ibuf[294]\ : INBUF
      port map(PAD => PIODATAWORD(294), Y => \PIODATAWORD_c[294]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[0]\ : 
        CFG3
      generic map(INIT => x"E4")

      port map(A => \PIRegAddr_c[1]\, B => \IdleSTAT\, C => 
        \PIERR_c[0]\, Y => N_74);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[7]_net_1\, B => 
        \SRXFIFO_4[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[7]\);
    
    \SRXFIFO_6[15]\ : SLE
      port map(D => \PIODATAWORD_c[111]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[15]_net_1\);
    
    \PIODATAWORD_ibuf[479]\ : INBUF
      port map(PAD => PIODATAWORD(479), Y => \PIODATAWORD_c[479]\);
    
    \SRXFIFO_6[5]\ : SLE
      port map(D => \PIODATAWORD_c[101]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[5]_net_1\);
    
    \SRXFIFO_23[8]\ : SLE
      port map(D => \PIODATAWORD_c[376]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[7]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[7]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[7]\, Y => 
        \SRXMODEDATAWORD_1[7]\);
    
    \SRXFIFO_31[6]\ : SLE
      port map(D => \PIODATAWORD_c[502]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO[13]\ : 
        CFG4
      generic map(INIT => x"3B38")

      port map(A => \SCOMMWORD[13]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[13]\, 
        C => \PIRegAddr_c[1]\, D => \SBUSAWORD[13]_net_1\, Y => 
        N_174);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[6]_net_1\, B => 
        \SRXFIFO_0[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[6]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_ns[9]\ : CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[9]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[9]\, Y => 
        \SRXMODEDATAWORD_1[9]\);
    
    \RXFIFOcount[0]\ : SLE
      port map(D => N_4489_i_0, CLK => PICLK_c, EN => 
        RXFIFOcounte, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \RXFIFOcount[0]_net_1\);
    
    \PIODATAWORD_ibuf[407]\ : INBUF
      port map(PAD => PIODATAWORD(407), Y => \PIODATAWORD_c[407]\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_1[15]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[15]_net_1\, B => \PIOWORD_4[15]\, C
         => \PIRegAddr_c[3]\, Y => N_4499);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[10]\, 
        C => \PIODATAWORD_c[250]\, D => \PIODATAWORD_c[202]\, Y
         => N_2593);
    
    \SRXFIFO_14[6]\ : SLE
      port map(D => \PIODATAWORD_c[230]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[6]_net_1\);
    
    \PIOWORD_1[8]\ : SLE
      port map(D => N_210, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_4[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[180]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_21\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[3]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2586, D => N_2826, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[3]_net_1\);
    
    \SRXFIFO_18[13]\ : SLE
      port map(D => \PIODATAWORD_c[301]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[13]_net_1\);
    
    \PIODATAWORD_ibuf[127]\ : INBUF
      port map(PAD => PIODATAWORD(127), Y => \PIODATAWORD_c[127]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_pibusa_0_a2\ : CFG2
      generic map(INIT => x"2")

      port map(A => PIBUSA_c, B => PIBUSB_c, Y => un1_pibusa_0_a2);
    
    \PIODATAWORD_ibuf[2]\ : INBUF
      port map(PAD => PIODATAWORD(2), Y => \PIODATAWORD_c[2]\);
    
    \FFempty_flag_generator.un45_sregaddr.RXFIFOcount_n2\ : CFG4
      generic map(INIT => x"60A0")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[0]_net_1\, C => N_4406, D => 
        \RXFIFOcount[1]_net_1\, Y => RXFIFOcount_n2);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u_RNO_0[15]\ : CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[15]_net_1\, D => 
        \SRXMODEDATAWORD[15]_net_1\, Y => 
        \un9_sdatawordlen_1.un1_SCOMMWORD_4_1_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO[7]\ : 
        CFG4
      generic map(INIT => x"CB0B")

      port map(A => \SBUSBWORD[7]_net_1\, B => \PIRegAddr_c[3]\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[7]\, 
        D => \SBUSAWORD[7]_net_1\, Y => N_169);
    
    SErrorTimerFlag : SLE
      port map(D => N_90, CLK => PICLK_c, EN => N_1131_i_0, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => \SErrorTimerFlag\);
    
    \PIODATAWORD_ibuf[186]\ : INBUF
      port map(PAD => PIODATAWORD(186), Y => \PIODATAWORD_c[186]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[216]\, B => 
        \PIODATAWORD_c[232]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[8]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[12]\, 
        C => \PIODATAWORD_c[252]\, D => \PIODATAWORD_c[204]\, Y
         => N_2595);
    
    \PIODATAWORD_ibuf[493]\ : INBUF
      port map(PAD => PIODATAWORD(493), Y => \PIODATAWORD_c[493]\);
    
    \SRXFIFO_23[7]\ : SLE
      port map(D => \PIODATAWORD_c[375]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[7]_net_1\);
    
    \PIODATAWORD_ibuf[287]\ : INBUF
      port map(PAD => PIODATAWORD(287), Y => \PIODATAWORD_c[287]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[14]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2789, C => N_2549, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[14]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[14]\);
    
    \SRXFIFO_0[5]\ : SLE
      port map(D => \PIODATAWORD_c[5]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[5]_net_1\);
    
    \SErrorCounter_cry[3]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[3]_net_1\, D => GND_net_1, FCI => 
        \SErrorCounter_cry[2]_net_1\, S => \SErrorCounter_s[3]\, 
        Y => OPEN, FCO => \SErrorCounter_cry[3]_net_1\);
    
    \PIODATAWORD_ibuf[344]\ : INBUF
      port map(PAD => PIODATAWORD(344), Y => \PIODATAWORD_c[344]\);
    
    \PICMD_ibuf[1]\ : INBUF
      port map(PAD => PICMD(1), Y => \PICMD_c[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[15]\, 
        C => \PIODATAWORD_c[447]\, D => \PIODATAWORD_c[399]\, Y
         => N_2950);
    
    \SErrorCounter_cry[2]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[2]_net_1\, D => GND_net_1, FCI => 
        \SErrorCounter_cry[1]_net_1\, S => \SErrorCounter_s[2]\, 
        Y => OPEN, FCO => \SErrorCounter_cry[2]_net_1\);
    
    \PIODATAWORD_ibuf[431]\ : INBUF
      port map(PAD => PIODATAWORD(431), Y => \PIODATAWORD_c[431]\);
    
    \SCOMMWORD[12]\ : SLE
      port map(D => \PICMD_c[12]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[12]_net_1\, B => 
        \SRXFIFO_1[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[12]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[6]_net_1\, B => 
        \SRXFIFO_14[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[6]\, 
        Y => N_3435);
    
    \SBUSBWORD[5]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[5]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[5]_net_1\);
    
    \PIODATAWORD_ibuf[490]\ : INBUF
      port map(PAD => PIODATAWORD(490), Y => \PIODATAWORD_c[490]\);
    
    \PIODATAWORD_ibuf[365]\ : INBUF
      port map(PAD => PIODATAWORD(365), Y => \PIODATAWORD_c[365]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[7]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3436, C => 
        N_3391, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[7]_net_1\, 
        Y => \PIOWORD_4_31_am[7]\);
    
    \SRXFIFO_7[7]\ : SLE
      port map(D => \PIODATAWORD_c[119]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[15]_net_1\, B => 
        \SRXFIFO_5[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[15]\);
    
    \SCTRL[5]\ : SLE
      port map(D => \PIOWORD_in[5]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1_i_m3[7]\ : 
        CFG3
      generic map(INIT => x"B8")

      port map(A => \PIERR_c[7]\, B => \PIRegAddr_c[1]\, C => 
        POVALMESS_c, Y => N_189);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[2]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2697, D => N_2937, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[2]_net_1\);
    
    \SRXFIFO_18[0]\ : SLE
      port map(D => \PIODATAWORD_c[288]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[0]_net_1\);
    
    \PIODATAWORD_ibuf[399]\ : INBUF
      port map(PAD => PIODATAWORD(399), Y => \PIODATAWORD_c[399]\);
    
    \H6110_states[4]\ : SLE
      port map(D => N_2474_i_0, CLK => PICLK_c, EN => VCC_net_1, 
        ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \H6110_states[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3[6]\ : 
        CFG3
      generic map(INIT => x"E4")

      port map(A => N_162, B => N_168, C => N_191, Y => N_212);
    
    \PIODATAWORD_ibuf[429]\ : INBUF
      port map(PAD => PIODATAWORD(429), Y => \PIODATAWORD_c[429]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[17]\, B => \PIODATAWORD_c[33]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[1]\);
    
    \PIODATAWORD_ibuf[45]\ : INBUF
      port map(PAD => PIODATAWORD(45), Y => \PIODATAWORD_c[45]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[1]\, 
        C => \PIODATAWORD_c[113]\, D => \PIODATAWORD_c[65]\, Y
         => N_2536);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[2]\, 
        C => \PIODATAWORD_c[498]\, D => \PIODATAWORD_c[450]\, Y
         => N_2697);
    
    \SRXFIFO_22[0]\ : SLE
      port map(D => \PIODATAWORD_c[352]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_6\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_5\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_4\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_3\, 
        Y => N_2539);
    
    \PIODATAWORD_ibuf[393]\ : INBUF
      port map(PAD => PIODATAWORD(393), Y => \PIODATAWORD_c[393]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[4]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[4]\, C => \PIOWORD_4_31_am[4]\, Y => 
        \PIOWORD_4[4]\);
    
    \SRXFIFO_8[12]\ : SLE
      port map(D => \PIODATAWORD_c[140]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[12]_net_1\);
    
    \PIODATAWORD_ibuf[485]\ : INBUF
      port map(PAD => PIODATAWORD(485), Y => \PIODATAWORD_c[485]\);
    
    \PIODATAWORD_ibuf[100]\ : INBUF
      port map(PAD => PIODATAWORD(100), Y => \PIODATAWORD_c[100]\);
    
    \SRXMODEDATAWORD[8]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[8]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[8]_net_1\);
    
    \SRXFIFO_23[14]\ : SLE
      port map(D => \PIODATAWORD_c[382]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[14]_net_1\);
    
    \SRXFIFO_22[15]\ : SLE
      port map(D => \PIODATAWORD_c[367]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[15]_net_1\);
    
    \PIODATAWORD_ibuf[19]\ : INBUF
      port map(PAD => PIODATAWORD(19), Y => \PIODATAWORD_c[19]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[2]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2889, C => N_2649, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[2]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[2]\);
    
    \SRXFIFO_6[1]\ : SLE
      port map(D => \PIODATAWORD_c[97]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[10]_net_1\, B => 
        \SRXFIFO_2[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[10]\);
    
    \PIODATAWORD_ibuf[76]\ : INBUF
      port map(PAD => PIODATAWORD(76), Y => \PIODATAWORD_c[76]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[11]\, 
        C => \PIODATAWORD_c[187]\, D => \PIODATAWORD_c[139]\, Y
         => N_2834);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[12]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3336, D => N_3291, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[12]_net_1\);
    
    \PIODATAWORD_ibuf[36]\ : INBUF
      port map(PAD => PIODATAWORD(36), Y => \PIODATAWORD_c[36]\);
    
    \SRXFIFO_15[4]\ : SLE
      port map(D => \PIODATAWORD_c[244]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[4]_net_1\);
    
    \SRXFIFO_26[0]\ : SLE
      port map(D => \PIODATAWORD_c[416]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[0]_net_1\);
    
    \PIRTA_ibuf[2]\ : INBUF
      port map(PAD => PIRTA(2), Y => \PIRTA_c[2]\);
    
    \PIODATAWORD_ibuf[4]\ : INBUF
      port map(PAD => PIODATAWORD(4), Y => \PIODATAWORD_c[4]\);
    
    \PIODATAWORD_ibuf[340]\ : INBUF
      port map(PAD => PIODATAWORD(340), Y => \PIODATAWORD_c[340]\);
    
    \PIODATAWORD_ibuf[272]\ : INBUF
      port map(PAD => PIODATAWORD(272), Y => \PIODATAWORD_c[272]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[4]_net_1\, B => 
        \SRXFIFO_6[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[4]\);
    
    \SRXFIFO_4[14]\ : SLE
      port map(D => \PIODATAWORD_c[78]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[14]_net_1\);
    
    \SRXFIFO_3[7]\ : SLE
      port map(D => \PIODATAWORD_c[55]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[7]_net_1\);
    
    \SRXFIFO_26[11]\ : SLE
      port map(D => \PIODATAWORD_c[427]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[11]_net_1\);
    
    \SRXFIFO_21[2]\ : SLE
      port map(D => \PIODATAWORD_c[338]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[2]_net_1\);
    
    \PIODATAWORD_ibuf[199]\ : INBUF
      port map(PAD => PIODATAWORD(199), Y => \PIODATAWORD_c[199]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1_0[0]\ : 
        CFG3
      generic map(INIT => x"1D")

      port map(A => N_79, B => N_162, C => N_74, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[0]_net_1\);
    
    \SRXFIFO_22[1]\ : SLE
      port map(D => \PIODATAWORD_c[353]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[1]_net_1\);
    
    \SRXFIFO_12[10]\ : SLE
      port map(D => \PIODATAWORD_c[202]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[10]_net_1\);
    
    \PIODATAWORD_ibuf[53]\ : INBUF
      port map(PAD => PIODATAWORD(53), Y => \PIODATAWORD_c[53]\);
    
    \PIODATAWORD_ibuf[411]\ : INBUF
      port map(PAD => PIODATAWORD(411), Y => \PIODATAWORD_c[411]\);
    
    \PICMD_ibuf[7]\ : INBUF
      port map(PAD => PICMD(7), Y => \PICMD_c[7]\);
    
    \PIODATAWORD_ibuf[437]\ : INBUF
      port map(PAD => PIODATAWORD(437), Y => \PIODATAWORD_c[437]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[88]\, B => 
        \PIODATAWORD_c[104]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[8]\);
    
    \SRXFIFO_12[2]\ : SLE
      port map(D => \PIODATAWORD_c[194]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[2]_net_1\);
    
    \SRXFIFO_10[2]\ : SLE
      port map(D => \PIODATAWORD_c[162]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[401]\, B => 
        \PIODATAWORD_c[417]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[5]_net_1\, B => 
        \SRXFIFO_11[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[5]\, 
        Y => N_3614);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[15]_net_1\, B => 
        \SRXFIFO_10[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[15]\, 
        Y => N_3399);
    
    \SRXFIFO_26[2]\ : SLE
      port map(D => \PIODATAWORD_c[418]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[2]_net_1\);
    
    \SRXFIFO_1[3]\ : SLE
      port map(D => \PIODATAWORD_c[19]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[3]_net_1\);
    
    \PIODATAWORD_ibuf[274]\ : INBUF
      port map(PAD => PIODATAWORD(274), Y => \PIODATAWORD_c[274]\);
    
    \PIODATAWORD_ibuf[240]\ : INBUF
      port map(PAD => PIODATAWORD(240), Y => \PIODATAWORD_c[240]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[469]\, B => 
        \PIODATAWORD_c[485]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[3]_net_1\, B => 
        \SRXFIFO_1[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[3]\);
    
    \SRXFIFO_15[12]\ : SLE
      port map(D => \PIODATAWORD_c[252]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[12]_net_1\);
    
    \SCTRL[11]\ : SLE
      port map(D => \PIOWORD_in[11]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[11]_net_1\);
    
    \PIODATAWORD_ibuf[68]\ : INBUF
      port map(PAD => PIODATAWORD(68), Y => \PIODATAWORD_c[68]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[11]_net_1\, B => 
        \SRXFIFO_2[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[11]\);
    
    \PIERR_ibuf[5]\ : INBUF
      port map(PAD => PIERR(5), Y => \PIERR_c[5]\);
    
    \SRXFIFO_1[6]\ : SLE
      port map(D => \PIODATAWORD_c[22]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[6]_net_1\);
    
    \PIODATAWORD_ibuf[307]\ : INBUF
      port map(PAD => PIODATAWORD(307), Y => \PIODATAWORD_c[307]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_8[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[244]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_19\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[3]_net_1\, B => 
        \SRXFIFO_11[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[3]\, 
        Y => N_3612);
    
    \PIODATAWORD_ibuf[442]\ : INBUF
      port map(PAD => PIODATAWORD(442), Y => \PIODATAWORD_c[442]\);
    
    \PIODATAWORD_ibuf[153]\ : INBUF
      port map(PAD => PIODATAWORD(153), Y => \PIODATAWORD_c[153]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_errorstat5_0_0\ : 
        CFG4
      generic map(INIT => x"7FFF")

      port map(A => \SErrorCounter[7]_net_1\, B => 
        \SErrorCounter[6]_net_1\, C => \SCTRL[6]_net_1\, D => 
        N_57, Y => un1_errorstat5);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[13]_net_1\, B => 
        \SRXFIFO_1[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[13]\);
    
    \SRXFIFO_25[6]\ : SLE
      port map(D => \PIODATAWORD_c[406]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[6]_net_1\);
    
    \SRXFIFO_20[6]\ : SLE
      port map(D => \PIODATAWORD_c[326]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[6]_net_1\);
    
    \SCTRL[13]\ : SLE
      port map(D => \PIOWORD_in[13]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[13]_net_1\);
    
    \PIODATAWORD_ibuf[302]\ : INBUF
      port map(PAD => PIODATAWORD(302), Y => \PIODATAWORD_c[302]\);
    
    \SRXFIFO_29[15]\ : SLE
      port map(D => \PIODATAWORD_c[479]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[15]_net_1\);
    
    \SRXFIFO_1[9]\ : SLE
      port map(D => \PIODATAWORD_c[25]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[9]_net_1\);
    
    \SRXFIFO_3[13]\ : SLE
      port map(D => \PIODATAWORD_c[61]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[13]_net_1\);
    
    \SCTRL[12]\ : SLE
      port map(D => \PIOWORD_in[12]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[12]_net_1\);
    
    \SRXFIFO_8[8]\ : SLE
      port map(D => \PIODATAWORD_c[136]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[9]_net_1\, B => 
        \SRXFIFO_0[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[9]\);
    
    \SRXFIFO_3[9]\ : SLE
      port map(D => \PIODATAWORD_c[57]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[9]_net_1\);
    
    \SRXFIFO_1[5]\ : SLE
      port map(D => \PIODATAWORD_c[21]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[5]_net_1\);
    
    \PIODATAWORD_ibuf[473]\ : INBUF
      port map(PAD => PIODATAWORD(473), Y => \PIODATAWORD_c[473]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[11]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3560, D => N_3515, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[11]_net_1\);
    
    \SRXFIFO_1[14]\ : SLE
      port map(D => \PIODATAWORD_c[30]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[338]\, B => 
        \PIODATAWORD_c[354]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[11]\, 
        C => \PIODATAWORD_c[251]\, D => \PIODATAWORD_c[203]\, Y
         => N_2594);
    
    \PIODATAWORD_ibuf[222]\ : INBUF
      port map(PAD => PIODATAWORD(222), Y => \PIODATAWORD_c[222]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[7]\ : 
        CFG3
      generic map(INIT => x"1D")

      port map(A => N_169, B => N_162, C => N_189, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[7]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0[1]\ : 
        CFG4
      generic map(INIT => x"FEFC")

      port map(A => \H6110_states[1]_net_1\, B => N_90, C => 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_2[1]_net_1\, 
        D => N_70, Y => \H6110_states_ns[1]\);
    
    \SCOMMWORD[13]\ : SLE
      port map(D => \PICMD_c[13]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[13]_net_1\);
    
    \SRXFIFO_31[9]\ : SLE
      port map(D => \PIODATAWORD_c[505]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[9]_net_1\);
    
    \SRXFIFO_31[1]\ : SLE
      port map(D => \PIODATAWORD_c[497]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[1]_net_1\);
    
    \PIODATAWORD_ibuf[85]\ : INBUF
      port map(PAD => PIODATAWORD(85), Y => \PIODATAWORD_c[85]\);
    
    \PIODATAWORD_ibuf[417]\ : INBUF
      port map(PAD => PIODATAWORD(417), Y => \PIODATAWORD_c[417]\);
    
    \PIODATAWORD_ibuf[70]\ : INBUF
      port map(PAD => PIODATAWORD(70), Y => \PIODATAWORD_c[70]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[15]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2790, C => N_2550, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[15]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[15]\);
    
    \SRXFIFO_31[7]\ : SLE
      port map(D => \PIODATAWORD_c[503]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[7]_net_1\);
    
    \SRXFIFO_12[11]\ : SLE
      port map(D => \PIODATAWORD_c[203]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_a2[9]\ : 
        CFG4
      generic map(INIT => x"1000")

      port map(A => \PIRegAddr_c[2]\, B => \PIRegAddr_c[3]\, C
         => N_64, D => N_4593, Y => N_95);
    
    \SRXFIFO_19[10]\ : SLE
      port map(D => \PIODATAWORD_c[314]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[10]_net_1\);
    
    \PIODATAWORD_ibuf[470]\ : INBUF
      port map(PAD => PIODATAWORD(470), Y => \PIODATAWORD_c[470]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3[1]\ : 
        CFG4
      generic map(INIT => x"5D58")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[1]_net_1\, 
        B => \SCOMMWORD[1]_net_1\, C => \PIRegAddr_c[1]\, D => 
        \SBUSAWORD[1]_net_1\, Y => N_205);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_58\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_57\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_56\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_55\, 
        Y => N_2779);
    
    \SRXFIFO_25[9]\ : SLE
      port map(D => \PIODATAWORD_c[409]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[9]_net_1\);
    
    \SCTRL[15]\ : SLE
      port map(D => \PIOWORD_in[15]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[15]_net_1\);
    
    \PIODATAWORD_ibuf[348]\ : INBUF
      port map(PAD => PIODATAWORD(348), Y => \PIODATAWORD_c[348]\);
    
    \PIODATAWORD_ibuf[30]\ : INBUF
      port map(PAD => PIODATAWORD(30), Y => \PIODATAWORD_c[30]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[15]_net_1\, B => 
        \SRXFIFO_15[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[15]\, 
        Y => N_3669);
    
    \PIODATAWORD_ibuf[130]\ : INBUF
      port map(PAD => PIODATAWORD(130), Y => \PIODATAWORD_c[130]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_RNO_1[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[217]\, B => 
        \PIODATAWORD_c[249]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_6_1_1[9]\);
    
    \PIODATAWORD_ibuf[46]\ : INBUF
      port map(PAD => PIODATAWORD(46), Y => \PIODATAWORD_c[46]\);
    
    \PIODATAWORD_ibuf[505]\ : INBUF
      port map(PAD => PIODATAWORD(505), Y => \PIODATAWORD_c[505]\);
    
    \PIODATAWORD_ibuf[224]\ : INBUF
      port map(PAD => PIODATAWORD(224), Y => \PIODATAWORD_c[224]\);
    
    \PIERR_ibuf[8]\ : INBUF
      port map(PAD => PIERR(8), Y => \PIERR_c[8]\);
    
    \SCOMMWORD[10]\ : SLE
      port map(D => \PICMD_c[10]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[10]_net_1\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_0[4]\ : CFG4
      generic map(INIT => x"0347")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, C
         => \un9_sdatawordlen_1.un1_SCOMMWORD_u_1[4]_net_1\, D
         => \PIRegAddr_c[3]\, Y => 
        \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_0[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[407]\, B => 
        \PIODATAWORD_c[423]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[7]\);
    
    \SRXFIFO_7[3]\ : SLE
      port map(D => \PIODATAWORD_c[115]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[3]_net_1\);
    
    \PIODATAWORD_ibuf[379]\ : INBUF
      port map(PAD => PIODATAWORD(379), Y => \PIODATAWORD_c[379]\);
    
    \PIODATAWORD_ibuf[346]\ : INBUF
      port map(PAD => PIODATAWORD(346), Y => \PIODATAWORD_c[346]\);
    
    \SRXFIFO_24[5]\ : SLE
      port map(D => \PIODATAWORD_c[389]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[5]\, 
        C => \PIODATAWORD_c[117]\, D => \PIODATAWORD_c[69]\, Y
         => N_2540);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[1]_net_1\, B => 
        \SRXFIFO_15[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[1]\, 
        Y => N_3655);
    
    \SRXFIFO_13[4]\ : SLE
      port map(D => \PIODATAWORD_c[212]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[11]_net_1\, B => 
        \SRXFIFO_9[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[11]\, 
        Y => N_3515);
    
    \SRXFIFO_26[9]\ : SLE
      port map(D => \PIODATAWORD_c[425]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[9]_net_1\);
    
    \PIODATAWORD_ibuf[373]\ : INBUF
      port map(PAD => PIODATAWORD(373), Y => \PIODATAWORD_c[373]\);
    
    \SRXFIFO_9[3]\ : SLE
      port map(D => \PIODATAWORD_c[147]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[3]_net_1\);
    
    \SRXFIFO_21[4]\ : SLE
      port map(D => \PIODATAWORD_c[340]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[4]_net_1\);
    
    \SRXFIFO_31[13]\ : SLE
      port map(D => \PIODATAWORD_c[509]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[13]_net_1\);
    
    \SRXFIFO_19[6]\ : SLE
      port map(D => \PIODATAWORD_c[310]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_22\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_21\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_20\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_19\, 
        Y => N_2587);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[8]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2783, C => N_2543, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[8]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[8]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[2]_net_1\, B => 
        \SRXFIFO_9[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[2]\, 
        Y => N_3506);
    
    \SRXFIFO_10[12]\ : SLE
      port map(D => \PIODATAWORD_c[172]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[12]_net_1\);
    
    \PIRTA_ibuf[1]\ : INBUF
      port map(PAD => PIRTA(1), Y => \PIRTA_c[1]\);
    
    \PIODATAWORD_ibuf[253]\ : INBUF
      port map(PAD => PIODATAWORD(253), Y => \PIODATAWORD_c[253]\);
    
    \SBUSAWORD[2]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[2]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[2]_net_1\);
    
    \PIRegAddr_ibuf[1]\ : INBUF
      port map(PAD => PIRegAddr(1), Y => \PIRegAddr_c[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[9]_net_1\, B => 
        \SRXFIFO_3[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[145]\, B => 
        \PIODATAWORD_c[161]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[15]\, 
        C => \PIODATAWORD_c[191]\, D => \PIODATAWORD_c[143]\, Y
         => N_2838);
    
    \FFempty_flag_generator.un45_sregaddr.N_2474_i\ : CFG3
      generic map(INIT => x"60")

      port map(A => PIBUSA_c, B => PIBUSB_c, C => 
        \H6110_states[5]_net_1\, Y => N_2474_i_0);
    
    \PIODATAWORD_ibuf[423]\ : INBUF
      port map(PAD => PIODATAWORD(423), Y => \PIODATAWORD_c[423]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[14]_net_1\, B => 
        \SRXFIFO_2[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[213]\, B => 
        \PIODATAWORD_c[229]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[5]\);
    
    \FFempty_flag_generator.un45_sregaddr.RXFIFOcount_n4\ : CFG4
      generic map(INIT => x"48C0")

      port map(A => RXFIFOcount_c2, B => N_4406, C => 
        \RXFIFOcount[4]_net_1\, D => \RXFIFOcount[3]_net_1\, Y
         => RXFIFOcount_n4);
    
    \SRXFIFO_14[1]\ : SLE
      port map(D => \PIODATAWORD_c[225]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[5]\, 
        C => \PIODATAWORD_c[53]\, D => \PIODATAWORD_c[5]\, Y => 
        N_2780);
    
    \SRXFIFO_20[9]\ : SLE
      port map(D => \PIODATAWORD_c[329]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[9]_net_1\);
    
    \PIODATAWORD_ibuf[179]\ : INBUF
      port map(PAD => PIODATAWORD(179), Y => \PIODATAWORD_c[179]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[80]\, B => \PIODATAWORD_c[96]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[0]\);
    
    \PIODATAWORD_ibuf[337]\ : INBUF
      port map(PAD => PIODATAWORD(337), Y => \PIODATAWORD_c[337]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[14]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2597, D => N_2837, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[14]_net_1\);
    
    \PIODATAWORD_ibuf[52]\ : INBUF
      port map(PAD => PIODATAWORD(52), Y => \PIODATAWORD_c[52]\);
    
    \SRXFIFO_19[0]\ : SLE
      port map(D => \PIODATAWORD_c[304]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[0]_net_1\);
    
    \PIODATAWORD_ibuf[420]\ : INBUF
      port map(PAD => PIODATAWORD(420), Y => \PIODATAWORD_c[420]\);
    
    \PIODATAWORD_ibuf[110]\ : INBUF
      port map(PAD => PIODATAWORD(110), Y => \PIODATAWORD_c[110]\);
    
    \SRXFIFO_16[7]\ : SLE
      port map(D => \PIODATAWORD_c[263]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[7]_net_1\);
    
    \PIOWORD_iobuf[1]\ : BIBUF
      port map(PAD => PIOWORD(1), D => \PIOWORD_1[1]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[1]\);
    
    \SRXFIFO_19[11]\ : SLE
      port map(D => \PIODATAWORD_c[315]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[11]_net_1\);
    
    \PIODATAWORD_ibuf[481]\ : INBUF
      port map(PAD => PIODATAWORD(481), Y => \PIODATAWORD_c[481]\);
    
    \SBUSBWORD[10]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[10]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[10]_net_1\);
    
    \SRXFIFO_27[3]\ : SLE
      port map(D => \PIODATAWORD_c[435]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[3]_net_1\);
    
    \PIODATAWORD_ibuf[332]\ : INBUF
      port map(PAD => PIODATAWORD(332), Y => \PIODATAWORD_c[332]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[11]_net_1\, B => 
        \SRXFIFO_3[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[11]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[4]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3658, C => 
        N_3613, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[4]_net_1\, 
        Y => \PIOWORD_4_31_bm[4]\);
    
    \SRXFIFO_6[2]\ : SLE
      port map(D => \PIODATAWORD_c[98]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[2]_net_1\);
    
    \PIODATAWORD_ibuf[329]\ : INBUF
      port map(PAD => PIODATAWORD(329), Y => \PIODATAWORD_c[329]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[7]_net_1\, B => 
        \SRXFIFO_8[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[7]\, 
        Y => N_3286);
    
    \SRXFIFO_7[10]\ : SLE
      port map(D => \PIODATAWORD_c[122]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[10]_net_1\);
    
    \SRXFIFO_30[12]\ : SLE
      port map(D => \PIODATAWORD_c[492]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[12]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2787, C => N_2547, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[12]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[13]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3562, D => N_3517, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[13]_net_1\);
    
    \SRXFIFO_2[11]\ : SLE
      port map(D => \PIODATAWORD_c[43]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SErrorCounter_0_sqmuxa_i_o2_0\ : 
        CFG4
      generic map(INIT => x"FEFF")

      port map(A => \SErrorCounter[5]_net_1\, B => 
        \SErrorCounter[4]_net_1\, C => \SErrorCounter[3]_net_1\, 
        D => N_72, Y => N_57);
    
    \SRXFIFO_1[2]\ : SLE
      port map(D => \PIODATAWORD_c[18]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[1]_net_1\, B => 
        \SRXFIFO_11[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[1]\, 
        Y => N_3610);
    
    \PIODATAWORD_ibuf[323]\ : INBUF
      port map(PAD => PIODATAWORD(323), Y => \PIODATAWORD_c[323]\);
    
    \PIODATAWORD_ibuf[40]\ : INBUF
      port map(PAD => PIODATAWORD(40), Y => \PIODATAWORD_c[40]\);
    
    \PICMD_ibuf[14]\ : INBUF
      port map(PAD => PICMD(14), Y => \PICMD_c[14]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[5]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3434, C => 
        N_3389, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[5]_net_1\, 
        Y => \PIOWORD_4_31_am[5]\);
    
    \PIODATAWORD_ibuf[163]\ : INBUF
      port map(PAD => PIODATAWORD(163), Y => \PIODATAWORD_c[163]\);
    
    \SRXFIFO_7[15]\ : SLE
      port map(D => \PIODATAWORD_c[127]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[15]_net_1\);
    
    \SRXFIFO_18[12]\ : SLE
      port map(D => \PIODATAWORD_c[300]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[12]_net_1\);
    
    \PIODATAWORD_ibuf[395]\ : INBUF
      port map(PAD => PIODATAWORD(395), Y => \PIODATAWORD_c[395]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[5]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2892, C => N_2652, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[5]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[5]\);
    
    \SBUSBWORD[8]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[8]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[8]_net_1\);
    
    \SRXFIFO_12[6]\ : SLE
      port map(D => \PIODATAWORD_c[198]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[8]\, 
        C => \PIODATAWORD_c[56]\, D => \PIODATAWORD_c[8]\, Y => 
        N_2783);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_RNO_2[9]\ : CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[281]\, B => 
        \PIODATAWORD_c[313]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_25_1_1[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[12]\, 
        C => \PIODATAWORD_c[188]\, D => \PIODATAWORD_c[140]\, Y
         => N_2835);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[8]_net_1\, B => 
        \SRXFIFO_6[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[8]\);
    
    \SRXFIFO_21[12]\ : SLE
      port map(D => \PIODATAWORD_c[348]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[12]_net_1\);
    
    \PIODATAWORD_ibuf[86]\ : INBUF
      port map(PAD => PIODATAWORD(86), Y => \PIODATAWORD_c[86]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[14]\, 
        C => \PIODATAWORD_c[190]\, D => \PIODATAWORD_c[142]\, Y
         => N_2837);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[5]_net_1\, B => 
        \SRXFIFO_6[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[4]_net_1\, B => 
        \SRXFIFO_0[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[4]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[1]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3655, C => 
        N_3610, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[1]_net_1\, 
        Y => \PIOWORD_4_31_bm[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_i_0_x2[2]\ : 
        CFG2
      generic map(INIT => x"6")

      port map(A => PIBUSA_c, B => PIBUSB_c, Y => N_63_i);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[11]\, 
        C => \PIODATAWORD_c[59]\, D => \PIODATAWORD_c[11]\, Y => 
        N_2786);
    
    \SRXFIFO_21[6]\ : SLE
      port map(D => \PIODATAWORD_c[342]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[151]\, B => 
        \PIODATAWORD_c[167]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[7]\);
    
    \PIODATAWORD_ibuf[317]\ : INBUF
      port map(PAD => PIODATAWORD(317), Y => \PIODATAWORD_c[317]\);
    
    \PIODATAWORD_ibuf[129]\ : INBUF
      port map(PAD => PIODATAWORD(129), Y => \PIODATAWORD_c[129]\);
    
    \H6110_states[1]\ : SLE
      port map(D => \H6110_states_ns[5]\, CLK => PICLK_c, EN => 
        VCC_net_1, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \H6110_states[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[4]_net_1\, B => 
        \SRXFIFO_8[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[4]\, 
        Y => N_3283);
    
    \PIODATAWORD_ibuf[142]\ : INBUF
      port map(PAD => PIODATAWORD(142), Y => \PIODATAWORD_c[142]\);
    
    \PIERR_ibuf[0]\ : INBUF
      port map(PAD => PIERR(0), Y => \PIERR_c[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[10]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2897, C => N_2657, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[10]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[10]\);
    
    \SRXFIFO_24[13]\ : SLE
      port map(D => \PIODATAWORD_c[397]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[13]_net_1\);
    
    \SErrorCounter_s[7]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[7]_net_1\, D => GND_net_1, FCI => 
        \SErrorCounter_cry[6]_net_1\, S => 
        \SErrorCounter_s[7]_net_1\, Y => OPEN, FCO => OPEN);
    
    \PIOWORD_iobuf[7]\ : BIBUF
      port map(PAD => PIOWORD(7), D => \PIOWORD_1[7]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[7]\);
    
    \SRXFIFO_11[5]\ : SLE
      port map(D => \PIODATAWORD_c[181]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[5]_net_1\);
    
    \PIODATAWORD_ibuf[487]\ : INBUF
      port map(PAD => PIODATAWORD(487), Y => \PIODATAWORD_c[487]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[6]_net_1\, B => 
        \SRXFIFO_8[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[6]\, 
        Y => N_3285);
    
    \PIODATAWORD_ibuf[312]\ : INBUF
      port map(PAD => PIODATAWORD(312), Y => \PIODATAWORD_c[312]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[93]\, B => 
        \PIODATAWORD_c[109]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[12]_net_1\, B => 
        \SRXFIFO_14[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[12]\, 
        Y => N_3441);
    
    \SRXFIFO_24[8]\ : SLE
      port map(D => \PIODATAWORD_c[392]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[8]_net_1\);
    
    \SRXFIFO_9[0]\ : SLE
      port map(D => \PIODATAWORD_c[144]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[3]\, 
        C => \PIODATAWORD_c[499]\, D => \PIODATAWORD_c[451]\, Y
         => N_2698);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[7]_net_1\, B => 
        \SRXFIFO_1[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[7]\);
    
    \un9_sdatawordlen_1.RcvbSTAT_3\ : CFG2
      generic map(INIT => x"2")

      port map(A => \SActB\, B => RcvaSTAT_1_sqmuxa, Y => 
        RcvbSTAT_3);
    
    \SRXFIFO_18[8]\ : SLE
      port map(D => \PIODATAWORD_c[296]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[7]_net_1\, B => 
        \SRXFIFO_7[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[7]\);
    
    \SRXFIFO_30[7]\ : SLE
      port map(D => \PIODATAWORD_c[487]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[92]\, B => 
        \PIODATAWORD_c[108]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[12]\);
    
    \SRXFIFO_16[13]\ : SLE
      port map(D => \PIODATAWORD_c[269]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[13]_net_1\);
    
    \PIOWORD_iobuf[4]\ : BIBUF
      port map(PAD => PIOWORD(4), D => \PIOWORD_1[4]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[4]\);
    
    \SRXFIFO_7[5]\ : SLE
      port map(D => \PIODATAWORD_c[117]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[5]_net_1\);
    
    \SRXFIFO_4[2]\ : SLE
      port map(D => \PIODATAWORD_c[66]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[6]_net_1\, B => 
        \SRXFIFO_13[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[6]\, 
        Y => N_3555);
    
    \SBUSBWORD[9]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[9]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[9]_net_1\);
    
    \PIODATAWORD_ibuf[5]\ : INBUF
      port map(PAD => PIODATAWORD(5), Y => \PIODATAWORD_c[5]\);
    
    SPRTYERR : SLE
      port map(D => sprtycheck, CLK => PICLK_c, EN => N_73_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => \SPRTYERR\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_RNO[6]\ : 
        CFG4
      generic map(INIT => x"CB0B")

      port map(A => \SBUSBWORD[6]_net_1\, B => \PIRegAddr_c[3]\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[6]\, 
        D => \SBUSAWORD[6]_net_1\, Y => N_168);
    
    \PIODATAWORD_ibuf[263]\ : INBUF
      port map(PAD => PIODATAWORD(263), Y => \PIODATAWORD_c[263]\);
    
    \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_0\ : CFG4
      generic map(INIT => x"7BDE")

      port map(A => \PIRTA_c[1]\, B => \PIRTA_c[0]\, C => 
        \PICMD_c[12]\, D => \PICMD_c[11]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_0_net_1\);
    
    \SRXFIFO_18[5]\ : SLE
      port map(D => \PIODATAWORD_c[293]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_8[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[116]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_3\);
    
    \SRXFIFO_25[14]\ : SLE
      port map(D => \PIODATAWORD_c[414]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[13]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2596, D => N_2836, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[13]_net_1\);
    
    \SRXFIFO_30[15]\ : SLE
      port map(D => \PIODATAWORD_c[495]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[15]_net_1\);
    
    \SRXFIFO_0[4]\ : SLE
      port map(D => \PIODATAWORD_c[4]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[4]_net_1\);
    
    \SRXFIFO_30[4]\ : SLE
      port map(D => \PIODATAWORD_c[484]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[4]_net_1\);
    
    \PIODATAWORD_ibuf[148]\ : INBUF
      port map(PAD => PIODATAWORD(148), Y => \PIODATAWORD_c[148]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[11]_net_1\, B => 
        \SRXFIFO_1[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[11]\);
    
    \FFempty_flag_generator.un45_sregaddr.sprtycheck_i_0\ : CFG3
      generic map(INIT => x"69")

      port map(A => \PIRTA_c[2]\, B => \PIRTA_c[1]\, C => 
        \FFempty_flag_generator.un45_sregaddr.sprtycheck_3_net_1\, 
        Y => sprtycheck_i_0);
    
    \SRXFIFO_24[2]\ : SLE
      port map(D => \PIODATAWORD_c[386]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[31]\, B => \PIODATAWORD_c[47]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[279]\, B => 
        \PIODATAWORD_c[295]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[7]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[13]_net_1\, B => 
        \SRXFIFO_11[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[13]\, 
        Y => N_3622);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[11]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3335, D => N_3290, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[11]_net_1\);
    
    PIMR_ibuf_RNITGAD : CLKINT
      port map(A => \PIMR_ibuf\, Y => PIMR_c);
    
    \PIODATAWORD_ibuf[80]\ : INBUF
      port map(PAD => PIODATAWORD(80), Y => \PIODATAWORD_c[80]\);
    
    \SErrorCounter_cry_cy[0]\ : ARI1
      generic map(INIT => x"42AAA")

      port map(A => N_57, B => \SCTRL[6]_net_1\, C => 
        \SErrorCounter[7]_net_1\, D => \SErrorCounter[6]_net_1\, 
        FCI => VCC_net_1, S => OPEN, Y => 
        \SErrorCounter_cry_cy_Y[0]\, FCO => SErrorCounter_cry_cy);
    
    \PIODATAWORD_ibuf[206]\ : INBUF
      port map(PAD => PIODATAWORD(206), Y => \PIODATAWORD_c[206]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[6]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2781, C => N_2541, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[6]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[6]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[4]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3328, D => N_3283, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[4]_net_1\);
    
    \SRXFIFO_30[11]\ : SLE
      port map(D => \PIODATAWORD_c[491]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1_0_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[0]_net_1\, D => \SRXMODEDATAWORD[0]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m2_1_1[0]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[7]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3331, D => N_3286, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[7]_net_1\);
    
    \PIOWORD_iobuf[2]\ : BIBUF
      port map(PAD => PIOWORD(2), D => \PIOWORD_1[2]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[2]\);
    
    \PIODATAWORD_ibuf[180]\ : INBUF
      port map(PAD => PIODATAWORD(180), Y => \PIODATAWORD_c[180]\);
    
    \SRXFIFO_22[8]\ : SLE
      port map(D => \PIODATAWORD_c[360]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[8]_net_1\);
    
    \SRXFIFO_23[6]\ : SLE
      port map(D => \PIODATAWORD_c[374]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[6]_net_1\);
    
    \SRXFIFO_10[8]\ : SLE
      port map(D => \PIODATAWORD_c[168]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[8]_net_1\);
    
    \PIODATAWORD_ibuf[446]\ : INBUF
      port map(PAD => PIODATAWORD(446), Y => \PIODATAWORD_c[446]\);
    
    \SRXFIFO_5[1]\ : SLE
      port map(D => \PIODATAWORD_c[81]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[1]_net_1\);
    
    \PIODATAWORD_ibuf[251]\ : INBUF
      port map(PAD => PIODATAWORD(251), Y => \PIODATAWORD_c[251]\);
    
    \PIODATAWORD_ibuf[249]\ : INBUF
      port map(PAD => PIODATAWORD(249), Y => \PIODATAWORD_c[249]\);
    
    \PIODATAWORD_ibuf[65]\ : INBUF
      port map(PAD => PIODATAWORD(65), Y => \PIODATAWORD_c[65]\);
    
    \SErrorCounter_cry[1]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[1]_net_1\, D => GND_net_1, FCI => 
        \SErrorCounter_cry[0]_net_1\, S => \SErrorCounter_s[1]\, 
        Y => OPEN, FCO => \SErrorCounter_cry[1]_net_1\);
    
    \SRXFIFO_13[0]\ : SLE
      port map(D => \PIODATAWORD_c[208]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[0]_net_1\);
    
    \SRXFIFO_12[4]\ : SLE
      port map(D => \PIODATAWORD_c[196]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[4]_net_1\);
    
    \SRXFIFO_10[0]\ : SLE
      port map(D => \PIODATAWORD_c[160]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[5]\, 
        C => \PIODATAWORD_c[245]\, D => \PIODATAWORD_c[197]\, Y
         => N_2588);
    
    \SRXFIFO_12[14]\ : SLE
      port map(D => \PIODATAWORD_c[206]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[14]_net_1\);
    
    \SRXFIFO_10[5]\ : SLE
      port map(D => \PIODATAWORD_c[165]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[1]_net_1\, B => 
        \SRXFIFO_13[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[1]\, 
        Y => N_3550);
    
    \PIODATAWORD_ibuf[508]\ : INBUF
      port map(PAD => PIODATAWORD(508), Y => \PIODATAWORD_c[508]\);
    
    \PIODATAWORD_ibuf[375]\ : INBUF
      port map(PAD => PIODATAWORD(375), Y => \PIODATAWORD_c[375]\);
    
    \SRXFIFO_8[0]\ : SLE
      port map(D => \PIODATAWORD_c[128]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[8]_net_1\, B => 
        \SRXFIFO_10[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[8]\, 
        Y => N_3392);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[2]\, 
        C => \PIODATAWORD_c[434]\, D => \PIODATAWORD_c[386]\, Y
         => N_2937);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[10]\, 
        C => \PIODATAWORD_c[186]\, D => \PIODATAWORD_c[138]\, Y
         => N_2833);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[13]_net_1\, B => 
        \SRXFIFO_13[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[13]\, 
        Y => N_3562);
    
    \SRXFIFO_23[13]\ : SLE
      port map(D => \PIODATAWORD_c[381]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[13]_net_1\);
    
    \SRXFIFO_19[9]\ : SLE
      port map(D => \PIODATAWORD_c[313]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[13]_net_1\, B => 
        \SRXFIFO_2[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[13]\);
    
    \SRXFIFO_29[3]\ : SLE
      port map(D => \PIODATAWORD_c[467]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[3]_net_1\);
    
    \SErrorCounter[2]\ : SLE
      port map(D => \SErrorCounter_s[2]\, CLK => PICLK_c, EN => 
        \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[0]_net_1\, B => 
        \SRXFIFO_0[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[0]\);
    
    \PIODATAWORD_ibuf[107]\ : INBUF
      port map(PAD => PIODATAWORD(107), Y => \PIODATAWORD_c[107]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[13]\, 
        C => \PIODATAWORD_c[317]\, D => \PIODATAWORD_c[269]\, Y
         => N_2900);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[90]\, B => 
        \PIODATAWORD_c[106]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[10]\);
    
    \H6110_states[2]\ : SLE
      port map(D => \H6110_states_ns[4]\, CLK => PICLK_c, EN => 
        VCC_net_1, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \H6110_states[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[5]\, 
        C => \PIODATAWORD_c[309]\, D => \PIODATAWORD_c[261]\, Y
         => N_2892);
    
    \PIODATAWORD_ibuf[458]\ : INBUF
      port map(PAD => PIODATAWORD(458), Y => \PIODATAWORD_c[458]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SCOMMWORD[7]_net_1\, D => \SRXMODEDATAWORD[7]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[7]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[346]\, B => 
        \PIODATAWORD_c[362]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[10]\);
    
    \SRXFIFO_0[3]\ : SLE
      port map(D => \PIODATAWORD_c[3]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[3]_net_1\);
    
    \PIODATAWORD_ibuf[387]\ : INBUF
      port map(PAD => PIODATAWORD(387), Y => \PIODATAWORD_c[387]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[3]_net_1\, B => 
        \SRXFIFO_5[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[3]\);
    
    \SRXFIFO_20[14]\ : SLE
      port map(D => \PIODATAWORD_c[334]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[14]_net_1\);
    
    \SRXFIFO_5[14]\ : SLE
      port map(D => \PIODATAWORD_c[94]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[3]\ : 
        CFG3
      generic map(INIT => x"E4")

      port map(A => \PIRegAddr_c[1]\, B => \FfemptySTAT\, C => 
        \PIERR_c[3]\, Y => N_75);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[14]\, 
        C => \PIODATAWORD_c[318]\, D => \PIODATAWORD_c[270]\, Y
         => N_2901);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[6]_net_1\, B => 
        \SRXFIFO_12[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[6]\, 
        Y => N_3330);
    
    \SRXFIFO_17[6]\ : SLE
      port map(D => \PIODATAWORD_c[278]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[15]\, 
        C => \PIODATAWORD_c[127]\, D => \PIODATAWORD_c[79]\, Y
         => N_2550);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[2]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3656, C => 
        N_3611, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[2]_net_1\, 
        Y => \PIOWORD_4_31_bm[2]\);
    
    PIRW_ibuf : INBUF
      port map(PAD => PIRW, Y => PIRW_c);
    
    \PIODATAWORD_ibuf[382]\ : INBUF
      port map(PAD => PIODATAWORD(382), Y => \PIODATAWORD_c[382]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_8[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[100]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_55\);
    
    \SRXFIFO_27[12]\ : SLE
      port map(D => \PIODATAWORD_c[444]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[12]_net_1\);
    
    \SRXFIFO_27[0]\ : SLE
      port map(D => \PIODATAWORD_c[432]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[404]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_30\);
    
    \SRXFIFO_15[5]\ : SLE
      port map(D => \PIODATAWORD_c[245]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[5]_net_1\);
    
    \SRXFIFO_4[3]\ : SLE
      port map(D => \PIODATAWORD_c[67]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[3]_net_1\);
    
    \SRXFIFO_0[12]\ : SLE
      port map(D => \PIODATAWORD_c[12]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[12]_net_1\);
    
    \SRXFIFO_21[9]\ : SLE
      port map(D => \PIODATAWORD_c[345]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[9]_net_1\);
    
    \SRXFIFO_21[1]\ : SLE
      port map(D => \PIODATAWORD_c[337]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[1]_net_1\);
    
    \PICMD_ibuf[13]\ : INBUF
      port map(PAD => PICMD(13), Y => \PICMD_c[13]\);
    
    \SRXFIFO_9[12]\ : SLE
      port map(D => \PIODATAWORD_c[156]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[9]_net_1\, B => 
        \SRXFIFO_9[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[9]\, 
        Y => N_3513);
    
    \SRXFIFO_21[7]\ : SLE
      port map(D => \PIODATAWORD_c[343]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[7]_net_1\);
    
    \PIODATAWORD_ibuf[409]\ : INBUF
      port map(PAD => PIODATAWORD(409), Y => \PIODATAWORD_c[409]\);
    
    \PIODATAWORD_ibuf[325]\ : INBUF
      port map(PAD => PIODATAWORD(325), Y => \PIODATAWORD_c[325]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[2]_net_1\, B => 
        \SRXFIFO_15[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[2]\, 
        Y => N_3656);
    
    \SRXFIFO_19[14]\ : SLE
      port map(D => \PIODATAWORD_c[318]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[14]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_1[9]\ : 
        CFG4
      generic map(INIT => x"CCCE")

      port map(A => \SPRTYERR\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0[9]_net_1\, 
        C => \PIRegAddr_c[3]\, D => N_64, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_1[9]_net_1\);
    
    \SRXFIFO_11[15]\ : SLE
      port map(D => \PIODATAWORD_c[191]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[15]_net_1\);
    
    \SRXFIFO_5[3]\ : SLE
      port map(D => \PIODATAWORD_c[83]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[3]_net_1\);
    
    \PIOWORD_iobuf[10]\ : BIBUF
      port map(PAD => PIOWORD(10), D => \PIOWORD_1[10]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[10]\);
    
    \PIODATAWORD_ibuf[236]\ : INBUF
      port map(PAD => PIODATAWORD(236), Y => \PIODATAWORD_c[236]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[10]_net_1\, B => 
        \SRXFIFO_9[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[10]\, 
        Y => N_3514);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[8]_net_1\, B => 
        \SRXFIFO_8[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[8]\, 
        Y => N_3287);
    
    \SCTRL[4]\ : SLE
      port map(D => \PIOWORD_in[4]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[4]_net_1\);
    
    \PIODATAWORD_ibuf[79]\ : INBUF
      port map(PAD => PIODATAWORD(79), Y => \PIODATAWORD_c[79]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[8]\, 
        C => \PIODATAWORD_c[312]\, D => \PIODATAWORD_c[264]\, Y
         => N_2895);
    
    \SCTRL[7]\ : SLE
      port map(D => \PIOWORD_in[7]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[7]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[0]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_4549, C => 
        N_4546, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[0]_net_1\, 
        Y => \PIOWORD_4_31_am[0]\);
    
    PORCVB_obuf : OUTBUF
      port map(D => PORCVB_c, PAD => PORCVB);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[285]\, B => 
        \PIODATAWORD_c[301]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[14]_net_1\, B => 
        \SRXFIFO_13[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[14]\, 
        Y => N_3563);
    
    \PIODATAWORD_ibuf[454]\ : INBUF
      port map(PAD => PIODATAWORD(454), Y => \PIODATAWORD_c[454]\);
    
    \PIODATAWORD_ibuf[39]\ : INBUF
      port map(PAD => PIODATAWORD(39), Y => \PIODATAWORD_c[39]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[14]_net_1\, B => 
        \SRXFIFO_3[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[14]\);
    
    \PIRTA_ibuf[0]\ : INBUF
      port map(PAD => PIRTA(0), Y => \PIRTA_c[0]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[4]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3553, D => N_3508, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[403]\, B => 
        \PIODATAWORD_c[419]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[3]\);
    
    \PIODATAWORD_ibuf[193]\ : INBUF
      port map(PAD => PIODATAWORD(193), Y => \PIODATAWORD_c[193]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[1]_net_1\, B => 
        \SRXFIFO_8[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[1]\, 
        Y => N_3280);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[15]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3444, C => 
        N_3399, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[15]_net_1\, 
        Y => \PIOWORD_4_31_am[15]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[7]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3556, D => N_3511, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_3[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[308]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_57\);
    
    \SRXFIFO_28[14]\ : SLE
      port map(D => \PIODATAWORD_c[462]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[14]_net_1\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_1_RNO[9]\ : 
        CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[201]\, B => 
        \PIODATAWORD_c[233]\, C => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_6_1_1[9]\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_2592);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_3[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[420]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_53\);
    
    \PIODATAWORD_ibuf[66]\ : INBUF
      port map(PAD => PIODATAWORD(66), Y => \PIODATAWORD_c[66]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[7]\, 
        C => \PIODATAWORD_c[503]\, D => \PIODATAWORD_c[455]\, Y
         => N_2702);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[0]\, 
        C => \PIODATAWORD_c[368]\, D => \PIODATAWORD_c[320]\, Y
         => N_2647);
    
    \PIODATAWORD_ibuf[258]\ : INBUF
      port map(PAD => PIODATAWORD(258), Y => \PIODATAWORD_c[258]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[1]_net_1\, B => 
        \SRXFIFO_12[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[1]\, 
        Y => N_3325);
    
    \PIODATAWORD_ibuf[261]\ : INBUF
      port map(PAD => PIODATAWORD(261), Y => \PIODATAWORD_c[261]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[2]\, 
        C => \PIODATAWORD_c[178]\, D => \PIODATAWORD_c[130]\, Y
         => N_2825);
    
    \SRXFIFO_24[0]\ : SLE
      port map(D => \PIODATAWORD_c[384]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[0]_net_1\);
    
    \SRXFIFO_14[7]\ : SLE
      port map(D => \PIODATAWORD_c[231]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[14]_net_1\, D => 
        \SRXMODEDATAWORD[14]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[14]\);
    
    \PIODATAWORD_ibuf[137]\ : INBUF
      port map(PAD => PIODATAWORD(137), Y => \PIODATAWORD_c[137]\);
    
    SActB : SLE
      port map(D => un1_pibusb_0_a2, CLK => PICLK_c, EN => 
        N_44_i_0, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SActB\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[7]_net_1\, B => 
        \SRXFIFO_15[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[7]\, 
        Y => N_3661);
    
    \FFempty_flag_generator.un45_sregaddr.N_73_i\ : CFG2
      generic map(INIT => x"2")

      port map(A => \H6110_states[6]_net_1\, B => PIMR_c, Y => 
        N_73_i_0);
    
    \SRXFIFO_8[11]\ : SLE
      port map(D => \PIODATAWORD_c[139]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[2]\, 
        C => \PIODATAWORD_c[114]\, D => \PIODATAWORD_c[66]\, Y
         => N_2537);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[13]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3667, C => 
        N_3622, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[13]_net_1\, 
        Y => \PIOWORD_4_31_bm[13]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_1_RNO[9]\ : 
        CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[457]\, B => 
        \PIODATAWORD_c[489]\, C => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_13_1_1[9]\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_2704);
    
    \SRXFIFO_4[6]\ : SLE
      port map(D => \PIODATAWORD_c[70]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[6]_net_1\);
    
    \PIODATAWORD_ibuf[23]\ : INBUF
      port map(PAD => PIODATAWORD(23), Y => \PIODATAWORD_c[23]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_i_i_a2[3]\ : 
        CFG2
      generic map(INIT => x"2")

      port map(A => \H6110_states[4]_net_1\, B => 
        RcvaSTAT_1_sqmuxa, Y => N_100);
    
    
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_a3_0_a2[4]\ : 
        CFG4
      generic map(INIT => x"0020")

      port map(A => N_61, B => 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_o2_1[1]_net_1\, 
        C => \H6110_states[3]_net_1\, D => \SPRTYERR\, Y => 
        \H6110_states_ns[4]\);
    
    \PIODATAWORD_ibuf[216]\ : INBUF
      port map(PAD => PIODATAWORD(216), Y => \PIODATAWORD_c[216]\);
    
    \PIODATAWORD_ibuf[155]\ : INBUF
      port map(PAD => PIODATAWORD(155), Y => \PIODATAWORD_c[155]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[0]_net_1\, B => 
        \SRXFIFO_9[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[0]\, 
        Y => N_4554);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_2[0]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[0]_net_1\, B => \PIOWORD_4[0]\, C => 
        \PIRegAddr_c[3]\, Y => N_4583);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_5[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[452]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_52\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[287]\, B => 
        \PIODATAWORD_c[303]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[15]\);
    
    \SRXFIFO_0[9]\ : SLE
      port map(D => \PIODATAWORD_c[9]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[9]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[15]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3669, C => 
        N_3624, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[15]_net_1\, 
        Y => \PIOWORD_4_31_bm[15]\);
    
    \SRXMODEDATAWORD[4]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[4]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[4]_net_1\);
    
    \PIODATAWORD_ibuf[255]\ : INBUF
      port map(PAD => PIODATAWORD(255), Y => \PIODATAWORD_c[255]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[13]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[13]\, C => \PIOWORD_4_31_am[13]\, Y => 
        \PIOWORD_4[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[11]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[11]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[11]\, Y => 
        \SRXMODEDATAWORD_1[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[30]\, B => \PIODATAWORD_c[46]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[14]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[8]_net_1\, B => 
        \SRXFIFO_15[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[8]\, 
        Y => N_3662);
    
    \SRXFIFO_8[6]\ : SLE
      port map(D => \PIODATAWORD_c[134]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[6]_net_1\);
    
    \SRXFIFO_6[0]\ : SLE
      port map(D => \PIODATAWORD_c[96]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[2]_net_1\, B => 
        \SRXFIFO_3[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[2]\);
    
    \SRXFIFO_6[12]\ : SLE
      port map(D => \PIODATAWORD_c[108]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[12]_net_1\);
    
    \SRXFIFO_16[4]\ : SLE
      port map(D => \PIODATAWORD_c[260]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[4]_net_1\);
    
    \PIODATAWORD_ibuf[468]\ : INBUF
      port map(PAD => PIODATAWORD(468), Y => \PIODATAWORD_c[468]\);
    
    \PIODATAWORD_ibuf[3]\ : INBUF
      port map(PAD => PIODATAWORD(3), Y => \PIODATAWORD_c[3]\);
    
    \PIODATAWORD_ibuf[351]\ : INBUF
      port map(PAD => PIODATAWORD(351), Y => \PIODATAWORD_c[351]\);
    
    \SCOMMWORD[0]\ : SLE
      port map(D => \PICMD_c[0]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[0]_net_1\);
    
    \PIODATAWORD_ibuf[293]\ : INBUF
      port map(PAD => PIODATAWORD(293), Y => \PIODATAWORD_c[293]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[9]_net_1\, B => 
        \SRXFIFO_4[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[8]_net_1\, B => 
        \SRXFIFO_4[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[8]\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u_1[4]\ : CFG4
      generic map(INIT => x"AF11")

      port map(A => \PIRegAddr_c[3]\, B => 
        \SRXMODEDATAWORD[4]_net_1\, C => \SCOMMWORD[4]_net_1\, D
         => \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_1[4]_net_1\, Y
         => \un9_sdatawordlen_1.un1_SCOMMWORD_u_1[4]_net_1\);
    
    \PIODATAWORD_ibuf[439]\ : INBUF
      port map(PAD => PIODATAWORD(439), Y => \PIODATAWORD_c[439]\);
    
    \PIODATAWORD_ibuf[202]\ : INBUF
      port map(PAD => PIODATAWORD(202), Y => \PIODATAWORD_c[202]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[13]\, 
        C => \PIODATAWORD_c[381]\, D => \PIODATAWORD_c[333]\, Y
         => N_2660);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[467]\, B => 
        \PIODATAWORD_c[483]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[3]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[14]_net_1\, B => 
        \SRXFIFO_4[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[14]\);
    
    \SRXFIFO_21[10]\ : SLE
      port map(D => \PIODATAWORD_c[346]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[10]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_2[8]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[8]_net_1\, B => \PIOWORD_4[8]\, C => 
        \PIRegAddr_c[3]\, Y => N_4592);
    
    \PIODATAWORD_ibuf[93]\ : INBUF
      port map(PAD => PIODATAWORD(93), Y => \PIODATAWORD_c[93]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[11]\, 
        C => \PIODATAWORD_c[443]\, D => \PIODATAWORD_c[395]\, Y
         => N_2946);
    
    \SRXFIFO_18[4]\ : SLE
      port map(D => \PIODATAWORD_c[292]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[4]_net_1\);
    
    \PIODATAWORD_ibuf[49]\ : INBUF
      port map(PAD => PIODATAWORD(49), Y => \PIODATAWORD_c[49]\);
    
    \SRXFIFO_22[11]\ : SLE
      port map(D => \PIODATAWORD_c[363]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[11]_net_1\);
    
    \SBUSAWORD[14]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[14]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[14]_net_1\);
    
    \SRXFIFO_16[12]\ : SLE
      port map(D => \PIODATAWORD_c[268]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[12]_net_1\);
    
    \PIODATAWORD_ibuf[117]\ : INBUF
      port map(PAD => PIODATAWORD(117), Y => \PIODATAWORD_c[117]\);
    
    \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_1\ : CFG4
      generic map(INIT => x"7BDE")

      port map(A => \PIRTA_c[3]\, B => \PIRTA_c[2]\, C => 
        \PICMD_c[14]\, D => \PICMD_c[13]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_1_net_1\);
    
    \PIODATAWORD_ibuf[204]\ : INBUF
      port map(PAD => PIODATAWORD(204), Y => \PIODATAWORD_c[204]\);
    
    \PIERR_ibuf[4]\ : INBUF
      port map(PAD => PIERR(4), Y => \PIERR_c[4]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[415]\, B => 
        \PIODATAWORD_c[431]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[5]_net_1\, B => 
        \SRXFIFO_13[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[5]\, 
        Y => N_3554);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_RNO[9]\ : CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[73]\, B => 
        \PIODATAWORD_c[105]\, C => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_3_1_1[9]\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_2544);
    
    \PIODATAWORD_ibuf[60]\ : INBUF
      port map(PAD => PIODATAWORD(60), Y => \PIODATAWORD_c[60]\);
    
    \PIERR_ibuf[6]\ : INBUF
      port map(PAD => PIERR(6), Y => \PIERR_c[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2[3]\ : 
        CFG4
      generic map(INIT => x"20FD")

      port map(A => N_162, B => \PIRegAddr_c[0]\, C => N_4587, D
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[3]_net_1\, 
        Y => N_85);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[147]\, B => 
        \PIODATAWORD_c[163]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[3]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3[2]\ : 
        CFG4
      generic map(INIT => x"20FD")

      port map(A => N_162, B => \PIRegAddr_c[0]\, C => N_4586, D
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[2]_net_1\, 
        Y => N_214);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[14]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3563, D => N_3518, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[14]_net_1\);
    
    \SRXFIFO_15[3]\ : SLE
      port map(D => \PIODATAWORD_c[243]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_3[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[292]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_21\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO[12]\ : 
        CFG4
      generic map(INIT => x"3B38")

      port map(A => \SCOMMWORD[12]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[12]\, 
        C => \PIRegAddr_c[1]\, D => \SBUSAWORD[12]_net_1\, Y => 
        N_177);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[12]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2707, D => N_2947, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[12]_net_1\);
    
    \PIODATAWORD_ibuf[464]\ : INBUF
      port map(PAD => PIODATAWORD(464), Y => \PIODATAWORD_c[464]\);
    
    \SRXFIFO_20[7]\ : SLE
      port map(D => \PIODATAWORD_c[327]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[7]_net_1\);
    
    \PIODATAWORD_ibuf[51]\ : INBUF
      port map(PAD => PIODATAWORD(51), Y => \PIODATAWORD_c[51]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[11]_net_1\, D => 
        \SRXMODEDATAWORD[11]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[276]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_58\);
    
    \SRXMODEDATAWORD[5]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[5]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[5]_net_1\);
    
    SActA : SLE
      port map(D => un1_pibusa_0_a2, CLK => PICLK_c, EN => 
        N_44_i_0, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SActA\);
    
    \PIODATAWORD_ibuf[173]\ : INBUF
      port map(PAD => PIODATAWORD(173), Y => \PIODATAWORD_c[173]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[15]\, 
        C => \PIODATAWORD_c[383]\, D => \PIODATAWORD_c[335]\, Y
         => N_2662);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[9]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[9]\, C => \PIOWORD_4_31_am[9]\, Y => 
        \PIOWORD_4[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[10]_net_1\, B => 
        \SRXFIFO_10[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[10]\, 
        Y => N_3394);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3[8]\ : 
        CFG4
      generic map(INIT => x"20FD")

      port map(A => N_162, B => \PIRegAddr_c[0]\, C => N_4592, D
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[8]_net_1\, 
        Y => N_210);
    
    \PIODATAWORD_ibuf[403]\ : INBUF
      port map(PAD => PIODATAWORD(403), Y => \PIODATAWORD_c[403]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[6]\, 
        C => \PIODATAWORD_c[54]\, D => \PIODATAWORD_c[6]\, Y => 
        N_2781);
    
    \PIODATAWORD_ibuf[419]\ : INBUF
      port map(PAD => PIODATAWORD(419), Y => \PIODATAWORD_c[419]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[155]\, B => 
        \PIODATAWORD_c[171]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[11]_net_1\, B => 
        \SRXFIFO_8[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[11]\, 
        Y => N_3290);
    
    \un9_sdatawordlen_1.SUM[3]\ : CFG4
      generic map(INIT => x"3336")

      port map(A => \SCOMMWORD[2]_net_1\, B => 
        \SCOMMWORD[3]_net_1\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_4493);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[10]_net_1\, B => 
        \SRXFIFO_1[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[10]\);
    
    \SRXFIFO_5[9]\ : SLE
      port map(D => \PIODATAWORD_c[89]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[9]_net_1\);
    
    \SRXFIFO_31[10]\ : SLE
      port map(D => \PIODATAWORD_c[506]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[10]_net_1\);
    
    \SRXFIFO_11[0]\ : SLE
      port map(D => \PIODATAWORD_c[176]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[14]\, 
        C => \PIODATAWORD_c[126]\, D => \PIODATAWORD_c[78]\, Y
         => N_2549);
    
    \PIODATAWORD_ibuf[268]\ : INBUF
      port map(PAD => PIODATAWORD(268), Y => \PIODATAWORD_c[268]\);
    
    \SRXFIFO_17[15]\ : SLE
      port map(D => \PIODATAWORD_c[287]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[15]_net_1\);
    
    \PIOWORD_iobuf[3]\ : BIBUF
      port map(PAD => PIOWORD(3), D => \PIOWORD_1[3]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[3]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_cl_44_0[15]\ : 
        CFG4
      generic map(INIT => x"1202")

      port map(A => PIRW_c, B => PICS_c, C => PISTR_c, D => 
        \PIOWORD_cl[15]\, Y => \PIOWORD_cl_44[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[5]_net_1\, B => 
        \SRXFIFO_1[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[5]\);
    
    \PIODATAWORD_ibuf[400]\ : INBUF
      port map(PAD => PIODATAWORD(400), Y => \PIODATAWORD_c[400]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[6]_net_1\, B => 
        \SRXFIFO_2[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[6]\);
    
    \PIODATAWORD_ibuf[154]\ : INBUF
      port map(PAD => PIODATAWORD(154), Y => \PIODATAWORD_c[154]\);
    
    \SRXFIFO_29[11]\ : SLE
      port map(D => \PIODATAWORD_c[475]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[11]_net_1\);
    
    \SRXFIFO_26[5]\ : SLE
      port map(D => \PIODATAWORD_c[421]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[5]_net_1\);
    
    \SRXFIFO_20[4]\ : SLE
      port map(D => \PIODATAWORD_c[324]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[4]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[9]_net_1\, B => 
        \SRXFIFO_14[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[9]\, 
        Y => N_3438);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[15]_net_1\, B => 
        \SRXFIFO_7[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[15]\);
    
    \SRXFIFO_3[14]\ : SLE
      port map(D => \PIODATAWORD_c[62]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[14]_net_1\);
    
    \PIODATAWORD_ibuf[309]\ : INBUF
      port map(PAD => PIODATAWORD(309), Y => \PIODATAWORD_c[309]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[2]_net_1\, B => 
        \SRXFIFO_13[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[2]\, 
        Y => N_3551);
    
    \PIODATAWORD_ibuf[165]\ : INBUF
      port map(PAD => PIODATAWORD(165), Y => \PIODATAWORD_c[165]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_cl_48_0[15]\ : 
        CFG4
      generic map(INIT => x"FFF9")

      port map(A => PISTR_c, B => PIRW_c, C => PICS_c, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_cl_48_0_1_0[15]_net_1\, 
        Y => \PIOWORD_cl_48[15]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[3]_net_1\, B => 
        \SRXFIFO_14[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[3]\, 
        Y => N_3432);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[11]_net_1\, B => 
        \SRXFIFO_10[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[11]\, 
        Y => N_3395);
    
    \PIODATAWORD_ibuf[22]\ : INBUF
      port map(PAD => PIODATAWORD(22), Y => \PIODATAWORD_c[22]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_sqmuxa\ : CFG4
      generic map(INIT => x"0800")

      port map(A => \H6110_states[1]_net_1\, B => N_1120, C => 
        PIMR_c, D => N_61, Y => SRXMODEDATAWORD_1_sqmuxa);
    
    \PIODATAWORD_ibuf[303]\ : INBUF
      port map(PAD => PIODATAWORD(303), Y => \PIODATAWORD_c[303]\);
    
    \PIODATAWORD_ibuf[151]\ : INBUF
      port map(PAD => PIODATAWORD(151), Y => \PIODATAWORD_c[151]\);
    
    \PIODATAWORD_ibuf[265]\ : INBUF
      port map(PAD => PIODATAWORD(265), Y => \PIODATAWORD_c[265]\);
    
    \PIODATAWORD_ibuf[232]\ : INBUF
      port map(PAD => PIODATAWORD(232), Y => \PIODATAWORD_c[232]\);
    
    \PIODATAWORD_ibuf[286]\ : INBUF
      port map(PAD => PIODATAWORD(286), Y => \PIODATAWORD_c[286]\);
    
    \FFempty_flag_generator.un45_sregaddr.sprtycheck_3\ : CFG4
      generic map(INIT => x"6996")

      port map(A => \PIRTA_c[4]\, B => \PIRTA_c[3]\, C => 
        \PIRTA_c[0]\, D => PIRTAP_c, Y => 
        \FFempty_flag_generator.un45_sregaddr.sprtycheck_3_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.ALTB_ns[4]\ : CFG4
      generic map(INIT => x"127B")

      port map(A => \un9_sdatawordlen_1.CO3_i\, B => 
        \FFempty_flag_generator.un45_sregaddr.ALTB_ns_1[4]_net_1\, 
        C => \SCOMMWORD[4]_net_1\, D => \RXFIFOcount[4]_net_1\, Y
         => \FFempty_flag_generator.un45_sregaddr\);
    
    \SRXFIFO_23[5]\ : SLE
      port map(D => \PIODATAWORD_c[373]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[211]\, B => 
        \PIODATAWORD_c[227]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[3]\);
    
    \SRXFIFO_25[13]\ : SLE
      port map(D => \PIODATAWORD_c[413]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[13]_net_1\);
    
    \SRXFIFO_1[8]\ : SLE
      port map(D => \PIODATAWORD_c[24]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[8]_net_1\);
    
    \PIODATAWORD_ibuf[89]\ : INBUF
      port map(PAD => PIODATAWORD(89), Y => \PIODATAWORD_c[89]\);
    
    \SRXFIFO_4[10]\ : SLE
      port map(D => \PIODATAWORD_c[74]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_a2_0[1]\ : 
        CFG4
      generic map(INIT => x"F0D0")

      port map(A => N_61, B => 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_o2_1[1]_net_1\, 
        C => \H6110_states[3]_net_1\, D => \SPRTYERR\, Y => N_90);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[1]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2584, D => N_2824, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[1]_net_1\);
    
    \PIODATAWORD_ibuf[361]\ : INBUF
      port map(PAD => PIODATAWORD(361), Y => \PIODATAWORD_c[361]\);
    
    \PIODATAWORD_ibuf[123]\ : INBUF
      port map(PAD => PIODATAWORD(123), Y => \PIODATAWORD_c[123]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[15]_net_1\, B => 
        \SRXFIFO_8[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[15]\, 
        Y => N_3294);
    
    \PIODATAWORD_ibuf[234]\ : INBUF
      port map(PAD => PIODATAWORD(234), Y => \PIODATAWORD_c[234]\);
    
    \un9_sdatawordlen_1.H6110_states_tr5_i_o2_1\ : CFG3
      generic map(INIT => x"4D")

      port map(A => \SCOMMWORD[11]_net_1\, B => 
        \SCOMMWORD[14]_net_1\, C => \SCOMMWORD[12]_net_1\, Y => 
        \un9_sdatawordlen_1.H6110_states_tr5_i_o2_1_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[21]\, B => \PIODATAWORD_c[37]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[5]\);
    
    \PIODATAWORD_ibuf[273]\ : INBUF
      port map(PAD => PIODATAWORD(273), Y => \PIODATAWORD_c[273]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[280]\, B => 
        \PIODATAWORD_c[296]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[8]\);
    
    \SRXFIFO_4[15]\ : SLE
      port map(D => \PIODATAWORD_c[79]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[15]_net_1\);
    
    \PIODATAWORD_ibuf[13]\ : INBUF
      port map(PAD => PIODATAWORD(13), Y => \PIODATAWORD_c[13]\);
    
    \SRXFIFO_14[4]\ : SLE
      port map(D => \PIODATAWORD_c[228]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[4]_net_1\);
    
    \SErrorCounter[7]\ : SLE
      port map(D => \SErrorCounter_s[7]_net_1\, CLK => PICLK_c, 
        EN => \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1_i_m3[6]\ : 
        CFG3
      generic map(INIT => x"B8")

      port map(A => \PIERR_c[6]\, B => \PIRegAddr_c[1]\, C => 
        \RF1STAT\, Y => N_194);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[10]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3334, D => N_3289, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[479]\, B => 
        \PIODATAWORD_c[495]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[15]\);
    
    \PIODATAWORD_ibuf[109]\ : INBUF
      port map(PAD => PIODATAWORD(109), Y => \PIODATAWORD_c[109]\);
    
    \PIERR_ibuf[2]\ : INBUF
      port map(PAD => PIERR(2), Y => \PIERR_c[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[10]_net_1\, B => 
        \SRXFIFO_3[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[10]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[6]_net_1\, B => 
        \SRXFIFO_6[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[5]_net_1\, B => 
        \SRXFIFO_12[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[5]\, 
        Y => N_3329);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[7]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2702, D => N_2942, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[1]_net_1\, B => 
        \SRXFIFO_4[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[1]\);
    
    \SRXFIFO_23[9]\ : SLE
      port map(D => \PIODATAWORD_c[377]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[9]_net_1\);
    
    PORCVA_obuf : OUTBUF
      port map(D => PORCVA_c, PAD => PORCVA);
    
    \PIODATAWORD_ibuf[92]\ : INBUF
      port map(PAD => PIODATAWORD(92), Y => \PIODATAWORD_c[92]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[9]_net_1\, B => 
        \SRXFIFO_10[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[9]\, 
        Y => N_3393);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[10]\, 
        C => \PIODATAWORD_c[506]\, D => \PIODATAWORD_c[458]\, Y
         => N_2705);
    
    \PICMD_ibuf[10]\ : INBUF
      port map(PAD => PICMD(10), Y => \PICMD_c[10]\);
    
    \PIODATAWORD_ibuf[354]\ : INBUF
      port map(PAD => PIODATAWORD(354), Y => \PIODATAWORD_c[354]\);
    
    \PIODATAWORD_ibuf[187]\ : INBUF
      port map(PAD => PIODATAWORD(187), Y => \PIODATAWORD_c[187]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[4]_net_1\, B => 
        \SRXFIFO_13[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[4]\, 
        Y => N_3553);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[260]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_22\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[5]_net_1\, B => 
        \SRXFIFO_3[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[11]_net_1\, B => 
        \SRXFIFO_15[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[11]\, 
        Y => N_3665);
    
    \PIODATAWORD_ibuf[433]\ : INBUF
      port map(PAD => PIODATAWORD(433), Y => \PIODATAWORD_c[433]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[3]_net_1\, B => 
        \SRXFIFO_8[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[3]\, 
        Y => N_3282);
    
    \PIODATAWORD_ibuf[212]\ : INBUF
      port map(PAD => PIODATAWORD(212), Y => \PIODATAWORD_c[212]\);
    
    \SRXFIFO_16[8]\ : SLE
      port map(D => \PIODATAWORD_c[264]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[8]_net_1\);
    
    \PIODATAWORD_ibuf[291]\ : INBUF
      port map(PAD => PIODATAWORD(291), Y => \PIODATAWORD_c[291]\);
    
    \SRXFIFO_27[10]\ : SLE
      port map(D => \PIODATAWORD_c[442]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[10]_net_1\);
    
    \SRXFIFO_1[10]\ : SLE
      port map(D => \PIODATAWORD_c[26]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[10]_net_1\);
    
    \SBUSBWORD[7]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[7]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[219]\, B => 
        \PIODATAWORD_c[235]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[5]_net_1\, B => 
        \SRXFIFO_8[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[5]\, 
        Y => N_3284);
    
    \PIODATAWORD_ibuf[430]\ : INBUF
      port map(PAD => PIODATAWORD(430), Y => \PIODATAWORD_c[430]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm[9]\ : CFG4
      generic map(INIT => x"B383")

      port map(A => N_2544, B => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_1[9]_net_1\, 
        C => N_4493, D => N_2784, Y => 
        \SRXMODEDATAWORD_1_31_bm[9]\);
    
    \PIOWORD_1[7]\ : SLE
      port map(D => N_211, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[7]_net_1\);
    
    \PIOWORD_1[10]\ : SLE
      port map(D => \un1_SCOMMWORD_u[10]\, CLK => PICLK_c, EN => 
        pioword29, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[10]_net_1\);
    
    \PIODATAWORD_ibuf[214]\ : INBUF
      port map(PAD => PIODATAWORD(214), Y => \PIODATAWORD_c[214]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.error_states_ns_i_0_a2_RNIE7R31[1]\ : 
        CFG4
      generic map(INIT => x"0233")

      port map(A => \SErrorTimerFlag\, B => \error_states_ns[0]\, 
        C => \SPrevErrorTimerFlag\, D => \error_states[0]_net_1\, 
        Y => N_2453_i_0);
    
    \SRXFIFO_1[4]\ : SLE
      port map(D => \PIODATAWORD_c[20]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[4]_net_1\);
    
    \SRXFIFO_13[3]\ : SLE
      port map(D => \PIODATAWORD_c[211]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[3]_net_1\);
    
    \SRXFIFO_1[15]\ : SLE
      port map(D => \PIODATAWORD_c[31]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[15]_net_1\);
    
    \PIODATAWORD_ibuf[146]\ : INBUF
      port map(PAD => PIODATAWORD(146), Y => \PIODATAWORD_c[146]\);
    
    \SRXFIFO_27[7]\ : SLE
      port map(D => \PIODATAWORD_c[439]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[7]_net_1\);
    
    \PIODATAWORD_ibuf[223]\ : INBUF
      port map(PAD => PIODATAWORD(223), Y => \PIODATAWORD_c[223]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[12]_net_1\, B => 
        \SRXFIFO_5[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[12]\);
    
    \PIODATAWORD_ibuf[339]\ : INBUF
      port map(PAD => PIODATAWORD(339), Y => \PIODATAWORD_c[339]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[86]\, B => 
        \PIODATAWORD_c[102]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[0]_net_1\, B => 
        \SRXFIFO_4[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[0]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[11]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3440, C => 
        N_3395, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[11]_net_1\, 
        Y => \PIOWORD_4_31_am[11]\);
    
    \PIODATAWORD_ibuf[247]\ : INBUF
      port map(PAD => PIODATAWORD(247), Y => \PIODATAWORD_c[247]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[14]_net_1\, B => 
        \SRXFIFO_10[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[14]\, 
        Y => N_3398);
    
    \SRXFIFO_4[4]\ : SLE
      port map(D => \PIODATAWORD_c[68]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[5]\ : 
        CFG3
      generic map(INIT => x"1D")

      port map(A => N_167, B => N_162, C => N_198, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[159]\, B => 
        \PIODATAWORD_c[175]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[15]\);
    
    \PIODATAWORD_ibuf[333]\ : INBUF
      port map(PAD => PIODATAWORD(333), Y => \PIODATAWORD_c[333]\);
    
    \SRXFIFO_20[13]\ : SLE
      port map(D => \PIODATAWORD_c[333]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[13]_net_1\);
    
    \PIODATAWORD_ibuf[489]\ : INBUF
      port map(PAD => PIODATAWORD(489), Y => \PIODATAWORD_c[489]\);
    
    \PIODATAWORD_ibuf[164]\ : INBUF
      port map(PAD => PIODATAWORD(164), Y => \PIODATAWORD_c[164]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[2]_net_1\, B => 
        \SRXFIFO_12[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[2]\, 
        Y => N_3326);
    
    \PIODATAWORD_ibuf[1]\ : INBUF
      port map(PAD => PIODATAWORD(1), Y => \PIODATAWORD_c[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[5]_net_1\, B => 
        \SRXFIFO_5[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[5]\);
    
    \PIODATAWORD_ibuf[350]\ : INBUF
      port map(PAD => PIODATAWORD(350), Y => \PIODATAWORD_c[350]\);
    
    \PIODATAWORD_ibuf[498]\ : INBUF
      port map(PAD => PIODATAWORD(498), Y => \PIODATAWORD_c[498]\);
    
    \SRXFIFO_27[9]\ : SLE
      port map(D => \PIODATAWORD_c[441]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[9]_net_1\);
    
    \SRXFIFO_9[1]\ : SLE
      port map(D => \PIODATAWORD_c[145]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[11]_net_1\, B => 
        \SRXFIFO_11[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[11]\, 
        Y => N_3620);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_RNISTSH1[1]\ : 
        CFG4
      generic map(INIT => x"CACC")

      port map(A => N_205, B => N_206, C => \PIRegAddr_c[2]\, D
         => N_64, Y => N_4577_i_0);
    
    \PIODATAWORD_ibuf[413]\ : INBUF
      port map(PAD => PIODATAWORD(413), Y => \PIODATAWORD_c[413]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[0]_net_1\, B => 
        \SRXFIFO_11[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[0]\, 
        Y => N_4561);
    
    \PIODATAWORD_ibuf[161]\ : INBUF
      port map(PAD => PIODATAWORD(161), Y => \PIODATAWORD_c[161]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[11]_net_1\, B => 
        \SRXFIFO_0[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[11]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_errorstat5_0_o2\ : 
        CFG3
      generic map(INIT => x"7F")

      port map(A => \SErrorCounter[2]_net_1\, B => 
        \SErrorCounter[1]_net_1\, C => \SErrorCounter[0]_net_1\, 
        Y => N_72);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[8]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2591, D => N_2831, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[8]_net_1\);
    
    \SRXFIFO_26[3]\ : SLE
      port map(D => \PIODATAWORD_c[419]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[3]_net_1\);
    
    \SRXFIFO_12[13]\ : SLE
      port map(D => \PIODATAWORD_c[205]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[13]_net_1\);
    
    \PIODATAWORD_ibuf[250]\ : INBUF
      port map(PAD => PIODATAWORD(250), Y => \PIODATAWORD_c[250]\);
    
    \PIODATAWORD_ibuf[139]\ : INBUF
      port map(PAD => PIODATAWORD(139), Y => \PIODATAWORD_c[139]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[3]\, 
        C => \PIODATAWORD_c[51]\, D => \PIODATAWORD_c[3]\, Y => 
        N_2778);
    
    \SRXFIFO_28[1]\ : SLE
      port map(D => \PIODATAWORD_c[449]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[1]_net_1\);
    
    \SRXFIFO_14[9]\ : SLE
      port map(D => \PIODATAWORD_c[233]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[9]_net_1\);
    
    \PIODATAWORD_ibuf[445]\ : INBUF
      port map(PAD => PIODATAWORD(445), Y => \PIODATAWORD_c[445]\);
    
    \SRXFIFO_26[14]\ : SLE
      port map(D => \PIODATAWORD_c[430]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[14]_net_1\);
    
    \PIODATAWORD_ibuf[410]\ : INBUF
      port map(PAD => PIODATAWORD(410), Y => \PIODATAWORD_c[410]\);
    
    \SRXFIFO_2[13]\ : SLE
      port map(D => \PIODATAWORD_c[45]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[13]_net_1\);
    
    \SRXFIFO_24[3]\ : SLE
      port map(D => \PIODATAWORD_c[387]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[3]_net_1\);
    
    \PICMD_ibuf[5]\ : INBUF
      port map(PAD => PICMD(5), Y => \PICMD_c[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3[1]\ : 
        CFG4
      generic map(INIT => x"F1E0")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[3]\, C
         => \un1_SCOMMWORD_4_i_m3_d[1]\, D => \PIOWORD_4[1]\, Y
         => N_206);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[15]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2598, D => N_2838, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[15]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[2]_net_1\, B => 
        \SRXFIFO_11[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[2]\, 
        Y => N_3611);
    
    \SRXFIFO_21[15]\ : SLE
      port map(D => \PIODATAWORD_c[351]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[15]_net_1\);
    
    \PIODATAWORD_ibuf[452]\ : INBUF
      port map(PAD => PIODATAWORD(452), Y => \PIODATAWORD_c[452]\);
    
    \PIODATAWORD_ibuf[319]\ : INBUF
      port map(PAD => PIODATAWORD(319), Y => \PIODATAWORD_c[319]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[156]\, B => 
        \PIODATAWORD_c[172]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[286]\, B => 
        \PIODATAWORD_c[302]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[6]\, 
        C => \PIODATAWORD_c[310]\, D => \PIODATAWORD_c[262]\, Y
         => N_2893);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[10]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3559, D => N_3514, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[10]_net_1\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_1[4]\ : CFG3
      generic map(INIT => x"E2")

      port map(A => \PIERR_c[4]\, B => \PIRegAddr_c[3]\, C => 
        \SCTRL[4]_net_1\, Y => N_3064);
    
    \PIODATAWORD_ibuf[12]\ : INBUF
      port map(PAD => PIODATAWORD(12), Y => \PIODATAWORD_c[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[15]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3564, D => N_3519, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[15]_net_1\);
    
    \SRXFIFO_3[8]\ : SLE
      port map(D => \PIODATAWORD_c[56]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[8]_net_1\);
    
    \SRXFIFO_3[1]\ : SLE
      port map(D => \PIODATAWORD_c[49]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[1]_net_1\);
    
    \PIODATAWORD_ibuf[313]\ : INBUF
      port map(PAD => PIODATAWORD(313), Y => \PIODATAWORD_c[313]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[158]\, B => 
        \PIODATAWORD_c[174]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[12]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2899, C => N_2659, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[12]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[12]\);
    
    \SRXFIFO_7[12]\ : SLE
      port map(D => \PIODATAWORD_c[124]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[12]_net_1\);
    
    \SRXFIFO_28[13]\ : SLE
      port map(D => \PIODATAWORD_c[461]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[13]_net_1\);
    
    SPrevErrorTimerFlag : SLE
      port map(D => \SErrorTimerFlag\, CLK => PICLK_c, EN => 
        PIMR_c_i_0, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SPrevErrorTimerFlag\);
    
    \PIODATAWORD_ibuf[9]\ : INBUF
      port map(PAD => PIODATAWORD(9), Y => \PIODATAWORD_c[9]\);
    
    \PIODATAWORD_ibuf[494]\ : INBUF
      port map(PAD => PIODATAWORD(494), Y => \PIODATAWORD_c[494]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[4]_net_1\, B => 
        \SRXFIFO_12[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[4]\, 
        Y => N_3328);
    
    \SRXFIFO_5[2]\ : SLE
      port map(D => \PIODATAWORD_c[82]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[2]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[3]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3432, C => 
        N_3387, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[3]_net_1\, 
        Y => \PIOWORD_4_31_am[3]\);
    
    \SRXFIFO_6[7]\ : SLE
      port map(D => \PIODATAWORD_c[103]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[7]_net_1\);
    
    \SRXFIFO_23[2]\ : SLE
      port map(D => \PIODATAWORD_c[370]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[2]_net_1\);
    
    \SRXFIFO_11[10]\ : SLE
      port map(D => \PIODATAWORD_c[186]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[148]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_22\);
    
    \PIODATAWORD_ibuf[364]\ : INBUF
      port map(PAD => PIODATAWORD(364), Y => \PIODATAWORD_c[364]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[15]_net_1\, B => 
        \SRXFIFO_0[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[15]\);
    
    \SRXFIFO_3[6]\ : SLE
      port map(D => \PIODATAWORD_c[54]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[6]\, 
        C => \PIODATAWORD_c[374]\, D => \PIODATAWORD_c[326]\, Y
         => N_2653);
    
    \SRXFIFO_11[8]\ : SLE
      port map(D => \PIODATAWORD_c[184]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[275]\, B => 
        \PIODATAWORD_c[291]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[3]\);
    
    \PIODATAWORD_ibuf[57]\ : INBUF
      port map(PAD => PIODATAWORD(57), Y => \PIODATAWORD_c[57]\);
    
    \PIODATAWORD_ibuf[358]\ : INBUF
      port map(PAD => PIODATAWORD(358), Y => \PIODATAWORD_c[358]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[14]_net_1\, B => 
        \SRXFIFO_14[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[14]\, 
        Y => N_3443);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[13]_net_1\, B => 
        \SRXFIFO_5[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[13]\);
    
    \PIODATAWORD_ibuf[298]\ : INBUF
      port map(PAD => PIODATAWORD(298), Y => \PIODATAWORD_c[298]\);
    
    \SRXFIFO_7[4]\ : SLE
      port map(D => \PIODATAWORD_c[116]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[4]_net_1\);
    
    \PIODATAWORD_ibuf[119]\ : INBUF
      port map(PAD => PIODATAWORD(119), Y => \PIODATAWORD_c[119]\);
    
    \PIODATAWORD_ibuf[271]\ : INBUF
      port map(PAD => PIODATAWORD(271), Y => \PIODATAWORD_c[271]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[5]_net_1\, B => 
        \SRXFIFO_10[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[5]\, 
        Y => N_3389);
    
    \SRXFIFO_19[13]\ : SLE
      port map(D => \PIODATAWORD_c[317]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[13]_net_1\);
    
    \PIODATAWORD_ibuf[305]\ : INBUF
      port map(PAD => PIODATAWORD(305), Y => \PIODATAWORD_c[305]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[12]\, 
        C => \PIODATAWORD_c[316]\, D => \PIODATAWORD_c[268]\, Y
         => N_2899);
    
    \SRXFIFO_3[5]\ : SLE
      port map(D => \PIODATAWORD_c[53]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[5]_net_1\);
    
    \PIODATAWORD_ibuf[356]\ : INBUF
      port map(PAD => PIODATAWORD(356), Y => \PIODATAWORD_c[356]\);
    
    \PIODATAWORD_ibuf[282]\ : INBUF
      port map(PAD => PIODATAWORD(282), Y => \PIODATAWORD_c[282]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[14]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3668, C => 
        N_3623, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[14]_net_1\, 
        Y => \PIOWORD_4_31_bm[14]\);
    
    \PIODATAWORD_ibuf[54]\ : INBUF
      port map(PAD => PIODATAWORD(54), Y => \PIODATAWORD_c[54]\);
    
    \SCOMMWORD[11]\ : SLE
      port map(D => \PICMD_c[11]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[223]\, B => 
        \PIODATAWORD_c[239]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[2]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2585, D => N_2825, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[2]_net_1\);
    
    \PIODATAWORD_ibuf[195]\ : INBUF
      port map(PAD => PIODATAWORD(195), Y => \PIODATAWORD_c[195]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[13]_net_1\, B => 
        \SRXFIFO_8[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[13]\, 
        Y => N_3292);
    
    \SRXFIFO_12[3]\ : SLE
      port map(D => \PIODATAWORD_c[195]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[12]_net_1\, B => 
        \SRXFIFO_12[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[12]\, 
        Y => N_3336);
    
    \PIODATAWORD_ibuf[284]\ : INBUF
      port map(PAD => PIODATAWORD(284), Y => \PIODATAWORD_c[284]\);
    
    \SRXMODEDATAWORD[14]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[14]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[3]_net_1\, B => 
        \SRXFIFO_10[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[3]\, 
        Y => N_3387);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[12]_net_1\, B => 
        \SRXFIFO_8[12]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[12]\, 
        Y => N_3291);
    
    \PIODATAWORD_ibuf[295]\ : INBUF
      port map(PAD => PIODATAWORD(295), Y => \PIODATAWORD_c[295]\);
    
    \SRXFIFO_24[12]\ : SLE
      port map(D => \PIODATAWORD_c[396]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[12]_net_1\);
    
    \PIOWORD_1[5]\ : SLE
      port map(D => N_213, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[5]_net_1\);
    
    \SErrorCounter[4]\ : SLE
      port map(D => \SErrorCounter_s[4]\, CLK => PICLK_c, EN => 
        \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[4]_net_1\);
    
    \un9_sdatawordlen_1.SUM[4]\ : CFG2
      generic map(INIT => x"9")

      port map(A => \un9_sdatawordlen_1.CO3_i\, B => 
        \SCOMMWORD[4]_net_1\, Y => N_4490);
    
    \PIODATAWORD_ibuf[69]\ : INBUF
      port map(PAD => PIODATAWORD(69), Y => \PIODATAWORD_c[69]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[4]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SRXMODEDATAWORD_1_31_bm[4]\, C => 
        \SRXMODEDATAWORD_1_31_am[4]\, Y => \SRXMODEDATAWORD_1[4]\);
    
    \PIODATAWORD_ibuf[360]\ : INBUF
      port map(PAD => PIODATAWORD(360), Y => \PIODATAWORD_c[360]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_RXFIFOloaded_0_845_i_a2_0_a2\ : 
        CFG2
      generic map(INIT => x"2")

      port map(A => \FFempty_flag_generator.un45_sregaddr\, B => 
        \RXFIFOloaded\, Y => N_4406);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[0]\, 
        C => \PIODATAWORD_c[240]\, D => \PIODATAWORD_c[192]\, Y
         => N_2583);
    
    \PIODATAWORD_ibuf[478]\ : INBUF
      port map(PAD => PIODATAWORD(478), Y => \PIODATAWORD_c[478]\);
    
    \PIODATAWORD_ibuf[391]\ : INBUF
      port map(PAD => PIODATAWORD(391), Y => \PIODATAWORD_c[391]\);
    
    \SRXFIFO_0[11]\ : SLE
      port map(D => \PIODATAWORD_c[11]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[14]\, 
        C => \PIODATAWORD_c[382]\, D => \PIODATAWORD_c[334]\, Y
         => N_2661);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[10]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3664, C => 
        N_3619, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[10]_net_1\, 
        Y => \PIOWORD_4_31_bm[10]\);
    
    \SRXFIFO_11[11]\ : SLE
      port map(D => \PIODATAWORD_c[187]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[11]_net_1\);
    
    \SRXFIFO_9[11]\ : SLE
      port map(D => \PIODATAWORD_c[155]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_7[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[372]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_55\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_RNO_0[9]\ : 
        CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[393]\, B => 
        \PIODATAWORD_c[425]\, C => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_28_1_1[9]\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_2944);
    
    \SRXFIFO_28[2]\ : SLE
      port map(D => \PIODATAWORD_c[450]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[2]_net_1\);
    
    \PIODATAWORD_ibuf[260]\ : INBUF
      port map(PAD => PIODATAWORD(260), Y => \PIODATAWORD_c[260]\);
    
    \PICMD_ibuf[0]\ : INBUF
      port map(PAD => PICMD(0), Y => \PICMD_c[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[11]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2898, C => N_2658, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[11]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[11]\);
    
    \SRXFIFO_17[4]\ : SLE
      port map(D => \PIODATAWORD_c[276]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[4]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.sprtycheck\ : CFG3
      generic map(INIT => x"96")

      port map(A => \PIRTA_c[2]\, B => \PIRTA_c[1]\, C => 
        \FFempty_flag_generator.un45_sregaddr.sprtycheck_3_net_1\, 
        Y => sprtycheck);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[15]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[15]\, C => \PIOWORD_4_31_am[15]\, Y => 
        \PIOWORD_4[15]\);
    
    \SRXFIFO_27[8]\ : SLE
      port map(D => \PIODATAWORD_c[440]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[8]_net_1\);
    
    \SRXFIFO_25[8]\ : SLE
      port map(D => \PIODATAWORD_c[408]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[284]\, B => 
        \PIODATAWORD_c[300]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[8]_net_1\, B => 
        \SRXFIFO_13[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[8]\, 
        Y => N_3557);
    
    \PIODATAWORD_ibuf[483]\ : INBUF
      port map(PAD => PIODATAWORD(483), Y => \PIODATAWORD_c[483]\);
    
    \PIODATAWORD_ibuf[221]\ : INBUF
      port map(PAD => PIODATAWORD(221), Y => \PIODATAWORD_c[221]\);
    
    \SCOMMWORD[8]\ : SLE
      port map(D => \PICMD_c[8]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[8]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[5]_net_1\, B => 
        \SRXFIFO_14[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[5]\, 
        Y => N_3434);
    
    
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_o2_1[1]\ : 
        CFG3
      generic map(INIT => x"FE")

      port map(A => \PIERR_c[8]\, B => \PIERR_c[7]\, C => 
        \PIERR_c[6]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_o2_1[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[220]\, B => 
        \PIODATAWORD_c[236]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[12]\);
    
    \SRXFIFO_4[9]\ : SLE
      port map(D => \PIODATAWORD_c[73]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[222]\, B => 
        \PIODATAWORD_c[238]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[14]\);
    
    \PIODATAWORD_ibuf[480]\ : INBUF
      port map(PAD => PIODATAWORD(480), Y => \PIODATAWORD_c[480]\);
    
    \PIODATAWORD_ibuf[462]\ : INBUF
      port map(PAD => PIODATAWORD(462), Y => \PIODATAWORD_c[462]\);
    
    \SCOMMWORD[4]\ : SLE
      port map(D => \PICMD_c[4]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[12]\, 
        C => \PIODATAWORD_c[444]\, D => \PIODATAWORD_c[396]\, Y
         => N_2947);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[11]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2706, D => N_2946, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[13]_net_1\, B => 
        \SRXFIFO_10[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[13]\, 
        Y => N_3397);
    
    \error_states[0]\ : SLE
      port map(D => \error_states_ns[0]\, CLK => PICLK_c, EN => 
        VCC_net_1, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \error_states[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[154]\, B => 
        \PIODATAWORD_c[170]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[10]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[2]_net_1\, B => 
        \SRXFIFO_1[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[2]\);
    
    \PIODATAWORD_ibuf[389]\ : INBUF
      port map(PAD => PIODATAWORD(389), Y => \PIODATAWORD_c[389]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[471]\, B => 
        \PIODATAWORD_c[487]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[7]\);
    
    \FFempty_flag_generator.un45_sregaddr.RXFIFOcount_c2\ : CFG3
      generic map(INIT => x"80")

      port map(A => \RXFIFOcount[1]_net_1\, B => 
        \RXFIFOcount[0]_net_1\, C => \RXFIFOcount[2]_net_1\, Y
         => RXFIFOcount_c2);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[14]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[14]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[14]\, Y => 
        \SRXMODEDATAWORD_1[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[7]_net_1\, B => 
        \SRXFIFO_5[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[7]\);
    
    \PIODATAWORD_ibuf[474]\ : INBUF
      port map(PAD => PIODATAWORD(474), Y => \PIODATAWORD_c[474]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[12]_net_1\, B => 
        \SRXFIFO_7[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[12]_net_1\, B => 
        \SRXFIFO_6[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[6]_net_1\, B => 
        \SRXFIFO_11[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[6]\, 
        Y => N_3615);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[9]_net_1\, B => 
        \SRXFIFO_2[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[9]\);
    
    \PIODATAWORD_ibuf[383]\ : INBUF
      port map(PAD => PIODATAWORD(383), Y => \PIODATAWORD_c[383]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[0]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[0]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[0]\, Y => 
        \SRXMODEDATAWORD_1[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[3]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2778, C => N_2538, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[3]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[3]\);
    
    \SRXFIFO_2[5]\ : SLE
      port map(D => \PIODATAWORD_c[37]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[5]_net_1\);
    
    \SRXFIFO_18[9]\ : SLE
      port map(D => \PIODATAWORD_c[297]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[9]_net_1\);
    
    \PIODATAWORD_ibuf[335]\ : INBUF
      port map(PAD => PIODATAWORD(335), Y => \PIODATAWORD_c[335]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[0]_net_1\, B => 
        \SRXFIFO_3[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[6]_net_1\, B => 
        \SRXFIFO_1[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[6]\);
    
    \PIODATAWORD_ibuf[441]\ : INBUF
      port map(PAD => PIODATAWORD(441), Y => \PIODATAWORD_c[441]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0[14]\ : 
        CFG4
      generic map(INIT => x"7340")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, C
         => N_4599, D => N_171, Y => \un1_SCOMMWORD_u_0[14]\);
    
    \PIODATAWORD_ibuf[428]\ : INBUF
      port map(PAD => PIODATAWORD(428), Y => \PIODATAWORD_c[428]\);
    
    \PIODATAWORD_ibuf[7]\ : INBUF
      port map(PAD => PIODATAWORD(7), Y => \PIODATAWORD_c[7]\);
    
    \PIODATAWORD_ibuf[152]\ : INBUF
      port map(PAD => PIODATAWORD(152), Y => \PIODATAWORD_c[152]\);
    
    \PIODATAWORD_ibuf[368]\ : INBUF
      port map(PAD => PIODATAWORD(368), Y => \PIODATAWORD_c[368]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[3]\, 
        C => \PIODATAWORD_c[115]\, D => \PIODATAWORD_c[67]\, Y
         => N_2538);
    
    \PIRegAddr_ibuf[3]\ : INBUF
      port map(PAD => PIRegAddr(3), Y => \PIRegAddr_c[3]\);
    
    \SRXFIFO_27[15]\ : SLE
      port map(D => \PIODATAWORD_c[447]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[15]_net_1\);
    
    \SRXFIFO_22[5]\ : SLE
      port map(D => \PIODATAWORD_c[357]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[5]_net_1\);
    
    \SRXFIFO_17[5]\ : SLE
      port map(D => \PIODATAWORD_c[277]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[5]_net_1\);
    
    \SRXFIFO_10[3]\ : SLE
      port map(D => \PIODATAWORD_c[163]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[3]_net_1\);
    
    \PIODATAWORD_ibuf[278]\ : INBUF
      port map(PAD => PIODATAWORD(278), Y => \PIODATAWORD_c[278]\);
    
    \PICMD_ibuf[11]\ : INBUF
      port map(PAD => PICMD(11), Y => \PICMD_c[11]\);
    
    \SRXMODEDATAWORD[7]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[7]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[7]_net_1\);
    
    \SRXFIFO_17[1]\ : SLE
      port map(D => \PIODATAWORD_c[273]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[1]_net_1\);
    
    \PIODATAWORD_ibuf[194]\ : INBUF
      port map(PAD => PIODATAWORD(194), Y => \PIODATAWORD_c[194]\);
    
    \PIODATAWORD_ibuf[366]\ : INBUF
      port map(PAD => PIODATAWORD(366), Y => \PIODATAWORD_c[366]\);
    
    \FFempty_flag_generator.un45_sregaddr.ALTB_bm[4]\ : CFG4
      generic map(INIT => x"8E4D")

      port map(A => \un9_sdatawordlen_1.CO1_1_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.ALTB[1]_net_1\, C
         => \RXFIFOcount[2]_net_1\, D => \SCOMMWORD[2]_net_1\, Y
         => \ALTB_bm[4]\);
    
    \SRXFIFO_23[12]\ : SLE
      port map(D => \PIODATAWORD_c[380]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[3]\, 
        C => \PIODATAWORD_c[307]\, D => \PIODATAWORD_c[259]\, Y
         => N_2890);
    
    \PIRTA_ibuf[4]\ : INBUF
      port map(PAD => PIRTA(4), Y => \PIRTA_c[4]\);
    
    \PIODATAWORD_ibuf[189]\ : INBUF
      port map(PAD => PIODATAWORD(189), Y => \PIODATAWORD_c[189]\);
    
    \SRXFIFO_6[11]\ : SLE
      port map(D => \PIODATAWORD_c[107]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[11]_net_1\);
    
    \SRXFIFO_30[1]\ : SLE
      port map(D => \PIODATAWORD_c[481]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[1]_net_1\);
    
    \PIODATAWORD_ibuf[175]\ : INBUF
      port map(PAD => PIODATAWORD(175), Y => \PIODATAWORD_c[175]\);
    
    \SRXFIFO_17[10]\ : SLE
      port map(D => \PIODATAWORD_c[282]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[12]\, 
        C => \PIODATAWORD_c[380]\, D => \PIODATAWORD_c[332]\, Y
         => N_2659);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[1]_net_1\, B => 
        \SRXFIFO_10[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[1]\, 
        Y => N_3385);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[6]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2701, D => N_2941, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[7]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2894, C => N_2654, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[7]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[7]\);
    
    \SRXFIFO_3[4]\ : SLE
      port map(D => \PIODATAWORD_c[52]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[4]_net_1\);
    
    \PIODATAWORD_ibuf[191]\ : INBUF
      port map(PAD => PIODATAWORD(191), Y => \PIODATAWORD_c[191]\);
    
    \SRXFIFO_5[10]\ : SLE
      port map(D => \PIODATAWORD_c[90]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[10]_net_1\);
    
    \PIODATAWORD_ibuf[275]\ : INBUF
      port map(PAD => PIODATAWORD(275), Y => \PIODATAWORD_c[275]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_7[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[356]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_19\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[14]_net_1\, B => 
        \SRXFIFO_11[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[14]\, 
        Y => N_3623);
    
    \SBUSBWORD[2]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[2]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[2]_net_1\);
    
    \PIODATAWORD_ibuf[424]\ : INBUF
      port map(PAD => PIODATAWORD(424), Y => \PIODATAWORD_c[424]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_6[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[212]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_20\);
    
    \SRXFIFO_5[15]\ : SLE
      port map(D => \PIODATAWORD_c[95]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[15]_net_1\);
    
    \PIODATAWORD_ibuf[315]\ : INBUF
      port map(PAD => PIODATAWORD(315), Y => \PIODATAWORD_c[315]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[7]\, 
        C => \PIODATAWORD_c[55]\, D => \PIODATAWORD_c[7]\, Y => 
        N_2782);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_7[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[500]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_27\);
    
    \SRXFIFO_25[0]\ : SLE
      port map(D => \PIODATAWORD_c[400]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[0]_net_1\);
    
    \PIODATAWORD_ibuf[447]\ : INBUF
      port map(PAD => PIODATAWORD(447), Y => \PIODATAWORD_c[447]\);
    
    \PIODATAWORD_ibuf[371]\ : INBUF
      port map(PAD => PIODATAWORD(371), Y => \PIODATAWORD_c[371]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[2]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[2]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[2]\, Y => 
        \SRXMODEDATAWORD_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[8]\, 
        C => \PIODATAWORD_c[504]\, D => \PIODATAWORD_c[456]\, Y
         => N_2703);
    
    \SRXFIFO_1[1]\ : SLE
      port map(D => \PIODATAWORD_c[17]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[1]_net_1\);
    
    \PIODATAWORD_ibuf[158]\ : INBUF
      port map(PAD => PIODATAWORD(158), Y => \PIODATAWORD_c[158]\);
    
    \PIODATAWORD_ibuf[21]\ : INBUF
      port map(PAD => PIODATAWORD(21), Y => \PIODATAWORD_c[21]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1_i_m3[1]\ : 
        CFG3
      generic map(INIT => x"B8")

      port map(A => \PIERR_c[1]\, B => \PIRegAddr_c[1]\, C => 
        PORCVA_c, Y => N_208);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[13]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2900, C => N_2660, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[13]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[8]_net_1\, B => 
        \SRXFIFO_12[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[8]\, 
        Y => N_3332);
    
    \SRXFIFO_11[3]\ : SLE
      port map(D => \PIODATAWORD_c[179]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[18]\, B => \PIODATAWORD_c[34]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[13]_net_1\, B => 
        \SRXFIFO_0[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[13]\);
    
    \SRXFIFO_8[9]\ : SLE
      port map(D => \PIODATAWORD_c[137]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO_0[12]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[12]_net_1\, D => 
        \SRXMODEDATAWORD[12]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[12]_net_1\, B => 
        \SRXFIFO_0[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[12]\);
    
    \SRXFIFO_25[2]\ : SLE
      port map(D => \PIODATAWORD_c[402]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[2]_net_1\);
    
    \PIODATAWORD_ibuf[228]\ : INBUF
      port map(PAD => PIODATAWORD(228), Y => \PIODATAWORD_c[228]\);
    
    \SRXFIFO_12[12]\ : SLE
      port map(D => \PIODATAWORD_c[204]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[10]\, 
        C => \PIODATAWORD_c[442]\, D => \PIODATAWORD_c[394]\, Y
         => N_2945);
    
    \SRXFIFO_16[1]\ : SLE
      port map(D => \PIODATAWORD_c[257]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[1]_net_1\);
    
    \SRXFIFO_12[9]\ : SLE
      port map(D => \PIODATAWORD_c[201]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[9]_net_1\);
    
    \SCTRL[6]\ : SLE
      port map(D => \PIOWORD_in[6]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[7]\, 
        C => \PIODATAWORD_c[375]\, D => \PIODATAWORD_c[327]\, Y
         => N_2654);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[1]_net_1\, B => 
        \SRXFIFO_7[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[1]\);
    
    \un9_sdatawordlen_1.RcvaSTAT_3\ : CFG2
      generic map(INIT => x"2")

      port map(A => \SActA\, B => RcvaSTAT_1_sqmuxa, Y => 
        RcvaSTAT_3);
    
    \SBUSAWORD[9]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[9]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[218]\, B => 
        \PIODATAWORD_c[234]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[10]\);
    
    \PIODATAWORD_ibuf[456]\ : INBUF
      port map(PAD => PIODATAWORD(456), Y => \PIODATAWORD_c[456]\);
    
    \SRXFIFO_7[0]\ : SLE
      port map(D => \PIODATAWORD_c[112]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[0]_net_1\);
    
    \SCOMMWORD[2]\ : SLE
      port map(D => \PICMD_c[2]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[2]_net_1\);
    
    \PIODATAWORD_ibuf[259]\ : INBUF
      port map(PAD => PIODATAWORD(259), Y => \PIODATAWORD_c[259]\);
    
    \PIODATAWORD_ibuf[394]\ : INBUF
      port map(PAD => PIODATAWORD(394), Y => \PIODATAWORD_c[394]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SCOMMWORD[8]_net_1\, D => \SRXMODEDATAWORD[8]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[8]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[215]\, B => 
        \PIODATAWORD_c[231]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[7]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[11]_net_1\, B => 
        \SRXFIFO_5[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[7]_net_1\, B => 
        \SRXFIFO_6[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[7]\);
    
    \SRXFIFO_4[7]\ : SLE
      port map(D => \PIODATAWORD_c[71]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[7]_net_1\);
    
    \SBUSBWORD[14]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[14]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[14]_net_1\);
    
    \PIODATAWORD_ibuf[125]\ : INBUF
      port map(PAD => PIODATAWORD(125), Y => \PIODATAWORD_c[125]\);
    
    \SRXFIFO_8[13]\ : SLE
      port map(D => \PIODATAWORD_c[141]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[13]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2708, D => N_2948, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[13]_net_1\);
    
    \SRXFIFO_14[15]\ : SLE
      port map(D => \PIODATAWORD_c[239]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[15]_net_1\);
    
    \SRXFIFO_9[8]\ : SLE
      port map(D => \PIODATAWORD_c[152]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[8]_net_1\);
    
    \SRXFIFO_17[11]\ : SLE
      port map(D => \PIODATAWORD_c[283]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[1]\, 
        C => \PIODATAWORD_c[241]\, D => \PIODATAWORD_c[193]\, Y
         => N_2584);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[11]\, 
        C => \PIODATAWORD_c[507]\, D => \PIODATAWORD_c[459]\, Y
         => N_2706);
    
    \PIODATAWORD_ibuf[91]\ : INBUF
      port map(PAD => PIODATAWORD(91), Y => \PIODATAWORD_c[91]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[12]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2595, D => N_2835, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[12]_net_1\);
    
    \SRXFIFO_4[1]\ : SLE
      port map(D => \PIODATAWORD_c[65]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[1]_net_1\);
    
    \PIODATAWORD_ibuf[225]\ : INBUF
      port map(PAD => PIODATAWORD(225), Y => \PIODATAWORD_c[225]\);
    
    \PIERR_ibuf[1]\ : INBUF
      port map(PAD => PIERR(1), Y => \PIERR_c[1]\);
    
    \SRXFIFO_26[6]\ : SLE
      port map(D => \PIODATAWORD_c[422]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[6]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_PIOWORD_cl_i[15]\ : 
        CFG2
      generic map(INIT => x"8")

      port map(A => \PIOWORD_cl[15]\, B => \PIOWORD_cl_31[15]\, Y
         => \un1_PIOWORD_cl_i_0_i[15]\);
    
    \PIODATAWORD_ibuf[103]\ : INBUF
      port map(PAD => PIODATAWORD(103), Y => \PIODATAWORD_c[103]\);
    
    \SRXFIFO_0[7]\ : SLE
      port map(D => \PIODATAWORD_c[7]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[339]\, B => 
        \PIODATAWORD_c[355]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[3]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[13]_net_1\, D => 
        \SRXMODEDATAWORD[13]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_1_1[13]\);
    
    \PIODATAWORD_ibuf[73]\ : INBUF
      port map(PAD => PIODATAWORD(73), Y => \PIODATAWORD_c[73]\);
    
    \RXFIFOcount[3]\ : SLE
      port map(D => RXFIFOcount_n3, CLK => PICLK_c, EN => 
        RXFIFOcounte, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \RXFIFOcount[3]_net_1\);
    
    \SErrorCounter[0]\ : SLE
      port map(D => \SErrorCounter_s[0]\, CLK => PICLK_c, EN => 
        \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[0]_net_1\);
    
    \PIODATAWORD_ibuf[33]\ : INBUF
      port map(PAD => PIODATAWORD(33), Y => \PIODATAWORD_c[33]\);
    
    \PIODATAWORD_ibuf[321]\ : INBUF
      port map(PAD => PIODATAWORD(321), Y => \PIODATAWORD_c[321]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[4]_net_1\, B => 
        \SRXFIFO_15[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[4]\, 
        Y => N_3658);
    
    \SRXFIFO_13[1]\ : SLE
      port map(D => \PIODATAWORD_c[209]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[1]_net_1\);
    
    \PIODATAWORD_ibuf[162]\ : INBUF
      port map(PAD => PIODATAWORD(162), Y => \PIODATAWORD_c[162]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[4]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3433, C => 
        N_3388, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[4]_net_1\, 
        Y => \PIOWORD_4_31_am[4]\);
    
    \PIODATAWORD_ibuf[140]\ : INBUF
      port map(PAD => PIODATAWORD(140), Y => \PIODATAWORD_c[140]\);
    
    \SRXFIFO_12[7]\ : SLE
      port map(D => \PIODATAWORD_c[199]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[7]_net_1\);
    
    \SErrorCounter[6]\ : SLE
      port map(D => \SErrorCounter_s[6]\, CLK => PICLK_c, EN => 
        \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[5]\, 
        C => \PIODATAWORD_c[437]\, D => \PIODATAWORD_c[389]\, Y
         => N_2940);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[1]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[1]_net_1\, D => \SRXMODEDATAWORD[1]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[1]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1[13]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[13]_net_1\, B => \PIOWORD_4[13]\, C
         => \PIRegAddr_c[3]\, Y => N_4598);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[411]\, B => 
        \PIODATAWORD_c[427]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[11]\);
    
    \SRXFIFO_19[1]\ : SLE
      port map(D => \PIODATAWORD_c[305]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[1]_net_1\);
    
    \PIODATAWORD_ibuf[174]\ : INBUF
      port map(PAD => PIODATAWORD(174), Y => \PIODATAWORD_c[174]\);
    
    \SBUSBWORD[6]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[6]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[9]_net_1\, B => 
        \SRXFIFO_1[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[9]\);
    
    \SRXFIFO_28[3]\ : SLE
      port map(D => \PIODATAWORD_c[451]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[3]_net_1\);
    
    \SRXFIFO_19[12]\ : SLE
      port map(D => \PIODATAWORD_c[316]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[3]_net_1\, B => 
        \SRXFIFO_7[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[3]\);
    
    \SRXFIFO_0[1]\ : SLE
      port map(D => \PIODATAWORD_c[1]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[1]_net_1\);
    
    POVALMESS_obuf : OUTBUF
      port map(D => POVALMESS_c, PAD => POVALMESS);
    
    \PIODATAWORD_ibuf[390]\ : INBUF
      port map(PAD => PIODATAWORD(390), Y => \PIODATAWORD_c[390]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[3]_net_1\, B => 
        \SRXFIFO_13[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[3]\, 
        Y => N_3552);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[15]\, 
        C => \PIODATAWORD_c[255]\, D => \PIODATAWORD_c[207]\, Y
         => N_2598);
    
    \SRXFIFO_11[14]\ : SLE
      port map(D => \PIODATAWORD_c[190]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[85]\, B => 
        \PIODATAWORD_c[101]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[5]\);
    
    \SRXMODEDATAWORD[1]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[1]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[1]_net_1\);
    
    \SRXFIFO_26[13]\ : SLE
      port map(D => \PIODATAWORD_c[429]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[13]_net_1\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u[15]\ : CFG4
      generic map(INIT => x"7340")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, C
         => N_4499, D => N_2499, Y => \un1_SCOMMWORD_u[15]\);
    
    \PIODATAWORD_ibuf[171]\ : INBUF
      port map(PAD => PIODATAWORD(171), Y => \PIODATAWORD_c[171]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[3]_net_1\, B => 
        \SRXFIFO_3[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[3]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[1]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3430, C => 
        N_3385, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[1]_net_1\, 
        Y => \PIOWORD_4_31_am[1]\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u_RNO[15]\ : CFG4
      generic map(INIT => x"50EE")

      port map(A => \PIRegAddr_c[1]\, B => \SBUSAWORD[15]_net_1\, 
        C => \SCOMMWORD[15]_net_1\, D => 
        \un9_sdatawordlen_1.un1_SCOMMWORD_4_1_1[15]\, Y => N_2499);
    
    \PIODATAWORD_ibuf[290]\ : INBUF
      port map(PAD => PIODATAWORD(290), Y => \PIODATAWORD_c[290]\);
    
    \SRXFIFO_7[1]\ : SLE
      port map(D => \PIODATAWORD_c[113]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[1]_net_1\);
    
    \SRXFIFO_18[6]\ : SLE
      port map(D => \PIODATAWORD_c[294]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[9]_net_1\, B => 
        \SRXFIFO_13[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[9]\, 
        Y => N_3558);
    
    \SBUSAWORD[5]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[5]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[5]_net_1\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_RNO_1[9]\ : CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[89]\, B => 
        \PIODATAWORD_c[121]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_3_1_1[9]\);
    
    \PIODATAWORD_ibuf[203]\ : INBUF
      port map(PAD => PIODATAWORD(203), Y => \PIODATAWORD_c[203]\);
    
    \SRXMODEDATAWORD[6]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[6]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[6]_net_1\);
    
    \PIODATAWORD_ibuf[347]\ : INBUF
      port map(PAD => PIODATAWORD(347), Y => \PIODATAWORD_c[347]\);
    
    \PIODATAWORD_ibuf[168]\ : INBUF
      port map(PAD => PIODATAWORD(168), Y => \PIODATAWORD_c[168]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[4]_net_1\, B => 
        \SRXFIFO_3[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[4]\);
    
    \SRXFIFO_31[14]\ : SLE
      port map(D => \PIODATAWORD_c[510]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[14]_net_1\);
    
    \H6110_states[0]\ : SLE
      port map(D => N_2480_i_0, CLK => PICLK_c, EN => VCC_net_1, 
        ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \H6110_states[0]_net_1\);
    
    \PIODATAWORD_ibuf[492]\ : INBUF
      port map(PAD => PIODATAWORD(492), Y => \PIODATAWORD_c[492]\);
    
    \PIODATAWORD_ibuf[385]\ : INBUF
      port map(PAD => PIODATAWORD(385), Y => \PIODATAWORD_c[385]\);
    
    \SRXFIFO_29[5]\ : SLE
      port map(D => \PIODATAWORD_c[469]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[5]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0[11]\ : 
        CFG4
      generic map(INIT => x"7340")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, C
         => N_4596, D => N_180, Y => N_3176);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[3]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[3]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[3]\, Y => 
        \SRXMODEDATAWORD_1[3]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[1]_net_1\, B => 
        \SRXFIFO_0[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[1]\);
    
    \SRXFIFO_24[10]\ : SLE
      port map(D => \PIODATAWORD_c[394]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[10]_net_1\);
    
    \PIODATAWORD_ibuf[342]\ : INBUF
      port map(PAD => PIODATAWORD(342), Y => \PIODATAWORD_c[342]\);
    
    PIBUSA_ibuf : INBUF
      port map(PAD => PIBUSA, Y => PIBUSA_c);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[8]\, 
        C => \PIODATAWORD_c[120]\, D => \PIODATAWORD_c[72]\, Y
         => N_2543);
    
    
        \FFempty_flag_generator.un45_sregaddr.RXFIFOcount_2_sqmuxa_i_0_o2\ : 
        CFG4
      generic map(INIT => x"CCCE")

      port map(A => N_231, B => \RXFIFOloaded\, C => 
        \PIRegAddr_c[1]\, D => \PIRegAddr_c[3]\, Y => 
        RXFIFOcounte);
    
    \SRXFIFO_13[15]\ : SLE
      port map(D => \PIODATAWORD_c[223]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[15]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[7]_net_1\, B => 
        \SRXFIFO_3[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[7]\);
    
    \SRXFIFO_13[8]\ : SLE
      port map(D => \PIODATAWORD_c[216]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[8]_net_1\);
    
    \PIODATAWORD_ibuf[124]\ : INBUF
      port map(PAD => PIODATAWORD(124), Y => \PIODATAWORD_c[124]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[11]_net_1\, B => 
        \SRXFIFO_13[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[11]\, 
        Y => N_3560);
    
    \PIODATAWORD_ibuf[43]\ : INBUF
      port map(PAD => PIODATAWORD(43), Y => \PIODATAWORD_c[43]\);
    
    \PIODATAWORD_ibuf[133]\ : INBUF
      port map(PAD => PIODATAWORD(133), Y => \PIODATAWORD_c[133]\);
    
    \SRXFIFO_4[8]\ : SLE
      port map(D => \PIODATAWORD_c[72]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[8]_net_1\);
    
    \PIODATAWORD_ibuf[466]\ : INBUF
      port map(PAD => PIODATAWORD(466), Y => \PIODATAWORD_c[466]\);
    
    \PIODATAWORD_ibuf[269]\ : INBUF
      port map(PAD => PIODATAWORD(269), Y => \PIODATAWORD_c[269]\);
    
    \PIODATAWORD_ibuf[374]\ : INBUF
      port map(PAD => PIODATAWORD(374), Y => \PIODATAWORD_c[374]\);
    
    \SRXFIFO_27[2]\ : SLE
      port map(D => \PIODATAWORD_c[434]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[87]\, B => 
        \PIODATAWORD_c[103]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[7]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[22]\, B => \PIODATAWORD_c[38]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[6]\);
    
    \SRXMODEDATAWORD[0]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[0]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[0]_net_1\);
    
    \SRXFIFO_29[2]\ : SLE
      port map(D => \PIODATAWORD_c[466]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[2]\, 
        C => \PIODATAWORD_c[50]\, D => \PIODATAWORD_c[2]\, Y => 
        N_2777);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[0]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2695, D => N_2935, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[0]_net_1\);
    
    \PIODATAWORD_ibuf[11]\ : INBUF
      port map(PAD => PIODATAWORD(11), Y => \PIODATAWORD_c[11]\);
    
    \PIODATAWORD_ibuf[398]\ : INBUF
      port map(PAD => PIODATAWORD(398), Y => \PIODATAWORD_c[398]\);
    
    \PIODATAWORD_ibuf[121]\ : INBUF
      port map(PAD => PIODATAWORD(121), Y => \PIODATAWORD_c[121]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_22\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_21\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_20\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_19\, 
        Y => N_2891);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[6]_net_1\, B => 
        \SRXFIFO_4[6]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[15]_net_1\, B => 
        \SRXFIFO_6[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[5]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[5]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[5]\, Y => 
        \SRXMODEDATAWORD_1[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[408]\, B => 
        \PIODATAWORD_c[424]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[8]\);
    
    \SRXFIFO_13[7]\ : SLE
      port map(D => \PIODATAWORD_c[215]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[7]_net_1\);
    
    \PIODATAWORD_ibuf[396]\ : INBUF
      port map(PAD => PIODATAWORD(396), Y => \PIODATAWORD_c[396]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[15]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[15]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[15]\, Y => 
        \SRXMODEDATAWORD_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[5]\, 
        C => \PIODATAWORD_c[181]\, D => \PIODATAWORD_c[133]\, Y
         => N_2828);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[7]_net_1\, B => 
        \SRXFIFO_9[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[7]\, 
        Y => N_3511);
    
    \SRXFIFO_2[8]\ : SLE
      port map(D => \PIODATAWORD_c[40]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[8]_net_1\);
    
    \SRXFIFO_29[7]\ : SLE
      port map(D => \PIODATAWORD_c[471]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[7]_net_1\, B => 
        \SRXFIFO_11[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[7]\, 
        Y => N_3616);
    
    \SRXFIFO_0[6]\ : SLE
      port map(D => \PIODATAWORD_c[6]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO[8]\ : 
        CFG4
      generic map(INIT => x"CB0B")

      port map(A => \SBUSBWORD[8]_net_1\, B => \PIRegAddr_c[3]\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[8]\, 
        D => \SBUSAWORD[8]_net_1\, Y => N_170);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[10]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[10]\, 
        C => \PIODATAWORD_c[58]\, D => \PIODATAWORD_c[10]\, Y => 
        N_2785);
    
    \SRXFIFO_29[8]\ : SLE
      port map(D => \PIODATAWORD_c[472]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[8]_net_1\);
    
    \PIODATAWORD_ibuf[72]\ : INBUF
      port map(PAD => PIODATAWORD(72), Y => \PIODATAWORD_c[72]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[475]\, B => 
        \PIODATAWORD_c[491]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[7]\, 
        C => \PIODATAWORD_c[311]\, D => \PIODATAWORD_c[263]\, Y
         => N_2894);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[0]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2887, C => N_2647, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[0]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1_i_m3[2]\ : 
        CFG3
      generic map(INIT => x"B8")

      port map(A => \PIERR_c[2]\, B => \PIRegAddr_c[1]\, C => 
        PORCVB_c, Y => N_203);
    
    \SRXFIFO_3[10]\ : SLE
      port map(D => \PIODATAWORD_c[58]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[10]_net_1\);
    
    \PIODATAWORD_ibuf[32]\ : INBUF
      port map(PAD => PIODATAWORD(32), Y => \PIODATAWORD_c[32]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[0]\, 
        C => \PIODATAWORD_c[48]\, D => \PIODATAWORD_c[0]\, Y => 
        N_2775);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[10]_net_1\, B => 
        \SRXFIFO_11[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[10]\, 
        Y => N_3619);
    
    \SBUSAWORD[1]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[1]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[95]\, B => 
        \PIODATAWORD_c[111]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[283]\, B => 
        \PIODATAWORD_c[299]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[13]\, 
        C => \PIODATAWORD_c[509]\, D => \PIODATAWORD_c[461]\, Y
         => N_2708);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[3]_net_1\, B => 
        \SRXFIFO_12[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[3]\, 
        Y => N_3327);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[2]\ : 
        CFG3
      generic map(INIT => x"1D")

      port map(A => N_200, B => N_162, C => N_203, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[2]_net_1\);
    
    \SRXFIFO_3[15]\ : SLE
      port map(D => \PIODATAWORD_c[63]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[15]_net_1\);
    
    \SRXFIFO_25[7]\ : SLE
      port map(D => \PIODATAWORD_c[407]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[7]_net_1\);
    
    \SRXFIFO_25[1]\ : SLE
      port map(D => \PIODATAWORD_c[401]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[1]_net_1\);
    
    \PIODATAWORD_ibuf[113]\ : INBUF
      port map(PAD => PIODATAWORD(113), Y => \PIODATAWORD_c[113]\);
    
    \SRXFIFO_4[12]\ : SLE
      port map(D => \PIODATAWORD_c[76]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[12]_net_1\);
    
    \SRXFIFO_12[0]\ : SLE
      port map(D => \PIODATAWORD_c[192]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[12]\, 
        C => \PIODATAWORD_c[60]\, D => \PIODATAWORD_c[12]\, Y => 
        N_2787);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[4]_net_1\, B => 
        \SRXFIFO_1[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[4]\);
    
    \un9_sdatawordlen_1.CO3_a0\ : CFG4
      generic map(INIT => x"0001")

      port map(A => \SCOMMWORD[2]_net_1\, B => 
        \SCOMMWORD[3]_net_1\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => \un9_sdatawordlen_1.CO3_i\);
    
    \PIODATAWORD_ibuf[370]\ : INBUF
      port map(PAD => PIODATAWORD(370), Y => \PIODATAWORD_c[370]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[81]\, B => \PIODATAWORD_c[97]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1_i_m3[8]\ : 
        CFG3
      generic map(INIT => x"B8")

      port map(A => \PIERR_c[8]\, B => \PIRegAddr_c[1]\, C => 
        POERROR_c, Y => N_185);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[13]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[13]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[13]\, Y => 
        \SRXMODEDATAWORD_1[13]\);
    
    \PIODATAWORD_ibuf[324]\ : INBUF
      port map(PAD => PIODATAWORD(324), Y => \PIODATAWORD_c[324]\);
    
    \PIODATAWORD_ibuf[233]\ : INBUF
      port map(PAD => PIODATAWORD(233), Y => \PIODATAWORD_c[233]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[10]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[10]\, C => \PIOWORD_4_31_am[10]\, Y => 
        \PIOWORD_4[10]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[4]_net_1\, B => 
        \SRXFIFO_9[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[4]\, 
        Y => N_3508);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[6]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3660, C => 
        N_3615, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[6]_net_1\, 
        Y => \PIOWORD_4_31_bm[6]\);
    
    \SRXFIFO_25[12]\ : SLE
      port map(D => \PIODATAWORD_c[412]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[12]_net_1\);
    
    \SBUSAWORD[4]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[4]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[9]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[9]_net_1\, B => 
        \SRXFIFO_12[9]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[9]\, 
        Y => N_3333);
    
    \SRXFIFO_3[3]\ : SLE
      port map(D => \PIODATAWORD_c[51]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[3]_net_1\);
    
    \PIODATAWORD_ibuf[270]\ : INBUF
      port map(PAD => PIODATAWORD(270), Y => \PIODATAWORD_c[270]\);
    
    \SCOMMWORD[1]\ : SLE
      port map(D => \PICMD_c[1]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[6]_net_1\, B => 
        \SRXFIFO_9[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[6]\, 
        Y => N_3510);
    
    \SRXFIFO_30[13]\ : SLE
      port map(D => \PIODATAWORD_c[493]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[13]_net_1\);
    
    \SRXFIFO_22[14]\ : SLE
      port map(D => \PIODATAWORD_c[366]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[14]_net_1\);
    
    \SRXFIFO_7[11]\ : SLE
      port map(D => \PIODATAWORD_c[123]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[11]_net_1\);
    
    \PIODATAWORD_ibuf[27]\ : INBUF
      port map(PAD => PIODATAWORD(27), Y => \PIODATAWORD_c[27]\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_1[10]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[10]_net_1\, B => \PIOWORD_4[10]\, C
         => \PIRegAddr_c[3]\, Y => N_4527);
    
    \SRXFIFO_29[4]\ : SLE
      port map(D => \PIODATAWORD_c[468]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[4]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.N_1131_i\ : CFG2
      generic map(INIT => x"E")

      port map(A => \H6110_states[5]_net_1\, B => 
        \H6110_states[3]_net_1\, Y => N_1131_i_0);
    
    \SRXMODEDATAWORD[10]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[10]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[10]_net_1\);
    
    \SRXFIFO_30[2]\ : SLE
      port map(D => \PIODATAWORD_c[482]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[2]_net_1\);
    
    \SRXFIFO_23[10]\ : SLE
      port map(D => \PIODATAWORD_c[378]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[10]_net_1\);
    
    \SRXFIFO_16[0]\ : SLE
      port map(D => \PIODATAWORD_c[256]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[7]\, 
        C => \PIODATAWORD_c[439]\, D => \PIODATAWORD_c[391]\, Y
         => N_2942);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[1]_net_1\, B => 
        \SRXFIFO_3[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[1]\);
    
    \SRXFIFO_11[2]\ : SLE
      port map(D => \PIODATAWORD_c[178]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[2]_net_1\);
    
    \PICMD_ibuf[9]\ : INBUF
      port map(PAD => PICMD(9), Y => \PICMD_c[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[2]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2777, C => N_2537, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[2]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[2]\);
    
    \SRXFIFO_12[1]\ : SLE
      port map(D => \PIODATAWORD_c[193]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[1]_net_1\);
    
    \PIODATAWORD_ibuf[83]\ : INBUF
      port map(PAD => PIODATAWORD(83), Y => \PIODATAWORD_c[83]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[2]_net_1\, D => \SRXMODEDATAWORD[2]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[2]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[0]_net_1\, B => 
        \SRXFIFO_15[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[0]\, 
        Y => N_4564);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \PIODATAWORD_ibuf[472]\ : INBUF
      port map(PAD => PIODATAWORD(472), Y => \PIODATAWORD_c[472]\);
    
    \PIODATAWORD_ibuf[24]\ : INBUF
      port map(PAD => PIODATAWORD(24), Y => \PIODATAWORD_c[24]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_4[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[164]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_9\);
    
    \SRXFIFO_28[7]\ : SLE
      port map(D => \PIODATAWORD_c[455]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[7]_net_1\);
    
    \SRXFIFO_20[1]\ : SLE
      port map(D => \PIODATAWORD_c[321]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[1]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[2]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3431, C => 
        N_3386, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[2]_net_1\, 
        Y => \PIOWORD_4_31_am[2]\);
    
    \SRXFIFO_16[2]\ : SLE
      port map(D => \PIODATAWORD_c[258]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[2]_net_1\);
    
    \SRXFIFO_17[14]\ : SLE
      port map(D => \PIODATAWORD_c[286]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[14]_net_1\);
    
    \PICMD_ibuf[3]\ : INBUF
      port map(PAD => PICMD(3), Y => \PICMD_c[3]\);
    
    \PICMD_ibuf[12]\ : INBUF
      port map(PAD => PICMD(12), Y => \PICMD_c[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[2]_net_1\, B => 
        \SRXFIFO_2[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[2]\);
    
    \SBUSAWORD[6]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[6]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[6]_net_1\);
    
    \SRXFIFO_2[14]\ : SLE
      port map(D => \PIODATAWORD_c[46]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[14]_net_1\);
    
    \SRXFIFO_1[12]\ : SLE
      port map(D => \PIODATAWORD_c[28]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[1]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2888, C => N_2648, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[1]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[0]_net_1\, B => 
        \SRXFIFO_13[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[0]\, 
        Y => N_4557);
    
    \SRXFIFO_21[11]\ : SLE
      port map(D => \PIODATAWORD_c[347]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[11]_net_1\);
    
    \PIOWORD_iobuf[15]\ : BIBUF
      port map(PAD => PIOWORD(15), D => \PIOWORD_1[15]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_ns[6]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SRXMODEDATAWORD_1_31_am[6]\, B => N_4490, C
         => \SRXMODEDATAWORD_1_31_bm[6]\, Y => 
        \SRXMODEDATAWORD_1[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[272]\, B => 
        \PIODATAWORD_c[288]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[0]\);
    
    \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE\ : CFG4
      generic map(INIT => x"FFF6")

      port map(A => \PIRTA_c[4]\, B => \PICMD_c[15]\, C => 
        \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_1_net_1\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_0_net_1\, 
        Y => un8_scmd_NE);
    
    \un9_sdatawordlen_1.SUM[2]\ : CFG3
      generic map(INIT => x"36")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \SCOMMWORD[2]_net_1\, C => \SCOMMWORD[0]_net_1\, Y => 
        N_4492);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[27]\, B => \PIODATAWORD_c[43]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[11]\);
    
    \PIODATAWORD_ibuf[320]\ : INBUF
      port map(PAD => PIODATAWORD(320), Y => \PIODATAWORD_c[320]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[152]\, B => 
        \PIODATAWORD_c[168]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[8]\);
    
    \PIODATAWORD_ibuf[97]\ : INBUF
      port map(PAD => PIODATAWORD(97), Y => \PIODATAWORD_c[97]\);
    
    \PIODATAWORD_ibuf[42]\ : INBUF
      port map(PAD => PIODATAWORD(42), Y => \PIODATAWORD_c[42]\);
    
    \PIODATAWORD_ibuf[213]\ : INBUF
      port map(PAD => PIODATAWORD(213), Y => \PIODATAWORD_c[213]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[11]\, 
        C => \PIODATAWORD_c[379]\, D => \PIODATAWORD_c[331]\, Y
         => N_2658);
    
    \PIODATAWORD_ibuf[192]\ : INBUF
      port map(PAD => PIODATAWORD(192), Y => \PIODATAWORD_c[192]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[9]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3333, D => N_3288, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[9]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[0]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_4542, D => N_4539, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[0]_net_1\);
    
    \PIODATAWORD_ibuf[201]\ : INBUF
      port map(PAD => PIODATAWORD(201), Y => \PIODATAWORD_c[201]\);
    
    \PIODATAWORD_ibuf[378]\ : INBUF
      port map(PAD => PIODATAWORD(378), Y => \PIODATAWORD_c[378]\);
    
    \SRXFIFO_15[6]\ : SLE
      port map(D => \PIODATAWORD_c[246]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[6]_net_1\);
    
    \SRXFIFO_10[6]\ : SLE
      port map(D => \PIODATAWORD_c[166]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[6]_net_1\);
    
    \PIODATAWORD_ibuf[94]\ : INBUF
      port map(PAD => PIODATAWORD(94), Y => \PIODATAWORD_c[94]\);
    
    \PIODATAWORD_ibuf[220]\ : INBUF
      port map(PAD => PIODATAWORD(220), Y => \PIODATAWORD_c[220]\);
    
    \SRXMODEDATAWORD[9]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[9]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[402]\, B => 
        \PIODATAWORD_c[418]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[10]_net_1\, B => 
        \SRXFIFO_5[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[10]\);
    
    \PIODATAWORD_ibuf[376]\ : INBUF
      port map(PAD => PIODATAWORD(376), Y => \PIODATAWORD_c[376]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_ns_1[6]\ : 
        CFG3
      generic map(INIT => x"35")

      port map(A => \PIRegAddr_c[3]\, B => N_194, C => 
        \PIRegAddr_c[0]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_ns_1[6]_net_1\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_1[4]\ : CFG4
      generic map(INIT => x"139B")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSAWORD[4]_net_1\, D => \SBUSBWORD[4]_net_1\, Y
         => \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_1[4]_net_1\);
    
    \SRXFIFO_29[14]\ : SLE
      port map(D => \PIODATAWORD_c[478]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[14]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2901, C => N_2661, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[14]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[14]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[1]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3325, D => N_3280, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[1]_net_1\);
    
    \SCOMMWORD[14]\ : SLE
      port map(D => \PICMD_c[14]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[8]_net_1\, B => 
        \SRXFIFO_0[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[8]\);
    
    \SRXFIFO_20[12]\ : SLE
      port map(D => \PIODATAWORD_c[332]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[349]\, B => 
        \PIODATAWORD_c[365]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[13]\);
    
    IdleSTAT : SLE
      port map(D => RcvaSTAT_1_sqmuxa, CLK => PICLK_c, EN => 
        \H6110_states[4]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \IdleSTAT\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[4]\ : 
        CFG4
      generic map(INIT => x"44FA")

      port map(A => N_4493, B => N_2699, C => N_2587, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[4]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[4]\);
    
    \PIODATAWORD_ibuf[422]\ : INBUF
      port map(PAD => PIODATAWORD(422), Y => \PIODATAWORD_c[422]\);
    
    \SRXFIFO_15[9]\ : SLE
      port map(D => \PIODATAWORD_c[249]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[9]_net_1\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u_RNO_0[10]\ : CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[10]_net_1\, D => 
        \SRXMODEDATAWORD[10]_net_1\, Y => 
        \un9_sdatawordlen_1.un1_SCOMMWORD_4_1_1[10]\);
    
    \SRXMODEDATAWORD[2]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[2]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[2]_net_1\);
    
    \PIODATAWORD_ibuf[8]\ : INBUF
      port map(PAD => PIODATAWORD(8), Y => \PIODATAWORD_c[8]\);
    
    \PIODATAWORD_ibuf[58]\ : INBUF
      port map(PAD => PIODATAWORD(58), Y => \PIODATAWORD_c[58]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[9]_net_1\, B => 
        \SRXFIFO_7[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[9]\);
    
    \PIODATAWORD_ibuf[408]\ : INBUF
      port map(PAD => PIODATAWORD(408), Y => \PIODATAWORD_c[408]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[10]_net_1\, B => 
        \SRXFIFO_8[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[10]\, 
        Y => N_3289);
    
    \SRXFIFO_14[5]\ : SLE
      port map(D => \PIODATAWORD_c[229]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[0]_net_1\, B => 
        \SRXFIFO_1[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[0]\);
    
    \SRXFIFO_16[9]\ : SLE
      port map(D => \PIODATAWORD_c[265]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[9]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[6]_net_1\, B => 
        \SRXFIFO_15[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[6]\, 
        Y => N_3660);
    
    \PIODATAWORD_ibuf[198]\ : INBUF
      port map(PAD => PIODATAWORD(198), Y => \PIODATAWORD_c[198]\);
    
    \PIODATAWORD_ibuf[183]\ : INBUF
      port map(PAD => PIODATAWORD(183), Y => \PIODATAWORD_c[183]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[13]\, 
        C => \PIODATAWORD_c[189]\, D => \PIODATAWORD_c[141]\, Y
         => N_2836);
    
    \SRXFIFO_8[7]\ : SLE
      port map(D => \PIODATAWORD_c[135]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[7]_net_1\);
    
    \SRXFIFO_11[4]\ : SLE
      port map(D => \PIODATAWORD_c[180]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[15]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2710, D => N_2950, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[15]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[8]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3662, C => 
        N_3617, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[8]_net_1\, 
        Y => \PIOWORD_4_31_bm[8]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[12]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3666, C => 
        N_3621, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[12]_net_1\, 
        Y => \PIOWORD_4_31_bm[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[7]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[7]\, 
        C => \PIODATAWORD_c[183]\, D => \PIODATAWORD_c[135]\, Y
         => N_2830);
    
    \SBUSAWORD[11]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[11]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[10]_net_1\, B => 
        \SRXFIFO_15[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[10]\, 
        Y => N_3664);
    
    \PIODATAWORD_ibuf[328]\ : INBUF
      port map(PAD => PIODATAWORD(328), Y => \PIODATAWORD_c[328]\);
    
    \PIODATAWORD_ibuf[246]\ : INBUF
      port map(PAD => PIODATAWORD(246), Y => \PIODATAWORD_c[246]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[2]\, 
        C => \PIODATAWORD_c[306]\, D => \PIODATAWORD_c[258]\, Y
         => N_2889);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[14]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3338, D => N_3293, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[14]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[11]\, 
        C => \PIODATAWORD_c[123]\, D => \PIODATAWORD_c[75]\, Y
         => N_2546);
    
    \SErrorCounter[5]\ : SLE
      port map(D => \SErrorCounter_s[5]\, CLK => PICLK_c, EN => 
        \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[5]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[11]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[11]\, C => \PIOWORD_4_31_am[11]\, Y => 
        \PIOWORD_4[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[351]\, B => 
        \PIODATAWORD_c[367]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[8]_net_1\, B => 
        \SRXFIFO_3[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[8]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[14]_net_1\, B => 
        \SRXFIFO_9[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[14]\, 
        Y => N_3518);
    
    \SRXFIFO_2[0]\ : SLE
      port map(D => \PIODATAWORD_c[32]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[0]_net_1\);
    
    \PIODATAWORD_ibuf[326]\ : INBUF
      port map(PAD => PIODATAWORD(326), Y => \PIODATAWORD_c[326]\);
    
    \PIODATAWORD_ibuf[496]\ : INBUF
      port map(PAD => PIODATAWORD(496), Y => \PIODATAWORD_c[496]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0[13]\ : 
        CFG4
      generic map(INIT => x"7340")

      port map(A => \PIRegAddr_c[0]\, B => \PIRegAddr_c[2]\, C
         => N_4598, D => N_174, Y => \un1_SCOMMWORD_u_0[13]\);
    
    \PIODATAWORD_ibuf[299]\ : INBUF
      port map(PAD => PIODATAWORD(299), Y => \PIODATAWORD_c[299]\);
    
    \SRXFIFO_10[9]\ : SLE
      port map(D => \PIODATAWORD_c[169]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[9]_net_1\);
    
    \SRXFIFO_28[12]\ : SLE
      port map(D => \PIODATAWORD_c[460]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_8[4]\ : 
        CFG4
      generic map(INIT => x"8010")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[228]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_7\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_1_RNITM6R1[4]\ : CFG4
      generic map(INIT => x"F858")

      port map(A => \PIRegAddr_c[2]\, B => N_3064, C => 
        \un9_sdatawordlen_1.un1_SCOMMWORD_u_1_0[4]_net_1\, D => 
        \PIOWORD_4[4]\, Y => \un1_SCOMMWORD_1_RNITM6R1[4]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[94]\, B => 
        \PIODATAWORD_c[110]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[4]\ : 
        CFG4
      generic map(INIT => x"07C7")

      port map(A => N_2651, B => N_4493, C => N_4490, D => N_2539, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[4]_net_1\);
    
    \SRXFIFO_24[15]\ : SLE
      port map(D => \PIODATAWORD_c[399]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[15]_net_1\);
    
    \PIODATAWORD_ibuf[82]\ : INBUF
      port map(PAD => PIODATAWORD(82), Y => \PIODATAWORD_c[82]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[11]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2786, C => N_2546, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[11]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[11]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[5]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2700, D => N_2940, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[0]_net_1\, B => 
        \SRXFIFO_12[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[0]\, 
        Y => N_4542);
    
    \H6110_states[5]\ : SLE
      port map(D => \H6110_states_ns[1]\, CLK => PICLK_c, EN => 
        VCC_net_1, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \H6110_states[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_cl_48_0_1_0[15]\ : 
        CFG4
      generic map(INIT => x"467D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[2]\, C
         => \PIRegAddr_c[1]\, D => \PIRegAddr_c[0]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_cl_48_0_1_0[15]_net_1\);
    
    \PIODATAWORD_ibuf[404]\ : INBUF
      port map(PAD => PIODATAWORD(404), Y => \PIODATAWORD_c[404]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_0[9]\ : 
        CFG3
      generic map(INIT => x"E2")

      port map(A => \SCOMMWORD[9]_net_1\, B => \PIRegAddr_c[1]\, 
        C => \SRXMODEDATAWORD[9]_net_1\, Y => N_4593);
    
    \PIODATAWORD_ibuf[231]\ : INBUF
      port map(PAD => PIODATAWORD(231), Y => \PIODATAWORD_c[231]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[273]\, B => 
        \PIODATAWORD_c[289]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[15]\, 
        C => \PIODATAWORD_c[319]\, D => \PIODATAWORD_c[271]\, Y
         => N_2902);
    
    \SRXFIFO_17[3]\ : SLE
      port map(D => \PIODATAWORD_c[275]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[3]_net_1\);
    
    \PIODATAWORD_ibuf[156]\ : INBUF
      port map(PAD => PIODATAWORD(156), Y => \PIODATAWORD_c[156]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[1]\, 
        C => \PIODATAWORD_c[369]\, D => \PIODATAWORD_c[321]\, Y
         => N_2648);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[0]\, 
        C => \PIODATAWORD_c[304]\, D => \PIODATAWORD_c[256]\, Y
         => N_2887);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_RNO_0[9]\ : CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[9]\, B => \PIODATAWORD_c[41]\, 
        C => \un9_sdatawordlen_1.SRXMODEDATAWORD_1_18_1_1[9]\, D
         => \SCOMMWORD[0]_net_1\, Y => N_2784);
    
    \PIODATAWORD_ibuf[257]\ : INBUF
      port map(PAD => PIODATAWORD(257), Y => \PIODATAWORD_c[257]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[8]_net_1\, B => 
        \SRXFIFO_9[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[8]\, 
        Y => N_3512);
    
    \SRXFIFO_7[6]\ : SLE
      port map(D => \PIODATAWORD_c[118]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[6]_net_1\);
    
    \SBUSAWORD[0]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[0]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[0]_net_1\);
    
    \PIODATAWORD_ibuf[17]\ : INBUF
      port map(PAD => PIODATAWORD(17), Y => \PIODATAWORD_c[17]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[9]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3558, D => N_3513, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[9]_net_1\);
    
    \PIOWORD_1[6]\ : SLE
      port map(D => N_212, CLK => PICLK_c, EN => pioword29, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[82]\, B => \PIODATAWORD_c[98]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[2]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[0]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_4557, D => N_4554, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[0]_net_1\);
    
    \PIODATAWORD_ibuf[147]\ : INBUF
      port map(PAD => PIODATAWORD(147), Y => \PIODATAWORD_c[147]\);
    
    \SRXFIFO_15[15]\ : SLE
      port map(D => \PIODATAWORD_c[255]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[15]_net_1\);
    
    \SRXFIFO_14[10]\ : SLE
      port map(D => \PIODATAWORD_c[234]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[2]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[146]\, B => 
        \PIODATAWORD_c[162]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[2]\);
    
    \PIODATAWORD_ibuf[172]\ : INBUF
      port map(PAD => PIODATAWORD(172), Y => \PIODATAWORD_c[172]\);
    
    \PIODATAWORD_ibuf[208]\ : INBUF
      port map(PAD => PIODATAWORD(208), Y => \PIODATAWORD_c[208]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[15]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[15]\, 
        C => \PIODATAWORD_c[511]\, D => \PIODATAWORD_c[463]\, Y
         => N_2710);
    
    \SErrorCounter_cry[6]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[6]_net_1\, D => GND_net_1, FCI => 
        \SErrorCounter_cry[5]_net_1\, S => \SErrorCounter_s[6]\, 
        Y => OPEN, FCO => \SErrorCounter_cry[6]_net_1\);
    
    \SRXFIFO_0[13]\ : SLE
      port map(D => \PIODATAWORD_c[13]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[13]_net_1\);
    
    SPrevSTR : SLE
      port map(D => PISTR_c, CLK => PICLK_c, EN => VCC_net_1, ALn
         => PIMR_c_i_0, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => \SPrevSTR\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[1]_net_1\, B => 
        \SRXFIFO_9[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[1]\, 
        Y => N_3505);
    
    \PIODATAWORD_ibuf[14]\ : INBUF
      port map(PAD => PIODATAWORD(14), Y => \PIODATAWORD_c[14]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[13]_net_1\, B => 
        \SRXFIFO_7[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[13]\);
    
    \SBUSAWORD[13]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[13]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[13]_net_1\);
    
    \PIODATAWORD_ibuf[283]\ : INBUF
      port map(PAD => PIODATAWORD(283), Y => \PIODATAWORD_c[283]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1_RNO[2]\ : 
        CFG4
      generic map(INIT => x"3B38")

      port map(A => \SCOMMWORD[2]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m3_1_1[2]\, 
        C => \PIRegAddr_c[1]\, D => \SBUSAWORD[2]_net_1\, Y => 
        N_200);
    
    \SRXFIFO_9[13]\ : SLE
      port map(D => \PIODATAWORD_c[157]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[13]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[0]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[0]\, C => \PIOWORD_4_31_am[0]\, Y => 
        \PIOWORD_4[0]\);
    
    RF1STAT : SLE
      port map(D => RF1STAT_1, CLK => PICLK_c, EN => 
        \H6110_states[2]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \RF1STAT\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[1]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3550, D => N_3505, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[2]_net_1\, B => 
        \SRXFIFO_4[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[5]_net_1\, B => 
        \SRXFIFO_2[5]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[5]\);
    
    \PIODATAWORD_ibuf[438]\ : INBUF
      port map(PAD => PIODATAWORD(438), Y => \PIODATAWORD_c[438]\);
    
    \PIODATAWORD_ibuf[105]\ : INBUF
      port map(PAD => PIODATAWORD(105), Y => \PIODATAWORD_c[105]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[8]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[344]\, B => 
        \PIODATAWORD_c[360]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[8]\);
    
    \SRXFIFO_24[6]\ : SLE
      port map(D => \PIODATAWORD_c[390]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_4_i_m3_d[1]\ : 
        CFG3
      generic map(INIT => x"CA")

      port map(A => \SCTRL[1]_net_1\, B => N_208, C => 
        \PIRegAddr_c[0]\, Y => \un1_SCOMMWORD_4_i_m3_d[1]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[470]\, B => 
        \PIODATAWORD_c[486]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[6]\);
    
    \SRXFIFO_11[6]\ : SLE
      port map(D => \PIODATAWORD_c[182]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[6]_net_1\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_RNO_2[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[409]\, B => 
        \PIODATAWORD_c[441]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_28_1_1[9]\);
    
    \SRXFIFO_31[5]\ : SLE
      port map(D => \PIODATAWORD_c[501]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[5]_net_1\);
    
    \SRXFIFO_27[11]\ : SLE
      port map(D => \PIODATAWORD_c[443]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[11]_net_1\);
    
    \un9_sdatawordlen_1.un1_SCOMMWORD_u_RNO[10]\ : CFG4
      generic map(INIT => x"50EE")

      port map(A => \PIRegAddr_c[1]\, B => \SBUSAWORD[10]_net_1\, 
        C => \SCOMMWORD[10]_net_1\, D => 
        \un9_sdatawordlen_1.un1_SCOMMWORD_4_1_1[10]\, Y => N_3159);
    
    \PIODATAWORD_ibuf[455]\ : INBUF
      port map(PAD => PIODATAWORD(455), Y => \PIODATAWORD_c[455]\);
    
    \PIRegAddr_ibuf[0]\ : INBUF
      port map(PAD => PIRegAddr(0), Y => \PIRegAddr_c[0]\);
    
    \PIODATAWORD_ibuf[205]\ : INBUF
      port map(PAD => PIODATAWORD(205), Y => \PIODATAWORD_c[205]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[5]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2780, C => N_2540, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[5]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[405]\, B => 
        \PIODATAWORD_c[421]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[5]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_10\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_9\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_8\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_7\, 
        Y => N_2827);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[412]\, B => 
        \PIODATAWORD_c[428]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[12]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[5]\, 
        C => \PIODATAWORD_c[501]\, D => \PIODATAWORD_c[453]\, Y
         => N_2700);
    
    \FFempty_flag_generator.un45_sregaddr.RXFIFOcount_n3\ : CFG4
      generic map(INIT => x"0408")

      port map(A => RXFIFOcount_c2, B => 
        \FFempty_flag_generator.un45_sregaddr\, C => 
        \RXFIFOloaded\, D => \RXFIFOcount[3]_net_1\, Y => 
        RXFIFOcount_n3);
    
    \PIODATAWORD_ibuf[211]\ : INBUF
      port map(PAD => PIODATAWORD(211), Y => \PIODATAWORD_c[211]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[14]\, 
        C => \PIODATAWORD_c[446]\, D => \PIODATAWORD_c[398]\, Y
         => N_2949);
    
    \PIODATAWORD_ibuf[449]\ : INBUF
      port map(PAD => PIODATAWORD(449), Y => \PIODATAWORD_c[449]\);
    
    \SRXFIFO_14[8]\ : SLE
      port map(D => \PIODATAWORD_c[232]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[10]_net_1\, B => 
        \SRXFIFO_14[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[10]\, 
        Y => N_3439);
    
    \PIODATAWORD_ibuf[301]\ : INBUF
      port map(PAD => PIODATAWORD(301), Y => \PIODATAWORD_c[301]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[11]_net_1\, B => 
        \SRXFIFO_4[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[11]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_RNO_1[9]\ : CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[345]\, B => 
        \PIODATAWORD_c[377]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_10_1_1[9]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[12]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3441, C => 
        N_3396, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[12]_net_1\, 
        Y => \PIOWORD_4_31_am[12]\);
    
    \SRXFIFO_8[4]\ : SLE
      port map(D => \PIODATAWORD_c[132]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[4]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[1]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[1]_net_1\, B => 
        \SRXFIFO_14[1]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[1]\, 
        Y => N_3430);
    
    \PIODATAWORD_ibuf[63]\ : INBUF
      port map(PAD => PIODATAWORD(63), Y => \PIODATAWORD_c[63]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[10]_net_1\, B => 
        \SRXFIFO_12[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[10]\, 
        Y => N_3334);
    
    \PIODATAWORD_ibuf[178]\ : INBUF
      port map(PAD => PIODATAWORD(178), Y => \PIODATAWORD_c[178]\);
    
    \SRXMODEDATAWORD[13]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[13]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[13]_net_1\);
    
    \PIODATAWORD_ibuf[122]\ : INBUF
      port map(PAD => PIODATAWORD(122), Y => \PIODATAWORD_c[122]\);
    
    \SRXFIFO_14[11]\ : SLE
      port map(D => \PIODATAWORD_c[235]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[11]_net_1\);
    
    \SRXFIFO_6[6]\ : SLE
      port map(D => \PIODATAWORD_c[102]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[7]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2590, D => N_2830, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[7]_net_1\);
    
    \SRXFIFO_2[6]\ : SLE
      port map(D => \PIODATAWORD_c[38]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_2[1]\ : 
        CFG4
      generic map(INIT => x"FFDC")

      port map(A => sprtycheck, B => \H6110_states[0]_net_1\, C
         => \H6110_states[6]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_1[1]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.H6110_states_ns_0_0_2[1]_net_1\);
    
    \SRXFIFO_28[0]\ : SLE
      port map(D => \PIODATAWORD_c[448]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[0]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_2[3]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[3]_net_1\, B => \PIOWORD_4[3]\, C => 
        \PIRegAddr_c[3]\, Y => N_4587);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[9]_net_1\, B => 
        \SRXFIFO_5[9]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[8]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[8]_net_1\, B => 
        \SRXFIFO_5[8]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[8]\);
    
    \SRXFIFO_23[15]\ : SLE
      port map(D => \PIODATAWORD_c[383]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[15]_net_1\);
    
    \PIODATAWORD_ibuf[434]\ : INBUF
      port map(PAD => PIODATAWORD(434), Y => \PIODATAWORD_c[434]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[2]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[2]_net_1\, B => 
        \SRXFIFO_7[2]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[2]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_RNO[9]\ : CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[329]\, B => 
        \PIODATAWORD_c[361]\, C => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_10_1_1[9]\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_2656);
    
    \SRXFIFO_11[13]\ : SLE
      port map(D => \PIODATAWORD_c[189]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[10]_net_1\, B => 
        \SRXFIFO_0[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[10]\);
    
    \PIODATAWORD_ibuf[418]\ : INBUF
      port map(PAD => PIODATAWORD(418), Y => \PIODATAWORD_c[418]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[0]_net_1\, B => 
        \SRXFIFO_10[0]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[0]\, 
        Y => N_4546);
    
    \PIODATAWORD_ibuf[476]\ : INBUF
      port map(PAD => PIODATAWORD(476), Y => \PIODATAWORD_c[476]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[6]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[6]\, 
        C => \PIODATAWORD_c[246]\, D => \PIODATAWORD_c[198]\, Y
         => N_2589);
    
    \SRXFIFO_10[15]\ : SLE
      port map(D => \PIODATAWORD_c[175]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[15]_net_1\);
    
    \PIODATAWORD_ibuf[279]\ : INBUF
      port map(PAD => PIODATAWORD(279), Y => \PIODATAWORD_c[279]\);
    
    \SRXFIFO_9[2]\ : SLE
      port map(D => \PIODATAWORD_c[146]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[2]_net_1\);
    
    \SRXFIFO_1[0]\ : SLE
      port map(D => \PIODATAWORD_c[16]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[0]_net_1\);
    
    \SRXFIFO_14[2]\ : SLE
      port map(D => \PIODATAWORD_c[226]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[2]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[14]\, 
        C => \PIODATAWORD_c[510]\, D => \PIODATAWORD_c[462]\, Y
         => N_2709);
    
    \SRXFIFO_25[10]\ : SLE
      port map(D => \PIODATAWORD_c[410]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[1]\, 
        C => \PIODATAWORD_c[433]\, D => \PIODATAWORD_c[385]\, Y
         => N_2936);
    
    \SRXFIFO_6[13]\ : SLE
      port map(D => \PIODATAWORD_c[109]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[13]_net_1\);
    
    \PIODATAWORD_ibuf[238]\ : INBUF
      port map(PAD => PIODATAWORD(238), Y => \PIODATAWORD_c[238]\);
    
    \SRXFIFO_13[10]\ : SLE
      port map(D => \PIODATAWORD_c[218]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[15]_net_1\, B => 
        \SRXFIFO_4[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[15]\);
    
    \SRXFIFO_30[8]\ : SLE
      port map(D => \PIODATAWORD_c[488]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[8]_net_1\);
    
    \PIODATAWORD_ibuf[166]\ : INBUF
      port map(PAD => PIODATAWORD(166), Y => \PIODATAWORD_c[166]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[14]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[14]\, 
        C => \PIODATAWORD_c[62]\, D => \PIODATAWORD_c[14]\, Y => 
        N_2789);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[5]\, 
        C => \PIODATAWORD_c[373]\, D => \PIODATAWORD_c[325]\, Y
         => N_2652);
    
    \SRXFIFO_5[5]\ : SLE
      port map(D => \PIODATAWORD_c[85]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[5]_net_1\);
    
    \SRXFIFO_3[0]\ : SLE
      port map(D => \PIODATAWORD_c[48]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[0]_net_1\);
    
    \SRXFIFO_25[4]\ : SLE
      port map(D => \PIODATAWORD_c[404]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[4]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[2]_net_1\, B => 
        \SRXFIFO_10[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[2]\, 
        Y => N_3386);
    
    \PIODATAWORD_ibuf[267]\ : INBUF
      port map(PAD => PIODATAWORD(267), Y => \PIODATAWORD_c[267]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[14]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2709, D => N_2949, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[14]_net_1\);
    
    \SRXFIFO_30[0]\ : SLE
      port map(D => \PIODATAWORD_c[480]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[13]_net_1\, B => 
        \SRXFIFO_12[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[13]\, 
        Y => N_3337);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[6]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3330, D => N_3285, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[6]_net_1\);
    
    \SRXFIFO_4[5]\ : SLE
      port map(D => \PIODATAWORD_c[69]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[5]_net_1\);
    
    \SRXFIFO_12[8]\ : SLE
      port map(D => \PIODATAWORD_c[200]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_12[8]_net_1\);
    
    \SRXFIFO_9[5]\ : SLE
      port map(D => \PIODATAWORD_c[149]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[5]_net_1\);
    
    \SRXFIFO_30[5]\ : SLE
      port map(D => \PIODATAWORD_c[485]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[5]_net_1\);
    
    \SRXFIFO_13[6]\ : SLE
      port map(D => \PIODATAWORD_c[214]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_17[14]_net_1\, B => 
        \SRXFIFO_1[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[14]\);
    
    \SRXFIFO_22[2]\ : SLE
      port map(D => \PIODATAWORD_c[354]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[2]_net_1\);
    
    \SRXFIFO_20[2]\ : SLE
      port map(D => \PIODATAWORD_c[322]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[2]_net_1\);
    
    \PIOWORD_iobuf[13]\ : BIBUF
      port map(PAD => PIOWORD(13), D => \PIOWORD_1[13]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[13]\);
    
    \PIODATAWORD_ibuf[135]\ : INBUF
      port map(PAD => PIODATAWORD(135), Y => \PIODATAWORD_c[135]\);
    
    \PIODATAWORD_ibuf[128]\ : INBUF
      port map(PAD => PIODATAWORD(128), Y => \PIODATAWORD_c[128]\);
    
    \SRXFIFO_8[14]\ : SLE
      port map(D => \PIODATAWORD_c[142]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[14]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.ALTB_ns_1[4]\ : CFG3
      generic map(INIT => x"5C")

      port map(A => \ALTB_bm[4]\, B => \RXFIFOcount[3]_net_1\, C
         => N_4496, Y => 
        \FFempty_flag_generator.un45_sregaddr.ALTB_ns_1[4]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[9]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3663, C => 
        N_3618, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[9]_net_1\, 
        Y => \PIOWORD_4_31_bm[9]\);
    
    \PIODATAWORD_ibuf[500]\ : INBUF
      port map(PAD => PIODATAWORD(500), Y => \PIODATAWORD_c[500]\);
    
    \PIODATAWORD_ibuf[235]\ : INBUF
      port map(PAD => PIODATAWORD(235), Y => \PIODATAWORD_c[235]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_1[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[214]\, B => 
        \PIODATAWORD_c[230]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[6]\);
    
    \SRXFIFO_5[12]\ : SLE
      port map(D => \PIODATAWORD_c[92]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[12]_net_1\);
    
    \PIODATAWORD_ibuf[104]\ : INBUF
      port map(PAD => PIODATAWORD(104), Y => \PIODATAWORD_c[104]\);
    
    \PIODATAWORD_ibuf[414]\ : INBUF
      port map(PAD => PIODATAWORD(414), Y => \PIODATAWORD_c[414]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[5]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[149]\, B => 
        \PIODATAWORD_c[165]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[5]\);
    
    \PIOWORD_iobuf[5]\ : BIBUF
      port map(PAD => PIOWORD(5), D => \PIOWORD_1[5]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[5]\);
    
    \PIODATAWORD_ibuf[242]\ : INBUF
      port map(PAD => PIODATAWORD(242), Y => \PIODATAWORD_c[242]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[336]\, B => 
        \PIODATAWORD_c[352]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[0]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[410]\, B => 
        \PIODATAWORD_c[426]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[10]\);
    
    \SRXFIFO_19[3]\ : SLE
      port map(D => \PIODATAWORD_c[307]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_19[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[476]\, B => 
        \PIODATAWORD_c[492]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[12]\);
    
    \un9_sdatawordlen_1.RF0STAT_1\ : CFG2
      generic map(INIT => x"4")

      port map(A => \SCOMMWORD[10]_net_1\, B => \SActA\, Y => 
        RF0STAT_1);
    
    \SRXFIFO_18[15]\ : SLE
      port map(D => \PIODATAWORD_c[303]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_18[15]_net_1\);
    
    \PIODATAWORD_ibuf[71]\ : INBUF
      port map(PAD => PIODATAWORD(71), Y => \PIODATAWORD_c[71]\);
    
    \PIODATAWORD_ibuf[331]\ : INBUF
      port map(PAD => PIODATAWORD(331), Y => \PIODATAWORD_c[331]\);
    
    \PIODATAWORD_ibuf[426]\ : INBUF
      port map(PAD => PIODATAWORD(426), Y => \PIODATAWORD_c[426]\);
    
    \PIODATAWORD_ibuf[229]\ : INBUF
      port map(PAD => PIODATAWORD(229), Y => \PIODATAWORD_c[229]\);
    
    \PIODATAWORD_ibuf[465]\ : INBUF
      port map(PAD => PIODATAWORD(465), Y => \PIODATAWORD_c[465]\);
    
    \PIODATAWORD_ibuf[101]\ : INBUF
      port map(PAD => PIODATAWORD(101), Y => \PIODATAWORD_c[101]\);
    
    \SRXFIFO_22[13]\ : SLE
      port map(D => \PIODATAWORD_c[365]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[13]_net_1\);
    
    \PIOWORD_iobuf[8]\ : BIBUF
      port map(PAD => PIOWORD(8), D => \PIOWORD_1[8]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[8]\);
    
    \PIODATAWORD_ibuf[31]\ : INBUF
      port map(PAD => PIODATAWORD(31), Y => \PIODATAWORD_c[31]\);
    
    RcvbSTAT : SLE
      port map(D => RcvbSTAT_3, CLK => PICLK_c, EN => 
        \H6110_states[4]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => PORCVB_c);
    
    \PIODATAWORD_ibuf[244]\ : INBUF
      port map(PAD => PIODATAWORD(244), Y => \PIODATAWORD_c[244]\);
    
    \SErrorCounter[1]\ : SLE
      port map(D => \SErrorCounter_s[1]\, CLK => PICLK_c, EN => 
        \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[1]_net_1\);
    
    \PIODATAWORD_ibuf[218]\ : INBUF
      port map(PAD => PIODATAWORD(218), Y => \PIODATAWORD_c[218]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[2]\, 
        C => \PIODATAWORD_c[242]\, D => \PIODATAWORD_c[194]\, Y
         => N_2585);
    
    \SRXFIFO_13[11]\ : SLE
      port map(D => \PIODATAWORD_c[219]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[11]_net_1\);
    
    \PIODATAWORD_ibuf[281]\ : INBUF
      port map(PAD => PIODATAWORD(281), Y => \PIODATAWORD_c[281]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[12]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3561, D => N_3516, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[12]_net_1\);
    
    \PIODATAWORD_ibuf[55]\ : INBUF
      port map(PAD => PIODATAWORD(55), Y => \PIODATAWORD_c[55]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[3]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3327, D => N_3282, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[3]_net_1\);
    
    \SRXFIFO_17[0]\ : SLE
      port map(D => \PIODATAWORD_c[272]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[0]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un12_serr_0_a2_0_o2_3\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => \PIERR_c[5]\, B => \PIERR_c[4]\, C => 
        \PIERR_c[1]\, D => \PIERR_c[0]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un12_serr_0_a2_0_o2_3_net_1\);
    
    \PIODATAWORD_ibuf[115]\ : INBUF
      port map(PAD => PIODATAWORD(115), Y => \PIODATAWORD_c[115]\);
    
    \SRXFIFO_20[10]\ : SLE
      port map(D => \PIODATAWORD_c[330]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[10]_net_1\);
    
    \SBUSAWORD[3]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[3]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[3]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1_RNO[14]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_28[14]_net_1\, B => 
        \SRXFIFO_12[14]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[14]\, 
        Y => N_3338);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO[11]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_25_1_1[11]\, 
        C => \PIODATAWORD_c[315]\, D => \PIODATAWORD_c[267]\, Y
         => N_2898);
    
    \PIODATAWORD_ibuf[62]\ : INBUF
      port map(PAD => PIODATAWORD(62), Y => \PIODATAWORD_c[62]\);
    
    \SRXFIFO_11[9]\ : SLE
      port map(D => \PIODATAWORD_c[185]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[9]_net_1\);
    
    \SRXFIFO_11[1]\ : SLE
      port map(D => \PIODATAWORD_c[177]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[7]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[23]\, B => \PIODATAWORD_c[39]\, 
        C => \SCOMMWORD[1]_net_1\, D => \SCOMMWORD[0]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[7]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_1[9]\ : CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2592, D => N_2832, 
        Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_bm_1_1[9]_net_1\);
    
    \PIODATAWORD_ibuf[215]\ : INBUF
      port map(PAD => PIODATAWORD(215), Y => \PIODATAWORD_c[215]\);
    
    \PIODATAWORD_ibuf[451]\ : INBUF
      port map(PAD => PIODATAWORD(451), Y => \PIODATAWORD_c[451]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[8]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2895, C => N_2655, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[8]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[8]\);
    
    \SRXFIFO_11[7]\ : SLE
      port map(D => \PIODATAWORD_c[183]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[7]_net_1\);
    
    \PIODATAWORD_ibuf[443]\ : INBUF
      port map(PAD => PIODATAWORD(443), Y => \PIODATAWORD_c[443]\);
    
    \SCTRL[1]\ : SLE
      port map(D => \PIOWORD_in[1]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[1]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[1]\, 
        C => \PIODATAWORD_c[177]\, D => \PIODATAWORD_c[129]\, Y
         => N_2824);
    
    \SRXFIFO_23[4]\ : SLE
      port map(D => \PIODATAWORD_c[372]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[4]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_2[2]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[2]_net_1\, B => \PIOWORD_4[2]\, C => 
        \PIRegAddr_c[3]\, Y => N_4586);
    
    \PIODATAWORD_ibuf[304]\ : INBUF
      port map(PAD => PIODATAWORD(304), Y => \PIODATAWORD_c[304]\);
    
    \SErrorCounter_cry[5]\ : ARI1
      generic map(INIT => x"48800")

      port map(A => VCC_net_1, B => \SErrorCounter_cry_cy_Y[0]\, 
        C => \SErrorCounter[5]_net_1\, D => GND_net_1, FCI => 
        \SErrorCounter_cry[4]_net_1\, S => \SErrorCounter_s[5]\, 
        Y => OPEN, FCO => \SErrorCounter_cry[5]_net_1\);
    
    \PIODATAWORD_ibuf[311]\ : INBUF
      port map(PAD => PIODATAWORD(311), Y => \PIODATAWORD_c[311]\);
    
    \PICMD_ibuf[8]\ : INBUF
      port map(PAD => PICMD(8), Y => \PICMD_c[8]\);
    
    \FFempty_flag_generator.un45_sregaddr.un8_scmd_NE_RNIME1K1\ : 
        CFG4
      generic map(INIT => x"A82A")

      port map(A => un8_scmd_NE, B => \PICMD_c[15]\, C => 
        \PICMD_c[12]\, D => 
        \FFempty_flag_generator.un45_sregaddr.m8_1_net_1\, Y => 
        RcvaSTAT_1_sqmuxa);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[1]_net_1\, B => 
        \SRXFIFO_5[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[1]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am[13]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3442, C => 
        N_3397, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_1[13]_net_1\, 
        Y => \PIOWORD_4_31_am[13]\);
    
    \SBUSAWORD[8]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[8]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[8]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_2[15]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_19[15]_net_1\, B => 
        \SRXFIFO_3[15]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[15]\);
    
    \SRXFIFO_29[6]\ : SLE
      port map(D => \PIODATAWORD_c[470]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[6]_net_1\);
    
    \PIODATAWORD_ibuf[440]\ : INBUF
      port map(PAD => PIODATAWORD(440), Y => \PIODATAWORD_c[440]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[4]_net_1\, B => 
        \SRXFIFO_4[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[4]\);
    
    \SRXFIFO_8[5]\ : SLE
      port map(D => \PIODATAWORD_c[133]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[5]_net_1\);
    
    \PIODATAWORD_ibuf[488]\ : INBUF
      port map(PAD => PIODATAWORD(488), Y => \PIODATAWORD_c[488]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[6]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[6]\, C => \PIOWORD_4_31_am[6]\, Y => 
        \PIOWORD_4[6]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[406]\, B => 
        \PIODATAWORD_c[422]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[6]\);
    
    \SRXFIFO_29[13]\ : SLE
      port map(D => \PIODATAWORD_c[477]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[13]_net_1\);
    
    \SRXFIFO_2[4]\ : SLE
      port map(D => \PIODATAWORD_c[36]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[4]_net_1\);
    
    \PIODATAWORD_ibuf[349]\ : INBUF
      port map(PAD => PIODATAWORD(349), Y => \PIODATAWORD_c[349]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[6]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3555, D => N_3510, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[6]_net_1\);
    
    \PIODATAWORD_ibuf[134]\ : INBUF
      port map(PAD => PIODATAWORD(134), Y => \PIODATAWORD_c[134]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[3]_net_1\, B => 
        \SRXFIFO_9[3]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[3]\, 
        Y => N_3507);
    
    \SRXFIFO_24[1]\ : SLE
      port map(D => \PIODATAWORD_c[385]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[1]_net_1\);
    
    \PIODATAWORD_ibuf[343]\ : INBUF
      port map(PAD => PIODATAWORD(343), Y => \PIODATAWORD_c[343]\);
    
    \PIODATAWORD_ibuf[41]\ : INBUF
      port map(PAD => PIODATAWORD(41), Y => \PIODATAWORD_c[41]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[14]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[350]\, B => 
        \PIODATAWORD_c[366]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[14]\);
    
    \SRXFIFO_4[11]\ : SLE
      port map(D => \PIODATAWORD_c[75]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_4[11]_net_1\);
    
    \SRXFIFO_17[13]\ : SLE
      port map(D => \PIODATAWORD_c[285]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[13]_net_1\);
    
    \SRXFIFO_14[0]\ : SLE
      port map(D => \PIODATAWORD_c[224]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[0]_net_1\);
    
    \SRXFIFO_28[10]\ : SLE
      port map(D => \PIODATAWORD_c[458]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[10]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0_1[9]\ : 
        CFG4
      generic map(INIT => x"5520")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[2]\, C
         => \PIRegAddr_c[1]\, D => \PIRegAddr_c[0]\, Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0_1[9]_net_1\);
    
    \SRXFIFO_30[10]\ : SLE
      port map(D => \PIODATAWORD_c[490]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_30[10]_net_1\);
    
    \SRXFIFO_29[0]\ : SLE
      port map(D => \PIODATAWORD_c[464]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[0]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[5]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[5]_net_1\, B => 
        \SRXFIFO_9[5]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[5]\, 
        Y => N_3509);
    
    \SRXFIFO_26[7]\ : SLE
      port map(D => \PIODATAWORD_c[423]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[7]_net_1\);
    
    \PIODATAWORD_ibuf[131]\ : INBUF
      port map(PAD => PIODATAWORD(131), Y => \PIODATAWORD_c[131]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_2[5]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[5]_net_1\, B => \PIOWORD_4[5]\, C => 
        \PIRegAddr_c[3]\, Y => N_4590);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[474]\, B => 
        \PIODATAWORD_c[490]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[10]\);
    
    \PIOWORD_iobuf[0]\ : BIBUF
      port map(PAD => PIOWORD(0), D => \PIOWORD_1[0]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[0]\);
    
    \PIODATAWORD_ibuf[457]\ : INBUF
      port map(PAD => PIODATAWORD(457), Y => \PIODATAWORD_c[457]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_0[6]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_26[6]_net_1\, B => 
        \SRXFIFO_10[6]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[6]\, 
        Y => N_3390);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[10]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[10]_net_1\, B => 
        \SRXFIFO_6[10]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[10]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[0]_net_1\, B => 
        \SRXFIFO_2[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[0]\);
    
    \PIODATAWORD_ibuf[300]\ : INBUF
      port map(PAD => PIODATAWORD(300), Y => \PIODATAWORD_c[300]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_21[0]_net_1\, B => 
        \SRXFIFO_5[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[0]\);
    
    \SRXFIFO_26[12]\ : SLE
      port map(D => \PIODATAWORD_c[428]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_26[12]_net_1\);
    
    \PIODATAWORD_ibuf[149]\ : INBUF
      port map(PAD => PIODATAWORD(149), Y => \PIODATAWORD_c[149]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_0[4]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_27[4]_net_1\, B => 
        \SRXFIFO_11[4]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_25_1_1[4]\, 
        Y => N_3613);
    
    \PIODATAWORD_ibuf[484]\ : INBUF
      port map(PAD => PIODATAWORD(484), Y => \PIODATAWORD_c[484]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am[9]\ : CFG4
      generic map(INIT => x"B383")

      port map(A => N_2656, B => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_1[9]_net_1\, 
        C => N_4493, D => N_2896, Y => 
        \SRXMODEDATAWORD_1_31_am[9]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_1[4]\ : 
        CFG4
      generic map(INIT => x"0060")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[388]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_54\);
    
    \PIODATAWORD_ibuf[200]\ : INBUF
      port map(PAD => PIODATAWORD(200), Y => \PIODATAWORD_c[200]\);
    
    \SRXFIFO_2[9]\ : SLE
      port map(D => \PIODATAWORD_c[41]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[9]_net_1\);
    
    \SRXFIFO_14[14]\ : SLE
      port map(D => \PIODATAWORD_c[238]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_14[14]_net_1\);
    
    \SRXFIFO_22[6]\ : SLE
      port map(D => \PIODATAWORD_c[358]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[6]_net_1\);
    
    PICS_ibuf : INBUF
      port map(PAD => PICS, Y => PICS_c);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1_RNO[12]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_1_1[12]\, 
        C => \PIODATAWORD_c[508]\, D => \PIODATAWORD_c[460]\, Y
         => N_2707);
    
    \SRXFIFO_6[4]\ : SLE
      port map(D => \PIODATAWORD_c[100]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[4]_net_1\);
    
    \PIODATAWORD_ibuf[56]\ : INBUF
      port map(PAD => PIODATAWORD(56), Y => \PIODATAWORD_c[56]\);
    
    \PIODATAWORD_ibuf[510]\ : INBUF
      port map(PAD => PIODATAWORD(510), Y => \PIODATAWORD_c[510]\);
    
    \PIODATAWORD_ibuf[114]\ : INBUF
      port map(PAD => PIODATAWORD(114), Y => \PIODATAWORD_c[114]\);
    
    \SRXFIFO_9[9]\ : SLE
      port map(D => \PIODATAWORD_c[153]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[9]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[3]\ : 
        CFG4
      generic map(INIT => x"4657")

      port map(A => \RXFIFOcount[2]_net_1\, B => 
        \RXFIFOcount[1]_net_1\, C => N_3552, D => N_3507, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[3]_net_1\);
    
    \un9_sdatawordlen_1.SBUSBWORD_1_sqmuxa\ : CFG4
      generic map(INIT => x"0020")

      port map(A => SRXMODEDATAWORD_0_sqmuxa, B => N_1120, C => 
        \SActB\, D => \SActA\, Y => SBUSBWORD_1_sqmuxa);
    
    \PIODATAWORD_ibuf[288]\ : INBUF
      port map(PAD => PIODATAWORD(288), Y => \PIODATAWORD_c[288]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[13]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[13]_net_1\, B => 
        \SRXFIFO_4[13]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[13]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[2]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[2]\, C => \PIOWORD_4_31_am[2]\, Y => 
        \PIOWORD_4[2]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[11]_net_1\, B => 
        \SRXFIFO_6[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[11]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_1_RNO_1[9]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \PIODATAWORD_c[473]\, B => 
        \PIODATAWORD_c[505]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_13_1_1[9]\);
    
    PICLK_ibuf : INBUF
      port map(PAD => PICLK, Y => \PICLK_ibuf\);
    
    \SRXFIFO_1[11]\ : SLE
      port map(D => \PIODATAWORD_c[27]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_1[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1_0_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"195D")

      port map(A => \PIRegAddr_c[3]\, B => \PIRegAddr_c[1]\, C
         => \SBUSBWORD[3]_net_1\, D => \SRXMODEDATAWORD[3]_net_1\, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m2_1_1[3]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_1[12]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_20[12]_net_1\, B => 
        \SRXFIFO_4[12]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_6_1_1[12]\);
    
    \PIODATAWORD_ibuf[402]\ : INBUF
      port map(PAD => PIODATAWORD(402), Y => \PIODATAWORD_c[402]\);
    
    \PIODATAWORD_ibuf[334]\ : INBUF
      port map(PAD => PIODATAWORD(334), Y => \PIODATAWORD_c[334]\);
    
    \PIODATAWORD_ibuf[111]\ : INBUF
      port map(PAD => PIODATAWORD(111), Y => \PIODATAWORD_c[111]\);
    
    \SRXFIFO_21[5]\ : SLE
      port map(D => \PIODATAWORD_c[341]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_21[5]_net_1\);
    
    \PIERR_ibuf[3]\ : INBUF
      port map(PAD => PIERR(3), Y => \PIERR_c[3]\);
    
    \SCOMMWORD[15]\ : SLE
      port map(D => \PICMD_c[15]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[15]_net_1\);
    
    \PIODATAWORD_ibuf[461]\ : INBUF
      port map(PAD => PIODATAWORD(461), Y => \PIODATAWORD_c[461]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[14]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[14]\, C => \PIOWORD_4_31_am[14]\, Y => 
        \PIOWORD_4[14]\);
    
    \PICMD_ibuf[15]\ : INBUF
      port map(PAD => PICMD(15), Y => \PICMD_c[15]\);
    
    \PIODATAWORD_ibuf[185]\ : INBUF
      port map(PAD => PIODATAWORD(185), Y => \PIODATAWORD_c[185]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO[13]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_31[13]_net_1\, B => 
        \SRXFIFO_15[13]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[13]\, 
        Y => N_3667);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[2]_net_1\, B => 
        \SRXFIFO_14[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[2]\, 
        Y => N_3431);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_1_31_am_RNO_0[9]\ : CFG4
      generic map(INIT => x"AC0F")

      port map(A => \PIODATAWORD_c[265]\, B => 
        \PIODATAWORD_c[297]\, C => 
        \un9_sdatawordlen_1.SRXMODEDATAWORD_1_25_1_1[9]\, D => 
        \SCOMMWORD[0]_net_1\, Y => N_2896);
    
    \PIODATAWORD_ibuf[196]\ : INBUF
      port map(PAD => PIODATAWORD(196), Y => \PIODATAWORD_c[196]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1_RNO[10]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_29[10]_net_1\, B => 
        \SRXFIFO_13[10]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_21_1_1[10]\, 
        Y => N_3559);
    
    \SRXFIFO_28[8]\ : SLE
      port map(D => \PIODATAWORD_c[456]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[8]_net_1\);
    
    \PIODATAWORD_ibuf[150]\ : INBUF
      port map(PAD => PIODATAWORD(150), Y => \PIODATAWORD_c[150]\);
    
    \PIODATAWORD_ibuf[297]\ : INBUF
      port map(PAD => PIODATAWORD(297), Y => \PIODATAWORD_c[297]\);
    
    \PIODATAWORD_ibuf[285]\ : INBUF
      port map(PAD => PIODATAWORD(285), Y => \PIODATAWORD_c[285]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[6]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[150]\, B => 
        \PIODATAWORD_c[166]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[6]\);
    
    \SRXFIFO_11[12]\ : SLE
      port map(D => \PIODATAWORD_c[188]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_11[12]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_3_1_1[0]\, 
        C => \PIODATAWORD_c[112]\, D => \PIODATAWORD_c[64]\, Y
         => N_2535);
    
    \PIODATAWORD_ibuf[28]\ : INBUF
      port map(PAD => PIODATAWORD(28), Y => \PIODATAWORD_c[28]\);
    
    \SRXFIFO_25[15]\ : SLE
      port map(D => \PIODATAWORD_c[415]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[15]_net_1\);
    
    \SRXFIFO_10[7]\ : SLE
      port map(D => \PIODATAWORD_c[167]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[7]_net_1\);
    
    \PIODATAWORD_ibuf[308]\ : INBUF
      port map(PAD => PIODATAWORD(308), Y => \PIODATAWORD_c[308]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_2[12]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[348]\, B => 
        \PIODATAWORD_c[364]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[12]\);
    
    \PIODATAWORD_ibuf[81]\ : INBUF
      port map(PAD => PIODATAWORD(81), Y => \PIODATAWORD_c[81]\);
    
    \SRXFIFO_9[7]\ : SLE
      port map(D => \PIODATAWORD_c[151]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[7]_net_1\);
    
    \PIODATAWORD_ibuf[381]\ : INBUF
      port map(PAD => PIODATAWORD(381), Y => \PIODATAWORD_c[381]\);
    
    \PICMD_ibuf[4]\ : INBUF
      port map(PAD => PICMD(4), Y => \PICMD_c[4]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXFIFO_0_0_sqmuxa_0_a2\ : 
        CFG3
      generic map(INIT => x"20")

      port map(A => \H6110_states[1]_net_1\, B => N_1120, C => 
        N_61, Y => SRXFIFO_0_0_sqmuxa);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_16[3]_net_1\, B => 
        \SRXFIFO_0[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[3]\);
    
    \SRXFIFO_3[12]\ : SLE
      port map(D => \PIODATAWORD_c[60]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_3[12]_net_1\);
    
    \SRXFIFO_31[0]\ : SLE
      port map(D => \PIODATAWORD_c[496]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[0]_net_1\);
    
    \SRXFIFO_28[5]\ : SLE
      port map(D => \PIODATAWORD_c[453]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[5]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[1]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[1]_net_1\, B => 
        \SRXFIFO_6[1]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[1]\);
    
    \PIERR_ibuf[7]\ : INBUF
      port map(PAD => PIERR(7), Y => \PIERR_c[7]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[6]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2893, C => N_2653, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[6]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[6]\);
    
    \PIODATAWORD_ibuf[306]\ : INBUF
      port map(PAD => PIODATAWORD(306), Y => \PIODATAWORD_c[306]\);
    
    \SCTRL[14]\ : SLE
      port map(D => \PIOWORD_in[14]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[14]_net_1\);
    
    \PIOWORD_iobuf[6]\ : BIBUF
      port map(PAD => PIOWORD(6), D => \PIOWORD_1[6]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[6]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[7]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[7]\, C => \PIOWORD_4_31_am[7]\, Y => 
        \PIOWORD_4[7]\);
    
    \SRXFIFO_15[10]\ : SLE
      port map(D => \PIODATAWORD_c[250]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[10]_net_1\);
    
    \PIODATAWORD_ibuf[330]\ : INBUF
      port map(PAD => PIODATAWORD(330), Y => \PIODATAWORD_c[330]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[4]\ : 
        CFG4
      generic map(INIT => x"FFFE")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_54\, 
        B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_53\, 
        C => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_52\, 
        D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_51\, 
        Y => N_2939);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[0]\, 
        C => \PIODATAWORD_c[432]\, D => \PIODATAWORD_c[384]\, Y
         => N_2935);
    
    \PIODATAWORD_ibuf[314]\ : INBUF
      port map(PAD => PIODATAWORD(314), Y => \PIODATAWORD_c[314]\);
    
    \SRXFIFO_7[13]\ : SLE
      port map(D => \PIODATAWORD_c[125]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_7[13]_net_1\);
    
    \PIODATAWORD_ibuf[495]\ : INBUF
      port map(PAD => PIODATAWORD(495), Y => \PIODATAWORD_c[495]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[6]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2589, D => N_2829, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[6]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_RNO_0[15]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_25[15]_net_1\, B => 
        \SRXFIFO_9[15]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_18_1_1[15]\, 
        Y => N_3519);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[11]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[11]_net_1\, B => 
        \SRXFIFO_14[11]_net_1\, C => \RXFIFOcount[3]_net_1\, D
         => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[11]\, 
        Y => N_3440);
    
    \SRXFIFO_16[5]\ : SLE
      port map(D => \PIODATAWORD_c[261]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[5]_net_1\);
    
    \PIODATAWORD_ibuf[50]\ : INBUF
      port map(PAD => PIODATAWORD(50), Y => \PIODATAWORD_c[50]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3[5]\ : 
        CFG4
      generic map(INIT => x"20FD")

      port map(A => N_162, B => \PIRegAddr_c[0]\, C => N_4590, D
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m3_1[5]_net_1\, 
        Y => N_213);
    
    \SRXFIFO_10[4]\ : SLE
      port map(D => \PIODATAWORD_c[164]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[4]_net_1\);
    
    \SRXFIFO_31[12]\ : SLE
      port map(D => \PIODATAWORD_c[508]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[12]_net_1\);
    
    \PIODATAWORD_ibuf[98]\ : INBUF
      port map(PAD => PIODATAWORD(98), Y => \PIODATAWORD_c[98]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[7]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[7]_net_1\, B => 
        \SRXFIFO_14[7]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[7]\, 
        Y => N_3436);
    
    \SRXMODEDATAWORD[11]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[11]\, CLK => PICLK_c, EN
         => SRXMODEDATAWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SRXMODEDATAWORD[11]_net_1\);
    
    \PIODATAWORD_ibuf[467]\ : INBUF
      port map(PAD => PIODATAWORD(467), Y => \PIODATAWORD_c[467]\);
    
    \PIODATAWORD_ibuf[357]\ : INBUF
      port map(PAD => PIODATAWORD(357), Y => \PIODATAWORD_c[357]\);
    
    \PIODATAWORD_ibuf[230]\ : INBUF
      port map(PAD => PIODATAWORD(230), Y => \PIODATAWORD_c[230]\);
    
    \PIODATAWORD_ibuf[77]\ : INBUF
      port map(PAD => PIODATAWORD(77), Y => \PIODATAWORD_c[77]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[3]\ : 
        CFG4
      generic map(INIT => x"2367")

      port map(A => N_4493, B => N_4492, C => N_2698, D => N_2938, 
        Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[3]_net_1\);
    
    \SRXFIFO_8[1]\ : SLE
      port map(D => \PIODATAWORD_c[129]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_8[1]_net_1\);
    
    \SRXFIFO_13[14]\ : SLE
      port map(D => \PIODATAWORD_c[222]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[14]_net_1\);
    
    \SRXFIFO_20[8]\ : SLE
      port map(D => \PIODATAWORD_c[328]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[8]_net_1\);
    
    \PIODATAWORD_ibuf[37]\ : INBUF
      port map(PAD => PIODATAWORD(37), Y => \PIODATAWORD_c[37]\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm[7]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => \RXFIFOcount[1]_net_1\, B => N_3661, C => 
        N_3616, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_1_1[7]_net_1\, 
        Y => \PIOWORD_4_31_bm[7]\);
    
    \PIOWORD_1[9]\ : SLE
      port map(D => \un1_SCOMMWORD_u_0[9]\, CLK => PICLK_c, EN
         => pioword29, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2[0]\ : 
        CFG4
      generic map(INIT => x"20FD")

      port map(A => N_162, B => \PIRegAddr_c[0]\, C => N_4583, D
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1[0]_net_1\, 
        Y => N_84);
    
    \PIODATAWORD_ibuf[352]\ : INBUF
      port map(PAD => PIODATAWORD(352), Y => \PIODATAWORD_c[352]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_RNO[1]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_18_1_1[1]\, 
        C => \PIODATAWORD_c[49]\, D => \PIODATAWORD_c[1]\, Y => 
        N_2776);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[14]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[14]_net_1\, B => 
        \SRXFIFO_6[14]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[14]\);
    
    \FFempty_flag_generator.un45_sregaddr.AXB[3]\ : CFG4
      generic map(INIT => x"A596")

      port map(A => \RXFIFOcount[3]_net_1\, B => 
        \un9_sdatawordlen_1.CO1_1_net_1\, C => 
        \SCOMMWORD[3]_net_1\, D => \SCOMMWORD[2]_net_1\, Y => 
        N_4496);
    
    \SRXFIFO_23[0]\ : SLE
      port map(D => \PIODATAWORD_c[368]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_23[0]_net_1\);
    
    \SRXFIFO_22[4]\ : SLE
      port map(D => \PIODATAWORD_c[356]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_22[4]_net_1\);
    
    \SRXFIFO_20[0]\ : SLE
      port map(D => \PIODATAWORD_c[320]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[0]_net_1\);
    
    \SRXFIFO_13[5]\ : SLE
      port map(D => \PIODATAWORD_c[213]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[5]_net_1\);
    
    \PIODATAWORD_ibuf[74]\ : INBUF
      port map(PAD => PIODATAWORD(74), Y => \PIODATAWORD_c[74]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0[9]\ : 
        CFG4
      generic map(INIT => x"6240")

      port map(A => \PIRegAddr_c[0]\, B => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0_1[9]_net_1\, 
        C => \SBUSBWORD[9]_net_1\, D => \SBUSAWORD[9]_net_1\, Y
         => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_0[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[13]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[13]\, 
        C => \PIODATAWORD_c[445]\, D => \PIODATAWORD_c[397]\, Y
         => N_2948);
    
    \SRXFIFO_20[5]\ : SLE
      port map(D => \PIODATAWORD_c[325]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[5]_net_1\);
    
    \PIODATAWORD_ibuf[432]\ : INBUF
      port map(PAD => PIODATAWORD(432), Y => \PIODATAWORD_c[432]\);
    
    \FFempty_flag_generator.un45_sregaddr.un12_serr_0_a2_0_o2\ : 
        CFG3
      generic map(INIT => x"01")

      port map(A => \PIERR_c[3]\, B => \PIERR_c[2]\, C => 
        \FFempty_flag_generator.un45_sregaddr.un12_serr_0_a2_0_o2_3_net_1\, 
        Y => N_61);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO[8]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_30[8]_net_1\, B => 
        \SRXFIFO_14[8]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[8]\, 
        Y => N_3437);
    
    \PIODATAWORD_ibuf[34]\ : INBUF
      port map(PAD => PIODATAWORD(34), Y => \PIODATAWORD_c[34]\);
    
    \PIOWORD_1[13]\ : SLE
      port map(D => \un1_SCOMMWORD_u_0[13]\, CLK => PICLK_c, EN
         => pioword29, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \PIOWORD_1[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_3[4]\ : 
        CFG4
      generic map(INIT => x"1080")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[436]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_29\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[0]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[0]_net_1\, B => 
        \SRXFIFO_7[0]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[0]\);
    
    \SCTRL[9]\ : SLE
      port map(D => \PIOWORD_in[9]\, CLK => PICLK_c, EN => 
        SCTRL_1_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \SCTRL[9]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_1[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_22[3]_net_1\, B => 
        \SRXFIFO_6[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_13_1_1[3]\);
    
    \un9_sdatawordlen_1.RF1STAT_1\ : CFG2
      generic map(INIT => x"4")

      port map(A => \SCOMMWORD[10]_net_1\, B => \SActB\, Y => 
        RF1STAT_1);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1_RNO[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_6_1_1[3]\, 
        C => \PIODATAWORD_c[243]\, D => \PIODATAWORD_c[195]\, Y
         => N_2586);
    
    \SRXFIFO_29[9]\ : SLE
      port map(D => \PIODATAWORD_c[473]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_29[9]_net_1\);
    
    \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_ns[1]\ : 
        CFG3
      generic map(INIT => x"D8")

      port map(A => \RXFIFOcount[0]_net_1\, B => 
        \PIOWORD_4_31_bm[1]\, C => \PIOWORD_4_31_am[1]\, Y => 
        \PIOWORD_4[1]\);
    
    \SBUSAWORD[12]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[12]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[12]_net_1\);
    
    FfemptySTAT : SLE
      port map(D => N_4397, CLK => PICLK_c, EN => RXFIFOcounte, 
        ALn => PIMR_c_i_0, ADn => GND_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => \FfemptySTAT\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_bm_RNO_1[11]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_23[11]_net_1\, B => 
        \SRXFIFO_7[11]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_28_1_1[11]\);
    
    \PIODATAWORD_ibuf[310]\ : INBUF
      port map(PAD => PIODATAWORD(310), Y => \PIODATAWORD_c[310]\);
    
    \SBUSBWORD[11]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[11]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.FfemptySTAT_1_sqmuxa_0_835_a2_0_a2\ : 
        CFG2
      generic map(INIT => x"1")

      port map(A => \FFempty_flag_generator.un45_sregaddr\, B => 
        \RXFIFOloaded\, Y => N_4397);
    
    \SRXFIFO_2[10]\ : SLE
      port map(D => \PIODATAWORD_c[42]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[10]_net_1\);
    
    \SRXFIFO_20[15]\ : SLE
      port map(D => \PIODATAWORD_c[335]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_20[15]_net_1\);
    
    \SRXFIFO_2[7]\ : SLE
      port map(D => \PIODATAWORD_c[39]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[7]_net_1\);
    
    \SRXFIFO_13[9]\ : SLE
      port map(D => \PIODATAWORD_c[217]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_13[9]_net_1\);
    
    \PIODATAWORD_ibuf[184]\ : INBUF
      port map(PAD => PIODATAWORD(184), Y => \PIODATAWORD_c[184]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[3]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[3]_net_1\, B => 
        \SRXFIFO_2[3]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[3]\);
    
    \SRXFIFO_15[11]\ : SLE
      port map(D => \PIODATAWORD_c[251]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_15[11]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_10_1_1[2]\, 
        C => \PIODATAWORD_c[370]\, D => \PIODATAWORD_c[322]\, Y
         => N_2649);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_1_RNO_0[2]\ : 
        CFG4
      generic map(INIT => x"C0AF")

      port map(A => \SRXFIFO_24[2]_net_1\, B => 
        \SRXFIFO_8[2]_net_1\, C => \RXFIFOcount[3]_net_1\, D => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_3_1_1[2]\, 
        Y => N_3281);
    
    \SRXFIFO_6[3]\ : SLE
      port map(D => \PIODATAWORD_c[99]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_6[3]_net_1\);
    
    \PIODATAWORD_ibuf[345]\ : INBUF
      port map(PAD => PIODATAWORD(345), Y => \PIODATAWORD_c[345]\);
    
    \SErrorCounter[3]\ : SLE
      port map(D => \SErrorCounter_s[3]\, CLK => PICLK_c, EN => 
        \error_states[1]_net_1\, ALn => PIMR_c_i_0, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SErrorCounter[3]_net_1\);
    
    \PIODATAWORD_ibuf[338]\ : INBUF
      port map(PAD => PIODATAWORD(338), Y => \PIODATAWORD_c[338]\);
    
    \SRXFIFO_2[15]\ : SLE
      port map(D => \PIODATAWORD_c[47]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_2[15]_net_1\);
    
    \SBUSAWORD[7]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[7]\, CLK => PICLK_c, EN
         => SBUSAWORD_0_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSAWORD[7]_net_1\);
    
    \PIODATAWORD_ibuf[210]\ : INBUF
      port map(PAD => PIODATAWORD(210), Y => \PIODATAWORD_c[210]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_RNO_5[4]\ : 
        CFG4
      generic map(INIT => x"6000")

      port map(A => \SCOMMWORD[0]_net_1\, B => 
        \SCOMMWORD[1]_net_1\, C => \PIODATAWORD_c[468]\, D => 
        \SCOMMWORD[2]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_13_28\);
    
    \PIODATAWORD_ibuf[176]\ : INBUF
      port map(PAD => PIODATAWORD(176), Y => \PIODATAWORD_c[176]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1[14]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[14]_net_1\, B => \PIOWORD_4[14]\, C
         => \PIRegAddr_c[3]\, Y => N_4599);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_2[0]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[400]\, B => 
        \PIODATAWORD_c[416]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[0]\);
    
    \SRXFIFO_16[15]\ : SLE
      port map(D => \PIODATAWORD_c[271]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_16[15]_net_1\);
    
    \SCOMMWORD[9]\ : SLE
      port map(D => \PICMD_c[9]\, CLK => PICLK_c, EN => N_16_i_0, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => 
        \SCOMMWORD[9]_net_1\);
    
    \PIODATAWORD_ibuf[181]\ : INBUF
      port map(PAD => PIODATAWORD(181), Y => \PIODATAWORD_c[181]\);
    
    \PIODATAWORD_ibuf[160]\ : INBUF
      port map(PAD => PIODATAWORD(160), Y => \PIODATAWORD_c[160]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[4]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[4]_net_1\, B => 
        \SRXFIFO_2[4]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[4]\);
    
    \un9_sdatawordlen_1.N_2480_i\ : CFG2
      generic map(INIT => x"8")

      port map(A => \H6110_states[2]_net_1\, B => 
        \SCOMMWORD[10]_net_1\, Y => N_2480_i_0);
    
    \SRXFIFO_27[6]\ : SLE
      port map(D => \PIODATAWORD_c[438]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_27[6]_net_1\);
    
    \SRXFIFO_10[10]\ : SLE
      port map(D => \PIODATAWORD_c[170]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_10[10]_net_1\);
    
    \PIODATAWORD_ibuf[336]\ : INBUF
      port map(PAD => PIODATAWORD(336), Y => \PIODATAWORD_c[336]\);
    
    \PIODATAWORD_ibuf[277]\ : INBUF
      port map(PAD => PIODATAWORD(277), Y => \PIODATAWORD_c[277]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_1[12]\ : 
        CFG3
      generic map(INIT => x"AC")

      port map(A => \SCTRL[12]_net_1\, B => \PIOWORD_4[12]\, C
         => \PIRegAddr_c[3]\, Y => N_4597);
    
    \PIODATAWORD_ibuf[102]\ : INBUF
      port map(PAD => PIODATAWORD(102), Y => \PIODATAWORD_c[102]\);
    
    \SRXFIFO_24[11]\ : SLE
      port map(D => \PIODATAWORD_c[395]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_24[11]_net_1\);
    
    \PIODATAWORD_ibuf[504]\ : INBUF
      port map(PAD => PIODATAWORD(504), Y => \PIODATAWORD_c[504]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_i_m2_1_0_RNO[0]\ : 
        CFG4
      generic map(INIT => x"5D58")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_5_i_m2_1_1[0]\, 
        B => \SCOMMWORD[0]_net_1\, C => \PIRegAddr_c[1]\, D => 
        \SBUSAWORD[0]_net_1\, Y => N_79);
    
    \SRXFIFO_25[5]\ : SLE
      port map(D => \PIODATAWORD_c[405]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_25[5]_net_1\);
    
    \SRXFIFO_31[15]\ : SLE
      port map(D => \PIODATAWORD_c[511]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[15]_net_1\);
    
    \PIODATAWORD_ibuf[412]\ : INBUF
      port map(PAD => PIODATAWORD(412), Y => \PIODATAWORD_c[412]\);
    
    \PIODATAWORD_ibuf[501]\ : INBUF
      port map(PAD => PIODATAWORD(501), Y => \PIODATAWORD_c[501]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_2[13]\ : 
        CFG4
      generic map(INIT => x"305F")

      port map(A => \PIODATAWORD_c[157]\, B => 
        \PIODATAWORD_c[173]\, C => \SCOMMWORD[1]_net_1\, D => 
        \SCOMMWORD[0]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[13]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_RNO_0[0]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_21_1_1[0]\, 
        C => \PIODATAWORD_c[176]\, D => \PIODATAWORD_c[128]\, Y
         => N_2823);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am[15]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2902, C => N_2662, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_1[15]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_am[15]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_31_am_RNO_2[7]\ : 
        CFG4
      generic map(INIT => x"0F53")

      port map(A => \SRXFIFO_18[7]_net_1\, B => 
        \SRXFIFO_2[7]_net_1\, C => \RXFIFOcount[4]_net_1\, D => 
        \RXFIFOcount[3]_net_1\, Y => 
        \FFempty_flag_generator.un45_sregaddr.PIOWORD_4_10_1_1[7]\);
    
    \un9_sdatawordlen_1.SRXMODEDATAWORD_0_sqmuxa\ : CFG3
      generic map(INIT => x"40")

      port map(A => PIMR_c, B => N_61, C => 
        \H6110_states[1]_net_1\, Y => SRXMODEDATAWORD_0_sqmuxa);
    
    \PIODATAWORD_ibuf[47]\ : INBUF
      port map(PAD => PIODATAWORD(47), Y => \PIODATAWORD_c[47]\);
    
    \SRXFIFO_17[7]\ : SLE
      port map(D => \PIODATAWORD_c[279]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[7]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.un12_serr_0_a2_0_o2_RNI04MO\ : 
        CFG4
      generic map(INIT => x"7520")

      port map(A => \H6110_states[1]_net_1\, B => N_1120, C => 
        N_61, D => \H6110_states[5]_net_1\, Y => 
        un1_H6110_states_3_i_0);
    
    \SRXFIFO_5[0]\ : SLE
      port map(D => \PIODATAWORD_c[80]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[0]_net_1\);
    
    \un9_sdatawordlen_1.CO1_1\ : CFG2
      generic map(INIT => x"E")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \SCOMMWORD[0]_net_1\, Y => 
        \un9_sdatawordlen_1.CO1_1_net_1\);
    
    \SRXFIFO_5[7]\ : SLE
      port map(D => \PIODATAWORD_c[87]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_5[7]_net_1\);
    
    \PIOWORD_iobuf[9]\ : BIBUF
      port map(PAD => PIOWORD(9), D => \PIOWORD_1[9]_net_1\, E
         => \un1_PIOWORD_cl_i_0_i[15]\, Y => \PIOWORD_in[9]\);
    
    \SRXFIFO_31[11]\ : SLE
      port map(D => \PIODATAWORD_c[507]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_31[11]_net_1\);
    
    \SRXFIFO_28[15]\ : SLE
      port map(D => \PIODATAWORD_c[463]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_28[15]_net_1\);
    
    \SBUSBWORD[13]\ : SLE
      port map(D => \SRXMODEDATAWORD_1[13]\, CLK => PICLK_c, EN
         => SBUSBWORD_1_sqmuxa, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \SBUSBWORD[13]_net_1\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm[10]\ : 
        CFG4
      generic map(INIT => x"A0DD")

      port map(A => N_4493, B => N_2785, C => N_2545, D => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_bm_1_1[10]_net_1\, 
        Y => \SRXMODEDATAWORD_1_31_bm[10]\);
    
    \PIODATAWORD_ibuf[44]\ : INBUF
      port map(PAD => PIODATAWORD(44), Y => \PIODATAWORD_c[44]\);
    
    
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_31_am_1_RNO_0[3]\ : 
        CFG4
      generic map(INIT => x"7362")

      port map(A => \SCOMMWORD[1]_net_1\, B => 
        \FFempty_flag_generator.un45_sregaddr.SRXMODEDATAWORD_1_28_1_1[3]\, 
        C => \PIODATAWORD_c[435]\, D => \PIODATAWORD_c[387]\, Y
         => N_2938);
    
    \SRXFIFO_17[12]\ : SLE
      port map(D => \PIODATAWORD_c[284]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[12]_net_1\);
    
    \PIODATAWORD_ibuf[475]\ : INBUF
      port map(PAD => PIODATAWORD(475), Y => \PIODATAWORD_c[475]\);
    
    \PIODATAWORD_ibuf[18]\ : INBUF
      port map(PAD => PIODATAWORD(18), Y => \PIODATAWORD_c[18]\);
    
    \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0[9]\ : 
        CFG4
      generic map(INIT => x"FFEA")

      port map(A => 
        \FFempty_flag_generator.un45_sregaddr.un1_SCOMMWORD_u_0_1[9]_net_1\, 
        B => N_231, C => N_4594, D => N_95, Y => 
        \un1_SCOMMWORD_u_0[9]\);
    
    \SRXFIFO_0[14]\ : SLE
      port map(D => \PIODATAWORD_c[14]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_0[14]_net_1\);
    
    \PIODATAWORD_ibuf[318]\ : INBUF
      port map(PAD => PIODATAWORD(318), Y => \PIODATAWORD_c[318]\);
    
    \PIODATAWORD_ibuf[384]\ : INBUF
      port map(PAD => PIODATAWORD(384), Y => \PIODATAWORD_c[384]\);
    
    \SRXFIFO_9[14]\ : SLE
      port map(D => \PIODATAWORD_c[158]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_9[14]_net_1\);
    
    \PIODATAWORD_ibuf[367]\ : INBUF
      port map(PAD => PIODATAWORD(367), Y => \PIODATAWORD_c[367]\);
    
    \SRXFIFO_17[9]\ : SLE
      port map(D => \PIODATAWORD_c[281]\, CLK => PICLK_c, EN => 
        SRXFIFO_0_0_sqmuxa, ALn => PIMR_c_i_0, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \SRXFIFO_17[9]_net_1\);
    

end DEF_ARCH; 
