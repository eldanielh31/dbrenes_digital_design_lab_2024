library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Main_FullAdder is
    Port (
        -- Entradas desde los switches
        Switches : in  std_logic_vector(7 downto 0);
        -- Salida hacia el display de 7 segmentos
        Segments : out std_logic_vector(6 downto 0);
        -- Salida hacia el LED
        LED : out std_logic
    );
end Main_FullAdder;

architecture Behavioral of Main_FullAdder is
    signal A, B : std_logic_vector(3 downto 0);
    signal Cin : std_logic;
    signal Sum : std_logic_vector(3 downto 0);
    signal Cout : std_logic;
    signal Result_Hex : std_logic_vector(6 downto 0); -- Cambiado a 7 bits para acomodar hasta 30
    
    component FullAdder_4bit is
        Port (
            A, B : in  std_logic_vector(3 downto 0);
            Cin : in  std_logic;
            Sum : out std_logic_vector(3 downto 0);
            Cout : out std_logic
        );
    end component;

begin
    -- Mapeo de los switches a las entradas A y B
    A <= Switches(3 downto 0);
    B <= Switches(7 downto 4);
    Cin <= Switches(0); -- Se asigna el primer switch como entrada de Cin
    
    -- Instanciación del sumador completo de 4 bits
    FA: FullAdder_4bit port map(A, B, Cin, Sum, Cout);
    
    -- Conversión del resultado a hexadecimal para mostrar en los displays de 7 segmentos
    process(Sum)
    begin
       case Sum is
            when "0000" =>
                Result_Hex <= "1000000"; -- 0 en hexadecimal
            when "0001" =>
                Result_Hex <= "1111001"; -- 1 en hexadecimal
            when "0010" =>
                Result_Hex <= "0100100"; -- 2 en hexadecimal
            when "0011" =>
                Result_Hex <= "0110000"; -- 3 en hexadecimal
            when "0100" =>
                Result_Hex <= "0011001"; -- 4 en hexadecimal
            when "0101" =>
                Result_Hex <= "0010010"; -- 5 en hexadecimal
            when "0110" =>
                Result_Hex <= "0000010"; -- 6 en hexadecimal
            when "0111" =>
                Result_Hex <= "1111000"; -- 7 en hexadecimal
            when "1000" =>
                Result_Hex <= "0000000"; -- 8 en hexadecimal
            when "1001" =>
                Result_Hex <= "0010000"; -- 9 en hexadecimal
            when "1010" =>
                Result_Hex <= "0001000"; -- A en hexadecimal
            when "1011" =>
                Result_Hex <= "0000011"; -- B en hexadecimal
            when "1100" =>
                Result_Hex <= "1000110"; -- C en hexadecimal
            when "1101" =>
                Result_Hex <= "0100001"; -- D en hexadecimal
            when "1110" =>
                Result_Hex <= "0000110"; -- E en hexadecimal
            when "1111" =>
                Result_Hex <= "0001110"; -- F en hexadecimal
            when others =>
                Result_Hex <= "1111111"; -- Si el resultado no es un número hexadecimal válido
        end case;
           
    end process;

    -- Mapeo del resultado hexadecimal a los displays de 7 segmentos
    Segments <= Result_Hex;

    -- Encendido o apagado del LED según el valor de Cout
    LED <= Cout;

end Behavioral;
