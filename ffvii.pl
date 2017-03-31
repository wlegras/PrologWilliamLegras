ffvii(personnage(aeris,cetras,soin,19,10000),ifalna).
ffvii(personnage(ifalna,cetras,pnj,6,15000),cloud).
ffvii(personnage(cloud,soldat,heros,18,30000),cloud).
ffvii(personnage(tifa,equipe,guerrier,11,15000),barret).
ffvii(personnage(barret,equipe,guerrier,7,14000),cloud).
ffvii(personnage(rougexiii,equipe,soin,18,11000),barret).
ffvii(personnage(yuffie,equipe,ninja,8,2000),barret).

%% a) La règle prend 2 paramètres, le perso à rentrer et l'equipe. On rentre le premier
%% et la règle nous ressort l'equipe de ce perso en nom_equipe en respectant la syntaxe du tp
regle_groupe(Nom_perso,Nom_equipe) :- ffvii(personnage(Nom_perso,Nom_equipe, _, _, _), _).

%% b) La règle prend 2 paramètres, le perso à rentrer et le chef. On rentre le premier
%% et la règle nous ressort le chef de ce perso en nom_chef en respectant la syntaxe du tp
regle_chef(Nom_perso,Nom_chef) :- ffvii(personnage(Nom_perso, _, _, _, _), Nom_chef).

%% c) Il faut définir cloud en temps que chef supreme, nous permettant de savoir si le
%% membre est valide ou non. On va ensuite faire une récursivité en appelant la regle
%% permettant de trouver le chef du perso, et de vérifier ensuite si celui ci est cloud
%% tant que le chef n'est pas cloud, la règle va s'exécuter, et se stopper lorsque cloud est le chef
%% renvoi true si le perso existe et false s'il n'existe pas.
membre_valide(cloud).
membre_valide(Nom_perso) :- regle_chef(Nom_perso,Nom_chef),membre_valide(Nom_chef).

%% d) La règle prend 2 paramètres, le perso à rentrer et l'xp. On rentre le premier
%% et la règle nous ressort l'xp de ce perso en xp_perso en respectant la syntaxe du tp
regle_xp(Nom_perso,Xp_perso) :- ffvii(personnage(Nom_perso, _, _, _, Xp_perso), _).

%% permet de connaitre la cote du personnage rentré pour ensuite définir son bonus
cote(Nom_perso,Cote_perso) :- ffvii(personnage(Nom_perso, _, _, Cote_perso, _), _).
%% e)i) Si le perso a une cote supérieure ou égale à 10, son xp sera augmentée de 5000
xp_reelle1(Nom_perso,Xp_reelle) :-
  cote(Nom_perso, Cote_perso),
  regle_xp(Nom_perso,Xp_perso),
  (Cote_perso >= 10 ->
    Xp_reelle is Xp_perso+5000;
    Cote_perso < 10,
    Xp_reelle is Xp_perso).

%% e)ii) On compare l'xp du perso avec celle du chef, et si elle est inférieur alors on fait +5000
xp_reelle2(Nom_perso,Xp_reelle) :-
  regle_chef(Nom_perso, Nom_chef),
  xp_reelle1(Nom_perso, Xp_reelle_perso),
  xp_reelle1(Nom_chef,Xp_reelle_chef),
  Xp_reelle_perso < Xp_reelle_chef,
  Xp_reelle is Xp_reelle_perso.
%% e)ii) On compare l'xp du perso avec celle du chef, et si elle est supérieur alors on prend l'xp du chef
xp_reelle2(Nom_perso,Xp_reelle) :-
  regle_chef(Nom_perso, Nom_chef),
  xp_reelle1(Nom_perso, Xp_reelle_perso),
  xp_reelle1(Nom_chef,Xp_reelle_chef),
  Xp_reelle_perso >= Xp_reelle_chef,
  Xp_reelle is Xp_reelle_chef.
