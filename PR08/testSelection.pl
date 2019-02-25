:- dynamic eats/2.
:- dynamic on_eriliik/2.

reset :- retractall(eats(_,_)), fail.
reset :- retractall(on_eriliik(_,_)), fail.
reset.

chain([A,B|Rest]) :- assertz(on_eriliik(B,A)), chain([B|Rest]).
chain([_]).

foodChain([A,B|Rest]) :- assertz(eats(A,B)), foodChain([B|Rest]).
foodChain([_]).


test:should_not_select_root :-
    write("Testing should_not_select_root"), nl,
    reset,
    chain([root, category1, species1]),
    chain([root, category2, species2]),
    chain([root, category2, species3]),
    foodChain([species1, species2]),
    find_most_sensitive_species(Species,_,_),
    !,
    (dif(Species, root) -> write("OK") ; write("FAIL")),
    nl,nl.

test:should_select_non_terminal_if_it_is_part_of_the_food_chain :-
    write("Testing should_select_non_terminal_if_it_is_part_of_the_food_chain"), nl,
    reset,
    chain([root, category1, species1]),
    chain([root, category2, species2]),
    chain([category2, species3]),
    foodChain([species1, category2]),

    assertSolution(category2, 3).

test:should_select_terminal_if_it_is_part_of_food_chain :-
    write("Testing should_select_terminal_if_it_is_part_of_food_chain"), nl,
    reset,
    chain([root, category1, species1]),
    chain([root, category2, species3]),
    chain([category1, species2]),
    chain([category2, species4]),
    foodChain([species1, species2, species3]),
    foodChain([species2, species4]),

    assertSolution(species2, 2).

test:example_from_post :-
    write("Testing example_from_post"), nl,
    reset,
    chain([elus, taim, kapsas]),
    chain([taim, voilill]),
    chain([elus, loom, hamster]),
    chain([loom, koduloom, kass]),
    chain([koduloom, koer]),
    foodChain([koer, kass, hamster, taim]),

    assertSolution(taim, 5).

assertSolution(Species, Count) :-
    find_most_sensitive_species(S, C, _),
    !,
    (
        Species = S,
        Count = C,
        write("OK"), nl, nl
        ;
        write("FAIL: EXPECTED Species,Count="), write(Species), write(","), write(Count), write(" --- WAS "), write(S), write(","), write(C), nl, nl
    ).

run_test :-
    test:should_not_select_root,
    test:should_select_non_terminal_if_it_is_part_of_the_food_chain,
    test:should_select_terminal_if_it_is_part_of_food_chain,
    test:example_from_post.