library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu4_extended is
    port (
        a        : in  std_logic_vector(3 downto 0);
        b        : in  std_logic_vector(3 downto 0);
        op       : in  std_logic_vector(2 downto 0);
        result   : out std_logic_vector(3 downto 0);
        zero     : out std_logic;   -- '1' when result = "0000"
        carry    : out std_logic;   -- '1' when ADD produces a carry out
        negative : out std_logic    -- '1' when result(3) = '1' (MSB set)
    );
end alu4_extended;

architecture rtl of alu4_extended is
    signal result_int: std_logic_vector(3 downto 0);
    signal a5, b5, sum5: unsigned(4 downto 0);

    constant ADD_OP    : std_logic_vector(2 downto 0) := "000";
    constant SUB_OP    : std_logic_vector(2 downto 0) := "001";
    constant AND_OP    : std_logic_vector(2 downto 0) := "010";
    constant OR_OP     : std_logic_vector(2 downto 0) := "011";
    constant XOR_OP    : std_logic_vector(2 downto 0) := "100";
    constant NOT_OP    : std_logic_vector(2 downto 0) := "101";
    constant NEGATE_OP : std_logic_vector(2 downto 0) := "110";
begin

    a5 <= '0' & unsigned(a);
    b5 <= '0' & unsigned(b);
    sum5 <= a5 + b5;

    alu: process(a, b, op, sum5) begin
        carry <= '0';
        case op is

            when ADD_OP =>
                result_int <= std_logic_vector(sum5(3 downto 0));
                carry <= sum5(4);

            when SUB_OP =>
                result_int <= std_logic_vector(unsigned(a) - unsigned(b));

            when AND_OP =>
                result_int <= a and b;

            when OR_OP =>
                result_int <= a or b;

            when XOR_OP =>
                result_int <= a xor b;

            when NOT_OP =>
                result_int <= not a;

            when NEGATE_OP =>
                result_int <= std_logic_vector(-signed(a));

            when others =>
                result_int <= (others => '0');

        end case;
    end process;  
    zero <= '1' when result_int = "0000" else '0';
    negative <= result_int(3);
    result <= result_int;           
end rtl;