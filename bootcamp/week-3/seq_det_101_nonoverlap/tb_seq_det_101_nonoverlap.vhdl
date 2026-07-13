library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_seq_det_101_nonoverlap is
end entity;

architecture sim of tb_seq_det_101_nonoverlap is
    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    signal data: std_logic := '0';
    signal detected: std_logic;
    constant CLK_PERIOD: time := 10 ns;
begin

    clk <= not clk after CLK_PERIOD/2;

    uut: entity work.seq_det_101_nonoverlap
        port map(
            clk => clk,
            reset => reset,
            data => data,
            detected => detected
        );

    stimuli: process begin
        reset <= '1';
        wait for 25 ns;
        wait until rising_edge(clk);

        reset <= '0';
        data <= '0';
        wait until rising_edge(clk); data <= '1';
        wait until rising_edge(clk); data <= '1';
        wait until rising_edge(clk); data <= '0';
        wait until rising_edge(clk); data <= '1';
        wait until rising_edge(clk); data <= '0';
        wait until rising_edge(clk); data <= '1';

        reset <= '1';
        wait until rising_edge(clk); data <= '1';
        wait until rising_edge(clk); data <= '0';
        wait until rising_edge(clk); data <= '1';

        reset <= '0';
        wait until rising_edge(clk); data <= '1';
        wait until rising_edge(clk); data <= '0';
        wait until rising_edge(clk); data <= '1';

        wait;
    end process;
end sim;