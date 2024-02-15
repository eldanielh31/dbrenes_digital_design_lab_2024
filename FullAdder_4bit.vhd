-- FullAdder_4bit.vhd
library ieee;
use ieee.std_logic_1164.all;

entity FullAdder_4bit is
    Port (
        A, B : in  std_logic_vector(3 downto 0);
        Cin : in  std_logic;
        Sum : out std_logic_vector(3 downto 0);
        Cout : out std_logic
    );
end FullAdder_4bit;

architecture Behavioral of FullAdder_4bit is
    component FullAdder_1bit is
        Port (
            A, B, Cin : in  std_logic;
            Sum, Cout : out std_logic
        );
    end component;
    
    signal Carry : std_logic_vector(3 downto 0);
begin
    FA0: FullAdder_1bit port map(A(0), B(0), Cin, Sum(0), Carry(0));
    FA1: FullAdder_1bit port map(A(1), B(1), Carry(0), Sum(1), Carry(1));
    FA2: FullAdder_1bit port map(A(2), B(2), Carry(1), Sum(2), Carry(2));
    FA3: FullAdder_1bit port map(A(3), B(3), Carry(2), Sum(3), Cout);
end Behavioral;
