library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_traffic_light is
end tb_traffic_light;

architecture sim of tb_traffic_light is
    constant CLK_PERIOD : time := 10 ns;
    signal clk: std_logic := '0';
    signal reset: std_logic;
    signal red: std_logic;
    signal green: std_logic;
    signal yellow: std_logic;
begin
    clk <= not clk after CLK_PERIOD/2;
    uut: entity work.traffic_light
        port map(
            clk => clk,
            reset => reset,
            red => red,
            green => green,
            yellow => yellow
        );
    
    stimuli: process begin
        reset <= '1';
        wait for 50 ns;

        reset <= '0';
        wait for 300 ns;

        wait;
    end process;
end sim;