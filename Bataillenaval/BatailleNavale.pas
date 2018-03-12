PROGRAM BatNavale;

uses crt;


CONST
	MAX=14;			//Dimensions
	MAXBAT=5;		//Nombre MAXimal de bateaux (définit aussi la taille MAXimale)
	NBJOUEUR=2;		//Nombre de joueurs

TYPE
	coord=RECORD
		x,y:INTEGER
END;

TYPE
	bateau=RECORD
		cases:ARRAY[1..5] OF coord;
		taille:INTEGER;
END;

TYPE
	flotte=RECORD
		bat:ARRAY[1..MAXBAT] OF bateau;
		joueur,restants:INTEGER;
END;

TYPE grille=ARRAY[1..NBJOUEUR] OF flotte;								

								
FUNCTION Flotte (flotte1:flotte ; coord1:coord) : BOOLEAN;
//BUT: Retourne un booléen qui vérifie si un bateau de la flotte en paramètre possède les coordonnées entrées 
//ENTREES: Flotte et coordonnée à comparer 
//SORTIES: Booléen
VAR	
	i:INTEGER;
BEGIN
	Flotte:=FALSE;								
	FOR i:=1 TO MAXBAT DO								
		IF (OwnBateau(flotte1.bateau[i],coord1)=TRUE) THEN
			BEGIN
				Flotte:=TRUE;
			END;
END;

PROCEDURE CreaCoord(x,y:INTEGER ; var coord1:coord);
//BUT: Assigner une coordonnée à partir de deux entiers
//ENTREES: x,y, coordonnée à modifier
//SORTIES: Coordonnée 
BEGIN
	coord1.x:=x;
	coord1.y:=y;
END;
						


FUNCTION CreaBateau (compteur,taille:INTEGER): Bateau;
//BUT: Placer correctement un bateau en fonction des coordonnées et de la direction entrées par l'utilisateur
//ENTREES: Valeur compteur représentant le numéro du bateau dans la flotte le possédant, bateau vide, flotte en initialisation
//SORTIES: Affectation des coordonnées de chaque cellule du bateau
VAR
	i:INTEGER;
	x,y:1..MAX;
	direction:CHAR;
	coord:coord;
	bateau1:bateau;
BEGIN
	REPEAT																											
		writeln('Entrez les coordonnées de votre bateau de longueur ', taille, ' (comprises entre 1 et ', MAX, ')');
		writeln('Entrez les abscisse et ordonnée de votre bateau');
		readln(x,y);
		CreaCoord(x,y,coord);			
		bateau1.taille:=taille;
		REPEAT														
			writeln('Entrez l''orientation de votre bateau :');		
			writeln('NORD:(N), SUD:(S), EST:(E), OUEST:(O)');
			readln(direction);
		UNTIL (direction='N') OR (direction='E') OR (direction='S') OR  (direction='O');
			FOR i:=1 TO bateau1.taille DO						
			BEGIN
				CASE direction OF							
					'S':
						BEGIN
							(bateau1.cases[i].x):=(stock.x);
							(bateau1.cases[i].y):=(stock.y+i-1);
						END;
					'E':
						BEGIN
							(bateau1.cases[i].x):=(stock.x+i-1);
							(bateau1.cases[i].y):=(stock.y);
						END;
					'N':
						BEGIN
							(bateau1.cases[i].x):=(stock.x);
							(bateau1.cases[i].y):=(stock.y-i+1);
						END;
					'O':
						BEGIN
							(bateau1.cases[i].x):=(stock.x-i+1);
							(bateau1.cases[i].y):=(stock.y);
						END;
				END;
			END;
	UNTIL (i=bateau1.taille)
	Creabateau:=bateau1;	
END;
								
PROCEDURE AffichageTableau(flotte1:flotte);			
//BUT: Afficher la grille de jeu avec les axe x,y et les bateaux
//ENTREES: Flotte
//SORTIES: Affichage de la grille avec flotte
VAR
	i,j:INTEGER;
	stock:coord;
BEGIN
	FOR i:=0 TO MAX DO								
	BEGIN
		FOR j:=0 TO MAX DO					
		BEGIN
			stock.x:=j;				
			stock.y:=i;
			IF (i=0)THEN				
				IF j>9 THEN				
					write(' ',j)
				ELSE
					write('  ',j)
			ELSE
			IF (j=0) THEN			
				IF i>9 THEN			
					write(' ',i,' ')
				ELSE
					write('  ',i,' ')
			ELSE
			IF Flotte(flotte1,stock) THEN
				write(' ',CHR(129),' ')
			ELSE				
				write(' . ')
		END;
			writeln;
	END;			
END;

PROCEDURE InitFlotte (var flotte1:flotte);
//BUT: Assignation d'une flotte 
//ENTREES: Flotte
//SORTIES: Flotte remplie de bateaux
VAR
	i,j:INTEGER;
	bateau1:bateau;
BEGIN
	FOR i:=1 TO MAXBAT DO
	BEGIN
		CASE i OF
			1:flotte1.bateau[i].taille:=2;		
			2:flotte1.bateau[i].taille:=3;
		ELSE
			flotte1.bateau[i].taille:=i
		END;
		REPEAT
			bateau1:=CreaBateau(i,flotte1.bateau[i].taille);
			writeln('ok1');
			IF bateauflotte(flotte1,bateau1) THEN
			BEGIN
				writeln('ok1');
				writeln('Superposition impossible, recommencez');
			END;
		UNTIL bateauflotte(flotte1,bateau1)=FALSE;
		writeln('ok1');
		flotte1.bateau[i]:=bateau1;
		writeln('ok1');
		AffichageTableau(flotte1);
	END;
