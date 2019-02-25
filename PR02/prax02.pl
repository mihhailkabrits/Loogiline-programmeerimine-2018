married(linda,joosep).
married(viivi,tom).
married(agne,uku).
married(katlin,teet).
married(jenni, fred).
married(liisi, alo).
married(aigi, leo).
married(kati, aare).
married(laura, leho).
married(stiina, sten).

mother(tom, linda).
mother(agne, linda).
mother(katlin, viivi).
mother(jenni, agne).
mother(alo, agne).
mother(leo, katlin).
mother(aare, jenni).
mother(laura, jenni).
mother(sten, liisi).


female(linda).
female(viivi).
female(agne).
female(katlin).
female(jenni).
female(liisi).
female(aigi).
female(kati).
female(laura).
female(stiina).

male(joosep).
male(tom).
male(uku).
male(teet).
male(fred).
male(alo).
male(leo).
male(aare).
male(leho).
male(sten).


%ema_lapsed(Mina).
%------------vend
%mother(Mina, EmaNimi).


brother(Mina, VennaNimi):-
	mother(Mina, EmaNimi), mother(VennaNimi, EmaNimi), male(VennaNimi), Mina\=VennaNimi.
%----------------isa
father(Mina, IsaNimi):-
	mother(Mina,EmaNimi),married(EmaNimi, IsaNimi), male(IsaNimi).
%--------------sisiter
sister(Mina, OdeNimi):-
	mother(Mina, EmaNimi), mother(OdeNimi, EmaNimi), female(OdeNimi), Mina\=OdeNimi.
%----------tadi----
aunt(Mina,TadiNimi):-
  mother(Mina,EmaNimi), father(Mina, IsaNimi), (sister(EmaNimi, TadiNimi); sister(IsaNimi, TadiNimi)), female(TadiNimi).
%---------------uncle--
uncle(Mina,OnuNimi):-
	mother(Mina,EmaNimi), father(Mina, IsaNimi),(brother(EmaNimi, OnuNimi); brother(IsaNimi, OnuNimi)), male(OnuNimi).
%-----------vanaisa--
grandfather(Mina,V_isa):-
	(father(EmaNimi, V_isa);father(IsaNimi, V_isa)), mother(Mina, EmaNimi), father(Mina, IsaNimi), male(V_isa).
%----------------vanaema
grandmother(Mina, V_ema):-
	(mother(EmaNimi, V_ema);mother(IsaNimi, V_ema)), mother(Mina, EmaNimi), father(Mina, IsaNimi), female(V_ema).
	/*
mother(Mina, EmaNimi).
married(EmaNimi, IsaNimi).

ema_lapsed(Mina):-
mother(Mina, EmaNimi),
mother(Mother, Teine_laps), Teine_laps \= Mina, write (Teine_laps),
fail.

ema_lapsed(_):-
	write('minu emal ei ole rohkem lapsi').

father(Child,Father):-
mother(Child, Mother),
married(Mother, Father),
male(Father)...
%
*/
