+++
draft = false
title = 'Reporte No. 4'

[header]
  featured = true
summary = "Práctica 3: Entorno de Desarrollo Haskell y Aplicación TODO"
+++

# Práctica 3: Entorno de Desarrollo Haskell y Aplicación TODO

Link de portafolio en GitHub: [Asignatura Paradigmas](https://github.com/MikeArmando/asignatura-paradigmas)

Link de portafolio en GitHub Pages (página estática): [Asignatura Paradigmas](https://mikearmando.github.io/asignatura-paradigmas/)
 
---
 
## Sesión 1 — Instalación del Entorno de Desarrollo
 
### 1.1 Descripción General
 
Para trabajar con Haskell se requiere instalar un conjunto de herramientas que conforman el entorno de desarrollo. La forma oficial y recomendada de hacerlo es mediante **GHCup**, un instalador universal del ecosistema Haskell disponible en [haskell.org/downloads](https://www.haskell.org/downloads/).
 
### 1.2 Herramientas Instaladas
 
Al ejecutar el comando de instalación de GHCup se obtienen los siguientes componentes:
 
| Herramienta                          | Función                                                                                                                                                                                           |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **GHCup**                            | Gestor del entorno de desarrollo. Descarga, instala y actualiza las demás herramientas del ecosistema Haskell.                                                                                    |
| **GHC** *(Glasgow Haskell Compiler)* | Compilador principal de Haskell. Transforma el código fuente `.hs` en binarios ejecutables.                                                                                                       |
| **GHCi** *(anteriormente Hugs)*      | Intérprete interactivo de Haskell (REPL). Permite ejecutar expresiones y probar código sin necesidad de compilar.                                                                                 |
| **HLS** *(Haskell Language Server)*  | Servidor de lenguaje que provee autocompletado, análisis estático y otras ayudas al editor. Contiene las librerías estándar y el código base del que dependen GHC y GHCi. No se usa directamente. |
| **Stack**                            | Manejador de paquetes y proyectos, similar a `pip` en Python o `apt` en Ubuntu/Debian.                                                                                                            |
| **Cabal**                            | Herramienta de empaquetado y compilación (*build tool*). Coordina a Stack (para descargar dependencias) y a GHC (para compilar), todo en un solo comando.                                         |
 
> Los archivos de código fuente Haskell utilizan la extensión **`.hs`**.
 
### 1.3 Proceso de Instalación en Windows 10
 
#### Paso 1 — Abrir PowerShell
 
Se abre una ventana de **PowerShell** en modo normal (sin privilegios de administrador). Esto es importante ya que el instalador de GHCup gestiona los permisos por su cuenta.
 
![EVIDENCIA](img/p3_ps.png)
 
#### Paso 2 — Ejecutar el Comando de GHCup
 
En la página oficial de GHCup ([haskell.org/ghcup](https://www.haskell.org/ghcup/)) se encuentra el comando de instalación para Windows. Se copia y se pega directamente en PowerShell:
 
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -ArgumentList $true
```
 
#### Paso 3 — Seguir el Asistente de Instalación
 
El script descarga GHCup y luego presenta un menú interactivo en la terminal con opciones de instalación. Se selecciona la opción de instalación recomendada (*recommended*), que incluye automáticamente GHC, HLS, Cabal y Stack.
 
#### Paso 4 — Esperar la Descarga e Instalación
 
GHCup descarga e instala todos los componentes. El proceso puede tomar varios minutos dependiendo de la velocidad de internet, ya que GHC y HLS son paquetes de tamaño considerable.
 
#### Paso 5 — Verificar la Instalación
 
Al finalizar la instalación, se abre una **nueva** ventana de PowerShell (para que las variables de entorno se actualicen) y se verifica cada herramienta con los siguientes comandos:
 
```powershell
ghc --version
 
stack --version
 
cabal --version
 
ghci
```
 
![EVIDENCIA](img/p3_ps2.png)

 
Para salir de GHCi se escribe `:quit` o `:q`.
 
### 1.4 Verificación con la Guía Oficial de Get Started
 
Siguiendo la [guía oficial de inicio de Haskell](https://www.haskell.org/get-started/), se ejecuta un programa sencillo de prueba para confirmar que el compilador funciona correctamente.
 
Se crea un archivo `Main.hs` con el siguiente contenido:
 
```haskell
module Main where
 
main :: IO ()
main = putStrLn "Hello, Haskell!"
```
 
Y se compila o ejecuta con GHC o `runghc`:
 
```powershell
runghc Main.hs
```
 
![EVIDENCIA](img/p3_ps3.png)
 
---
 
## Sesión 2 — Aplicación TODO en Haskell
 
### 2.1 Descripción de la Aplicación
 
La aplicación TODO es un gestor de tareas que se ejecuta en la terminal (*CLI — Command Line Interface*). Fue desarrollada en Haskell como ejemplo del paradigma funcional, demostrando conceptos como pattern matching, recursión, listas y la mónada IO para manejo de efectos secundarios.
 
El código fuente proviene del blog de Haskell ([haskell.org/examples/blog/todo](https://www.haskell.org/)) y es referenciado también en el artículo *"How to use Haskell to build a todo app with Stack"*.
 
### 2.2 Creación del Proyecto con Stack
 
#### Paso 1 — Crear un nuevo proyecto
 
Stack permite generar la estructura de un proyecto Haskell a partir de una plantilla:
 
```powershell
stack new todo
cd todo
```
 
![EVIDENCIA](img/p3_ps4.png)

 
El proyecto genera la siguiente estructura de archivos:
 
```
todo/
├── app/
│   └── Main.hs        ← Punto de entrada del programa
├── src/
│   └── Lib.hs         ← Lógica de la librería (puede dejarse vacío)
├── test/
│   └── Spec.hs        ← Pruebas unitarias
├── package.yaml       ← Configuración de dependencias
└── stack.yaml         ← Configuración de Stack y versión de GHC
```
 
#### Paso 2 — Código fuente de la aplicación
 
El código principal de la aplicación TODO se coloca en `app/Main.hs`. A continuación se presenta el código completo con explicación de cada sección:
 
```haskell
import Data.List (delete)
```
 
Se importa la función `delete` del módulo `Data.List` de la librería estándar. Esta función elimina la **primera ocurrencia** de un elemento en una lista.
 
```haskell
putTodo :: (Int, String) -> IO ()
putTodo (n, todo) = putStrLn (show n ++ ": " ++ todo)
```
 
La función `putTodo` recibe una tupla `(índice, texto)` y la imprime en pantalla con formato `"0: Tarea"`. El tipo `IO ()` indica que esta función realiza una operación de entrada/salida sin retornar un valor útil.
 
```haskell
prompt :: [String] -> IO ()
prompt todos = do
    putStrLn ""
    putStrLn "Current TODO list:"
    mapM_ putTodo (zip [0..] todos)
    command <- getLine
    interpret command todos
```
 
La función `prompt` es el **núcleo del ciclo principal**. Recibe la lista actual de tareas, las muestra en pantalla numeradas, y luego espera que el usuario ingrese un comando. La función `mapM_` aplica `putTodo` a cada par `(índice, tarea)` generado por `zip [0..]`. Finalmente pasa el comando a `interpret`.
 
```haskell
interpret :: String -> [String] -> IO ()
interpret ('+':' ':todo) todos = prompt (todo:todos)
interpret ('-':' ':num ) todos =
    case delete (read num) todos of
        Nothing     -> do
            putStrLn "No TODO entry matches the given number"
            prompt todos
        Just todos' -> prompt todos'
interpret "q"     todos  = return ()
interpret command todos  = do
    putStrLn ("Invalid command: `" ++ command ++ "`")
    prompt todos
```
 
La función `interpret` utiliza **pattern matching** para identificar el comando ingresado:
 
- `'+' : ' ' : todo` → Si el string comienza con `"+ "`, añade la tarea al frente de la lista con el operador `:` y vuelve a `prompt`.
- `'-' : ' ' : num` → Si comienza con `"- "`, intenta eliminar la tarea con el índice dado. Si no existe, notifica al usuario; si existe, actualiza la lista.
- `"q"` → Termina el programa retornando `()`.
- Cualquier otra entrada → Muestra un mensaje de error y vuelve al prompt.
> El patrón `'+':' ':todo` es una forma funcional de analizar una cadena carácter por carácter, característica fundamental del paradigma funcional en Haskell.
 
```haskell
main :: IO ()
main = do
    putStrLn "Commands:"
    putStrLn "+ <String> - Add a TODO entry"
    putStrLn "- <Int>    - Delete the numbered entry"
    putStrLn "q          - Quit"
    prompt []
```
 
La función `main` es el punto de entrada del programa. Muestra el menú de comandos disponibles e inicia el ciclo con `prompt []`, pasando una lista vacía de tareas.
 
### 2.3 Compilación y Ejecución
 
#### Compilar el proyecto:
 
```powershell
stack build
```

![EVIDENCIA](img/p3_ps5.png)

 
#### Ejecutar la aplicación:
 
```powershell
stack run
```
 
![EVIDENCIA](img/p3_ps6.png)

 
### 2.4 Funcionamiento de la Aplicación
 
Al ejecutar la aplicación, se muestra el menú de comandos disponibles:
 
```
Commands:
+ <String> - Add a TODO entry
- <Int>    - Delete the numbered entry
q          - Quit
 
Current TODO list:
```
 
A continuación se muestra un ejemplo de sesión de uso:
 

 ![EVIDENCIA](img/p3_ps7.png)

 
### 2.5 Conceptos del Paradigma Funcional Demostrados
 
La aplicación TODO ilustra varios conceptos clave de la programación funcional:
 
**Recursión en lugar de ciclos:** La función `prompt` se llama a sí misma (a través de `interpret`) en cada iteración. No existe un `while` o `for`; el ciclo se implementa mediante recursión.
 
**Inmutabilidad:** La lista `todos` nunca se modifica en su lugar. Cada operación genera una **nueva lista** con los cambios aplicados. Esto es una característica central del paradigma funcional.
 
**Pattern Matching:** La función `interpret` analiza la forma del string de entrada sin condicionales `if-else`. Haskell compara el valor contra cada patrón en orden hasta encontrar una coincidencia.
 
**Tipos e IO:** El sistema de tipos de Haskell separa explícitamente las funciones puras (sin efectos secundarios) de las que realizan IO. Esto queda expresado en las firmas de tipo con `IO ()`.
 
---
 
## Conclusión
 
En esta práctica se instaló exitosamente el entorno de desarrollo de Haskell mediante GHCup, obteniendo el compilador GHC, el intérprete GHCi, el servidor de lenguaje HLS, el gestor de paquetes Stack y la herramienta de compilación Cabal. También se analizó la aplicación TODO escrita en Haskell, la cual demuestra en forma concisa los principios del paradigma funcional: recursión, inmutabilidad, pattern matching y el manejo explícito de efectos de IO mediante el sistema de tipos.
 
---
 
## Referencias
 
- Haskell Downloads. [https://www.haskell.org/downloads/](https://www.haskell.org/downloads/)
- GHCup — Universal Haskell Installer. [https://www.haskell.org/ghcup/](https://www.haskell.org/ghcup/)
- Get Started with Haskell. [https://www.haskell.org/get-started/](https://www.haskell.org/get-started/)
- Basic Haskell Examples — Haskell for all. [https://www.haskellforall.com/2015/10/basic-haskell-examples.html](https://www.haskellforall.com/2015/10/basic-haskell-examples.html)
- How to use Haskell to build a todo app with Stack. [https://dev.to/steadylearner/how-to-use-stack-to-build-a-haskell-app-499j](https://dev.to/steadylearner/how-to-use-stack-to-build-a-haskell-app-499j)
- Haskell Tutorial for C Programmers. [https://wiki.haskell.org/Haskell_Tutorial_for_C_Programmers](https://wiki.haskell.org/Haskell_Tutorial_for_C_Programmers)