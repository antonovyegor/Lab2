library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all; 
use ieee.math_real.all;
entity RLA is
	port (
		C : in std_logic;
		RST: in std_logic;
		In_X : in unsigned(1 to 6);
		Out_Y : out unsigned(1 to 6)
	);
end RLA;

architecture BEH of RLA is
signal currX : Integer :=0;
signal Y : unsigned( 1 to 6 ) := "000000";
signal COUNTER : Integer :=0;
type MEM is array (1 to 8) of unsigned(1 to 6);
signal MemX : MEM := (others => "000000");
begin

	MEMORY : process (C,In_X)
	begin
		if C'event and C='1'  then
			MemX(COUNTER mod 8 + 1 )<= In_X;
			COUNTER<=COUNTER+1;
		end if;
	end process;

	SUM: process (C)
	begin  
		if C'event and C='1'  then 
		Y <= conv_unsigned(
		conv_integer(Y)+
		(
		conv_integer(MemX(1))+
		conv_integer(MemX(2))+
		conv_integer(MemX(3))+
		conv_integer(MemX(4))+
		conv_integer(MemX(5))+
		conv_integer(MemX(6))+
		conv_integer(MemX(7))+
		conv_integer(MemX(8))
		) / 8 
		, 6
		) ;

		end if;
	end process;

	Out_Y<=Y;

end BEH;