//TEAM_AXIS
paquete_tipo(1002, "municion").
paquete_tipo(1001, "medicina").

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

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  .look_at(Position);
  if(rotando){
    -rotando;
  };
  if(not primerEnemigoVisto) {
    +primerEnemigoVisto;
    ?capitan(Cap_List);
    ?position(MyPos);
    .print("Ayuda solicitda")
    .send(Cap_List, tell, solicitarRefuerzo(Position));
  };
  if(not friends_in_fov(_,_,Angle,_,_,_)){ 
    +disparando;
    .shoot(5,Position);
    if(Health < 3){
      -disparando;
      ?health(H);
      +health(H);
      ?ammo(A);
      +ammo(A);
      +rotando;
      +rotar(0);
    };
  }.

/* Hace que la creencia se mantenga actualizada y se borren creeencias anteriores con datos desactualizados */
+friends_in_fov(ID,Type,Angle,Distance,Health,Position): friends_in_fov(ID,Type2,Angle2,Distance2,Health2,Position2)
  <-
  -friends_in_fov(ID,Type2,Angle2,Distance2,Health2,Position2).


/* Salud */

+health(H): H < 20 & not solicitarSalud & not disparando //cambiar valor a lo mejor
	<-
  if(rotando){
    -rotando;
  };
	+solicitarSalud.


+solicitarSalud
	<-
	?capitan(Cap_List);
  ?asignar(N);
	.send(Cap_List, tell, solSalud(N));
	.wait(1500).

+health(H): H >= 20 & solicitarSalud //cambiar valor aqui tb
  <- 
  -solicitarSalud.

+solicitudSaludHecha(N)[source(A)]
  <-  .print("Solicitud salud hecha"); 
      +buscarSalud.

+buscarSalud
  <- ?flag(F);
     .goto(F);
     +aporsalud;
     +nopaquetefijado;
     -buscarSalud.

// TYPE == 1001 SALUD

+packs_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, POS): TYPE == 1001 & nopaquetefijado & aporsalud
  <-    .print("Se ha disparado packs in fov - health");
        -nopaquetefijado;
        +aporpaquete;
        +paqueteacoger(TYPE);
        .goto(POS).

+target_reached(T): aporpaquete
    <-  -aporpaquete;
        ?paqueteacoger(P);
        -paqueteacoger(P);
        +pack_taken(P).

+pack_taken(Type): Type < 1003 
    <-  ?paquete_tipo(Type, Tipo);
    	  .print("He cogido un paquete de tipo: ", Tipo);
    	  if(Type == 1001){
    	     -aporsalud;
    	  };
        if(Type == 1002){
           -apormunicion;
    	  }; 
        // Vuelve a su pos inicial
        -pack_taken(Type);
        ?asignar(Num);
        ?posicionesIniciales(Posiciones);
        .nth(Num, Posiciones, Punto);
        +aPuntoVigia;
        .goto(Punto).

/* Municion */
// TYPE == 1002 MUNICION

+ammo(A): A < 20 & not solicitarMunicion & not disparando //cambiar valor a lo mejor
	<-
  if(rotando){
    -rotando;
  };
	+solicitarMunicion.


+solicitarMunicion
	<-
	?capitan(Cap_List);
  ?asignar(N);
	.send(Cap_List, tell, solMunicion(N));
	.wait(1500).

+ammo(A): A >= 20 & solicitarMunicion //cambiar valor aqui tb
  <- 
  -solicitarMunicion.

+solicitudMunicionHecha(N)[source(A)]
  <-  .print("Solicitud salud hecha"); 
      +buscarMun.

+buscarMun
  <- ?flag(F);
     .goto(F);
     +apormunicion;
     +nopaquetefijado;
     -buscarMun.

// TYPE == 1002 Municion

+packs_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, POS): TYPE == 1002 & nopaquetefijado & apormunicion
  <-    .print("Se ha disparado packs in fov - municion");
        -nopaquetefijado;
        +aporpaquete;
        +paqueteacoger(TYPE);
        .goto(POS).

+target_reached(T): aporpaquete
    <-  -aporpaquete;
        ?paqueteacoger(P);
        -paqueteacoger(P);
        +pack_taken(P).


+reforzar(Pos): asignar(N) & N=4
  <- 
  +aRefuerzo;
  .print("Yendo a refuerzo");
  .goto(Pos).

+target_reached(T): aRefuerzo
  <-
  -aRefuerzo;
  +rotando;
  +rotar(0);
  -target_reached(T).


