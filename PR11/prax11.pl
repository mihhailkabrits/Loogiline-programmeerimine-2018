%:- module(iapb184834kabe,[iapb184834/3]).

iapb184834(MyColour, X, Y):-
    (X = 0, Y = 0),						%if null null, we pick player
    leia_Derection(MyColour,Derection),
    tee_kaik(A,B,MyColour,Derection),			%walking
    kaigu_variandid(A,B,Derection,X1,Y1),!;	% watching our colour and derection
    (X =\= 0, Y =\= 0),
    ruut(X,Y, Color),
    leia_Derection(Color,Derection),
    votmine(X,Y,Derection,X1,Y1),!.
 
iapb184834(_,_,_).

tee_kaik(X,Y,Color, Derection):-			% Colour = 1 or 2
    TammiVarv is Color * 10,			% dam walk = 0=empty *10white 20black 1=white 2=black
    ruut(X, Y, TammiVarv),				% finding x y for our color
    kas_saab_votta_tamm(X,Y,X1,Y1,X2,Y2),!.
tee_kaik(X,Y,Color, Derection):-			% simple walk
    ruut(X, Y, Color),
    kas_saab_votta(X,Y,Derection,X1,Y1,X2,Y2),!.
tee_kaik(X,Y,Color, Derection):-
    TammiVarv is Color * 10,			% dam walk
    ruut(X, Y, TammiVarv),
    kas_tamm_saab_kaia(X,Y,X1,Y1),!.
tee_kaik(X,Y,Color, Derection) :-			% simple walk
    ruut(X, Y, Color),
    kas_naaber_vaba(X,Y,Derection,X1,Y1),!.    
 
leia_Derection(1,1):-!.
leia_Derection(10,1):-!.
leia_Derection(20,1):-!.
leia_Derection(2,-1). 
%=======================================
kaigu_variandid(X,Y,Derection,X1,Y1):-
    votmine(X,Y,Derection,X1,Y1),!.
kaigu_variandid(X,Y,Derection,X1,Y1):-
    kaimine(X,Y,Derection,X1,Y1),!.    
%=======================================
votmine(X,Y,Derection,X1,Y1):-
    ruut(X, Y, Color),
    (
        (Color = 10; Color = 20),kas_saab_votta_tamm(X,Y,X1,Y1,X2,Y2);
        (Color = 1; Color = 2),kas_saab_votta(X,Y,Derection,X1,Y1,X2,Y2)
    ),
    vota(X,Y,Derection,X1,Y1,X2,Y2),!.
 
vota(X,Y,Derection,X1,Y1,X2,Y2):-
    ruut(X,Y, MyColouror),
    retract(ruut(X, Y, _)),					% taking
    assert(ruut(X, Y, 0)),					% making empty
    retract(ruut(X1, Y1, _)),				% taking
    assert(ruut(X1,Y1, 0)),					% making empty
    retract(ruut(X2, Y2, 0)),				% taking empty iz togo kuda hodim
    ( 
	    (MyColouror = 1, X2 = 8),   			% if is dam white
         assert(ruut(X2, Y2, 10)),!;		% set dam
          (MyColouror = 2, X2 = 1),			% if is dam black
          assert(ruut(X2, Y2, 20)),!;  		
          assert(ruut(X2, Y2, MyColouror))	% set dam
	).
%=======================================
field_validation(X,Y) :-
    X >= 1, X =< 8,Y >= 1, Y =< 8.
      
kas_saab_votta_tamm(X,Y,X1,Y1,X2,Y2):-
    kas_saab_vota_uleval_paremal(X,Y,X1,Y1,X2,Y2,1), !.
kas_saab_votta_tamm(X,Y,X1,Y1,X2,Y2):-
    kas_saab_vota_uleval_vasakul(X,Y,X1,Y1,X2,Y2,1), !.
kas_saab_votta_tamm(X,Y,X1,Y1,X2,Y2):-
    kas_saab_vota_alla_paremal(X,Y,X1,Y1,X2,Y2,1), !.
kas_saab_votta_tamm(X,Y,X1,Y1,X2,Y2):-
    kas_saab_vota_alla_vasakul(X,Y,X1,Y1,X2,Y2,1), !.
      
kas_ruut_on_vaba_uleval_paremal(X,Y,Counter):-
    X1 is X + Counter,Y1 is Y + Counter,ruut(X1,Y1,0).		% check if it empty 
kas_ruut_on_vaba_uleval_vasakul(X,Y,Counter):-
    X1 is X - Counter,Y1 is Y + Counter,ruut(X1,Y1,0).		% check if it empty
kas_ruut_on_vaba_alla_paremal(X,Y,Counter):-				
    X1 is X + Counter,Y1 is Y - Counter,ruut(X1,Y1,0).
kas_ruut_on_vaba_alla_vasakul(X,Y,Counter):-				% check if it empty
    X1 is X - Counter,Y1 is Y - Counter,ruut(X1,Y1,0).     	
	  
kas_saab_vota_uleval_paremal(X,Y,X1,Y1,X2,Y2, Counter):-  	% x,y came   
    X1 is X + Counter,
    Y1 is Y + Counter,
    X2 is X1 + 1,
    Y2 is Y1 + 1,
    field_validation(X2,Y2),				% is on table
    ruut(X, Y, MyColouror),									% wathcing that square is our colour 
    ruut(X1,Y1, Color),										% wathcing that square is not our colour
    Color =\= MyColouror, Color =\= MyColouror/10, Color =\= 0,	% check dam 1.different colour wawka 2. not our 3. empty square
    ruut(X2,Y2, 0).											% where we go that it is empty
kas_saab_vota_uleval_paremal(X,Y,X1,Y1,X2,Y2, Counter):-
    field_validation(X + Counter + 1, Y + Counter + 1),			% if it possible to walk bigger
    kas_ruut_on_vaba_uleval_paremal(X,Y,Counter),
    kas_saab_vota_uleval_paremal(X,Y,X1,Y1,X2,Y2, Counter + 1).
      	  
kas_saab_vota_uleval_vasakul(X,Y,X1,Y1,X2,Y2, Counter):-  
    X1 is X - Counter,
    Y1 is Y + Counter,
    X2 is X1 - 1,
    Y2 is Y1 + 1,
    field_validation(X2,Y2),
    ruut(X1,Y1, Color),
    ruut(X, Y, MyColouror),
    Color =\= MyColouror, Color =\= MyColouror/10, Color =\= 0,
    ruut(X2,Y2, 0).
kas_saab_vota_uleval_vasakul(X,Y,X1,Y1,X2,Y2, Counter) :-
    field_validation(X - Counter - 1, Y + Counter + 1),
    kas_ruut_on_vaba_uleval_vasakul(X,Y,Counter),
    kas_saab_vota_uleval_vasakul(X,Y,X1,Y1,X2,Y2, Counter + 1).
      
kas_saab_vota_alla_paremal(X,Y,X1,Y1,X2,Y2, Counter):-
    X1 is X + Counter,										%cordinats configuration
    Y1 is Y - Counter,
    X2 is X1 + 1,
    Y2 is Y1 - 1,
    field_validation(X2,Y2),
    ruut(X1,Y1, Color),
    ruut(X, Y, MyColouror),
    Color =\= MyColouror, Color =\= MyColouror/10, Color =\= 0,
    ruut(X2,Y2, 0).
kas_saab_vota_alla_paremal(X,Y,X1,Y1,X2,Y2, Counter) :-
    field_validation(X + Counter + 1, Y - Counter - 1),
    kas_ruut_on_vaba_alla_paremal(X,Y,Counter),
    kas_saab_vota_alla_paremal(X,Y,X1,Y1,X2,Y2, Counter + 1).
      
kas_saab_vota_alla_vasakul(X,Y,X1,Y1,X2,Y2, Counter) :- 
    X1 is X - Counter,
    Y1 is Y - Counter,
    X2 is X1 - 1,
    Y2 is Y1 - 1,
    field_validation(X2,Y2),
    ruut(X1,Y1, Color),
    ruut(X, Y, MyColouror),
    Color =\= MyColouror, Color =\= MyColouror/10, Color =\= 0,
    ruut(X2,Y2, 0).
kas_saab_vota_alla_vasakul(X,Y,X1,Y1,X2,Y2, Counter) :-
    field_validation(X - Counter - 1, Y - Counter - 1),
    kas_ruut_on_vaba_alla_vasakul(X,Y,Counter),
    kas_saab_vota_alla_vasakul(X,Y,X1,Y1,X2,Y2, Counter + 1).
      
