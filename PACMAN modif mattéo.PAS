
PROGRAM pacman;

uses crt, sysutils, type_pacman, Niveau_lib, deplacement_lib, interaction_lib;

var
  select,nomJoueur : STRING;
  niv : Niveau;
  dir : TableauDir;
  bonus : byte;
  vie, fin, i : byte; {fin = 0 : la partie est en cours || fin = 1 : mange par un fantome || fin = 2 : manger tout les pièces}
  temps : LONGWORD;
  score : word;
  k : char;
  fichierScore :Text ;
  
BEGIN

  Randomize;
  clrscr;
  cursoroff;

  TextColor(Red); 
writeln('PPPPPPPPPPPPPPPPP                                         MMMMMMMM               MMMMMMMM                                        '); 
writeln('P::::::::::::::::P                                        M:::::::M             M:::::::M                                         '); 
writeln('P::::::PPPPPP:::::P                                       M::::::::M           M::::::::M                                         '); TextColor(Magenta);
writeln('PP:::::P     P:::::P                                      M:::::::::M         M:::::::::M                                         '); 
writeln(' P::::P     P:::::P  aaaaaaaaaaaaa       ccccccccccccccccM::::::::::M       M::::::::::M  aaaaaaaaaaaaa   nnnn  nnnnnnnn         ');
writeln('P::::P     P:::::P  a::::::::::::a    cc:::::::::::::::cM:::::::::::M     M:::::::::::M  a::::::::::::a  n:::nn::::::::nn       '); 
 TextColor(Green);
writeln('P::::PPPPPP:::::P   aaaaaaaaa:::::a  c:::::::::::::::::cM:::::::M::::M   M::::M:::::::M  aaaaaaaaa:::::a n::::::::::::::nn      '); 
writeln(' P:::::::::::::PP             a::::a c:::::::cccccc:::::cM::::::M M::::M M::::M M::::::M           a::::a nn:::::::::::::::n     '); 
writeln(' P::::PPPPPPPPP        aaaaaaa:::::a c::::::c     cccccccM::::::M  M::::M::::M  M::::::M    aaaaaaa:::::a   n:::::nnnn:::::n     '); 
 TextColor(Yellow);
writeln(' P::::P              aa::::::::::::a c:::::c             M::::::M   M:::::::M   M::::::M  aa::::::::::::a   n::::n    n::::n     '); 
writeln(' P::::P             a::::aaaa::::::a c:::::c             M::::::M    M:::::M    M::::::M a::::aaaa::::::a   n::::n    n::::n     '); 
writeln(' P::::P            a::::a    a:::::a c::::::c     cccccccM::::::M     MMMMM     M::::::Ma::::a    a:::::a   n::::n    n::::n     '); 
TextColor(Red);
writeln('PP::::::PP          a::::a    a:::::a c:::::::cccccc:::::cM::::::M               M::::::Ma::::a    a:::::a   n::::n    n::::n     '); 
writeln('P::::::::P          a:::::aaaa::::::a  c:::::::::::::::::cM::::::M               M::::::Ma:::::aaaa::::::a   n::::n    n::::n     '); 
writeln('P::::::::P           a::::::::::aa:::a  cc:::::::::::::::cM::::::M               M::::::M a::::::::::aa:::a  n::::n    n::::n     '); 
writeln('PPPPPPPPPP            aaaaaaaaaa  aaaa    ccccccccccccccccMMMMMMMM               MMMMMMMM  aaaaaaaaaa  aaaa  nnnnnn    nnnnnn     '); 
 TextColor(Blue);GotoXY(25,31); Write('Choisis le niveau du jeu :'); Delay(100); 
 TextColor(Red); GotoXY(24,31);Write('Choisis le niveau du jeu :'); Delay(100);
 TextColor(Yellow);GotoXY(25,31); Write('Choisis le niveau du jeu :'); Delay(100);
 TextColor(Green); GotoXY(25,31);Write('Choisis le niveau du jeu :'); Delay(100);
 TextColor(Magenta);GotoXY(25,31); Write('Choisis le niveau du jeu :'); Delay(100);
 TextColor(White);GotoXY(25,31); Write('Choisis le niveau du jeu :'); Delay(100);
  ReadLn(select);
