// Médico

+flag (F): team(200) 
  <- +aBandera; 
    .print("medico ha nacido");
    .get_service("capitan");
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
  //<- .print("Friend in fov - medic").

+generarSalud(N)[source(A)]
  <-  .print(A," nos ha pedido que dejemos paquetes de salud.");
      .cure;
      .cure;
      .print("Paquete de salud creado").

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

/* Salud */

+health(H): H < 20 & not disparando //cambiar valor a lo mejor
	<-
  .cure;
  +buscarSalud.

+health(H): H >= 20 & buscarSalud//cambiar valor aqui tb
  <- 
  -buscarSalud.

+buscarSalud
  <- +aporsalud;
     +nopaquetefijado;
     -buscarSalud.

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


/* Municion */
+ammo(A): A < 20 & not solicitarMunicion & not disparando 
	<-
  if(rotando){
    -rotando;
  };
	+solicitarMunicion.


+solicitarMunicion
	<-
	?capitan(Cap_List);
  .send(Cap_List, tell, solMunicion(0));
	.wait(1500).

+ammo(A): A >= 20 & solicitarMunicion 
  <- 
  -solicitarMunicion.

+solicitudMunicionHecha(N)[source(A)]
  <-  .print("Solicitud municion hecha"); 
      +buscarMun.

+buscarMun
  <- +apormunicion;
     +nopaquetefijado;
     -buscarMun.

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
	
