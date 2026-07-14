library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity washu2_ram is
    port (
        clk      : in  std_logic;
        we       : in  std_logic;
        addr     : in  std_logic_vector(11 downto 0);
        data_in  : in  std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end washu2_ram;

architecture rtl of washu2_ram is

    type ram_type is array (0 to 4095) of std_logic_vector(15 downto 0);

    -- ==============================================================
    -- PROGRAM: edit this initialiser for each exercise / test program.
    --
    -- Array indices are DECIMAL integers.
    -- Address 0x010 = index 16, 0x020 = 32, 0x100 = 256, etc.
    --
    -- Instructions go at low addresses (0, 1, 2, ...).
    -- Data values go at higher addresses (e.g., 16, 32, 256, ...).
    --
    -- Current program: Exercise 1, Program A — HALT only.
    -- Replace with your own program for each exercise.
    -- ==============================================================

    signal ram_mem : ram_type := (
        -- ================================================================
        -- DEFAULT PROGRAM: self-test for all five Week 7 instructions.
        -- Expected results after HALT:
        --   ACC        = 0xFFFB  (-5 in two's complement)
        --   mem[0x010] = 0xFFFB  (stored by DSTORE, reloaded by DLOAD)
        --   PC         = 0x0006  (incremented past HALT in fetch2)
        --   done       = '1'
        --
        -- Replace this initialiser with your own program for each exercise.
        -- Array indices are DECIMAL: 0x010 = 16, 0x020 = 32, etc.
        -- ================================================================

        -- ── Instructions (addresses 0x000–0x005) ──────────────────────
        0  => x"202A",   -- CLOAD 42
        1  => x"4010",   -- DSTORE 0x010
        2  => x"2000",   -- CLOAD 0
        3  => x"3010",   -- DLOAD 0x010
        4  => x"0000",   -- HALT

        16 => x"0000",   -- Data at address 0x010 (will become 0x002A after DSTORE)

        others => x"0000"
    );

    signal data_out_reg : std_logic_vector(15 downto 0) := (others => '0');

begin

    mem_proc : process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                ram_mem(to_integer(unsigned(addr))) <= data_in;
            end if;
            -- Registered read: data_out valid ONE cycle after addr is presented
            data_out_reg <= ram_mem(to_integer(unsigned(addr)));
        end if;
    end process mem_proc;

    data_out <= data_out_reg;

end rtl;