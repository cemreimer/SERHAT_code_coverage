----------------------------------------------------------------------------------
-- Company: PAVO
-- Engineer: Sinan Ali TOK
-- 
-- Create Date:    16:03:20 11/03/2009 
-- Design Name: 
-- Module Name:    process_1553 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:  Process Modul UKB'den gelen datalar?n/komutlar?n Sub-Adreslere göre yorumlan?p i?lendi?i modüldür.
--					  Bu modul hangi alt modullerin çal??aca??n? ve güncellenen veri bilgisini bildirir.
--					  Process Modülün alt modüller ile Enable ve Update sinyalleri d???nda direk bir ba?lant?s? yoktur.
--					  Genel olarak dramler üzerinden çal???r. UKB'ye gönderilecek datalar ilgili ramlerden okunur.	
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

use work.parameters.all;
use work.types.all;
use work.vhdl_bl4cl2_parameters_0.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity process_1553 is
	Port (  
			  PIClk 							: in  STD_LOGIC;
			  reset  							: in  STD_LOGIC;
			  
			  receive_cmd_r_dpra 	    	: out STD_LOGIC_VECTOR (5 downto 0);       --1553 komutlar?n?n okundu?u ramin adres giri?i
			  receive_cmd_r_dpo		    	: in  STD_LOGIC_VECTOR (15 downto 0);		 --1553 komutlar?n?n okundu?u ramin data ç?k???
			  
			  transmit_buf_r_a	 	    	: out STD_LOGIC_VECTOR (5 downto 0);		 --1553 üzerinden UKB ye gönderilecek olan datalar?n tutuldu?u ramin adres giri?i
			  transmit_buf_r_d	 	    	: out STD_LOGIC_VECTOR (15 downto 0);		 --1553 üzerinden UKB ye gönderilecek olan datalar?n tutuldu?u ramin data giri?i
			  transmit_buf_r_we		    	: out STD_LOGIC;									 --1553 üzerinden UKB ye gönderilecek olan datalar?n tutuldu?u ramin write enable giri?i
			  
			  dram_addr 						: out STD_LOGIC_VECTOR (7 downto 0);		 --Distributed Ramlerin Adres giri?i
			  dram_dout 						: in  STD_LOGIC_VECTOR (15 downto 0);		 --Distributed Ramlerin Data ç?k???
			  dram_din   						: out STD_LOGIC_VECTOR (15 downto 0);		 --Distributed Ramlerin Data giri?i
			  
			  modules_en	           		: out std_logic;							 		 --Alt modullerin Enable giri?i
			  clr_err_flg	          		: out std_logic;							 		  
	  
			  process_ok			    		: out STD_LOGIC;									 --1553 komutlar? ile gelen görevin tamamland???n? 1553_Ctrl modulüne belirtir	
			  rx_ready_1553			    	: in  STD_LOGIC;									 --UKB den 1553 bus üzerinden gelen komut dizinin ilgili ram bölgesine yaz?ld???n? bilgisini verir
			  config_value_ok             : in  std_logic;									 --Fram den okuma i?leminin tamamlan?p config datalar?n ilgili ramlere yaz?ld??? bilgisini verir
			  config_value_ready        	: in  std_logic									 --Fram den okuma i?leminin tamamlan?p config datalar?n ilgili ramlere yaz?ld??? bilgisini verir

    );
end process_1553;


architecture Behavioral of process_1553 is

 type state_process is (wait_config, idle, mode_ctrl,send_fw,send_fw1,send_fw2,send_fw3, send_data, send_data_w, send_data_wait, send_data_ww,
								pr_update_val, update_val, process_ok_st, process_ok_wait_st);							
								
   signal state_process_reg      :  state_process := wait_config;	 
	
	signal send_datalen	          : STD_LOGIC_VECTOR (5 downto 0);
	signal dram_addr_s 			  	 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal sub_adres 			  		 : STD_LOGIC_VECTOR (4 downto 0);
	
	signal i_transmit_buf_r_a	  	 : STD_LOGIC_VECTOR (5 downto 0);
	signal i_receive_cmd_r_dpra    : STD_LOGIC_VECTOR (5 downto 0);
	
	signal counter_update          : integer range 0 to 505 := 0;

	signal clr_err_flg_s			 	 : std_logic := '0';
	
