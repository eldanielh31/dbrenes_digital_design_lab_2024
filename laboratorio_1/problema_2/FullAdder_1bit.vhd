-- FullAdder_1bit.vhd
library ieee;
use ieee.std_logic_1164.all;

entity FullAdder_1bit is
    Port (
        A, B, Cin : in  std_logic;
        Sum, Cout : out std_logic
    );
end FullAdder_1bit;

architecture Behavioral of FullAdder_1bit is
begin
    Sum <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end Behavioral;
