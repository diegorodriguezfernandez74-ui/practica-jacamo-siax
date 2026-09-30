!say_hello.
!count.

+!say_hello
    <- .send(bob, tell, greeting("hola mundo")).

+!count
    <- inc_get(1, V);
       .print("Valor unico: ", V);
       .wait(1000);
       !count.

{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }
