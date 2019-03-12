-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- UFPR, BCC, ci210 2013-2, autor: Roberto Hexsel, 03sep2016
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux2(a,b,s,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux2 is
  port(a,b : in  bit;                   -- entradas de dados
       s   : in  bit;                   -- entrada de selecao
       z   : out bit);                  -- saida
end mux2;

architecture estrut of mux2 is 

  -- declara componentes que sao instanciados
  component inv is
    port(A : in bit; S : out bit);
  end component inv;

  component nand2 is
    port(A,B : in bit; S : out bit);
  end component nand2;

  signal r, p, q : bit;              -- sinais internos
  
begin  -- compare ligacoes dos sinais com diagrama das portas logicas

  Ui:  inv   port map(s, r);
  Ua0: nand2 port map(a, r, p);
  Ua1: nand2 port map(b, s, q);
  Uor: nand2 port map(p, q, z);
    
end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux4(a,b,c,d,s0,s1,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux4 is
  port(a,b,c,d : in  bit;               -- quatro entradas de dados
       s0,s1   : in  bit;               -- dois sinais de selecao
       z       : out bit);              -- saida
end mux4;

architecture estrut of mux4 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  signal p,q : bit;                     -- sinais internos
begin

    	m1: mux2 port map (a, b, s0, q);
    	m2: mux2 port map (c, d, s0, p);
    	m3: mux2 port map (q, p, s1, z);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux8(a,b,c,d,e,f,g,h,s0,s1,s2,z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux8 is
  port(a,b,c,d,e,f,g,h : in  bit;       -- oito entradas de dados
       s0,s1,s2        : in  bit;       -- tres sinais de controle
       z               : out bit);      -- saida
end mux8;

architecture estrut of mux8 is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q : bit;                     -- sinais internos
  
begin
  
  	m11: mux4 port map (a, b, c, d, s0, s1, p);
	m22: mux4 port map (e, f, g, h, s0, s1, q);
	m33: mux2 port map (p, q, s2, z);

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- mux8vet(entr(7downto0),sel(2downto1),z)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity mux8vet is
  port(entr : in  reg8;                 -- vetor de 8 bits
       sel  : in  reg3;                 -- vetor de 3 bits
       z    : out bit);
end mux8vet;

architecture estrut of mux8vet is 

  component mux2 is
    port(A,B : in  bit; S : in  bit; Z : out bit);
  end component mux2;

  component mux4 is
    port(A,B,C,D : in  bit; S0,S1 : in  bit; Z : out bit);
  end component mux4;

  signal p,q : bit;
  
begin

  -- implemente usando dois mux4 e um mux2

  -- voce deve isolar os componentes dos vetores de bits porque os
  --   componentes mux2 e mux4 não usam vetores de bits nas suas entidades

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux2(a,s,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux2 is
  port(a   : in  bit;
       s   : in  bit;
       z,w : out bit);
end demux2;

architecture estrut of demux2 is

  	component inv is
		port(A : in bit; S : out bit);
	end component inv;	
	
	component nand2 is
		port(A,B : in bit; S : out bit);
	end component nand2;
  
  signal p, q, r : bit;             -- declare sinais internos, se precisar

begin
	
	ui: inv port map (s, r);	
	na0: nand2 port map(a, s, p);
	na1: nand2 port map(a, r, q);
	uii: inv port map (p, w);
	uiii: inv port map (q, z);
	   	

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux4(a,s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux4 is
  port(a       : in  bit;
       s0,s1   : in  bit;
       x,y,z,w : out bit);
end demux4;

architecture estrut of demux4 is

  -- declara componentes que sao instanciados

  signal p,q : bit;             -- declare sinais internos, se precisar

begin

  -- implemente com um demux2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- demux8(a,s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity demux8 is
  port(a               : in  bit;
       s0,s1,s2        : in  bit;
       p,q,r,s,t,u,v,w : out bit);
end demux8;

architecture estrut of demux8 is

  -- declara componentes que sao instanciados

  signal e,f : bit;             -- declare sinais internos, se precisar

begin

  -- implemente com um demux2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod2(s,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod2 is
  port(s   : in  bit;
       z,w : out bit);
end decod2;

architecture estrut of decod2 is

  component inv is
		port(A : in bit; B : out bit);
	end component inv;
  -- declara componentes que sao instanciados

  signal a,b : bit;             -- declare sinais internos, se precisar

begin
  inv0: inv	port map(s, w);
	z <= s;
  -- implemente com portas logicas
end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod4(s0,s1,x,y,z,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod4 is
  port(s0,s1   : in  bit;
       x,y,z,w : out bit);
end decod4;

architecture estrut of decod4 is
  component inv is
		port(A : in bit; B : out bit);
	end component inv;
  -- declara componentes que sao instanciados

  signal s0_n,s1_n : bit;             -- declare sinais internos, se precisar

begin

  inv0: inv port map(s0,s0_n);
  inv1: inv port map(s1,s1_n);
  x <= s0 AND s1;
  y <= s0 AND s1_n;
  z <= s0_n AND s1;
  w <= s0_n AND s1_n; 

  -- implemente com decod2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- decod8(s0,s1,s2,p,q,r,s,t,u,v,w)
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
use work.p_wires.all;

entity decod8 is
  port(s0,s1,s2        : in  bit;
       p,q,r,s,t,u,v,w : out bit);
end decod8;

architecture estrut of decod8 is
  component inv is
		port(A : in bit; B : out bit);
	end component inv;

  -- declara componentes que sao instanciados

  signal s0_n,s1_n, s2_n : bit;             -- declare sinais internos, se precisar

begin
  inv0: inv port map(s0,s0_n);
  inv1: inv port map(s1,s1_n);
  inv2: inv port map(s2,s2_n);
  p <= s0 AND s1 AND s2;
  q <= s0 AND s1 AND s2_n;
  r <= s0 AND s1_n AND s2;
  s <= s0 AND s1_n AND s2_n;
  t <= s0_n AND s1 AND s2;
  u <= s0_n AND s1 AND s2_n;
  v <= s0_n AND s1_n AND s2;
  w <= s2_n AND s1_n AND s2_n;
  
  -- implemente com decod2 e circuito(s) visto(s) nesta aula

end architecture estrut;
-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

