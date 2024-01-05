# Mohamed amine KASMI
# ici on a param fichier on peut changer le nom des fichier si on veut
# Dans mon cas j'ai teste et j'ai obtenu les resultas que je veux 
param fichier := "u40_00.bpa"; 

# C signifie la capacite des boites 
param C :=  read fichier as "1n" comment "#" use 1 skip 1;
do print "Capacité des boîtes : ", C ;

# nbObjet signifie le nombre des objets
param nbObjet :=  read fichier as "2n" comment "#" use 1 skip 1;
do print "Nombre d'objets : ", nbObjet ;

# au total on a 3 parametres 

# avec set I et set J on va cree un ensemble d'objets et ensemble de boites
set I := {1 to nbObjet by 1} ;
set J := {1 to nbObjet by 1} ; 

# x[x,j] vaut 1 si i est dans la boite j 0 sinon 
var x[I*J] binary ;
# y[j] vaut 1 si la boite est utilisee
var y[J] binary ;

# ici on va lire la taille des objets
set tmp [ <i> in I ] := { read fichier as "<1n>" skip 1+ i use 1} ;
param taille [ <i> in I ] := ord ( tmp [ i ] ,1 ,1);

# la fonction objective est minimiser le nb de boites
minimize nbBoite : 
          sum <j> in J : y[j] ;

# 1ere contrainte
subto objet_par_objet : 
          forall <i> in I : sum <j> in J : x[i,j] == 1 ;

# 2eme contrainte
subto boite_utilisee : 
          forall <j> in J : forall <i> in I : y[j] >= x[i,j];
# 3eme contrainte
subto capacite_max_boites : 
          forall <j> in J : sum <i> in I : taille[i]*x[i,j] <= C ;

# tout ce qui suit c'est pour gerer la symetrie
# avec ces contraintes on veut eviter les solution equivalentes des boites
# on veut ameliorer le temps et reduire la complexite   
subto ordre_des_Boites: 
          forall <j> in J with j > 1: y[j-1] >= y[j];
subto anti_Symetrie:
          forall <j> in J with j > 1 : 
          sum <i> in I : x[i,j] <= sum <i> in I : x[i,j-1];
# cette version du fichier demenageurs62.zpl traite le probleme avec la gestion des symetries

