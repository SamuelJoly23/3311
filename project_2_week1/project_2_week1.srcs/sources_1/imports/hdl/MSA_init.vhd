
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
type state_type is (spi_send, spi_wait, timing_send, timing_wait, standby);
signal current_state: state_type;


signal cntrom : std_logic_vector(4 downto 0) := "00000"; -- initialisation de la premiere addresse a 0
--signal done : std_logic := '0';
--signal cntrom <= ROM_oled_cmd_addr_o      : std_logic_vector (4 downto 0); -- delete ??
begin
--init_done_o <= done;
ROM_oled_cmd_addr_o <= cntrom;

-- A remplacer
--        init_done_o         <= '0';
--        SPI_start_o         <= '0';
--        timing_start_o      <= '0';
--        ROM_oled_cmd_addr_o <= (others => '0');
        
process(rst_i, clk_i, delay_i)
begin
if rst_i = '1' then
    current_state <= timing_send; -- premiere etat de la sequence d'initialisation
    init_done_o <='0';
    SPI_start_o <= '0';
    timing_start_o <= '0';
    cntrom <= "00000";

    
elsif(rising_edge(clk_i)) then
    case current_state is
        when spi_send =>
            if(SPI_ready_i = '1') then
                SPI_start_o <= '1';
                current_state <= spi_wait;
            end if;

         when spi_wait => 
            SPI_start_o <= '0'; -- mise a zero du signal start apres une periode clk
            cntrom <= std_logic_vector(unsigned(cntrom) + 1);
            --ROM_oled_cmd_addr_o <= cntrom;
            
            if(delay_i = '1') then -- definition du current_state selon la valeur du delay_i
                current_state <= timing_send;
            elsif(delay_i = '0') then 
                current_state <= spi_send;
            end if;
            
            if unsigned(cntrom) = 24 then 
                current_state <= standby;
            end if;
        
        when timing_send =>
            if(timing_ready_i = '1') then
                timing_start_o <= '1';
                current_state <= timing_wait;
            end if;
            
        when timing_wait =>
            timing_start_o <= '0'; -- mise a zero du signal start apres une periode clk
            current_state <= spi_send;
            cntrom <= std_logic_vector(unsigned(cntrom) + 1);
            --ROM_oled_cmd_addr_o <= cntrom;
            
            if(delay_i = '1') then -- definition du current_state selon la valeur du delay_i
                current_state <= timing_send;
            elsif(delay_i = '0') then
                current_state <= spi_send;
            end if;
        
        when standby =>
            init_done_o <= '1'; -- done is active high
    end case;
end if;
end process;
end Behavioral;
