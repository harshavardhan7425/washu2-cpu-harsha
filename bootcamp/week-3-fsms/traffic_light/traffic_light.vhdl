library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_light is
    port(
        clk: in std_logic;
        reset: in std_logic;
        red: out std_logic;
        green: out std_logic;
        yellow: out std_logic
    );
end traffic_light;

architecture rtl of traffic_light is

    constant RED_TIME: integer := 5;
    constant RED_YELLOW_TIME: integer := 2;
    constant GREEN_TIME: integer := 5;
    constant YELLOW_TIME: integer := 2;

    signal timer: integer range 0 to 15 := 0;

    type state_type is (S_RED, S_RED_YELLOW, S_GREEN, S_YELLOW);
    signal current_state: state_type := S_RED;
    signal next_state: state_type := S_RED;
begin

    state_reg: process(clk) begin
        if rising_edge(clk) then
            if reset = '1' then
                current_state <= S_RED;
                timer <= 0;
            else
                current_state <= next_state;
                if next_state /= current_state then
                    timer <= 0;
                else 
                    timer <= timer + 1;
                    timer <= timer + 1;
                end if;
            end if;
        end if;
    end process;

    comb_logic: process(current_state, timer) begin
        next_state <= current_state;
        red <= '0';
        green <= '0';
        yellow <= '0';

        case current_state is

        when S_RED =>
            red <= '1';
            if timer = RED_TIME-1 then
                next_state <= S_RED_YELLOW;
            end if;

        when S_RED_YELLOW =>
            red <= '1';
            yellow <= '1';
            if timer = RED_YELLOW_TIME-1 then
                next_state <= S_GREEN;
            end if;

        when S_GREEN =>
            green <= '1';
            if timer = GREEN_TIME-1 then
                next_state <= S_YELLOW;
            end if;

        when S_YELLOW =>
            yellow <= '1';
            if timer = YELLOW_TIME-1 then
                next_state <= S_RED;
            end if;
            
        when others =>
            next_state <= current_state;

        end case;
    end process;
    
end rtl;