/*
Suite U :
U0(P,Q) = 0
U1(P,Q) = 1
Un(P,Q) = PUn-1(P,Q) - QUn-2(P,Q)

Suite V :
V0(P,Q) = 2
V1(P,Q) = P
Vn(P,Q) = PVn-1(P,Q) - QVn-2(P,Q)

Exclure : Δ:= 𝑃² − 4𝑄 ≠ 0
*/

%%Variables d'arrêt pour n = 0, R is 0 et pour n = 1, R is 1
suiteU(P,Q,N,RU) :- N = 0, RU is 0.
suiteU(P,Q,N,RU) :- N = 1, RU is 1.
suiteU(P,Q,N,RU) :-
%% N > -1, permet d'enlever l'erreur "Out of local stack"
	N > -1,
	%% Correspond à 𝑃𝑈𝑛−1(𝑃,𝑄)
	L is N-1,
	%% Correspond à 𝑄𝑈𝑛−2(𝑃,𝑄)
	M is N-2,
	%% La recursivite suivante permet de boucler sur la suite
	suiteU(P,Q,L,U),
	suiteU(P,Q,M,S),
	%% Calcul de l'equation 𝑃𝑈𝑛−1(𝑃,𝑄)−𝑄𝑈𝑛−2(𝑃,𝑄)
	RU is (P*U)-(Q*S).

%%Variables d'arrêt pour n = 0, R is 2 et pour n = 1, R is P
suiteV(P,Q,N,RV) :- N = 0, RV is 2.
suiteV(P,Q,N,RV) :- N = 1, RV is P.
suiteV(P,Q,N,RV) :-
	%% N > -1, permet d'enlever l'erreur "Out of local stack"
	N > -1,
	%% Correspond à 𝑃𝑈𝑛−1(𝑃,𝑄)
	L is N-1,
	%% Correspond à 𝑄𝑈𝑛−2(𝑃,𝑄)
	M is N-2,
	%% La recursivite suivante permet de boucler sur la suite
	suiteV(P,Q,L,U),
	suiteV(P,Q,M,S),
	%% Calcul de l'equation 𝑃𝑈𝑛−1(𝑃,𝑄)−𝑄𝑈𝑛−2(𝑃,𝑄)
	RV is (P*U)-(Q*S).

%% Le predicat suivant permet d'executer les calculs de U et V en une fois
calc(P,Q,N,MAX):-
	N =< MAX,
	suiteU(P,Q,N,RU),
	write( "\n\nN --> " + N ),
	write( "\nU --> " + RU ),
	suiteV(P,Q,N,RV),
	write( "\nV --> " + RV ),
	%% permet d'afficher la suite dans l'ordre croissant
	NBIS is N+1,
	calc(P,Q,NBIS,MAX).

lucas(P,Q) :-
	%% si 𝑃² − 4𝑄 ≠ 0 alors on continue
	ARRET is P*P-4*Q,
	not( ARRET = 0 ),
	calc(P,Q,0,10).
	%% sinon retourne false

	%% permet d'afficher la suite Un et Vn de 0 à 10
