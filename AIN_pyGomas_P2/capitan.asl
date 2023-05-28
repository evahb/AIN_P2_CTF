//TEAM_AXIS     CAPITAN

+flag (F): team(200)
  <-
  .register_service("capitan");
  +soldado(0);
  +medico(0);
  +fieldop(1);
  .posicionSoldados(F,P);
  +posicionesIniciales(P);
  .print("posiciones de soldados: ", P, "bandera en: ", F);

  .wait(2000);
  .get_backups.

+asignar("soldado")[source(A)]
  <- 
  ?soldado(N);
  .send(A, tell, asignar(N));
  .print("soldado ", A, " asginado con el numero ",  N);
  -+soldado(N+1).

+myBackups(Backups_list)//: soldado(S) & S >= 4
  <-
  ?posicionesIniciales(P);
  .print("Lista con posiciones iniciales enviada a soldados");
  .send(Backups_list, tell, posiciones(P));
  +rotando;
  +rotar(0).
     
+rotar(0): rotando
	<-
	.turn(1.5);
	.wait(250);
	-+rotar(0).

+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
  <- .print("Friend in fov - capitan").
  
  