// Paso 3: el destinatario del saludo se obtiene por su rol.
!say_hello.
!count.

+!say_hello
    <- .wait(play(Ag, role2, _));
       .send(Ag, tell, greeting("hola mundo")).

+!count
    <- inc_get(1, V);
       .print("Valor unico: ", V);
       .wait(1000);
       !count.

{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }
