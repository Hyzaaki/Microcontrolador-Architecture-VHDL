library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY alu IS
PORT (
		a_in, b_in : IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- entrada "a" e "b" dos dados
		c_in: IN STD_LOGIC; -- entrada de carry (usada nas operações de RR e RL)
		op_sel: IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- entrada de seleção de operação
		bit_sel: IN STD_LOGIC_VECTOR (2 DOWNTO 0); -- entrada de seleção de bit (usada nas operações de BS e BC)
		r_out: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		c_out: OUT STD_LOGIC; --saida do resultado
		dc_out: OUT STD_LOGIC; --saida do carry/barrow 
		z_out: OUT STD_LOGIC -- bit_sel quando é utilizado BS ou BC, nas outras entradas é 0
);
END ENTITY;

ARCHITECTURE arch OF alu IS

    SIGNAL a_temp, aux: STD_LOGIC_VECTOR (8 downto 0); -- temporario de a/saida de 9 bits da ula 
    SIGNAL temp_sum : INTEGER; --somador temporario 
    SIGNAL bit_sel_temp : STD_LOGIC_VECTOR(7 DOWNTO 0); -- bit select temporario que sera utilizado no BS E BC
    SIGNAL z_temp : STD_LOGIC; -- tempororario que corresponde ao bit_sel quando é utilizado BS ou BC, nas outras entradas é 0

BEGIN
        
        a_temp <= '0' & a_in;
        
   WITH bit_sel SELECT 
		bit_sel_temp <=  "00000001" WHEN "000", 
					"00000010" WHEN "001", 
					"00000100" WHEN "010", 
					"00001000" WHEN "011", 
					"00010000" WHEN "100", 
					"00100000" WHEN "101", 
					"01000000" WHEN "110", 
					"10000000" WHEN "111"; 
        
        
        
        
    WITH op_sel SELECT
        aux <=  '0' & (a_in AND b_in) WHEN "0000", -- AND
				'0' & (a_in OR b_in) WHEN "0001", -- OR
				'0' & (a_in XOR b_in) WHEN "0010", -- XOR
				'0' & (NOT a_in) WHEN "0011", -- COM
				
				
			   ('0' & a_in) + 1 WHEN "0100", -- INC
			   ('0' & a_in) - 1 WHEN "0101", -- DEC
			   ('0' & a_in) + ('0' & b_in) WHEN "0110", -- ADD
			   ('0' & a_in) - ('0' & b_in) WHEN "0111", -- SUB
			   
			   
			    '0' & a_in(3 downto 0) & a_in(7 downto 4) WHEN "1000", -- SWAP
				'0' & "00000000" WHEN "1001", -- CLR
				
					
				 a_temp(0) & c_in & a_temp(7 DOWNTO 1) WHEN "1010", --RR
			     a_temp(7) & a_temp(6 DOWNTO 0) & c_in WHEN "1011",--RL
				
				'0' & bit_sel_temp OR a_in WHEN "1100", -- BS
				'0' & (NOT bit_sel_temp) AND a_in WHEN "1101", -- BC 
				
				
				'0' & a_in WHEN "1110", -- PASS A
				'0' & b_in WHEN "1111"; -- PASS B
				
        
    r_out <= aux(7 downto 0);
    
    WITH op_sel SELECT
		  dc_out <= aux(4) WHEN "0110",
					NOT aux(4) WHEN "0111",
					'0' WHEN OTHERS;
      
    WITH op_sel SELECT
		   c_out <= aux (0) WHEN "1010",
					aux (7) WHEN "1011",
					aux (8) WHEN "0110" | "0111",
					aux (8) WHEN OTHERS;
		
		
	WITH bit_sel SELECT 
		z_temp <=   a_in(0) WHEN "000", 
					a_in(1) WHEN "001", 
					a_in(2) WHEN "010", 
					a_in(3) WHEN "011", 
					a_in(4) WHEN "100", 
					a_in(5) WHEN "101", 
					a_in(6) WHEN "110", 
					a_in(7) WHEN "111"; 	
					
		  z_out <=  z_temp WHEN op_sel = "1100" OR op_sel = "1101" ELSE
				   '1' WHEN aux(7 DOWNTO 0) = "00000000" ELSE
				   '0';
     
   
        
END arch;