library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_mod_counter is
end tb_mod_counter;

architecture sim of tb_mod_counter is
    signal clk, reset, enable, tick : std_logic := '0';
    signal count : std_logic_vector(3 downto 0) := (others => '0');
    constant CLK_PERIOD : time := 10 ns;
begin
    clk <= not clk after CLK_PERIOD/2;

    uut : entity work.mod_counter
        port map(
            clk => clk,
            reset => reset,
            enable => enable,
            tick => tick,
            count => count
        );

    stimulus: process begin
        reset <= '1';
        wait for 25 ns;

        reset <= '0';
        enable <= '1';
        wait for 30 ns;

        enable <= '0';
        wait for 30 ns;

        enable <= '1';
        wait for 300 ns;

        wait;
    end process;
end sim;