//TEAM_AXIS     CAPITAN

+flag (F): team(200)
  <-
  .register_service("capitan");
  +soldado(0);
  +medico(0);
  +fieldop(0);
  .posicionSoldados(F,P);
  +posicionSoldados(P);
  .print("posiciones de soldados: ", P)

  .wait(1000);
  .get_backups.

+asignar("soldado")[source(A)]
  <- 
  ?soldado(N);
  .send(A, tell, asignar(N));
  .print("soldado ", A, " asginado con el numero ",  N);
  -+soldado(N+1).

+myBackups(Backups_list):
  <-
  .send(Backups_list, tell, posiciones(P)).
  