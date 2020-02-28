---------------original behavioral fsm-----------------------

library IEEE;
USE ieee.std_logic_1164.ALL;

entity DigiCode is
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
end DigiCode;

architecture MOORE of DigiCode is
  type STATE_TYPE is (S0, S1, s2, s3, s4, s5, s6);  
  signal NS, CS : STATE_TYPE;

begin
  process (CS, reset, code, day)
  begin

    if (reset='1') then
      NS<=S0;
    else
      case CS is
        when S0 =>
          if (day='1' and code = "1101") then --code = o
			NS <= S5;
          elsif (code = x"2") then
			NS <= s1;
		  else
		    Ns <= s6;
          end if;

        when S1 =>
          if (day='1' and code = "1101") then --code = o
			NS <= S5;
          elsif (code = x"6") then
			NS <= s2;
		  else
		    Ns <= s6;
          end if;
		  
	  
        when S2 =>
          if (day='1' and code = "1101") then --code = o
			NS <= S5;
          elsif (code = "1010") then
			NS <= s3;
		  else
		    Ns <= s6;
          end if;

	 
        when S3 =>
          if (day='1' and code = "1101") then --code = o
			NS <= S5;
          elsif (code = x"0") then
			NS <= s4;
		  else
		    Ns <= s6;
          end if;
		 
	  
        when S4 =>
          if (day='1' and code = "1101") then --code = o
			NS <= S5;
          elsif (code = x"5") then
			NS <= s5;
		  else
		    Ns <= s6;
          end if;
		 
	  
        when S5 =>
		  --door <= '1';
		  null;
		  --alarm <= '0';
          -- if (day='1' and code == '1100') then --code = o
			-- NS <= S5;
          -- elsif (code == '0')
			-- NS <= s4;
		  -- else
		    -- Ns <= s6;
          -- end if;
		  
	  
        when S6 =>
		  --door <= '0';
		  --alarm <= '1';
		  null;
          -- if (day='1' and code == '1100') then --code = o
			-- NS <= S6;
          -- elsif (code == '0')
			-- NS <= s5;
		  -- else
		    -- Ns <= s6;
          -- end if;
		  
	    when others => assert(false)
		report "illegal state" severity error;
		  
		  
	  end case;
end if;

case cs is
	when s0 =>
	door <= '0';
	alarm <= '0';
	when s1 =>
	door <= '0';
	alarm <= '0';
	when s2 =>
	door <= '0';
	alarm <= '0';
	when s3 =>
	door <= '0';
	alarm <= '0';
	when s4 =>
	door <= '0';
	alarm <= '0';
	when s5 =>
	door <= '1';
	alarm <= '0';
	when s6 =>
	door <= '0';
	alarm <= '1';
	end case;
  end process;

-- Process (2): State update (sequential)
  process(ck)
  begin
	if(ck = '1' and not ck'stable)then
      CS <= NS;
    end if;
  end process;

end MOORE;
