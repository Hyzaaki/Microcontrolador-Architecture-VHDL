library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FSR_reg is
    Port (
        nrst : in STD_LOGIC;         -- Entrada de reset assíncrono
        clk_in : in STD_LOGIC;       -- Entrada de clock para escrita no registrador
        abus_in : in STD_LOGIC_VECTOR(8 downto 0);  -- Entrada de endereçamento
        dbus_in : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada de dados para escrita no registrador
        wr_en : in STD_LOGIC;         -- Entrada de habilitação para escrita no registrador
        rd_en : in STD_LOGIC;         -- Entrada de habilitação para leitura
        dbus_out : out STD_LOGIC_VECTOR(7 downto 0);  -- Saída de dados lidos
        fsr_out : out STD_LOGIC_VECTOR(7 downto 0)  -- Saída correspondente ao registrador
    );
end FSR_reg;

architecture architeture_8bits of FSR_reg is
    signal temp : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    process (clk_in, nrst)
    begin
        if nrst = '0' then
            -- Reset assíncrono ativo, zera o registrador
            temp <= (others => '0');
        elsif rising_edge(clk_in) then
            -- Verifica se o endereço é "0000100" (7 bits menos significativos)
            if abus_in(8 downto 2) = "0000100" then
                if wr_en = '1' then
                    -- Escreve no registrador sincronamente com o clock
                    temp <= dbus_in;
                end if;
                if rd_en = '1' then
                    -- Leitura combinacional, apenas habilitada
                    dbus_out <= temp;
                else
                    -- Leitura desabilitada, saída fica em alta impedância
                    dbus_out <= (others => 'Z');
                end if;
            end if;
        end if;
    end process;

    -- A saída fsr_out está sempre ativa e corresponde ao conteúdo do registrador
    fsr_out <= temp;
end architeture_8bits;
