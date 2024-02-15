library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity MSA_SPI is
  port (rst_i   : in  std_logic;
        clk_i   : in  std_logic;
        start_i : in  std_logic;
        data_i  : in  std_logic_vector (7 downto 0);
        ready_o : out std_logic;
        sdo_o   : out std_logic;
        sclk_o  : out std_logic);
end MSA_SPI;

architecture Behavioral of MSA_SPI is
type state_type is (attente, envoi);
signal current_state: state_type;
  -- A completer
signal cnt         : unsigned(6 downto 0);
signal cs          : std_logic;
signal data        : std_logic_vector (7 downto 0);
signal clk_5Mhz    : std_logic;
signal ready       : std_logic := '1'; 
--signal start       : std_logic;

begin
    sdo_o <= data(7);
    clk_5Mhz <= '1' when (cnt mod 10) < 5 else '0';
    sclk_o <= cs or clk_5Mhz;
    cs <= '1' when current_state = attente else '0';
    ready_o <= ready ;
process (rst_i, clk_i)
begin
--  -- A remplacer
    
--  sdo_o   <= '0';
--  sclk_o  <= '1';
-- avoir un current state

if rst_i = '1' then
    current_state <= attente;
    cnt <= to_unsigned(0, cnt'length);
    data <= "00000000";
elsif(rising_edge(clk_i)) then
    case current_state is
        when attente =>
            if(start_i = '1') then
                cnt <= to_unsigned(79, cnt'length);
                data <= data_i;
                current_state <= envoi;
                ready <= '0';
             else
                current_state <= attente;
             end if;
            
        when envoi =>
            ready <= '0';
            if(cnt = 0) then
                current_state <= attente;
                ready <= '1';
            elsif((cnt mod 10) = 0) then
                data <= data(6 downto 0) & '0';
            end if;
            cnt <= cnt - 1;
         end case;
     end if;
   end process;
end Behavioral;
