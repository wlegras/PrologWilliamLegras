%% X = 0 est la condition d'arrêt, ce qui permet de calculer la recursivité. Si X est inférieur à 0, alors on retourne false.
factorielle(X,Y):- X = 0, Y is 1.
factorielle(X,Y):-
	X > 0,
	N is (X-1),
	factorielle(N,Z),
	Y is X*Z.
