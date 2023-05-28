// Operador de campo

+flag (F): team(200) 
  <- +aBandera; 
  .print("operador ha nacido");
  .get_service("capitan").
  .goto(F).


+target_reached(T): aBandera
  <-
    .print("Llego a la bandera");
    -aBandera;
    +rotando;
    +rotar(0);
    -target_reached(T).
     
+rotar(0): rotando
	<-
	.turn(1.5);
	.wait(250);
	-+rotar(0).

 //+friends_in_fov(ID,Type,Angle,Distance,Health,Position)
  //<- .print("Friend in fov - fieldop").

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  .print("Salud", Health);
  .look_at(Position);
  if(rotando){
    -rotando;
  };
  if(not friends_in_fov(_,_,Angle,_,_,_)){ 
    +disparando;
    .shoot(5,Position);
    .print("Disparo 5");
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

+generarMunicion(N)[source(A)]
  <-  .print(A," nos ha pedido que dejemos paquetes de municion.");
      .reload;
      .reload;
      .print("Paquete de municion creado").


/* Salud */
+health(H): H < 20 & not solicitarSalud & not disparando 
	<-
  if(rotando){
    -rotando;
  };
	+solicitarSalud.


+solicitarSalud
	<-
	?capitan(Cap_List);
  .send(Cap_List, tell, solSalud(0));
	.wait(1500).

+health(H): H >= 20 & solicitarSalud 
  <- 
  -solicitarSalud.

+solicitudSaludHecha(N)[source(A)]
  <-  .print("Solicitud salud hecha"); 
      +buscarSalud.

+buscarSalud
  <- +aporsalud;
     +nopaquetefijado;
     -buscarSalud.

+packs_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, POS): TYPE == 1001 & nopaquetefijado & aporsalud
  <-    .print("Se ha disparado packs in fov - salud");
        -nopaquetefijado;
        +aporpaquete;
        +paqueteacoger(TYPE);
        .goto(POS).

+target_reached(T): aporpaquete
    <-  -aporpaquete;
        ?paqueteacoger(P);
        -paqueteacoger(P);
        +pack_taken(P).

/* Municion */
+ammo(A): A < 20 & not disparando 
	<-
  .reload;
  +buscarMun.

+ammo(A): A >= 20 & buscarMun
  <- 
  -buscarMun.

+buscarMun
  <- +apormunicion;
     +nopaquetefijado;
     -buscarMun.

+packs_in_fov(ID, TYPE, ANGLE, DIST, HEALTH, POS): TYPE == 1002 & nopaquetefijado & apormunicion
  <-    .print("Se ha disparado packs in fov - mun");
        -nopaquetefijado;
        +aporpaquete;
        +paqueteacoger(TYPE);
        .goto(POS).

+target_reached(T): aporpaquete
    <-  -aporpaquete;
        ?paqueteacoger(P);
        -paqueteacoger(P);
        +pack_taken(P).



/* Paquete cogido */

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
        ?flag(F);
        +aBandera;
        .goto(F).
