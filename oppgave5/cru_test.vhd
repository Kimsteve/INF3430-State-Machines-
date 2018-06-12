library ieee;
use ieee.std_logic_1164.all;
--library unisim;
--use unisim.all;

entity cru_test is
end entity cru_test;

architecture test of cru_test is

  component cru is
    port (
      arst : in std_logic; -- Asynch. reset
      refclk : in std_logic; -- Reference clock
      rst : out std_logic; -- Synchronized arst_n for mclk
      rst_div : out std_logic; -- Synchronized arst_n for mclk_div
      mclk : out std_logic; -- Master clock
      mclk_div : out std_logic -- Master clock div. by 128.
    );
  end component cru;

  signal arst     : std_logic := '0'; 
  signal refclk   : std_logic := '0';
  signal rst      : std_logic;
  signal rst_div  : std_logic;
  signal mclk     : std_logic;
  signal mclk_div : std_logic;
  constant Half_Period  : time := 20 ns;

begin

  uut: cru
      port map(
        arst => arst,
        refclk => refclk,
        rst => rst,
        rst_div => rst_div,
        mclk => mclk,
        mclk_div => mclk_div
      );
  refclk <= not refclk after Half_Period;
  
  testing: process
  begin
    arst <= '1', '0' after 500 ns;
    wait;
  end process testing;

end architecture test;