library ieee;
use ieee.std_logic_1164.all;

entity tb_pos_seg7_ctrl is
end entity tb_pos_seg7_ctrl;

architecture test of tb_pos_seg7_ctrl is
  component pos_seg7_ctrl is
    port (
      -- System Clock and Reset
      arst         : in  std_logic;       -- Reset
      sync_rst     : in  std_logic;       -- Synchronous reset 
      refclk       : in  std_logic;       -- Clock
      sp           : in  std_logic_vector(7 downto 0);  -- Set Point
      a            : in  std_logic;       -- From position sensor
      b            : in  std_logic;       -- From position sensor
      force_cw     : in  std_logic;       -- Force motor clock wise motion
      force_ccw    : in  std_logic;       -- Force motor counter clock wise motion
      motor_cw     : out std_logic;       -- Motor clock wise motion
      motor_ccw    : out std_logic;       -- Motor counter clock wise motion
      -- display
      abcdefgdec_n : out std_logic_vector(6 downto 0);
      a_n          : out std_logic_vector(3 downto 0)
    );
  end component pos_seg7_ctrl;
  
  component motor
    port (
      motor_cw  : in  std_logic;
      motor_ccw : in  std_logic;
      a         : out std_logic;
      b         : out std_logic
    );      
  end component motor;
  
  signal arst           : std_logic := '0';
  signal sync_rst       : std_logic := '0';
  signal refclk         : std_logic := '0';
  signal sp             : std_logic_vector(7 downto 0) := "00000000";
  signal a_int          : std_logic := '0';
  signal b_int          : std_logic := '0';
  signal force_cw       : std_logic := '0';
  signal force_ccw      : std_logic := '0';
  signal motor_cw_int   : std_logic;
  signal motor_ccw_int  : std_logic;
  signal abcdefgdec_n   : std_logic_vector(6 downto 0);
  signal a_n            : std_logic_vector(3 downto 0);
  constant Half_Period  : time := 20 ns;

begin
  uut1: pos_seg7_ctrl
        port map(
         arst=> arst, 
         sync_rst=> sync_rst, 
         refclk=> refclk,
         sp=> sp, 
         a=> a_int, 
         b=> b_int,
         force_cw=> force_cw,
         force_ccw=> force_ccw, 
         motor_cw=> motor_cw_int, 
         motor_ccw=> motor_ccw_int, 
         abcdefgdec_n=> abcdefgdec_n, 
         a_n=> a_n
        );
  uut2: motor 
        port map(
         motor_cw=> motor_cw_int, 
         motor_ccw=>  motor_ccw_int, 
         a=> a_int, 
         b=> b_int
        );
        
  refclk <= not refclk after Half_Period;
  
  check: process
  begin
    arst <= '1', '0' after 20 us;
    --wait for 1000 us;
     --force_ccw <= '1';
    -- wait for 100 us;
     --force_ccw <= '0';
     --wait for 1000 us;
    sp <= "00000010";
    wait for 250 us;
    force_cw <= '1';
    wait for 400 us;
    force_cw <= '0';
    force_ccw <= '1';
    wait;
  end process check;

end architecture test;