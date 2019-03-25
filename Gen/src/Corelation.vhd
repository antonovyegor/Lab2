library IEEE;
use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all; 
use ieee.math_real.all;



entity Corelation is 
	port(							
		C : in std_logic;
		In_X : in unsigned( 1 to 6 )  
		);
end Corelation;

architecture BEH of Corelation is 
signal N: integer := 128 ;	
 signal k: integer := N/2;
subtype X is integer range 0 to 63;
type MEMn is array (0 to N-1) of X;
type MEMk is array (0 to k-1) of real;
 signal MemX : MEMn := (others => 1); 
 signal MemCor : MEMk := (others => 0.0); 
 signal COUNT : integer:=0;	
 
begin 
	Write_to_Mem: process (C) 
	begin 
		if C'event and C='1' then
			if COUNT < N and In_X/=0	then
			MemX(COUNT) <= conv_integer(In_X);
			COUNT<=COUNT+1;
			end if;
		end if;
		end process;
	 calc : process (COUNT)
	 variable sum : integer:=0;	   
	 variable del : real:=0.0;
	 begin	 
		 if COUNT = N	then
			 for I in 0 to k-1 loop	
				 sum:=0;
				 for j in 0 to N - I -1 loop
					 sum:= sum + MemX(j)* MemX(i+j);
				 end loop;
			 	 del:=real(real(sum)/ real((N-i)));
				 MemCor(i)<=del;
			 end loop;
		  end if;
		 end process;
end BEH;

