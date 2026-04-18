library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity W_reg is -- Entidade para W_reg
    Port (
        clk_in : in STD_LOGIC; -- Entrada do clock
        nrst : in STD_LOGIC; -- Entrada de reset assíncrono
        d_in : in STD_LOGIC_VECTOR (7 downto 0); -- Vetor de entrada de 8 bits para o registrador
        wr_en : in STD_LOGIC; -- Entrada de habilitação para escrita no registrador
        q_out : out STD_LOGIC_VECTOR (7 downto 0) -- Vetor de saída de 8 bits do registrador
    );
end W_reg;

architecture register_8bits of W_reg is -- Arquitetura para um registrador de 8 bits
    signal q_temp : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); -- Vetor temporário para atribuição de dados de saída
begin
    process (clk_in, nrst)
    begin
        if rising_edge(clk_in) then -- Se o sinal do clock está em subida
            if nrst = '0' then -- Se o bit de reset está ativo, definir a saída como 0
                q_temp <= "00000000";
            elsif wr_en = '1' then -- Se o controle de escrita estiver em 1, atualizar o registrador com os dados de entrada
                q_temp <= d_in;
            end if;
        end if;
    end process;

    q_out <= q_temp;
end register_8bits;
