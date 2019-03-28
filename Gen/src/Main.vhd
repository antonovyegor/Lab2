library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;

entity Main is
	port (
	C : in std_logic;
	Start_X : in unsigned ( 1 to 11 );
	RST : in std_logic
	);
end entity;


architecture BEH of Main is
   signal lfsrX : unsigned ( 1 to 6 );
   signal Y : unsigned (1 to 6);
   component LFSR is
	   port (C : in std_logic;
			In_X : in unsigned(1 to 11);
			Out_X : out std_logic   );
   end component;

   component RLA is
	port (
		C : in std_logic;
		In_X : in unsigned(1 to 6);
		Out_Y : out unsigned(1 to 6)
	);
   end component	;

   	component P is
	port(
	C: in std_logic;
	In_X : in unsigned( 1 to 6)
	);
	end component;

   	component Corelation is
	port(
		C : in std_logic;
		In_X : in unsigned( 1 to 6 )
		);
end component;
begin
	U1: LFSR port map (C =>C,In_X => Start_X, Out_X => lfsrX(1));
	U2: LFSR port map (C =>C,In_X => Start_X, Out_X => lfsrX(2));
	U3: LFSR port map (C =>C, In_X => Start_X, Out_X => lfsrX(3));
	U4: LFSR port map (C =>C, In_X => Start_X, Out_X => lfsrX(4));
	U5: LFSR port map (C =>C, In_X => Start_X, Out_X => lfsrX(5));
	U6: LFSR port map (C =>C, In_X => Start_X, Out_X => lfsrX(6));

	RLA1: RLA port map(C=>C, In_X=>lfsrX, Out_Y=>Y);

	M: P port map (C=>C,In_X=>Y);

	Cor: Corelation port map(C=>C, In_X => Y);
end BEH;