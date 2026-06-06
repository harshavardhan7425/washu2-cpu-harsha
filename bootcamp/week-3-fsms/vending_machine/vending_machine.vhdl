library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vending_machine is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        coin5    : in  std_logic;   -- '1' for one clock cycle when 5p inserted
        coin10   : in  std_logic;   -- '1' for one clock cycle when 10p inserted
        dispense : out std_logic;   -- '1' for one cycle when item is released
        change   : out std_logic    -- '1' for one cycle when 5p change is given
    );
end vending_machine;

architecture rtl of vending_machine is
    type state_type is (P0, P5, P10, P15, P20);
    signal current_state: state_type := P0;
    signal next_state: state_type;
begin
    state_reg: process(clk) begin
        if rising_edge(clk) then
            if reset = '1' then
                current_state <= P0;
            else
                current_state <= next_state;
            end if;
        end if;
    end process state_reg;

    comb_logic: process(current_state, coin5, coin10) begin
        next_state <= current_state;
        dispense <= '0';
        change <= '0';
        case current_state is

            when P0 =>
                if coin5 = '1' then
                    next_state <= P5;
                elsif coin10 = '1' then
                    next_state <= P10;
                end if;
            
            when P5 =>
                if coin5 = '1' then
                    next_state <= P10;
                elsif coin10 = '1' then
                    next_state <= P15;
                end if;

            when P10 =>
                if coin5 = '1' then
                    next_state <= P15;
                elsif coin10 = '1' then
                    next_state <= P20;
                end if;

            when P15 =>
                dispense <= '1';
                if coin5 = '1' then
                    next_state <= P5;
                elsif coin10 = '1' then
                    next_state <= P10;
                else
                    next_state <= P0;
                end if;

            when P20 =>
                dispense <= '1';
                change <= '1';
                if coin5 = '1' then
                    next_state <= P5;
                elsif coin10 = '1' then
                    next_state <= P10;
                else
                    next_state <= P0;
                end if;

            when others =>
                next_state <= P0;
                
        end case;
    end process comb_logic;
end rtl;