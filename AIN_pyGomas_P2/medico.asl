// Médico

+flag (F): team(200) 
  <- +aBandera; 
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