LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL;
USE ieee.numeric_std.ALL;
use work.parameters.all;

package types is
subtype byte is std_logic_vector(7 downto 0);
type byte_vector is array (integer range <>) of byte;
type reel is array (reel_type_bit_size-1 downto 0) of std_logic;
type vector is array(natural range <>) of reel;
type matrix is array(natural range <>, natural range <>) of reel;
subtype word is std_logic_vector(15 downto 0);
type word_vector is array (integer range <>) of word;
-- Type Conversion Functions
--function std_logic_vector2byte(a : std_logic_vector(7 downto 0)) return byte;
--function byte2std_logic_vector(a : byte) return std_logic_vector;
function std_logic_vector2byte_vector(a : std_logic_vector) return byte_vector;
function byte_vector2std_logic_vector(a : byte_vector) return std_logic_vector;
function std_logic_vector2reel(a : std_logic_vector(reel_type_bit_size-1 downto 0)) return reel;
function reel2std_logic_vector(a : reel) return std_logic_vector;

-- Functions for Zero, One and HiZ assignments
function Zeros(a : integer) return std_logic_vector;
function Ones(a : integer) return std_logic_vector;
function HiZ(a : integer) return std_logic_vector;
--function HiZM(size_row, size_col : integer) return matrix;

--Functions for Operator Overloading
function "+"(a, b : reel) return reel;

end types;

package body types is
-- Type Conversion Functions
--function std_logic_vector2byte(a : std_logic_vector(7 downto 0)) return byte is
--variable x : byte;
--begin
--for cntr in 7 downto 0 loop
--	x(cntr) := a(cntr);
--end loop;
--return x; end std_logic_vector2byte;
 
--function byte2std_logic_vector(a : byte) return std_logic_vector is
--variable x : std_logic_vector(7 downto 0);
--begin
--for cntr in 7 downto 0 loop
--	x(cntr) := a(cntr);
--end loop;
--return x; end byte2std_logic_vector;

function std_logic_vector2reel(a : std_logic_vector(reel_type_bit_size-1 downto 0)) return reel is
variable x : reel;
begin
for cntr in reel_type_bit_size-1 downto 0 loop
	x(cntr) := a(cntr);
end loop;
return x; end std_logic_vector2reel;

function reel2std_logic_vector(a : reel) return std_logic_vector is
variable x : std_logic_vector(reel_type_bit_size-1 downto 0);
begin
for cntr in reel_type_bit_size-1 downto 0 loop
	x(cntr) := a(cntr);
end loop;
return x; end reel2std_logic_vector;

function std_logic_vector2byte_vector(a : std_logic_vector) return byte_vector is
variable x : byte_vector ((a'length/8) - 1 downto 0);
begin
for cntr in (a'length/8) - 1 downto 0 loop
	x(cntr) := a((cntr+1)*8-1 downto cntr * 8);
end loop;
return x; end std_logic_vector2byte_vector;

function byte_vector2std_logic_vector(a : byte_vector) return std_logic_vector is
variable x : std_logic_vector(a'length*8 - 1 downto 0);
begin
for cntr in a'length - 1  downto 0 loop
	x((cntr+1)*8-1 downto cntr * 8) := a(cntr);
end loop;
return x; end byte_vector2std_logic_vector;


-- Functions for Zero, One and HiZ assignments
function Zeros(a : integer) return std_logic_vector is
variable x : std_logic_vector (a-1 downto 0);
begin
for cntr in a-1 downto 0 loop
	x(cntr) := '0';
end loop;
return x; end Zeros;

function Ones(a : integer) return std_logic_vector is
variable x : std_logic_vector (a-1 downto 0);
begin
for cntr in a-1 downto 0 loop
	x(cntr) := '1';
end loop;
return x; end Ones;

function HiZ(a : integer) return std_logic_vector is
variable x : std_logic_vector (a-1 downto 0);
begin
for cntr in a-1 downto 0 loop
	x(cntr) := 'Z';
end loop;
return x; end HiZ;

--function HiZM(row_size, col_size : integer) return matrix is
--variable x : matrix (row_size-1 downto 0, col_size-1 downto 0);
--begin
--for cntrow in row_size-1 downto 0 loop
--	for cntcol in col_size-1 downto 0 loop
--		x(cntrow, cntcol) := std_logic_vector2reel(HiZ(reel_type_bit_size));
--	end loop;
--end loop;
--return x; end HiZM;

----Functions for Operator Overloading
function "+"(a, b : reel) return reel is
variable ret : reel;
variable ar, br, ai, bi : std_logic_vector((reel_type_bit_size/2)-1 downto 0);
variable temp : std_logic_vector(reel_type_bit_size/2 downto 0);
variable x : std_logic_vector(reel_type_bit_size-1 downto 0);
begin	
	for cntr in 0 to (reel_type_bit_size/2)-1 loop
		ar(cntr) := a(cntr + reel_type_bit_size/2); ai(cntr) := a(cntr);
		br(cntr) := b(cntr + reel_type_bit_size/2); bi(cntr) := b(cntr);
	end loop;
	temp := ('0'&ai) + ('0'&bi);
	if temp(32) = '1' then
		x(reel_type_bit_size-1 downto reel_type_bit_size/2) := ar + br + '1';
	else
		x(reel_type_bit_size-1 downto reel_type_bit_size/2) := ar + br;
	end if;
	x((reel_type_bit_size/2)-1 downto 0) := ai + bi;	
	ret := std_logic_vector2reel(x);
return ret; end function;

end package body types;
