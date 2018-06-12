library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity tb_pos_ctrl is
end entity tb_pos_ctrl;

architecture test of tb_pos_ctrl is

  component pos_ctrl is
    port (
      -- System Clock and Reset
      rst       : in  std_logic;          -- Reset
      rst_div   : in  std_logic;          -- Reset
      mclk      : in  std_logic;          -- Clock
      mclk_div  : in  std_logic;          -- Clock to p_reg
      sync_rst  : in  std_logic;          -- Synchronous reset
      sp        : in  std_logic_vector(7 downto 0);  -- Setpoint (wanted position)
      a         : in  std_logic;          -- From position sensor
      b         : in  std_logic;          -- From position sensor
      pos      : out std_logic_vector(7 downto 0);  -- Measured Position
      force_cw  : in  std_logic;          -- Force motor clock wise motion
      force_ccw : in  std_logic;          -- Force motor counter clock wise motion
      motor_cw  : out std_logic;          -- Motor clock wise motion
      motor_ccw : out std_logic           -- Motor counter clock wise motion
    );      
  end component pos_ctrl;
  
  component motor
    port (
      motor_cw  : in  std_logic;
      motor_ccw : in  std_logic;
      a         : out std_logic;
      b         : out std_logic
    );      
  end component motor;
  
  signal rst              : std_logic := '0';          
  signal rst_div          : std_logic := '0';         
  signal mclk             : std_logic := '0';
  signal mclk_div         : std_logic := '0';          
  signal sync_rst         : std_logic := '0';          
  signal sp               : std_logic_vector(7 downto 0) := "00000010";  
  signal a_int            : std_logic := '0';          
  signal b_int            : std_logic := '0';          
  signal pos             : std_logic_vector(7 downto 0);  
  signal force_cw         : std_logic := '0';          
  signal force_ccw        : std_logic := '0';          
  signal motor_cw_int     : std_logic;
  signal motor_ccw_int    : std_logic;
  constant Half_Period_o  : time := 30 ns;
  constant Half_Period_t  : time := 15 ns;


begin
  
  uut2:  pos_ctrl port map(
                               rst=>rst, 
                               rst_div=>rst_div, 
                               mclk=>mclk, 
                               mclk_div=>mclk_div, 
                               sync_rst=>sync_rst, 
                               sp=>sp, 
                               a=>a_int, 
                               b=>b_int, 
                               pos=>pos, 
                               force_cw=>force_cw, 
                               force_ccw=>force_ccw,
                               motor_cw=>motor_cw_int, 
                               motor_ccw=>motor_ccw_int
                               );
                
  uut1:  motor port map(
                         motor_cw=>motor_cw_int, 
                         motor_ccw=>motor_ccw_int, 
                         a=>a_int, 
                         b=>b_int
                        );

  mclk <= not mclk after Half_Period_o;
  mclk_div <= not mclk_div after Half_Period_t;

   
  testing: process
  begin
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
    wait for 1000 ns;
    force_ccw <= '1';
    wait for 500 ns;
    force_ccw <= '0';
    wait for 500 ns;
    
    wait;
  end process testing;

end architecture test;