END;

FUNCTION BateauCoule(bateau1:bateau) : INTEGER;							
//BUT: Retourner un entier qui permettra de comparer la taille du bateau avec le nombre de ses cellules touchées
//ENTREES: Bateau 
//SORTIES: Entier qui représente le nombre de cellules touchées 

VAR
	i:INTEGER;
BEGIN
	BateauCoule:=0;
	FOR i:=1 TO bateau1.taille DO
		IF (bateau1.cases[i].x=0) AND (bateau1.cases[i].y=0) THEN
			BateauCoule:=BateauCoule+1
END;
FUNCTION Defaite(flotte1:flotte): BOOLEAN;				
//BUT: Booléen qui vérifie si un joueur a perdu
//ENTREES: Flotte du joueur
//SORTES: Booléen

VAR
	i,j,stock:INTEGER;
BEGIN
	stock:=0;
	FOR i:=1 TO MAXBAT DO										
	BEGIN
		FOR j:=1 TO flotte1.bateau[i].taille DO 
		BEGIN
			IF (flotte1.bateau[i].cases[j].x=-1) AND (flotte1.bateau[i].cases[j].y=-1) THEN
				stock:=stock+1/ 
		END;
	END;
	IF stock=MAXBAT THEN 
	BEGIN
		Defaite:=TRUE;
		writeln('Le joueur ',flotte1.joueur,' a perdu');
	END
	ELSE
			Defaite:=FALSE
END;
								
PROCEDURE TourDeJeu(flotte1:flotte ; var flotte2:flotte);
//Lire les coordonnées du tir du joueur et agir en conséquence
//ENTREES: Flotte du joueur attaquant, flotte du joueur attaqué
//SORTIES: Affichage statut de la case (Touché, coulé ou manqué), exclusion des cellules touchées par un tir, affichage tir
VAR
	i,j:INTEGER;
	stock:coord;
	x,y:1..MAX;
						
BEGIN
	writeln('Voici votre flotte');
	AffichageTableau(flotte1);																
	writeln('Ordres du joueur ',flotte1.joueur);
	writeln('Entrez les coordonnées de votre tir');
	writeln('Ordre: Abscisse, Ordonnée');
	readln(x,y);
	CreaCoord(x,y,stock);																			
	clrscr;
	IF Flotte(flotte2,stock)=TRUE THEN										
	BEGIN
		writeln('Touché !');
		FOR i:=1 TO MAXBAT DO														
		BEGIN
			FOR j:=1 TO flotte2.bateau[i].taille DO							
			BEGIN
				IF (Comparaison(flotte2.bateau[i].cases[j],stock)) THEN
				BEGIN
					flotte2.bateau[i].cases[j].x:=0;					
					flotte2.bateau[i].cases[j].y:=0;
				END;
				IF (BateauCoule(flotte2.bateau[i])=flotte2.bateau[i].taille) THEN
				BEGIN
					writeln('Coulé !');
					flotte2.restants:=(flotte2.restants-1);			
					flotte2.bateau[i].cases[j].x:=-1;
					flotte2.bateau[i].cases[j].y:=-1; 				
				END;
			END;
		END;
	END
	ELSE
	BEGIN
		writeln('Manqué !');
	END;
	FOR i:=0 TO MAX DO
	BEGIN
		FOR j:=0 TO MAX DO
		BEGIN
		IF (i=0)THEN
			IF j>9 THEN
				write(' ',j)
			ELSE
				write('  ',j)
		ELSE
			IF (j=0) THEN
				IF i>9 THEN
					write(' ',i,' ')
				ELSE
					write('  ',i,' ')
			ELSE
				IF (stock.x=j) AND (stock.y=i) THEN
					write(' ',CHR(64),' ')
				ELSE 
					write(' . ')
		END;
		writeln;
	END;
	writeln('Votre adversaire possède encore ',flotte2.restants,' bateau(x). Entrez pour continuer');
	readln;		
END;

VAR
	nGrille:grille;
	i,j:INTEGER;
	Confirm:STRING;
BEGIN
	clrscr;
	writeln('Bienvenue dans le programme de bataille navale');
	writeln('Entrez pour commencer la partie');
	readln;
	clrscr;
	FOR i:=1 TO nbJoueur DO												
	BEGIN
		REPEAT
			writeln;
			writeln('Joueur ' , i ,' :');
			InitFlotte(nGrille[i]);
			nGrille[i].joueur:=i;			
			nGrille[i].restants:=MAXBAT;
			writeln('Entrez "OK" pour confirmer');
			readln(Confirm);
		UNTIL (Confirm='OK');
		clrscr;
	END;
	REPEAT														
		TourDeJeu(nGrille[1],nGrille[2]);	
		clrscr;
			IF Defaite(nGrille[1])=FALSE THEN
			BEGIN
				TourDeJeu(nGrille[2],nGrille[1]);
				clrscr;
			END;
	UNTIL (Defaite(nGrille[1])) OR (Defaite(nGrille[2]));
	readln;
	
END.
