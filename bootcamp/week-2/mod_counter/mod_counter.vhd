library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod_counter is
    generic(
        N : integer := 10
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        count : out std_logic_vector(3 downto 0);
        tick : out std_logic
    );
end mod_counter;

architecture rtl of mod_counter is
    signal count_int : std_logic_vector(3 downto 0);
begin
    process (clk, reset) begin
        if reset = '1' then
            count_int <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                if unsigned(count_int) = N-1 then
                    count_int <= (others => '0');
                else 
                    count_int <= std_logic_vector(unsigned(count_int) + 1);
                    tick <= '0';
                end if;
                if unsigned(count_int) = N-2 then
                    tick <= '1';
                elsif rising_edge(clk) then
                    tick <= '0';
                end if;
            end if;
        end if;
    end process;
    count <= count_int;
end rtl;