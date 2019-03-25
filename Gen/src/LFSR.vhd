library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity LFSR is
	port (
		C : in std_logic;
		RST: in std_logic;
		In_X : in unsigned(1 to 11);
		Out_X : out std_logic
	);
end LFSR;

architecture BEH of LFSR is
signal X : unsigned(1 to 11);
begin



	process (C,RST)
	begin
		if RST='1' then
			X <= In_X;
		elsif C'event and C='1' then
			X(1) <= not(X(9) xor X(11));
			X(2 to 11) <= X(1 to 10);
			Out_X <= X(11);
		end if;
	end process;
end BEH;