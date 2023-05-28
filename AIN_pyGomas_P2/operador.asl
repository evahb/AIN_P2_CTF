// Operador de campo

+flag (F): team(200) 
  <- +aBandera; 
  .print("operador ha nacido");
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
  .look_at(Position);
  if(rotando){
    -rotando;
  };
  if(not friends_in_fov(_,_,Angle,_,_,_)){ 
    .shoot(5,Position);
  }.

+generarMunicion(N)[source(A)]
  <-  .print(A," nos ha pedido que dejemos paquetes de municion.");
      .reload;
      .reload;
      .print("Paquete de municion creado").
