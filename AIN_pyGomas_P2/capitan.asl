//TEAM_AXIS     CAPITAN

+flag (F): team(200)
  <-
  .register_service("capitan");
  +soldado(0);
  +medico(0);
  +fieldop(0).

+asignar("soldado")[Source(A)]
  <- 
  ?soldado(N);
  .send(A, tell, asignar(N));
  -+soldado(N+1).