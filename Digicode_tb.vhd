library IEEE;
USE ieee.std_logic_1164.ALL;

-- Entity declaration for your testbench. Don't declare any ports here
ENTITY testbench_DigiCode IS
END ENTITY testbench_DigiCode;

ARCHITECTURE test_DigiCode OF testbench_DigiCode IS

-- Component Declaration for the Device Under Test (DUT)
COMPONENT DigiCode IS
port  (
	ck    : in	std_logic;
	vdd   : in	std_logic;
	vss   : in	std_logic;
	code  : in	std_logic_vector (3 downto 0);
	reset : in	std_logic;
	day   : in	std_logic;
	alarm : out	std_logic;
	door  : out	std_logic
      );
END COMPONENT DigiCode;

FOR dut: DigiCode USE ENTITY WORK.DigiCode (MOORE);

-- Declare input signals and initialize them
SIGNAL ck    : std_logic := '0';
SIGNAL vdd   : std_logic := '1';
SIGNAL vss   : std_logic := '0';
SIGNAL code  : std_logic_vector (3 downto 0) := x"0";
SIGNAL alarm : std_logic := '0';
SIGNAL reset : std_logic := '0';
SIGNAL day   : std_logic := '0';
SIGNAL door  : std_logic := '0';

-- Constants and Clock period definitions
constant clk_period : time := 20 ns;
BEGIN

-- Instantiate the Device Under Test (DUT)
dut: DigiCode PORT MAP (ck, vdd, vss, code, reset, day, alarm, door);

-- Clock process definitions( clock with 50% duty cycle )
   clk_process :process
   begin
        ck <= '0';
        wait for clk_period/2;  
        ck <= '1';
        wait for clk_period/2;  
   end process;

-- Stimulus process, refer to clock signal
stim_proc: PROCESS IS
BEGIN
	-- case 1 correct code entered at night "day = 0"
	code <= x"2";
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"6";
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"a";
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"0";
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"5";
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '1'
	REPORT "output error"
	SEVERITY error;
	
	--case 2 reset test
	code <= x"0";
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 3 testing wrong code at night "day = 0"
	code <= x"1";
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '1' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	--returning to s0
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 4 testing correct code with day = 1
	code <= x"2";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"6";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"a";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"0";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"5";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '1'
	REPORT "output error"
	SEVERITY error;
	
	--case 5 testing rest when day = 1
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 6 testing "o" button when day = 1
	code <= "1101";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '1'
	REPORT "output error"
	SEVERITY error;
	
	--returning to s0
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 6 wrong code when day = 1
	code <= x"1";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '1' and door = '0'
	REPORT "output error"
	SEVERITY error;
	
	--returning to s0
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm = '0' and door = '0'
	REPORT "output error"
	SEVERITY error;
	


WAIT; -- stop process simulation run

END PROCESS stim_proc;
END ARCHITECTURE test_DigiCode;


