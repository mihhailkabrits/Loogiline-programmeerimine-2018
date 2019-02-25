/*married(linda,joosep).
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
mother(sten, liisi).*/
mother(nadezda, ljudmila).
mother(evgenia, nadezda).
mother(tanja, evgenia).
mother(igor, evgenia).
mother(elena, evgenia).
mother(roman, elena).
mother(juri, elena).
mother(natali, elena).

married(evgenia, vladimir).
married(elena, eduard).
married(nadezda, vasili).
married(ljudmila, aleksei).

female(evgenia).
female(elena).
female(tanja).
female(natali).
female(nadezda).
female(ljudmila).
male(aleksei).
male(vasili).
male(vladimir).
male(eduard).
male(igor).
male(roman).
male(juri).

/*female(linda).
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
male(sten).*/


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
%-------------------------1-koik esivanemad----------------------------------------------------------------------------------------------------------------------
ancestor(Child,Parent):- mother(Child, Parent); mother(Child,Mother),married(Mother,Parent), male(Parent),female(Mother).
ancestor(Child,Parent):- mother(Child, Mother),ancestor(Mother,Parent).
%---------------------------------------2---male esivanemad --------------------------------
male_ancestor(Me, Vanem) :-
	father(Me, Vanem),
	male(Vanem).
male_ancestor(Me, Vanem) :-
	father(Me, Father),
	male(Vanem),
	male_ancestor(Father, Vanem);
	mother(Me, Mother),
	male(Vanem),
	male_ancestor(Mother, Vanem).

/*male_ancestor(C, G) :- father(C, G).
male_ancestor(C, G) :-
father(C, Father),
male_ancestor(Father, G), male(Father).*/
%---------------------------------------3---------female esivanemad-------------------------------------

female_ancestor(Child, Parent) :- mother(Child, Parent).
female_ancestor(Child, Parent):- 
     mother(Child, Mother), 
     female_ancestor(Mother, Parent).
     
%-------------------------------------4--ei kolba!!!!------------
ancestor1(X, Y, 1):- father(X,Y); mother(X, Y).
ancestor1(X, Y, N1):- (father(X, Z); mother(X, Z)), ancestor1(Z, Y, N2), N1 is N2+1.
/*
ancestor1(X, Y, 1):-mother(X,Y),!.
ancestor1(X, Y, N):-
                mother(X, Z),
                N1 = N - 1,
                N1 > 0, 
                ancestor1(Z, Y, N1).*/

%-------------------------------5---------?- ancestor2(Child, Parent, X).--------
ancestor2(Child, Parent, X) :-
	findall(Parent_child, (father(Parent_child, Parent); mother(Parent_child, Parent)), List),
	list_Length(List, X1),
	write(X1),
	X < X1,
        (male_ancestor(Child, Parent);
	female_ancestor(Child, Parent)).
list_Length([],0).
list_Length([_|X],N) :-
    list_Length(X,N1),
    N is N1+1.
/*
ancestor2(Child,Parent,N):-
      N>0, ancestor(Child,FirstParent,N),female_ancestor(FirstParent,Parent);
       N>0, ancestor(Child,FirstParent,N),male_ancestor(FirstParent,Parent).*/
%female_ancestor(Child, Parent) :- mother(Child, Parent).
%female_ancestor(Child, Parent):- mother(Child, Mother), female_ancestor(Mother, Parent).


/*ancestor1(Child,Parent,1):-
   mother(Child, Parent); mother(Child,Mother),married(Mother,Parent), male(Parent),female(Mother).
ancestor1(Child,Parent,N):-
       N>=1, Nv is N-1,mother(Child, Mother),ancestor1(Mother,Parent, Nv).*/

%male_ancestor(Child, Parent):- mother(Child,Mother),married(Mother,Parent), male(Parent),female(Mother).
%male_ancestor(Child, Parent):- mother(Child,Mother),male_ancestor(Mother, Parent).



%ancestor2(Child,Parent,0):- female_ancestor(Child,Parent);male_ancestor(Child,Parent).
%ancestor2(Child,Parent,N):-N>0, ancestor(Child,FirstParent,N),(female_ancestor(FirstParent,Parent);male_ancestor(FirstParent,Parent)).

%count(Parent,Count):-
%    female(Parent),aggregate_all(count, mother(X,Parent),Count); male(Parent),married(Mother,Parent),aggregate_all(count, mother(X,Mother),Count).
%ancestor2(Child,Parent,N):-(female_ancestor(Child,Parent);male_ancestor(Child,Parent)),count(Parent,Count), N<Count.

%ancestor2(Child,Parent,N):-N>0, ancestor(Child,FirstParent,N),female_ancestor(FirstParent,Parent); N>0, ancestor(Child,FirstParent,N),male_ancestor(FirstParent,Parent).