begin

transmit_buf_r_a 		<= i_transmit_buf_r_a;
dram_addr 				  <= dram_addr_s;
receive_cmd_r_dpra 	<= i_receive_cmd_r_dpra;


process (PIClk, reset)
begin
	if reset = '1' then					
		state_process_reg <= wait_config;	
	elsif rising_edge (PIClk) then
			
		transmit_buf_r_we 				<= '0';
		
		case state_process_reg is
			
---------------------           Config De?erlerin FRAM'den okunmas?n? beklemek (0)  			 --------------------
			when wait_config =>																--0
				--Config datalar?n Framden okunup Distributed ramlere yaz?lana kadar beklenmesi--
				 process_ok 						 <= '0';
				 clr_err_flg						 <= '0';
				 if config_value_ready = '1' then
					state_process_reg 		<= idle;
				 end if; 
---------------------           Config De?erlerin FRAM'den okunmas?n? beklemek (0)  			 --------------------

---------------------------------------------------------------------------------------------------------------------

--------------------- 1553 CTRL Modulününden Yeni Komutun Haz?r Oldu?u Bilgisini Beklemek (7)    --------------------
			when idle => 																		--7
				process_ok 					<= '0';
				modules_en 					<= '1';
 				i_receive_cmd_r_dpra 	<= "000000";
				clr_err_flg_s				<= '0';
				clr_err_flg					<= '0';        
				if rx_ready_1553 = '1' then
					state_process_reg <= mode_ctrl;
				end if;	
--------------------- 1553 CTRL Modulününden Yeni Komutun Haz?r Oldu?u Bilgisini Beklemek (7) -------------------------

-----------------------------------------------------------------------------------------------------------------------

--------------------- 1553 CTRL Modulününden Gelen Komutun Yorumlan?p ?lgili State'e Dallanmak (8) --------------------				
			when mode_ctrl =>																	--8
				
					if receive_cmd_r_dpo(10) = '1' then												--					UBB <- 1553
						
						dram_addr_s <= "11111111";
						i_transmit_buf_r_a <= "111111";
						transmit_buf_r_d(15 downto 5) <= "00000000000";
						transmit_buf_r_d(4 downto 0) <= receive_cmd_r_dpo(4 downto 0);
						
						if receive_cmd_r_dpo(4 downto 0) = "00000" then
							send_datalen <= "100000";
						else
							send_datalen(5) <= '0';
							send_datalen(4 downto 0) <= receive_cmd_r_dpo(4 downto 0);
						end if;
						transmit_buf_r_we <= '1';
						
						case receive_cmd_r_dpo(9 downto 5) is
							when sub_adr_1 =>																--	Status/IBIT/CBIT de?erlerinin okunmas?
			
									clr_err_flg_s 		<= '1';
									sub_adres         <= sub_adr_1;
									state_process_reg <= send_fw;
									
							when others =>
								
								sub_adres 			<= sub_adr_1;
								state_process_reg <= mode_ctrl;
								
						end case;
						
					else																						--			1553 -> UBB
						if receive_cmd_r_dpo(4 downto 0) = "00000" then
							send_datalen <= "100000";
						else
							send_datalen(5) <= '0';
							send_datalen(4 downto 0) <= receive_cmd_r_dpo(4 downto 0);
						end if;	
						dram_addr_s <= "11111111";
						case receive_cmd_r_dpo(9 downto 5) is
							when sub_adr_1 =>														--	Start/Stop IBIT/CBIT					
								state_process_reg <= idle;
								
							when sub_adr_2 =>															--	Analog Output de?erlerinin güncellenmesi
									sub_adres <= sub_adr_2;
									state_process_reg <= pr_update_val;
							when others =>
								state_process_reg <= idle;
						end case;
					end if;
--------------------- 1553 CTRL Modulününden Gelen Komutun Yorumlan?p ?lgili State'e Dallanmak (8) --------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------

