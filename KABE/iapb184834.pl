
:- module('Mihhail Kabrits',[iapb184834/3]).
iapb184834(MyColor,X,Y):-
      %write(['joudsin iapb184834 xy=0',MyColor]),nl,
  X==Y,Y==0,
  main(MyColor),!.
iapb184834(MyColor,X,Y):-
      %write(['joudsin iapb184834 xy!=0',MyColor]),nl,
  X =\= 0, Y =\= 0,
  leia_suund(MyColor,Suund),
  votmine(X,Y,Suund,X1,Y1),!.
%iapb184834(_,_,_).
main(MyColor):- % esiteks proovi votta
    TammColor is MyColor * 10,
    (color_of(X,Y, MyColor);color_of(X,Y,TammColor)),
    leia_suund(MyColor,Suund),
    %write('joudsinmain1'),nl,
    votmine(X,Y,Suund,X1,Y1),!.
main(MyColor):- % teiseks proovi kaia
  TammColor is MyColor * 10,
  (color_of(X,Y, MyColor);color_of(X,Y,TammColor)),
    leia_suund(MyColor,Suund),
    kaimine(X,Y,Suund,X1,Y1),!.
%main(_).

leia_suund(1,1):- !.
leia_suund(2,-1):- !.
leia_suund(20,1).
leia_suund(10,-1).

on_tamm(X,Y):-
  ruut(X,Y,20);
  ruut(X,Y,10).
color_of(X,Y,1):-ruut(X,Y,1);ruut(X,Y,10).
color_of(X,Y,2):-ruut(X,Y,2);ruut(X,Y,20).
color_of(X,Y,0):-ruut(X,Y,0).
muuda_tammiks_kui_vaja(X,Y):-
  (X = 8,color_of(X,Y,1); X = 1,color_of(X,Y,2)),
  not(on_tamm(X,Y)),
  retract(ruut(X,Y,Color)),
  Color10 is Color * 10,
  assert(ruut(X,Y,Color10)).
muuda_tammiks_kui_vaja(_,_).

%--------------------------------
kaigu_variandid(X,Y,Suund,X1,Y1):-
    votmine(X,Y,Suund,X1,Y1),!.
kaigu_variandid(X,Y,Suund,X1,Y1):-
    kaimine(X,Y,Suund,X1,Y1),!.
%---------------------------------***
votmine(X,Y,Suund,X1,Y1):-
  %write('joudsin votmine'),nl,
    kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2),
    vota(X,Y,Suund,X1,Y1,X2,Y2).
    %write([' votab ', X1,X2]).
    %fail.
vota(X,Y,Suund,X1,Y1,X2,Y2):-
  retract(ruut(X,Y,Color)),
  assert(ruut(X,Y,0)),
  retract(ruut(X1,Y1,Color2)),
  assert(ruut(X1,Y1,0)),
  retract(ruut(X2,Y2,0)),
  assert(ruut(X2,Y2,Color)),
  muuda_tammiks_kui_vaja(X2,Y2).

%--------
empty_between(X,Y,X1,Y1):-
  (Y1 > Y, Ys is 1; Ys is -1), % Y- suund
  (X1 > Y, Xs is 1; Xs is -1), % X- suund
  X2 is  X + Xs, %samm x1 suunas
  Y2 is  Y + Ys, %samm y1 suunas
  ((X1 = X2, Y1 = Y2); % OK, kui oleme joudnud kohale
  ruut(X2,Y2,0),empty_between(X2,Y2,X1,Y1)). % oleme tyhjal kohal, vaatame sammu edasi

tammi_kaik(X,Y,Xf,Yf,Sx,Sy,MyColor):-
  Xn is X + Sx, %Sx on x-teljel suund, Sy y-teljel suund
  Yn is Y + Sy,
  %if next square is enemy and the one after is empty:return true
  (color_of(Xn,Yn,Color),Color =\= MyColor,Color =\= 0,
  Xf is Xn + Sx,
  Yf is Yn + Sy,
  ruut(Xf,Yf,0);
  %else if next square is empty, call tammi_kaik on it again
  ruut(Xn,Yn,0),
  tammi_kaik(Xn,Yn,Xf,Yf,Sx,Sy,MyColor)
  ).

kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-%tammid
  %write('joudsin ksv tamm'),nl,
  color_of(X,Y,MyColor),on_tamm(X,Y),
  (
  tammi_kaik(X,Y,X2,Y2,Suund,1,MyColor),
  X1 is X2 - Suund,
  Y1 is Y2 -1;
  tammi_kaik(X,Y,X2,Y2,Suund,-1,MyColor),
  X1 is X2 - Suund,
  Y1 is Y2 +1
  ; % Vastassuunas
  Suund2 is Suund * (-1),
  tammi_kaik(X,Y,X2,Y2,Suund2,1,MyColor),
  X1 is X2 - Suund2,
  Y1 is Y2 -1;
  Suund2 is Suund * -1,
  tammi_kaik(X,Y,X2,Y2,Suund2,-1,MyColor),
  X1 is X2 - Suund2,
  Y1 is Y2 +1
  ).
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine edasi paremale
    %write('joudsin ksv edasi paremale'),nl,
    X1 is X + Suund,
    Y1 is Y + 1,
    color_of(X1,Y1, Color),
    color_of(X,Y,MyColor),
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund,
    Y2 is Y1 + 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine edasi vasakule
    %write('joudsin ksv edasi vasakule'),nl,
    X1 is X + Suund,
    Y1 is Y - 1,
    color_of(X1,Y1, Color),
    color_of(X,Y,MyColor),
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund,
    Y2 is Y1 - 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine tagasi paremale
    %write('joudsin ksv tagasi paremale'),nl,
    %write('vaatan tagasi paremale'),nl,
    X1 is X + Suund * -1,
    Y1 is Y + 1,
    color_of(X1,Y1, Color),
    color_of(X,Y,MyColor),
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund * -1,
    Y2 is Y1 + 1,
    ruut(X2,Y2, 0).
kas_saab_votta(X,Y,Suund,X1,Y1,X2,Y2):-  % Votmine tagasi vasakule
    %write('joudsin ksv tagasi vasakule'),nl,
    X1 is X + Suund * -1,
    Y1 is Y - 1,
    color_of(X,Y,MyColor),
    %write(['vaatan tagasi vasakule',X,Y,MyColor]),nl,
    color_of(X1,Y1, Color),
    %write(['seal on',X1,Y1,Color]),nl,
    Color =\= MyColor, Color =\= 0,
    X2 is X1 + Suund * -1,
    Y2 is Y1 - 1,
    ruut(X2,Y2, 0).
%--------------------------------
tee_kaik(X,Y,X1,Y1):-
  retract(ruut(X,Y,Color)),
  assert(ruut(X,Y,0)),
  retract(ruut(X1,Y1,0)),
  assert(ruut(X1,Y1,Color)),
  muuda_tammiks_kui_vaja(X1,Y1).
kaimine(X,Y,Suund,X1,Y1):-
  %write('joudsin kaimine'),
  on_tamm(X,Y),
  empty_between(X,Y,X1,Y1),
  tee_kaik(X,Y,X1,Y1).
kaimine(X,Y,Suund,X1,Y1):-
    kas_naaber_vaba(X,Y,Suund,X1,Y1),
    tee_kaik(X,Y,X1,Y1).
    %write([' kaib ', X1,Y1]).
    %fail.
%kaimine(_,_,_,_,_).

kas_naaber_vaba(X,Y,Suund,X1,Y1):-
    X1 is X +Suund,
    Y1 is Y + 1,
    ruut(X1,Y1, 0).
kas_naaber_vaba(X,Y,Suund,X1,Y1):-
    X1 is X +Suund,
    Y1 is Y -1,
    ruut(X1,Y1, 0).

% ----MANGU ALGSEIS-----------
/*
:-dynamic ruut/3.
% Valged

ruut(1,1,1).
ruut(1,3,1).
ruut(1,5,1).
ruut(1,7,1).
ruut(2,2,1).
ruut(2,4,1).
ruut(2,6,1).
ruut(2,8,1).
ruut(3,1,1).
ruut(3,3,1).
ruut(3,5,1).
ruut(3,7,1).
% Tuhjad ruudud
ruut(4,2,0).
ruut(4,4,0).
ruut(4,6,0).
ruut(4,8,0).
ruut(5,1,0).
ruut(5,3,0).
ruut(5,5,0).
ruut(5,7,0).
% Mustad
ruut(6,2,2).
ruut(6,4,2).
ruut(6,6,2).
ruut(6,8,2).
ruut(7,1,2).
ruut(7,3,2).
ruut(7,5,2).
ruut(7,7,2).
ruut(8,2,2).
ruut(8,4,2).
ruut(8,6,2).
ruut(8,8,2).
*/
/*
ruut(X,Y, Status).  %   kus X, Y [1,8]
Status = 0      % tuhi
Status = 1      % valge
Status = 2      %  must
Status = 10     % valge tamm
Status = 20     % must tamm
*/
/*
:-dynamic ruut/3.
ruut(4,4,1).
ruut(3,3,2).
ruut(2,2,0).
*/
%ruut(6,6,2).

%=================== Print checkers board - Start ==================
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

%=================== Print checkers board - End ====================

%=================== Print checkers board v2 - Start ==================
status_sq(ROW,COL):-
	(	ruut(ROW,COL,COLOR),
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
	status_row(1),!.
