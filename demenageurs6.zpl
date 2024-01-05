# KASMI Mohamed amine 
param fichier := "u40_00.bpa" ;
param N := read fichier as "2n" skip 1 use 1 ;
param C := read fichier as "1n" skip 1 use 1 ;

set I := {1..N} ;
set J := {1..N} ;

set tmp[<i> in I] := {read fichier as "<1n>" skip 1+i use 1} ;
param taille[<i> in I] := ord(tmp[i],1,1);

var x[I*J] binary; 
var y[J] binary; 
minimize nb_boites : sum <j> in J: y[j];

subto capacite_max_boites :
        forall <j> in J:
        sum <i> in I: taille[i]*x[i,j] <= C;

subto objet_par_boite :
        forall <i> in I:
        sum <j> in J: x[i,j] == 1;

subto boite_utilisee :
        forall<i,j> in I*J:
        x[i,j] <= y[j];

# ce fichier traite le probleme sans gestion des symetrie
# vous trouver les commantaires qui explique le role de chaque element dans le fichier demenageurs62.zpl

