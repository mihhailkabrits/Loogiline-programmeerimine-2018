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
%-----------------------------------

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

is_a('Ametnikud', 'Klienditeenindajad').
is_a('Klienditeenindajad', 'Kliendinoustajad').
is_a('Kliendinoustajad', 'reisikonsultant').
is_a('Kliendinoustajad', 'reisikorraldaja').

is_a('Ametnikud', 'Lihtametnikud ja arvutiametnikud').
is_a('Lihtametnikud ja arvutiametnikud', 'Yldsekretarid').
is_a('Yldsekretarid', 'trykisekretar').
is_a('Yldsekretarid', 'yldsekretar').

is_a('Tippspetsialistid', 'Loodus- ja tehnikateaduste tippspetsialistid').
is_a('Loodus- ja tehnikateaduste tippspetsialistid', 'Elektrotehnikainsenerid').
is_a('Elektrotehnikainsenerid', 'elektroonikainsener').
is_a('Elektrotehnikainsenerid', 'arvuti riistvara insener').
is_a('Elektrotehnikainsenerid', 'pooljuhtide insener').

is_a('Tippspetsialistid', 'Tervishoiu tippspetsialistid').
is_a('Tervishoiu tippspetsialistid', 'Arstid').
is_a('Arstid', 'kooliarst').
is_a('Arstid', 'perearst').
is_a('Arstid', 'yldarst').

is_a(linda,'reisikonsultant').
is_a(viivi,'reisikorraldaja').
is_a(agne,'trykisekretar').
is_a(katlin,'yldsekretar').
is_a(jenni,'elektroonikainsener').

is_a(joosep, 'arvuti riistvara insener').
is_a(tom, 'pooljuhtide insener').
is_a(uku, 'perearst').
is_a(teet, 'perearst').
is_a(fred, 'yldarst').
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
%
%-----------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------------
%-//--------------------------------------------------------------------------------------------------
alamklass(Who, Whose):-is_a(Who, Whose).
alamklass(Who, Whose):-is_a(Who,X), alamklass(X,Whose).




occupation(Who, Relative, O):- (Relative = mother;Relative=father;Relative=brother; Relative=grandfather;Relative=grandmother;
Relative=uncle;  Relative=aunt; Relative=sister)
->Term=..[Relative,Who,Role],Term
,(female(Role); male(Role)),is_a(Role,O). 
                 
who_is(O,Who):- (female(Who); male(Who)), alamklass(Who,O).
who_is(O,Who):-(female(Who); male(Who)), alamklass(O,X), alamklass(Who,X).

