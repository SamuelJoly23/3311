library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity msa_init_tb is
end;

architecture bench of msa_init_tb is

  -- "Component" du module a verifier
  component msa_init
    port
    (
      -- entrees
      clk_i          : in std_logic;
      rst_i          : in std_logic;
      delay_i        : in std_logic;
      SPI_ready_i    : in std_logic;
      timing_ready_i : in std_logic;
      -- sorties
      init_done_o         : out std_logic;
      SPI_start_o         : out std_logic;
      timing_start_o      : out std_logic;
      ROM_oled_cmd_addr_o : out std_logic_vector(4 downto 0)
    );
  end component;

  -- Declaration des signaux pour instancier le module a verifier
  signal clk_tb                 : std_logic := '1';
  signal rst_i_tb               : std_logic := '1';
  signal SPI_ready_i_tb         : std_logic;
  signal delay_i_tb             : std_logic;
  signal timing_ready_i_tb      : std_logic;

  signal init_done_o_tb         : std_logic;
  signal SPI_start_o_tb         : std_logic;
  signal timing_start_o_tb      : std_logic;
  signal ROM_oled_cmd_addr_o_tb : std_logic_vector(4 downto 0);

  -- Signaux pour la verification
  signal clk_en       : boolean := true;
  constant clk_period : time    := 20 ns;

begin
  -- Instancier le module a verifier
  uut : msa_init
  port map
  (
    -- entrees
    clk_i          => clk_tb,
    rst_i          => rst_i_tb,
    SPI_ready_i    => SPI_ready_i_tb,
    delay_i        => delay_i_tb,
    timing_ready_i => timing_ready_i_tb,
    -- sorties
    init_done_o         => init_done_o_tb,
    SPI_start_o         => SPI_start_o_tb,
    timing_start_o      => timing_start_o_tb,
    ROM_oled_cmd_addr_o => ROM_oled_cmd_addr_o_tb
  );

  -- Driver - Processus pour donner des valeurs
  -- aux entrees du module a verifier
  -- Les entrees changent sur le front descendant de l'horloge
  driver : process
  begin
    -- donnees initiales
    SPI_ready_i_tb <= '1';
    delay_i_tb     <= '1';
    -- On assume qu'il n'y a pas de verification a l'envoi
    timing_ready_i_tb <= '0';

    -- reset
    rst_i_tb <= '1';
    wait for 1 * clk_period;
    rst_i_tb <= '0';
    wait for 1 * clk_period; --attendre le reset


    -- Etat initial
    assert init_done_o_tb = '0'
    report "Test1 Error: init_done_o should be LOW at the beginning"
      severity error;

    assert SPI_start_o_tb = '0'
    report "Test2 Error: SPI_start_o should be LOW at the beginning"
      severity error;

    -- Ce signal est deja redescendu
    assert timing_start_o_tb = '0'
    report "Test3 Error: timing_start_o should be LOW at the beginning"
      severity error;

    assert ROM_oled_cmd_addr_o_tb = "00000"
    report "Test4 Error: ROM_oled_cmd_addr_o should be 00000 at the beginning"
      severity error;

    -- Test 1: Envoi d'un signal de demarrage de delai
    -- On envoi le signal de ready pour le timing
    wait for 5 * clk_period;
    timing_ready_i_tb <= '1';

    wait on ROM_oled_cmd_addr_o_tb;
    assert ROM_oled_cmd_addr_o_tb = "00001"
    report "Test5 Error: ROM_oled_cmd_addr_o should be 00001 after timing_ready_i is HIGH"
      severity error;

    -- Test 2: Envoi d'un signal de demarrage de SPI
    -- On envoi le signal de ready pour le SPI
    delay_i_tb <= '0';
    spi_ready_i_tb <= '0';
    wait for 5 * clk_period;

    SPI_ready_i_tb <= '1';

    wait on ROM_oled_cmd_addr_o_tb;
    assert ROM_oled_cmd_addr_o_tb = "00010"
    report "Test6 Error: ROM_oled_cmd_addr_o should be 00010 after SPI_ready_i is HIGH"
      severity error;

    wait for 100 * clk_period;

    -- Fin de la simulation
    clk_en <= false;
    wait;
  end process;

  -- Horloge
  clk_tb <= not clk_tb after clk_period/2 when clk_en else
    '0';

end bench;