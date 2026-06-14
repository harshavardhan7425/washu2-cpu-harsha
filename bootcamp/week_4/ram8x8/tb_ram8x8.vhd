library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_ram8x8 is
end tb_ram8x8;

architecture sim of tb_ram8x8 is
    signal clk: std_logic := '0';
    signal data_in: std_logic_vector(7 downto 0);
    signal addr: std_logic_vector(2 downto 0);
    signal we: std_logic;
    signal data_out: std_logic_vector(7 downto 0);
    signal valid: std_logic;
begin

    clk <= not clk after 5 ns;

    uut: entity work.ram8x8
        port map(
            clk => clk,
            data_in => data_in,
            addr => addr,
            we => we,
            data_out => data_out,
            valid => valid
        );

    stimulus: process
    begin

        we <= '1';
        addr <= "000";
        data_in <= "10110101";
        wait until rising_edge(clk);

        addr <= "001";
        data_in <= "11001100";
        wait until rising_edge(clk);

        addr <= "010";
        data_in <= "11110000";
        wait until rising_edge(clk);

        addr <= "011";
        data_in <= "00001111";
        wait until rising_edge(clk);

        we <= '0';
        addr <= "000";
        wait until rising_edge(clk);

        addr <= "001";
        wait until rising_edge(clk);

        addr <= "010";
        wait until rising_edge(clk);

        addr <= "011";
        wait until rising_edge(clk);

        we <= '1';
        addr <= "000";
        data_in <= "11111111";
        wait until rising_edge(clk);

        we <= '0';
        addr <= "000";
        wait until rising_edge(clk);

        addr <= "100";
        wait until rising_edge(clk);

        addr <= "101";
        wait until rising_edge(clk);

        wait;

    end process;
end sim;