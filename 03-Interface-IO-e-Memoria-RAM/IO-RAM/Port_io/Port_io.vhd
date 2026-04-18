library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity Port_io is
    generic (
        port_addr : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
        tris_addr : STD_LOGIC_VECTOR (8 downto 0) := "000000001";
        alt_port_addr : STD_LOGIC_VECTOR (8 downto 0) := "000000010";
        alt_tris_addr : STD_LOGIC_VECTOR (8 downto 0) := "000000011"
    );
    port (
        nrst : in STD_LOGIC;
        clk_in : in STD_LOGIC;
        abus_in : in STD_LOGIC_VECTOR (8 downto 0);
        dbus_in : in STD_LOGIC_VECTOR (7 downto 0);
        wr_en : in STD_LOGIC;
        rd_en : in STD_LOGIC;
        dbus_out : out STD_LOGIC_VECTOR (7 downto 0);
        port_io : inout STD_LOGIC_VECTOR (7 downto 0)
    );
end Port_io;

architecture Port_IO of Port_io is
    signal tris_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '1');
    signal port_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal latch : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
    -- operação de escrita nos registradores
    process (nrst, clk_in)
    begin
        if nrst = '0' then
            tris_reg <= (others => '1'); -- Todos os bits setados para '1'
            port_reg <= (others => '0'); -- Todos os bits setados para '0'
        elsif rising_edge(clk_in) then
            if wr_en = '1' then
                if abus_in = tris_addr or abus_in = alt_tris_addr then
                    tris_reg <= dbus_in(7 downto 0);
                elsif abus_in = port_addr or abus_in = alt_port_addr then
                    port_reg <= dbus_in(7 downto 0);
                end if;
            end if;
        end if;
    end process;

    -- operação de leitura dos registradores
    process (rd_en, abus_in, latch, tris_reg)
    begin
        if rd_en = '1' then
            if abus_in = port_addr or abus_in = alt_port_addr then
                dbus_out <= latch;
            elsif abus_in = tris_addr OR abus_in = alt_tris_addr THEN
                dbus_out <= tris_reg;
            else
                dbus_out <= (OTHERS => 'Z');
            end if;
        else 
            dbus_out <= (OTHERS => 'Z'); -- Missing semicolon here
        end if;
    end process;

    -- lógica da porta
    process (tris_reg, port_reg, port_io)
    begin
        for i in 0 to 7 loop 
            -- se algum bit de tris_reg for saida, port_io recebe o bit dessa posicao de port_reg
            if tris_reg(i) = '0' then 
                port_io(i) <= port_reg(i);
                -- caso não seja a posicao fica em alta impedancia
            else
                port_io(i) <= 'Z';
            end if;
        end loop;
    end process;

    -- lógica do latch
    process (rd_en, abus_in, port_io)
    begin
        if rd_en = '1' then
            if abus_in = port_addr or abus_in = alt_port_addr then
                latch <= port_io;
            end if;
        end if;
    end process;

end Port_IO;
