# Practica de JaCaMo

Sistema multiagente con JaCaMo 1.3.0, Java JDK 21 y Gradle Wrapper 8.10.

## Requisitos

Instalar un JDK 21 y configurar `JAVA_HOME` para que apunte a su carpeta. El comando `java -version` debe mostrar Java 21 en la terminal usada para el proyecto. No es necesario instalar Gradle: se incluye el Wrapper.

La primera ejecucion necesita conexion a Internet para descargar Gradle y las dependencias.

## Ejecutar en Windows

Abre PowerShell en la carpeta que contiene `gradlew.bat`, `build.gradle` y `hola.jcm`. Al extraer el ZIP puede quedar una carpeta `practica-jacamo` dentro de otra: entra en la interior si es ahi donde estan esos archivos.

Comprueba primero:

```powershell
Test-Path .\gradlew.bat
java -version
```

El primer comando debe devolver `True` y el segundo debe indicar Java 21. Si tienes otro Java, configura `JAVA_HOME` con la ruta de tu JDK 21 y agrega su carpeta `bin` al principio de `Path` en esta terminal.

Copia solamente el contenido de los bloques de comandos, sin el texto `PS C:\...>` de la terminal. El archivo se llama `gradlew.bat`: no pongas una barra entre `gradlew` y `.bat`. Conserva las comillas alrededor de todo el argumento `"-Pmas=hola.jcm"` (o el paso correspondiente) para que PowerShell lo pase completo a Gradle.

Ejecuta una etapa cada vez y detenla con Ctrl+C antes de iniciar otra. Si pregunta si quieres terminar el trabajo por lotes, confirma con `S`. Los ejemplos siguen activos hasta que los detienes; no tienen que terminar con `BUILD SUCCESSFUL`. Una cancelacion manual no indica que el ejemplo haya fallado.

```powershell
# Ejemplo inicial: Bob imprime hello world y observa el contador.
.\gradlew.bat -q --console=plain run "-Pmas=hola.jcm"

# Paso 1: Alice envia un saludo a Bob.
.\gradlew.bat -q --console=plain run "-Pmas=paso1.jcm"

# Paso 2: ambos agentes utilizan el contador compartido.
.\gradlew.bat -q --console=plain run "-Pmas=paso2.jcm"

# Paso 3: sistema completo con organizacion y roles.
.\gradlew.bat -q --console=plain run
```

En Linux o macOS, usa `./gradlew` en lugar de `.\gradlew.bat`; si hace falta, habilita su ejecucion con `chmod +x gradlew`.

## Resultados esperados

| Ejecucion | Comprobacion |
|---|---|
| `hola.jcm` | Aparece `[bob] hello world.`. En el inspector, Bob observa `count(3)`. |
| `paso1.jcm` | Aparece `[bob] He recibido hola mundo de alice`. |
| `paso2.jcm` | Aparece el saludo y valores crecientes de `Valor unico` y `contador`. El orden y los valores exactos pueden variar. |
| Ejecucion por defecto | Aparecen el saludo y el contador; el grupo `my_group` tiene Alice en `role1` y Bob en `role2`. |

## Estructura

| Archivo o carpeta | Funcion |
|---|---|
| `hola.jcm` | Ejemplo inicial. |
| `paso1.jcm` | Comunicacion entre agentes. |
| `paso2.jcm` | Entorno compartido. |
| `holamundo.jcm` | Aplicacion completa; es la que arranca por defecto. |
| `src/agt/` | Planes de los agentes Jason. |
| `src/env/example/Counter.java` | Artefacto contador de CArtAgO. |
| `src/org/org.xml` | Especificacion de la organizacion Moise. |
| `src/test/` | Prueba del objetivo start del agente inicial. |
| `build.gradle` | Compilacion, dependencias, pruebas y empaquetado. |

El paso 3 crea `my_group`, con Alice en `role1` y Bob en `role2`. Alice envia el saludo al agente que ocupa `role2`. El XML define tambien misiones y normas, pero esta aplicacion no instancia el esquema de misiones.

## Inspectores

Durante la ejecucion, utiliza las direcciones que imprime la consola. Los puertos habituales son:

- Jason: http://localhost:3272
- CArtAgO: http://localhost:3273
- Moise, en el paso 3: http://localhost:3271

Comprueba el saludo recibido, la propiedad `count` y los roles del grupo. Los identificadores internos y el orden de los incrementos pueden variar entre ejecuciones. Si los puertos estan ocupados, la consola indicara otros.

## Pruebas y entrega ejecutable

```powershell
.\gradlew.bat --console=plain test --info
.\gradlew.bat --console=plain uberJar
java -jar .\build\libs\jacamo-practica-jacamo-1.0-all.jar
```

El nombre del JAR depende del nombre de la carpeta del proyecto. El comando `uberJar` imprime su nombre y el comando exacto para ejecutarlo.

La prueba debe mostrar `#1 tests executed, #1 PASSED and #0 failed` y `BUILD SUCCESSFUL`. El empaquetado tambien debe terminar con `BUILD SUCCESSFUL`. Ejecuta despues el JAR: debe mostrar el mismo saludo, contador y roles que el sistema completo. Detenlo con Ctrl+C antes de iniciar otro ejemplo.

La prueba incluida verifica que el objetivo `start` incorpora la creencia `started(...)`. Los tres pasos pueden comprobarse con la consola y los inspectores.

## Historial Git

Esta carpeta es una exportacion del proyecto sin el historial anterior. Para publicar desde ella, inicializa un repositorio y registra el estado actual en un commit.

## Solucion de errores habituales

- **Task '.jcm' not found:** conserva las comillas en `"-Pmas=hola.jcm"`. No ejecutes `.jcm` como un argumento separado.
- **No se reconoce gradlew.bat:** comprueba que `Test-Path .\gradlew.bat` devuelve `True` y escribe `.\gradlew.bat`, sin otra barra intermedia.
- **Version de Java incompatible:** comprueba `java -version` y `JAVA_HOME` en la misma terminal; utiliza JDK 21.
- **Aviso sobre jason.jar de classpath y configuracion:** si continua con `Using the jason.jar from classpath` y aparecen los mensajes esperados, es un aviso de configuracion local, no un fallo de la practica.
- **Inspectores no disponibles:** deja el ejemplo ejecutandose y usa las direcciones y los puertos que imprime esa ejecucion. Moise corresponde al ejemplo completo.
- **AccessDeniedException al leer una biblioteca:** ejecuta `.\gradlew.bat --stop` y repite el comando. El proyecto configura `org.gradle.daemon=false` para evitar reutilizar procesos persistentes con permisos distintos. Si continua, hay que revisar el acceso al archivo indicado; no borres las bibliotecas sin diagnosticarlo.
