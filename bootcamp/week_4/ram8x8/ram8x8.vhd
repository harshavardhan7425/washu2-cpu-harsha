library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram8x8 is
    port(
        clk: in std_logic;
        data_in: in std_logic_vector(7 downto 0);
        addr: in std_logic_vector(2 downto 0);
        we: in std_logic;
        data_out: out std_logic_vector(7 downto 0);
        valid: out std_logic
    );
end ram8x8;

architecture rtl of ram8x8 is
    type ram_type is array (0 to 7) of std_logic_vector(7 downto 0);
    signal ram_mem: ram_type := (others => (others => '0'));
    signal valid_prev: std_logic := '0';
    signal data_reg: std_logic_vector(7 downto 0) := (others => '0');
begin
    mem: process (clk) begin
        if rising_edge(clk) then
            valid <= valid_prev;
            if we = '0' then
                data_reg <= ram_mem(to_integer(unsigned(addr)));
                valid_prev <= '1';
            else
                ram_mem(to_integer(unsigned(addr))) <= data_in;
                valid_prev <= '0';
            end if;
        end if;
    end process;
    data_out <= data_reg;
end rtl;