
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MSA_init is
        port (clk_i               : in  std_logic;
              rst_i               : in  std_logic;
              init_done_o         : out std_logic;
              SPI_start_o         : out std_logic;
              SPI_ready_i         : in  std_logic;
              delay_i             : in  std_logic;
              timing_start_o      : out std_logic;
              timing_ready_i      : in  std_logic;
              ROM_oled_cmd_addr_o : out std_logic_vector(4 downto 0)
              );
end MSA_init;

architecture Behavioral of MSA_init is
-- A completer
--signal vbat         : std_logic;
--signal vdd          : std_logic;
--signal res          : std_logic;
--signal dc           : std_logic;
type state_type is (spi_send, spi_wait, timing_send, timing_wait, standby);
signal current_state: state_type;
signal oled        : std_logic_vector (4 downto 0);
signal cntrom      : unsigned(5 downto 0); 

begin

-- A remplacer
--        init_done_o         <= '0';
--        SPI_start_o         <= '0';
--        timing_start_o      <= '0';
--        ROM_oled_cmd_addr_o <= (others => '0');
        
process(rst_i, clk_i, delay_i)
begin
if rst_i = '1' then
    current_state <= standby;
elsif(rising_edge(clk_i)) then
    case current_state is
        when timing_send =>
            timing_start_o <= '1';
            current_state <= timing_wait;
            
--            if(delay_i = '0' and SPI_ready_i <= '0') then
--                current_state <= spi;    

        when timing_wait =>
            if (timing_ready_i = '0') then
                cntrom <= cntrom + 1;
                --current_state <= ???????;
                if (cntrom = 24) then 
                current_state <= standby;
                end if;
            end if;


            
        when spi_send =>
            SPI_start_o <= '1';
            current_state <= spi_wait;
         
         
         when spi_wait => 
            if (SPI_ready_i = '1') then 
                cntrom <= cntrom + 1;
                if (cntrom = 24) then
                    current_state <= standby;
--            cntrom <= cntrom + 1;
--            if(delay_i = '1' and timing_ready_i <= '1') then 
--                current_state <= timing;
--            if (cntrom = 24);
                end if;
            end if;
            
    
        when standby =>
            init_done_o <= '0'; -- done is active low
        
    ROM_oled_cmd_addr_o <= "10000";
    
    end case;
end if;
    
    
    

    end process;
end Behavioral;