kas_saab_votta(X,Y,Derection,X1,Y1,X2,Y2):- 
    X1 is X + Derection,
    Y1 is Y + 1,
    ruut(X1,Y1, Color),
    ruut(X, Y, MyColouror),
    TammiVarv is MyColouror * 10,
    Color =\= MyColouror, Color =\= TammiVarv, Color =\= 0,
    X2 is X1 + Derection,
    Y2 is Y1 + 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Derection,X1,Y1,X2,Y2):- 
    X1 is X + Derection,
    Y1 is Y - 1,
    ruut(X1,Y1, Color),
    ruut(X, Y, MyColouror),
    TammiVarv is MyColouror * 10,
    Color =\= MyColouror, Color =\= TammiVarv, Color =\= 0,
    X2 is X1 + Derection,
    Y2 is Y1 - 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Derection,X1,Y1,X2,Y2):-  
    X1 is X + Derection * -1,
    Y1 is Y + 1,
    ruut(X1,Y1, Color),
    ruut(X, Y, MyColouror),
    TammiVarv is MyColouror * 10,
    Color =\= MyColouror, Color =\= TammiVarv, Color =\= 0,
    X2 is X1 + Derection * -1,
    Y2 is Y1 + 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Derection,X1,Y1,X2,Y2):-  
    X1 is X + Derection * -1,
    Y1 is Y - 1,
    ruut(X1,Y1, Color),
    ruut(X, Y, MyColouror),
    TammiVarv is MyColouror * 10,
    Color =\= MyColouror, Color =\= TammiVarv, Color =\= 0,
    X2 is X1 + Derection * -1,
    Y2 is Y1 - 1,
    ruut(X2,Y2, 0).
%--------------------------------
kaimine(X,Y,Derection,X1,Y1):-
    ruut(X, Y, Color),
    (
            (Color = 10; Color = 20),
            kas_tamm_saab_kaia(X,Y,X1,Y1);
            (Color = 1; Color = 2),
            kas_naaber_vaba(X,Y,Derection,X1,Y1)
    ),
    tee_kaik(X,Y,X1,Y1), !.
kaimine(_,_,_,_,_).
  
kas_naaber_vaba(X,Y,Derection,X1,Y1):-
    X1 is X +Derection,Y1 is Y + 1,ruut(X1,Y1, 0).
kas_naaber_vaba(X,Y,Derection,X1,Y1):-
    X1 is X +Derection,Y1 is Y -1,ruut(X1,Y1, 0).
kas_naaber_vaba(X,Y,X1,Y1):-
    ruut(X,Y, Status),assert(ruut1(X1,Y1, Status)),!.
      
kas_tamm_saab_kaia(X,Y,X1,Y1) :-
    X1 is X + 1,Y1 is Y + 1,ruut(X1,Y1, 0), !.
kas_tamm_saab_kaia(X,Y,X1,Y1) :-
    X1 is X - 1,Y1 is Y + 1,ruut(X1,Y1, 0), !.
kas_tamm_saab_kaia(X,Y,X1,Y1) :-
    X1 is X + 1,Y1 is Y - 1,ruut(X1,Y1, 0), !.
kas_tamm_saab_kaia(X,Y,X1,Y1) :-
    X1 is X - 1,Y1 is Y - 1,ruut(X1,Y1, 0), !.
      
tee_kaik(X,Y,X1,Y1) :-
    ruut(X, Y, MyColouror),
    retract(ruut(X, Y, MyColouror)),
    assert(ruut(X, Y, 0)),
    retract(ruut(X1, Y1, 0)),
    ((MyColouror = 1, X1 = 8),
    assert(ruut(X1, Y1, 10)), !;
    (MyColouror = 2, X1 = 1),
    assert(ruut(X1, Y1, 20)), !;
    assert(ruut(X1, Y1, MyColouror))). 
  
%============Print Board============
print_board :-
    print_squares(8).
  
print_squares(Row) :-
    between(1, 8, Row),
    write('|'), print_row_squares(Row, 1), write('|'), nl,
    NewRow is Row - 1,
    print_squares(NewRow), !.
print_squares(_) :- !.
  
  
print_row_squares(Row, Col) :-
    between(1, 8, Col),
    ruut(Col, Row, Status), write(' '), write(Status), write(' '),
    NewCol is Col + 1,
    print_row_squares(Row, NewCol), !.
print_row_squares(_, _) :- !.

%============Print Board============		
status_sq(ROW,COL):-
    (   ruut(ROW,COL,COLOR),
        write(COLOR)
    );(
        write(' ')
    ).
status_row(ROW):-
    write('row # '),write(ROW), write('   '),
    status_sq(ROW,1),
    status_sq(ROW,2),
    status_sq(ROW,3),
    status_sq(ROW,4),
    status_sq(ROW,5),
    status_sq(ROW,6),
    status_sq(ROW,7),
    status_sq(ROW,8),
    nl.
% print the entire checkers board..
status:-
    nl,
    status_row(8),
    status_row(7),
    status_row(6),
    status_row(5),
    status_row(4),
    status_row(3),
    status_row(2),
    status_row(1).
%============Print Board============					
