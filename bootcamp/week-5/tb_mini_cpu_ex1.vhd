-- tb_mini_cpu_ex1.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_mini_cpu_ex1 is
end tb_mini_cpu_ex1;

architecture sim of tb_mini_cpu_ex1 is

    signal clk       : std_logic := '0';
    signal reset     : std_logic := '1';
    signal done      : std_logic;

    signal dbg_acc   : std_logic_vector(7 downto 0);
    signal dbg_pc    : std_logic_vector(4 downto 0);
    signal dbg_ir    : std_logic_vector(7 downto 0);
    signal dbg_state : std_logic_vector(2 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    ------------------------------------------------------------------
    -- Clock generation
    ------------------------------------------------------------------

    clk <= not clk after CLK_PERIOD / 2;


    ------------------------------------------------------------------
    -- DUT
    ------------------------------------------------------------------

    uut : entity work.mini_cpu
        port map (

            clk       => clk,
            reset     => reset,
            done      => done,

            dbg_acc   => dbg_acc,
            dbg_pc    => dbg_pc,
            dbg_ir    => dbg_ir,
            dbg_state => dbg_state

        );


    ------------------------------------------------------------------
    -- Stimulus
    ------------------------------------------------------------------

    stimulus : process
    begin

        --------------------------------------------------------------
        -- Phase 1 : Reset
        --------------------------------------------------------------

        reset <= '1';

        wait for 3 * CLK_PERIOD;

        reset <= '0';


        --------------------------------------------------------------
        -- Phase 2 : Wait for program completion
        --------------------------------------------------------------

        wait until done = '1'
        for 25 * CLK_PERIOD;


        assert done = '1'
        report "FAIL : CPU never reached HALT"
        severity error;


        wait for CLK_PERIOD;


        --------------------------------------------------------------
        -- Phase 3 : Final checks
        --------------------------------------------------------------

        assert dbg_acc = x"14"
        report "FAIL : Expected ACC = 0x14"
        severity error;


        assert dbg_state = "100"
        report "FAIL : CPU should remain in HALT"
        severity error;


        --------------------------------------------------------------
        -- Phase 4 : Verify HALT stability
        --------------------------------------------------------------

        wait for 3 * CLK_PERIOD;


        assert done = '1'
        report "FAIL : CPU escaped HALT"
        severity error;


        assert dbg_acc = x"14"
        report "FAIL : ACC changed after HALT"
        severity error;


        --------------------------------------------------------------
        -- Phase 5 : Reset recovery
        --------------------------------------------------------------

        reset <= '1';

        wait for 2 * CLK_PERIOD;

        reset <= '0';

        wait for CLK_PERIOD;


        assert done = '0'
        report "FAIL : done should clear after reset"
        severity error;


        assert dbg_pc = "00000"
        report "FAIL : PC should return to 0"
        severity error;


        --------------------------------------------------------------
        -- PASS
        --------------------------------------------------------------

        report "tb_mini_cpu_ex1 : ALL TESTS PASSED"
        severity note;

        wait;

    end process;

end sim;