--------------------- 1553 CTRL Modülünden Transmit Komutunun Gelmesi ?le ?lgili Ram Bölgesinden Okunan Verileri Göndermek (11-13) -------------				

			when send_fw =>
                i_transmit_buf_r_a <= i_transmit_buf_r_a + "000001";
				transmit_buf_r_d(15 downto 8) <= x"33";
				transmit_buf_r_d(7 downto 0) <= x"12";
				transmit_buf_r_we <= '1';		
                state_process_reg	<= send_fw1;
            when send_fw1 =>
                i_transmit_buf_r_a <= i_transmit_buf_r_a + "000001";
				transmit_buf_r_d(15 downto 8) <= x"44";
				transmit_buf_r_d(7 downto 0) <= x"55";
				transmit_buf_r_we <= '1';		
                state_process_reg	<= send_fw2;
            when send_fw2 =>
                i_transmit_buf_r_a <= i_transmit_buf_r_a + "000001";
				transmit_buf_r_d(15 downto 8) <= x"66";
				transmit_buf_r_d(7 downto 0) <= x"77";
				transmit_buf_r_we <= '1';		
                state_process_reg	<= send_fw3;
            when send_fw3 =>
                i_transmit_buf_r_a <= i_transmit_buf_r_a + "000001";
				transmit_buf_r_d(15 downto 8) <= x"88";
				transmit_buf_r_d(7 downto 0) <= x"99";
				transmit_buf_r_we <= '1';		
                state_process_reg	<= process_ok_st;
            when send_data =>														--11
				dram_addr_s <= dram_addr_s + "00000001";
				state_process_reg <= send_data_w;
			when send_data_w =>													--12
					
				state_process_reg <= send_data_wait;	
			
			when send_data_wait =>												--12
			
					state_process_reg <= send_data_ww;
				
			when send_data_ww =>													--13
					i_transmit_buf_r_a <= i_transmit_buf_r_a + "000001";
					transmit_buf_r_d(15 downto 8) <= dram_dout(7 downto 0);
					transmit_buf_r_d(7 downto 0) <= dram_dout(15 downto 8);
					transmit_buf_r_we <= '1';		
					if dram_addr_s = send_datalen then
						state_process_reg	<= process_ok_st;
					else
						state_process_reg	<= send_data;
					end if;
--------------------- 1553 CTRL Modülünden Transmit Komutunun Gelmesi ?le ?lgili Ram Bölgesinden Okunan Verileri Göndermek (11-13) ----------------------------------------------------------------------
				
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
			
			when pr_update_val =>													--14
				i_receive_cmd_r_dpra <= i_receive_cmd_r_dpra + "000001";
				state_process_reg	<= update_val;
			when update_val =>														--15
				dram_addr_s <= dram_addr_s + "00000001";
				dram_din(15 downto 8) <= receive_cmd_r_dpo(7 downto 0);
				dram_din(7 downto 0) <= receive_cmd_r_dpo(15 downto 8);
				--dram_update_baud_we <= '1';   -- RAM alan? m? data array mi?
				if i_receive_cmd_r_dpra = send_datalen then

					state_process_reg	<= process_ok_wait_st;
				else
					state_process_reg	<= pr_update_val;
				end if;
--------------------- 1553 CTRL Modülünden Receive Komutunun Gelmesi ?le 1553 CTRL Modülünden Gelen Datalar? ?lgili DRAM Bölgesine Yazmak ve Gerekli ?se Update Sinayalini Ç?kartmak (14-15) ------------

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			
--------------------- 1553 CTRL Modülünden Gelen Komutun ??lendi?i ve Yeni Komuta Haz?r Olundu?u Bilgisini Göndermek (16) -------------------------------------------------------------------------------
			
			
			when process_ok_wait_st =>											--16
				
				state_process_reg	<= process_ok_st;
			
			when process_ok_st =>											--16
				process_ok 						<= '1';
				clr_err_flg						<= clr_err_flg_s; 
				
				if counter_update = 500 then
					state_process_reg	<= idle;
				else
					counter_update 				<= counter_update + 1;
				end if;
--------------------- 1553 CTRL Modülünden Gelen Komutun ??lendi?i ve Yeni Komuta Haz?r Olundu?u Bilgisini Göndermek (16) -------------------------------------------------------------------------------

			when others =>
				null;
		end case;
	end if;
end process;
		

end Behavioral;