clrscr;

  if (select = '') then
    select := 'lvl1';

  windmaxx := 50;
  windmaxy := 50;
  clrscr;

  temps := 0;
  vie := 3;
  score := 0;
  chargement(select,niv);


  while vie <> 0 do
  begin
    bonus := 0;
    fin := 0;

    niv.pos := niv.pos_start;
    for i := 0 to 4 do dir[i] := 0;

    affichage_niv(niv);
    affichage_perso(niv, bonus,vie, score);

    delay(3000);

    while fin = 0 do
    begin

      while Keypressed do
      Begin
        k := ReadKey;
        case k of
          #72 : if (niv.tab[niv.pos[0].x ,niv.pos[0].y - 1] > 1) then dir[0] := 1; {haut}
          #77 : if (niv.tab[niv.pos[0].x + 1 ,niv.pos[0].y] > 1) then dir[0] := 2; {droite}
          #80 : if (niv.tab[niv.pos[0].x ,niv.pos[0].y + 1] > 1) then dir[0] := 3; {bas}
          #75 : if (niv.tab[niv.pos[0].x - 1 ,niv.pos[0].y] > 1) then dir[0] := 4; {gauche}
          'q' : fin := 1;
        end;
      end;

      if temps mod 3 = 0 then
      begin
        Mouvement(niv,dir,bonus);
        Interaction(niv,temps,score,vie,bonus,fin);
        affichage_perso(niv,bonus,vie,score);
      end;

      delay(100);
      temps := temps + 1;
    end;

	if fin = 1 then
	  vie := vie - 1
  else if fin = 2 then
  begin
    chargement(select,niv);
    temps := 0;
  end; 

clrscr;

assign(fichierScore,'Scoreboard.txt'); 
if FileExists('Scoreboard.txt') then
	begin
		append(fichierScore);
		writeln('Entrez votre nom:');
		readln(nomJoueur);
		writeln(fichierScore,nomJoueur,' ',score);
		close(fichierScore)
	end
else
	begin
		rewrite(fichierScore);
		writeln('Entrez votre nom:');
		readln(nomJoueur);
		writeln(fichierScore,nomJoueur,' ',score);
		close(fichierScore)
	end;
  
  end;
END.
=======
{PROGRAM pacman;

uses crt, sysutils, type_pacman, Niveau_lib, deplacement_lib, interaction_lib;

var
  select : STRING;
  niv : Niveau;
  dir : TableauDir;
  bonus : byte;
  vie, fin, i : byte; {fin = 0 : la partie est en cours || fin = 1 : mange par un fantome || fin = 2 : manger tout les pièces
  temps : LONGWORD;
  score : word;
  k : char;

BEGIN

  Randomize;
  clrscr;
  cursoroff;

  WriteLn('*********************************************');
  WriteLn('*** Bienvenue sur ManPac  ***');
  WriteLn('*********************************************');
  WriteLn();
  WriteLn('Choisis le niveau du jeu :');
  ReadLn(select);

  if (select = '') then
    select := 'lvl1';

  windmaxx := 50;
  windmaxy := 50;
  clrscr;

  temps := 0;
  vie := 3;
  score := 0;
  chargement(select,niv);


  while vie <> 0 do
  begin
    bonus := 0;
    fin := 0;

    niv.pos := niv.pos_start;
    for i := 0 to 4 do dir[i] := 0;

    affichage_niv(niv);
    affichage_perso(niv, bonus,vie, score);

    delay(3000);

    while fin = 0 do
    begin

      while Keypressed do
      Begin
        k := ReadKey;
        case k of
          #72 : if (niv.tab[niv.pos[0].x ,niv.pos[0].y - 1] > 1) then dir[0] := 1; {haut
          #77 : if (niv.tab[niv.pos[0].x + 1 ,niv.pos[0].y] > 1) then dir[0] := 2; {droite
          #80 : if (niv.tab[niv.pos[0].x ,niv.pos[0].y + 1] > 1) then dir[0] := 3; {bas
          #75 : if (niv.tab[niv.pos[0].x - 1 ,niv.pos[0].y] > 1) then dir[0] := 4; {gauche
          'q' : fin := 1;
        end;
      end;

      if temps mod 3 = 0 then
      begin
        Mouvement(niv,dir,bonus);
        Interaction(niv,temps,score,vie,bonus,fin);
        affichage_perso(niv,bonus,vie,score);
      end;

      delay(80);
      temps := temps + 1;
    end;

	if fin = 1 then
	  vie := vie - 1
  else if fin = 2 then
  begin
    chargement(select,niv);
    temps := 0;
  end;

  end;
END.}

