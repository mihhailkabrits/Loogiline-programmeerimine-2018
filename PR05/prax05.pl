
viimane_element(X,[X]).
viimane_element(X,[_|Z]):- viimane_element(X,Z).


suurim([],[]).
suurim([X],[X]).
suurim([Head,X|Hvost],[Y|Hvost1]):- Head > X, Y is Head, suurim([X|Hvost],Hvost1).
suurim([Head,X|Hvost],[Y|Hvost1]):-Head =< X, Y is X, suurim([X|Hvost],Hvost1).





paki([],[]).
paki([X],[X]).
paki([Head,X|Hvost],[Y|Hvost1]):-Head\= X, Y=Head, paki([X|Hvost],Hvost1).
paki([Head,X|Hvost],Hvost1):-Head == X, paki([X|Hvost],Hvost1).


duplikeeri([],[]).
duplikeeri([Head|Hvost],[Head,Head|Hvost1]):- duplikeeri(Hvost,Hvost1).

kordista(List1,X,List2):- integer(X),X>=0,kordista(List1,X,List2,X).
kordista([],_,[],_).
kordista([_|Hvost],Count,List2,Stack):-Stack=<0, kordista(Hvost,Count,List2,Count).
kordista([Head|Hvost],Count,[Head|List2],Stack):- Stack>0, Stack1=Stack-1,
				kordista([Head|Hvost],Count,List2,Stack1).
				
				
vordle_predikaadiga([],_,[]).
vordle_predikaadiga([Head|Hvost],[F,Z],[Head|Hvost1]):-F==suurem_kui->integer(Z),suurem_kui(Head,Z), 
						vordle_predikaadiga(Hvost,[F,Z],Hvost1).

vordle_predikaadiga([Head|Hvost],[F,Z],Hvost1):-F==suurem_kui->integer(Z), \+suurem_kui(Head,Z),
						vordle_predikaadiga(Hvost,[F,Z],Hvost1).

vordle_predikaadiga([Head|Hvost],[F],[Head1|Hvost2]):-F==paaritu_arv-> 
 paaritu_arv(Head), Head1=Head,vordle_predikaadiga(Hvost,[F],Hvost2).
vordle_predikaadiga([Head|Hvost],[F],List2):-F==paaritu_arv-> 
 \+paaritu_arv(Head),vordle_predikaadiga(Hvost,[F],List2).
 
 


vordle_predikaadiga([Head|Hvost],[F],[Head1|Hvost2]):-F==paaris_arv-> 
 paaris_arv(Head), Head1=Head,vordle_predikaadiga(Hvost,[F],Hvost2).
vordle_predikaadiga([Head|Hvost],[F],List2):-F==paaris_arv-> 
 \+paaris_arv(Head),vordle_predikaadiga(Hvost,[F],List2).
 
suurem_kui(X,Y):- X > Y.
paaritu_arv(Head):-  Head mod 2 =:= 1.
paaris_arv(Head):-Head mod 2 =:= 0.