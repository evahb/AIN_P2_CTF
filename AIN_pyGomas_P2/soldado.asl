//TEAM_AXIS


+flag (F): team(200)
  <-
  .wait(1000);
  .get_service("capitan").


+capitan(Cap_List)
  <-
  .send(Cap_List, tell, asignar("soldado")).

+asignar(N)
  <-
  .print("soldado asignado ", N).

+posiciones(Posiciones): asignar(Num) & Num < 4
  <-
  +posicionesIniciales(Posiciones);
  .nth(Num, Posiciones, Punto);
  .print("Agente: ", Num, " asignado al punto: ", Punto);
  +aPuntoVigia;
  .goto(Punto).

+posiciones(Posiciones): asignar(Num) & Num == 4
  <-  .print("Soy el soldado 4");
      ?flag(F);
      +aPuntoVigia;
      .goto(F).

+target_reached(T): aPuntoVigia
  <- -aPuntoVigia;
     +rotando;
     +rotar(0);
     -target_reached(T).
     
+rotar(0): rotando
	<-
	.turn(1.5);
	.wait(250);
	-+rotar(0).

/* Visualiza enemigos */

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): atacando
  <-  .look_at(Position);
      if(rotando){
      -rotando;
      };
      .shoot(15,Position).

+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
  <- .print("Friend in fov").


+enemies_in_fov(_, _, _, _, _, Position)
	<-
	.look_at(Position);
	.print("Nuevo enemy in fov");
	+puedoDisparar(True);
	.while (?friends_in_fov(_,_,_,_,_,AmigoPos) & ?puedoDisparar(C) & C) {
		?position(MiPosicion);
		.print("Position", MiPosicion);
	}  
	
	-puedoDisparar(_).
