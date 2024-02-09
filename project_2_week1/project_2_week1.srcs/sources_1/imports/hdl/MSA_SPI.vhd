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
type state_type is (attente, pret);
signal current_state: state_type;
  -- A completer
signal cnt         : std_logic_vector (7 downto 0);
signal ready       : std_logic; 
signal data        : std_logic_vector (7 downto 0);
signal start       : std_logic;


begin
process (ready, start, data)
begin
--  -- A remplacer
--  ready_o <= '1';
--  sdo_o   <= '0';
--  sclk_o  <= '1';

-- avoir un current state

if rst_i = '1' then
    current_state <= attente;
    -- cnt <= to_unsigned(0,cnt length);
    data <= "00000000";
else
    case current_state is
        when attente =>
            if(start = '1') then
                --cnt <= to_unsigned(79, compteurlength);
                data <= data_i;
                current_state <= pret;
             else
                current_state <= attente;
             end if;
        when pret =>
            if(cnt = 0) then
                current_state <= attente;
            elsif((cnt mod 10) = 0) then
                data <= data(6 downto 0) & '0';
            end if;
            cnt <= cnt - 1;
         end case;
      end if;
   end process;
            


--if rising_edge(clk_i) then
--    case current_state is
--        when pret =>
--            if start = '1' then
--                if cnt = '0' then 
--                    cnt   <= std_logic_vector(unsigned(cnt) + 1);           
--                    data <= data_i;
--                if cnt = '1' then
--                    cnt = '0';
--                    current_state <= attente;
--                    ready_o <= '0';
--                end if;
--            end if; 
            
--        when attente =>
--            if start = '0' then
                
        
--end if;
end process;
end Behavioral;
