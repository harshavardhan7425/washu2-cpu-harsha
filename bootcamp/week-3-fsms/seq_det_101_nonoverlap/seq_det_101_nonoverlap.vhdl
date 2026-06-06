library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq_det_101_nonoverlap is
    port(
        clk: in std_logic;
        reset: in std_logic;
        data: in std_logic;
        detected: out std_logic
    );
end seq_det_101_nonoverlap;

architecture rtl of seq_det_101_nonoverlap is
    type state_type is (S_INIT, S_1, S_10, S_101);
    signal current_state: state_type := S_INIT;
    signal next_state: state_type;
begin
    state_reg: process(clk) begin
        if rising_edge(clk) then
            if reset = '1' then
                current_state <= S_INIT;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process state_reg;

    comb_logic: process(data, current_state) begin
        next_state <= current_state;
        detected <= '0';
        case current_state is

            when S_INIT =>
                if data = '1' then
                    next_state <= S_1;
                end if;
            
            when S_1 =>
                if data = '0' then
                    next_state <= S_10;
                end if;
            
            when S_10 =>
                if data = '1' then 
                    next_state <= S_101;
                end if;

            when S_101 =>
                detected <= '1';
                if data = '1' then 
                    next_state <= S_1;
                else
                    next_state <= S_INIT;
                end if;

        end case;
    end process comb_logic;
end rtl;
