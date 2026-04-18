library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Status_reg is
    Port (
        nrst : in STD_LOGIC;         -- Entrada de reset assíncrono
        clk_in : in STD_LOGIC;       -- Entrada de clock para escrita no registrador
        abus_in : in STD_LOGIC_VECTOR(8 downto 0);  -- Entrada de endereçamento
        dbus_in : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada de dados para escrita no registrador
        wr_en : in STD_LOGIC;         -- Entrada de habilitação para escrita no registrador
        rd_en : in STD_LOGIC;         -- Entrada de habilitação para leitura
        z_in : in STD_LOGIC;          -- Entrada de dado para escrita no bit 2 do registrador
        dc_in : in STD_LOGIC;         -- Entrada de dado para escrita no bit 1 do registrador
        c_in : in STD_LOGIC;          -- Entrada de dado para escrita no bit 0 do registrador
        z_wr_en : in STD_LOGIC;       -- Entrada para habilitação da escrita no bit 2 do registrador
        dc_wr_en : in STD_LOGIC;      -- Entrada para habilitação da escrita no bit 1 do registrador
        c_wr_en : in STD_LOGIC;       -- Entrada para habilitação da escrita no bit 0 do registrador
        dbus_out : buffer STD_LOGIC_VECTOR(7 downto 0);  -- Saída de dados lidos
        wr_out : out STD_LOGIC_VECTOR(7 downto 0); -- saida correspondente ao registrador - adicionei não pedia no trabalho -
        irp_out : out STD_LOGIC;      -- Saída correspondente ao bit 7 do registrador
        rp_out : out STD_LOGIC_VECTOR(1 downto 0);    -- Saída correspondente aos bits 6 e 5 do registrador
        z_out : out STD_LOGIC;        -- Saída correspondente ao bit 2 do registrador
        dc_out : out STD_LOGIC;       -- Saída correspondente ao bit 1 do registrador
        c_out : out STD_LOGIC          -- Saída correspondente ao bit 0 do registrador
    );
end Status_reg;

architecture register_8bits of Status_reg is
    
    signal temp : STD_LOGIC; 
begin
    process (clk_in, nrst)
    begin
    temp <= '1';
        if nrst = '0' then
            -- Reset assíncrono ativo, zera o registrador
            dbus_out <= (others => '0');
        elsif rising_edge(clk_in) then
            -- Verifica se o endereço é "0000011" (7 bits menos significativos)
            if abus_in(8 downto 2) = "0000011" then -- se o endereço de abus_in for o correto, permite as operações definidas abaixo: 
            
                if wr_en = '1' then -- permite a escrita no registrador 
					wr_out <= dbus_in;  -- saida correspondente a escrita do registrador
                end if;
                if rd_en = '1' then -- a saída dbus_out deverá corresponder ao conteúdo do registrador, exceto os bits 4 e 3, que deverão ser sempre lidos como ‘1’.
					dbus_out <= dbus_in;
					dbus_out(4) <= temp; -- os bits 4 e 3 do registrador devem ser sempre lidos como 1 
					dbus_out(3) <= temp;
				else 
					dbus_out <= (others => 'Z'); -- se rd_en for diferente de 1 a saida permanece em alta impedancia 	
				end if;
				-- as operações a seguir tem preferencia sobre rd_in 
				if z_wr_en = '1' then -- quando habilitada permite a escrita no bit 2 do registrador 
					dbus_out(2) <= z_in; -- bit 2 do registrador passa a ser o valor de z_in
				end if;
				if dc_wr_en = '1' then -- quando habilitada permite a escrita no bit 1 do registrador 
					dbus_out(1) <= dc_in; -- bit 1 do registrador passa a ser o valor de dc_in
				end if;
				if c_wr_en = '1' then -- quando habilitada permite a escrita no bit 0 do registrador 
					dbus_out(0) <= c_in; -- bit 0 do registrador passa a ser o valor de c_in
				end if;
			else -- caso o endereço de abus_in não seja correto a saida fica em alta impedancia 
				dbus_out <= (others => 'Z');
				wr_out <= (others => 'Z');
            end if;
		end if;
    end process;

    -- As saídas irp_out, rp_out, z_out, dc_out, c_out correspondem aos bits específicos do registrador
    
    irp_out <= dbus_out(7);
    rp_out <= dbus_out(6 downto 5);
    z_out <= dbus_out(2);
    dc_out <= dbus_out(1);
    c_out <= dbus_out(0);
end register_8bits;
