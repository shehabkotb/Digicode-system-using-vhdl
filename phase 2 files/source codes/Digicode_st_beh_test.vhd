---------------test bench of behavioral, loon output, scapin output-----------------------

library IEEE;
USE ieee.std_logic_1164.ALL;

-- Entity declaration for your testbench. Don't declare any ports here
ENTITY testbench_DigiCode_st IS
END ENTITY testbench_DigiCode_st;

ARCHITECTURE testbench_DigiCode_st OF testbench_DigiCode_st IS

-- Component Declaration for the Device Under Test (DUT)
COMPONENT DigiCode IS
port  (
	ck    : in	bit;
	vdd   : in	bit;
	vss   : in	bit;
	code  : in	bit_vector (3 downto 0);
	reset : in	bit;
	day   : in	bit;
	alarm : out	bit;
	door  : out	bit
      );
END COMPONENT DigiCode;

FOR dut_beh: DigiCode USE ENTITY WORK.DigiCode (MOORE);

COMPONENT digicodea_b_l IS
port  (
	ck    : in	bit;
	vdd   : in	bit;
	vss   : in	bit;
	code  : in	bit_vector(3 downto 0);
	reset : in	bit;
	day   : in	bit;
	alarm : out	bit;
	door  : out	bit
      );
END COMPONENT digicodea_b_l;

FOR dut_st: digicodea_b_l USE ENTITY WORK.digicodea_b_l (structural);

COMPONENT digicodea_b_l_scan IS
port  (
  ck      : in      bit;
  vdd     : in      bit;
  vss     : in      bit;
  code    : in      bit_vector(3 downto 0);
  reset   : in      bit;
  day     : in      bit;
  alarm   : out     bit;
  door    : out     bit;
  scanin  : in      bit;
  test    : in      bit;
  scanout : out     bit
      );
END COMPONENT digicodea_b_l_scan;

FOR dut_scan: digicodea_b_l_scan USE ENTITY WORK.digicodea_b_l_scan (structural);


-- Declare input signals and initialize them
SIGNAL ck    : bit := '0';
SIGNAL vdd   : bit := '1';
SIGNAL vss   : bit := '0';
SIGNAL code  : bit_vector(3 downto 0) := x"0";
SIGNAL reset : bit := '0';
SIGNAL day   : bit := '0';

SIGNAL test   : bit := '0';

SIGNAL door_b  : bit := '0';
SIGNAL alarm_b : bit := '0';

SIGNAL door_st  : bit := '0';
SIGNAL alarm_st : bit := '0';

SIGNAL door_scan  : bit := '0';
SIGNAL alarm_scan : bit := '0';

SIGNAL scanin  : bit := '0';
SIGNAL scanout : bit := '0';

-- Constants and Clock period definitions
constant clk_period : time := 20 ns;
constant sequence : bit_vector := "0011111011011100100111100";
BEGIN

-- Instantiate the Device Under Test (DUT)
dut_beh: DigiCode PORT MAP (ck, vdd, vss, code, reset, day, alarm_b, door_b);
dut_st: digicodea_b_l PORT MAP (ck, vdd, vss, code, reset, day, alarm_st, door_st);
dut_scan: digicodea_b_l_scan PORT MAP (ck, vdd, vss, code, reset, day, alarm_scan, door_scan, scanin, test, scanout);

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
	--reset case added to stabllise output at the beginnning
	code <= x"0";
	reset <= '1';
	test <= '0';
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	-- case 1 correct code entered at night "day = 0"
	code <= x"2";
	reset <= '0';
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"6";
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"a";
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"0";
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"5";
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '1' and alarm_st = '0' and door_st = '1' and alarm_scan = '0' and door_scan = '1'
	REPORT "output error"
	SEVERITY error;
	
	--case 2 reset test
	code <= x"0";
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 3 testing wrong code at night "day = 0"
	code <= x"1";
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '1' and door_b = '0' and alarm_st = '1' and door_st = '0' and alarm_scan = '1' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	--returning to s0
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 4 testing correct code with day = 1
	code <= x"2";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"6";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"a";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"0";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	code <= x"5";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '1' and alarm_st = '0' and door_st = '1' and alarm_scan = '0' and door_scan = '1'
	REPORT "output error"
	SEVERITY error;
	
	--case 5 testing rest when day = 1
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 6 testing "o" button when day = 1
	code <= "1101";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '1' and alarm_st = '0' and door_st = '1' and alarm_scan = '0' and door_scan = '1'
	REPORT "output error"
	SEVERITY error;
	
	--returning to s0
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 6 wrong code when day = 1
	code <= x"1";
	day <= '1';
	reset <= '0'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '1' and door_b = '0' and alarm_st = '1' and door_st = '0' and alarm_scan = '1' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	--returning to s0
	reset <= '1'; 
	WAIT FOR clk_period; 
	ASSERT alarm_b = '0' and door_b = '0' and alarm_st = '0' and door_st = '0' and alarm_scan = '0' and door_scan = '0'
	REPORT "output error"
	SEVERITY error;
	
	--case 7 test = 1
	day <= '0';
	test <= '1';
	for i in 0 to sequence'length-1 loop
	  scanin <= sequence(i);
	  wait for clk_period;
	  if i>=2 then
	    ASSERT scanout=sequence(i-2)
		REPORT "scanout does not follow scan in"
		SEVERITY error;
	  end if;
	end loop;
	


WAIT; -- stop process simulation run

END PROCESS stim_proc;
END ARCHITECTURE testbench_DigiCode_st;


