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

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): enemies_in_fov(ID,Type2,Angle2,Distance2,Health2,Position2)
  <-
  if(rotando){
    -rotando;
  };
  if(not friends_in_fov(_,_,Angle,_,_,_)){ 
    .shoot(5,Position);
  };
  -enemies_in_fov(ID,Type2,Angle2,Distance2,Health2,Position2).

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  if(rotando){
    -rotando;
  };
  if(not friends_in_fov(_,_,Angle,_,_,_)){ 
    .shoot(5,Position);
  }.

+friends_in_fov(ID,Type,Angle,Distance,Health,Position): friends_in_fov(ID,Type2,Angle2,Distance2,Health2,Position2)
  <-
  -friends_in_fov(ID,Type2,Angle2,Distance2,Health2,Position2).






