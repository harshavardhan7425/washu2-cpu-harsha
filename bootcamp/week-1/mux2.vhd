library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    port (
        a   :   in  std_logic;
        b   :   in  std_logic;
        sel :   in  std_logic;
        y   :   out std_logic
    );
end mux2;

architecture rtl of mux2 is
    signal  and1_gate, and2_gate, not_gate : std_logic;
begin
    not_gate <= not sel;
    --instantiating and gates
    a1: entity work.and_gate
        port map (a => a, b => not_gate, y => and1_gate);
    a2: entity work.and_gate
        port map (a => b, b => sel, y => and2_gate);

    --instantiating or gates
    o1: entity work.or_gate
        port map (a => and1_gate, b => and2_gate, y => y);
end rtl;