on_eriliik(s,d).
on_eriliik(t,d).
on_eriliik(s1,s).
on_eriliik(s2,s).
on_eriliik(s11,s1).
on_eriliik(s12,s1).
on_eriliik(s21,s2).
on_eriliik(s22,s2).
on_eriliik(t1,t).
on_eriliik(t2,t).
on_eriliik(t21,t2).
on_eriliik(t22,t2).

% eats(Kes,Keda).
eats(t1,t2).
eats(s2,t1).
eats(s1,s2).

subclass(Sub, Super) :-
    on_eriliik(Sub, Super).
subclass(Sub, Super) :-
    on_eriliik(Sub, V),
    subclass(V, Super).
	
is_terminal(X) :-
    not(on_eriliik(_, X)).

get_terminal_nodes(Node, Node) :-
    is_terminal(Node),!.
get_terminal_nodes(Node, Terminal) :-
    subclass(Terminal, Node), 
    is_terminal(Terminal).
	
	
dies(Eater, Eatee) :- 
    eats(Eater, Eatee).
dies(Eater, Eatee) :-
    eats(Eater, Intermediate),
	dies(Intermediate, Eatee).
	
count_terminals(Node, Terminals, Count):- findall(X, get_terminal_nodes(Node,X), Terminals), length(Terminals, Count).
	
extinction(Who, What_species, How_many) :-
    eats(_,Who),
    findall(X, dies(X, Who), Who_die),
    append(Who_die, [Who], Node_pass),
    get_term(Node_pass, Terminal_Nodes),
    flatten(Terminal_Nodes, What_species),
    length(What_species, How_many).

get_term([], []).
get_term([Head|Tail], [Head_Output|Tail_Output]) :- 
    findall(Terminal, get_terminal_nodes(Head, Terminal), Head_Output),
    get_term(Tail, Tail_Output).	

max_accumulator(X,Y,Z) :-
    extinction(Who, What_species, How_many) :-
    eats(_,Who),
    largest(Max_who, Max_what_species, Max_how_many),
    How_many > Max_how_many,
    retract(largest(Max_who, Max_what_species, Max_how_many)),
    assert(largest(Who, What_species, How_many)),
    fail.
max_accumulator.

find_most_sensitive_species(Species, Extinct_no, Extinct) :-
    extinction(Any_species, Any_extinct, Any_extinct_no), !,
    assert(largest(Any_species, Any_extinct, Any_extinct_no)),
    max_accumulator,
    largest(Species, Extinct, Extinct_no),
    retractall(largest(_)).
	