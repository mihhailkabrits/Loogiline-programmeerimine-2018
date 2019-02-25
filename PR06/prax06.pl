% Lists and rekursioon

member(X,[X|T]).
member(X,[Z|H]):-
    member(X,H).
	
%1 Hulkade ühisosa. Hulkade A ning B ühisosa tähistatakse kirjutisega A ∩ B. A ∩ B = { x | x ∈ A ja x ∈ B }.
 yhisosa([], _, []).

 yhisosa([H1|T1], L2, [H1|Res]) :-					%yhisosa([1,2,3], [1,2,4,6],X).
    member(H1, L2),
     yhisosa(T1, L2, Res).
	 
 yhisosa([_|T1], L2, Res) :-
     yhisosa(T1, L2, Res).
	 
%2 Hulkade ühend. Hulkade A ning B ühendit tähistatakse kirjutisega A ∪ B. A ∪ B = { x | x ∈ A või x ∈ B }.
yhend([],S2,S2).										%yhend([1,2,3], [1,2,4,6],X).
yhend([H|T],S2,S):- member(H,S2) , yhend(T,S2,S).
yhend([H|T],S2,[H|S]):- yhend(T,S2,S).

%3 Hulkade vahe. Hulkade A ning B vahe tähistatakse kirjutisega A – B. A - B = { x | x ∈ A ja x ∉ B }.
vahe([],_,[]).											%vahe([1,2,3], [1,2,4,6],X).
vahe([H|T],S2,S):- member(H,S2),vahe(T,S2,S).
vahe([H|T],S2,[H|S]):- vahe(T,S2,S).

%4 Hulkade ristkorrutis A × B = { (x,y) | x ∈ A ja y ∈ B }
ristkorrutis([],_,[]).								%ristkorrutis([1,2,3], [1,2,4,6],X).
		ristkorrutis([H1|T1],L2,R):- setin(H1,L2,R1),ristkorrutis(T1,L2,R2),append(R1,R2,R).

		setin(X,[],[]).
		setin(X,[H|T],[[X,H]|R]):- setin(X,T,R).

append([], A, A).
append([A|B], C, [A|D]) :-
    append(B, C, D).		