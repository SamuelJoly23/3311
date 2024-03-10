----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2024 02:34:46 PM
-- Design Name: 
-- Module Name: top_dog_tb - Behavioral
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

entity top_dog_tb is
end top_dog_tb;

architecture Behavioral of top_dog_tb is
component top
    Port ( 
        -- entrees
        clk_i           : in STD_LOGIC;
        rst_n_i         : in STD_LOGIC;
        -- sorties
        oled_dc_n_o     : out STD_LOGIC;
        oled_res_n_o    : out STD_LOGIC;
        oled_vbat_n_o   : out STD_LOGIC;
        oled_vdd_n_o    : out STD_LOGIC;
        oled_sclk_o     : out STD_LOGIC;
        oled_sdo_o      : out STD_LOGIC
    );
end component;
    
    -- entrees
    signal clk_i            : std_logic := '1';
    signal rst_n_i          : std_logic := '1';
    -- sorties
    signal oled_dc_n_o      : std_logic := '1';  
    signal oled_res_n_o     : std_logic := '1';  
    signal oled_vbat_n_o    : std_logic := '1';  
    signal oled_vdd_n_o     : std_logic := '1';  
    signal oled_sclk_o      : std_logic := '1';  
    signal oled_sdo_o       : std_logic := '1';  
    
    -- Clock period definitions
    constant clk_i_PERIOD : time := 20 ns;

    
begin
    uut : top
    port map(
        -- entrees
        clk_i           => clk_i,
        rst_n_i         => rst_n_i,
        -- sorties
        oled_dc_n_o     => oled_dc_n_o,
        oled_res_n_o    => oled_res_n_o,
        oled_vbat_n_o   => oled_vbat_n_o,
        oled_vdd_n_o    => oled_vdd_n_o,
        oled_sclk_o     => oled_sclk_o,
        oled_sdo_o      => oled_sdo_o
        );
    -- Clock definition
    clk_i <= not clk_i after clk_i_PERIOD/2;

    stim_proc : process
    begin
    -- clock simulation ??
    --wait for 1 us;
    --rst_n_i <= '0';
    end process;
end Behavioral;
