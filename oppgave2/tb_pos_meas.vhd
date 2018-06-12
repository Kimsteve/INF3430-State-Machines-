library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_pos_meas is
end entity;

architecture testbench of tb_pos_meas is
	component pos_meas is
	  port (
		-- System Clock and Reset
			rst      : in  std_logic;           -- Reset
			clk      : in  std_logic;           -- Clock
			sync_rst : in  std_logic;           -- Sync reset
			a        : in  std_logic;           -- From position sensor
			b        : in  std_logic;           -- From position sensor
			pos      : out signed(7 downto 0)   -- Measured position
		);      
	end component pos_meas;
	
	component motor is 
	 port (
		motor_cw  : in  std_logic;
		motor_ccw : in  std_logic;
		a         : out std_logic;
		b         : out std_logic
    );      
   end component;
   
   signal rst : std_logic := '0';
   signal sync_rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal motor_cw  :  std_logic:='0';
   signal 	motor_ccw :  std_logic:='0';
   signal a  : std_logic;
   signal b    : std_logic;
   signal pos  : signed(7 downto 0);
   
   constant Half_Period : time := 20 ns;
   
   begin 
   uut1: motor port map(
		motor_cw => motor_cw, 
		motor_ccw => motor_ccw, 
		a => a,
		b => b    
	);
	
	uut2: pos_meas port map (
			rst => rst,  
			clk => clk,
			sync_rst => sync_rst, 
			a =>a,  
			b => b,     
			pos => pos
	);
	
	clk <= not clk after Half_Period;
	
	process
		begin rst <= '1', '0' after 30 ns;
		motor_ccw<= '1';
		wait for 2000 ns;
		motor_cw <= '0';
		motor_ccw <= '0';
		wait for 500 ns ;
		motor_cw <= '1';
		motor_ccw <= '0';
		wait for 2000 ns;
		motor_cw <= '0';
		motor_ccw<= '1';
		wait;
	end process;	
	
end architecture;	
						
		
   
   
