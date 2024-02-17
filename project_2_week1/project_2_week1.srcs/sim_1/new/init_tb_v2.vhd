library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

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
