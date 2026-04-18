library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplexador is
    Port ( rp_in : in STD_LOGIC_VECTOR(1 downto 0);
           dir_addr_in : in STD_LOGIC_VECTOR(6 downto 0);
           irp_in : in STD_LOGIC;
           ind_addr_in : in STD_LOGIC_VECTOR(7 downto 0);
           abus_out : out STD_LOGIC_VECTOR(8 downto 0));
end Multiplexador;

architecture Behavioral of Multiplexador is
begin
    process (rp_in, dir_addr_in, irp_in, ind_addr_in)
    begin
        if dir_addr_in = "0000000" then
            abus_out <= irp_in & ind_addr_in; -- Concatenação de irp_in e ind_addr_in
        else
            abus_out <= rp_in & dir_addr_in; -- Concatenação de rp_in e dir_addr_in
        end if;
    end process;
end Behavioral;
