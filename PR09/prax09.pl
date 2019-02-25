%Ülesanne 2
lihtlause --> nimisonafraas, tegusonafraas.
nimisonafraas --> nimisona, omadussonafraas, nimisona.
nimisonafraas --> nimisona,nimisonafraas ;[].
nimisona --> [pakapiku];[habe];[tema];[sobimatuse];[jouluvanaks].
	
		% terminalsümbolid esinevad reeglis paremal pool ühiklistidena
		
omadussonafraas --> maarsona, omadussona.
maarsona --> [liiga].
omadussona --> [lyhike].
tegusonafraas --> tegusona, nimisonafraas.
tegusona --> [tingib];[pohjustab].

%Ülesanne 3

lihtlause --> nimisonafraas,tegusonafraas. 
lihtlause --> nimisonafraas,tegusonafraas,nimisonafraas. 
liitlause --> lihtlause,koma,lihtlause. 
liitlause --> lihtlause,koma,liitlause. 
nimisonafraas --> omadussonafraas,nimisona,nimisona. 
nimisonafraas --> omadussonafraas. 
nimisonafraas --> nimisona. 
nimisona --> [kivile];[sammal];[uhkus];[raha];[volad]. 
omadussonafraas --> omadussona. 
omadussonafraas --> maarsona. 
maarsona --> [upakile]. 
omadussona --> [veerevale]. 
tegusonafraas --> eitussona,tegusona. 
tegusonafraas --> tegusona. 
eitussona --> [ei]. 
tegusona --> [kasva];[ajab];[tuleb];[laheb];[jaavad]. 
koma --> [,].

% Veerevale kivile sammal ei kasva

%lihtlause --> nimisonafraas,tegusonafraas.

%nimisonafraas --> omadussonafraas,nimisona,nimisona.
%nimisona --> [kivile];[sammal].
%omadussonafraas --> omadussona.
%omadussona --> [veerevale]. 
%tegusonafraas --> eitussona,tegusona.
%eitussona --> [ei].
%tegusona --> [kasva].

% Uhkus ajab upakile.

%lihtlause --> nimisonafraas,tegusonafraas.
%nimisonafraas --> nimisona.
%nimisona --> [kivile];[sammal];[uhkus].
%tegusonafraas --> tegusona, maarsona.
%tegusona --> [kasva];[ajab].
%maarsona --> [upakile].

%  Raha tuleb, raha läheb, võlad jäävad.

%lihtlause --> nimisonafraas,tegusonafraas, nimisonafraas,tegusonafraas, %nimisonafraas,tegusonafraas.
%nimisonafraas --> nimisona.
%nimisona --> [raha];[võlad].
%tegusonafraas --> tegusona.
%tegusona --> [tuleb];[läheb];[jäävad].