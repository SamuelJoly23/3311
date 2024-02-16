----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2024 05:09:13 PM
-- Design Name: 
-- Module Name: init_tb_v2 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity init_tb_v2 is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           init_done_o : out STD_LOGIC;
           SPI_start_o : out STD_LOGIC;
           SPI_ready_i : in STD_LOGIC;
           delay_i : in STD_LOGIC;
           timing_start_o : out STD_LOGIC;
           timing_ready_i : in STD_LOGIC;
           ROM_oled_cmd_addr_o : out STD_LOGIC);
end init_tb_v2;

architecture Behavioral of init_tb_v2 is

begin


end Behavioral;
