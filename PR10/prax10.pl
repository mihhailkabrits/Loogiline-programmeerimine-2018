% Ülesanne 1 mina mees kuhu ainult soob

vota(A,B,Suund,A1,B1,C2,D2):- 
ruut(A, B, Color), ruut(A1, B1, Color1), 
retract(ruut(A, B, Color)), retract(ruut(A1, B1, Color1)), retract(ruut(C2, D2, 0)), 
assert(ruut(A, B, 0)), assert(ruut(A1, B1, 0)), assert(ruut(C2, D2, Color)),!. 

% Ülesanne 2 mina kuhu minna

tee_kaik(A,B,A1,B1):- 
ruut(A, B, Color), ruut(A1, B1, Color1), 
retract(ruut(A, B, Color)), retract(ruut(A1, B1, Color1)), 
assert(ruut(A, B, 0)), assert(ruut(A1, B1, Color)),!. 
