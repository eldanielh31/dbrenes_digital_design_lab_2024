-- FullAdder_4bit_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FullAdder_4bit_tb is
end FullAdder_4bit_tb;

architecture Behavioral of FullAdder_4bit_tb is
    component FullAdder_4bit is
        Port (
            A, B : in  std_logic_vector(3 downto 0);
            Cin : in  std_logic;
            Sum : out std_logic_vector(3 downto 0);
            Cout : out std_logic
        );
    end component;
    
    signal A_tb, B_tb, Sum_tb : std_logic_vector(3 downto 0);
    signal Cin_tb, Cout_tb : std_logic;
begin
    UUT : FullAdder_4bit port map(
        A => A_tb,
        B => B_tb,
        Cin => Cin_tb,
        Sum => Sum_tb,
        Cout => Cout_tb
    );

    process
    begin
        -- Test case 1
        A_tb <= "0001";
        B_tb <= "0010";
        Cin_tb <= '0';
        wait for 10 ns;
        assert Sum_tb = "0011" and Cout_tb = '0' report "Test case 1 failed" severity error;
        
        -- Test case 2
        A_tb <= "1011";
        B_tb <= "0101";
        Cin_tb <= '1';
        wait for 10 ns;
        assert Sum_tb = "0001" and Cout_tb = '1' report "Test case 2 failed" severity error;

        -- Test case 3
        A_tb <= "1111";
        B_tb <= "0000";
        Cin_tb <= '1';
        wait for 10 ns;
        assert Sum_tb = "0000" and Cout_tb = '1' report "Test case 3 failed" severity error;
        
        -- Test case 4
			A_tb <= "1001";
			B_tb <= "0010";
			Cin_tb <= '0';
			wait for 10 ns;
			assert Sum_tb = "1011" and Cout_tb = '0' report "Test case 4 failed" severity error;

        -- End simulation
        wait;
    end process;
end Behavioral;
