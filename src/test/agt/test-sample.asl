// Comprueba que el objetivo start incorpora la creencia started.

// Codigo del agente que se prueba.
{ include("sample_agent.asl") }

// Biblioteca de pruebas de Jason.
{ include("tester_agent.asl") }

@[test]
+!test_start
    <-  !start;
        !assert_true( started(_,_,_,_,_,_) ).

