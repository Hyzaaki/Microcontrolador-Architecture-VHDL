library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Stack is
    Port ( clk_in : in STD_LOGIC; -- entrade de clock 
           nrst : in STD_LOGIC; -- entrada de reset
           stack_in : in STD_LOGIC_VECTOR (12 downto 0); --vetor de entrada de dados da pilha 
           stack_push : in STD_LOGIC;
           stack_pop : in STD_LOGIC;
           stack_out : out STD_LOGIC_VECTOR (12 downto 0));
end Stack;

architecture architectureStack of Stack is
    type RegStack is array (0 to 7) of STD_LOGIC_VECTOR (12 downto 0);
    signal Regs : RegStack;
begin

process (clk_in, nrst)
begin
    if nrst = '0' then
        for i in 0 to 7 loop
            Regs(i) <= (others => '0');
        end loop;
    elsif rising_edge(clk_in) then
        if stack_push = '1' then
            Regs(0) <= stack_in;
            for i in 1 to 7 loop
                Regs(i) <= Regs(i-1);
            end loop;
        elsif stack_pop = '1' then
            Regs(7) <= (others => '0');
            for i in 6 downto 0 loop
                Regs(i+1) <= Regs(i);
            end loop;
        end if;
    end if;
end process;

stack_out <= Regs(7);

end architectureStack;