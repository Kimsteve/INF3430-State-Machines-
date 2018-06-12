library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity tb_p_ctrl is
end tb_p_ctrl;

architecture test of tb_p_ctrl is

  component p_ctrl is
    port(
    rst       : in  std_logic;           -- Reset
    clk       : in  std_logic;           -- Clock
    sp        : in  signed(7 downto 0);  -- Set Point
    pos      : in  signed(7 downto 0);  -- Measured position
    motor_cw  : out std_logic;           --Motor Clock Wise direction
    motor_ccw : out std_logic            --Motor Counter Clock Wise direction
    );      
  end component p_ctrl;
  
  component pos_meas is
    port (
      rst        : in  std_logic;           -- Reset
      clk        : in  std_logic;           -- Clock
      sync_rst   : in  std_logic;           -- Sync reset 
      a          : in  std_logic;           -- From position sensor
      b          : in  std_logic;           -- From position sensor
      pos       : out signed(7 downto 0)   -- Measured position
      );
  end component pos_meas;
  
  component motor
    port (
      motor_cw  : in  std_logic;
      motor_ccw : in  std_logic;
      a         : out std_logic;
      b         : out std_logic
    );      
  end component motor;

  signal rst            : std_logic := '0';
  signal clk            : std_logic := '0';
  signal sync_rst       : std_logic := '0';
  constant Half_Period  : time := 50 ns;
  signal a_int          : std_logic := '0';
  signal b_int          : std_logic := '0';
  signal sp             : signed(7 downto 0) := "00000000";
  signal pos_int       : signed(7 downto 0) := "00000000";
  signal motor_cw_int   : std_logic := '0';
  signal motor_ccw_int  : std_logic := '0';

begin


  uut1:  pos_meas 
			port map
  			  ( rst=>rst,
                          clk=>clk,
                          sync_rst=>sync_rst,
                          a=>a_int, 
                          b=>b_int,
                          pos=>pos_int
                          );
  uut: motor 
		port map
  		( motor_cw=>motor_cw_int,
                  motor_ccw=>motor_ccw_int,
                  a=>a_int,
                  b=>b_int
                  );
	

	
                                      
  uut2:  p_ctrl  
		port map
  		(rst=>rst, 
                    clk=>clk, 
                    sp=>sp, 
                    pos=>pos_int, 
                    motor_cw=>motor_cw_int, 
                    motor_ccw => motor_ccw_int
                    );
	
  clk <= not clk after Half_Period;
  
  check: process
  begin
    rst <= '1', '0' after 400 ns;
    
    wait ;
  end process check;

end architecture test;