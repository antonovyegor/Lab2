library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity P is
	port(
	C: in std_logic;
	  In_X : in unsigned( 1 to 6)
	);
end P;

architecture BEH of P is
type MEMint is array (0 to 63) of integer;
type MEMreal is array (0 to 63) of real;
signal MemM : MEMint := (others => 0);
signal MemP : MEMreal := (others => 0.0);
signal N : integer := 0;
begin
	M: process(C)
	begin
		if C'event and C='1' then
			if (N<128) then
			MemM(conv_integer(In_X))<= MemM(conv_integer(In_X))  +  1;
			N<=N+1;
			end if;
		end if;
	end process;

	P : process(C)
	begin
		if N=64 then
			for i in 0 to 63   loop
				MemP(i)<= real(real(MemM(i))/ 128.0);
			end loop;

		end if;
		end process;
	end BEH;