library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_alu4_extended is
end tb_alu4_extended;

architecture sim of tb_alu4_extended is
    signal a, b, result: std_logic_vector(3 downto 0);
    signal op: std_logic_vector(2 downto 0);
    signal zero, carry, negative: std_logic;
begin

    uut: entity work.alu4_extended
        port map(
            a => a,
            b => b,
            result => result,
            zero => zero,
            carry => carry,
            op => op,
            negative => negative
        );
    
    stimulus: process begin
            a <= "0011";
            b <= "0010";
            op <= "000";
            wait for 10 ns;

            a <= "1111";
            b <= "0001";
            op <= "000";
            wait for 10 ns;

            a <= "0111";
            b <= "0010";
            op <= "001";
            wait for 10 ns;

            a <= "0010";
            b <= "0101";
            op <= "001";
            wait for 10 ns;

            a <= "1100";
            b <= "1010";
            op <= "010";
            wait for 10 ns;

            a <= "1100";
            b <= "0011";
            op <= "011";
            wait for 10 ns;

            a <= "1111";
            b <= "0101";
            op <= "100";
            wait for 10 ns;

            a <= "1010";
            b <= "0000";
            op <= "101";
            wait for 10 ns;

            a <= "0011";
            b <= "0000";
            op <= "110";
            wait for 10 ns;

            a <= "0000";
            b <= "0000";
            op <= "000";
            wait for 10 ns;

            a <= "1000";
            b <= "0000";
            op <= "011";
            wait for 10 ns;

            wait;

    end process;

end sim;