library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_structural is
    port (
        a : in std_logic;
        b : in std_logic;
        y : out std_logic
        );
end xor_structural;

architecture rtl of xor_structural is
    signal not_a, not_b, and1_gate, and2_gate : std_logic;
begin
    not_a <= not a;
    not_b <= not b;
    -- instantiating and gates
    a1 : entity work.and_gate
        port map ( a => a, b => not_b, y => and1_gate);
    a2 : entity work.and_gate
        port map ( a => not_a, b => b, y => and2_gate);

    --instantiating or gate
    o1 : entity work.or_gate
        port map ( a => and1_gate, b => and2_gate, y => y);
end rtl;
