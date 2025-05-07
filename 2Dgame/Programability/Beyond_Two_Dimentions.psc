Algoritmo Beyond_Two_Dimensions_Mejorado
	
    // Esto definirá la barra de carga y la mostrará //
    Definir loadscreen Como Real
    loadscreen <- 0.0
    
    Repetir
        Esperar 70 Milisegundos
        loadscreen <- loadscreen + 1.0
        Escribir "Cargando... ", loadscreen, "%"
    Hasta Que loadscreen >= 100.0
    
    Definir Exit Como Logico
    Exit <- Verdadero
    
    Mientras Exit = Verdadero
		
        Borrar Pantalla
        Escribir "¿Quiere empezar? S (Si) / N (No)"
        Leer Inicio
        
        Si Inicio = 'N' Entonces
            Exit <- Falso
        SiNo
            Si Inicio = 'S' Entonces
                Esperar 100 Milisegundos
                Borrar Pantalla
                
                // Empezamos cinemática automáticamente 3 segundos
                Escribir "Se está reproduciendo la cinemática 1..."
                Esperar 3000 Milisegundos
                
                Definir Cinematica1 Como Logico
                Cinematica1 <- Verdadero
                
                Mientras Cinematica1 = Verdadero
                    Escribir "¿Desea saltar la cinemática?"
                    Escribir "S (Sí) / N (No) / SA (Salir)"
                    Leer SKIP
                    
                    Si SKIP = 'S' Entonces
                        Cinematica1 <- Falso
                    SiNo
                        Si SKIP = 'N' Entonces
                            Escribir "Reproduciendo cinemática completa..."
                            Esperar 10000 Milisegundos // o 15000 si quieres
                            Cinematica1 <- Falso
                        SiNo
                            Si SKIP = 'SA' Entonces
                                Exit <- Falso
                                Cinematica1 <- Falso
                            SiNo
                                Escribir "Opción no válida. Por favor, intente de nuevo."
                            FinSi
                        FinSi
                    FinSi
                FinMientras
                
                // Aquí puedes continuar con el resto del juego si Exit sigue siendo Verdadero
                Si Exit Entonces
                    Borrar Pantalla
                    Escribir "Fin de la cinemática. Comienza el juego..."
                    // Aquí iría el resto del juego
                    // Por ahora, cerramos el juego para probar que funciona
                    Exit <- Falso
                FinSi
            SiNo
                Borrar Pantalla
                Escribir "Opción no válida. Intente de nuevo."
            FinSi
        FinSi
		
    FinMientras
	
    Escribir "Gracias por jugar. ¡Adiós!"
	
    // Variables generales
    Definir AxisX, AxisY, SpdY, Gravity, DeltaTime Como Real
    Definir InTheFloor, FacingRight Como Lógico
    Definir EAxisX, EAxisY, ESpdY, EGravity, EDeltaTime Como Real
    Definir EInTheFloor, EFacingRight Como Lógico
    Definir jugando, GameOver Como Lógico
    Definir vida, vidaE Como Entero
    
    // Proyectil jugador
    Definir PX, PY Como Real
    Definir Disparando Como Lógico
    Definir ProyectilDir Como Entero
    
    // Proyectil enemigo
    Definir EPX, EPY Como Real
    Definir EDisparando Como Lógico
    Definir EProyectilDir Como Entero
    
    // Inicialización
    AxisX <- 25
    AxisY <- 2
    SpdY <- 0
    Gravity <- -20.0
    DeltaTime <- 0.1
    InTheFloor <- Verdadero
    FacingRight <- Verdadero
    vida <- 10
    
    EAxisX <- 45
    EAxisY <- 2
    ESpdY <- 0
    EGravity <- -20.0
    EDeltaTime <- 0.1
    EInTheFloor <- Verdadero
    EFacingRight <- Falso
    vidaE <- 100
    
    Disparando <- Falso
    EDisparando <- Falso
    primerDisparoEnemigo <- Verdadero
    
    jugando <- Verdadero
    GameOver <- Falso
    
    Mientras jugando Hacer
        Limpiar Pantalla
        
        // Colisión jugador-enemigo
        Si Trunc(AxisX) = Trunc(EAxisX) Y Trunc(AxisY) = Trunc(EAxisY) Entonces
            vida <- vida - 1
        FinSi
        
        // Colisión proyectil jugador-enemigo (mejorada)
        Si Disparando Entonces
            Si Abs(Trunc(PX) - Trunc(EAxisX)) <= 1 Y Abs(Trunc(PY) - Trunc(EAxisY)) <= 1 Entonces
                vidaE <- vidaE - 5
                Disparando <- Falso
            FinSi
        FinSi
        
        // Colisión proyectil enemigo-jugador
        Si EDisparando Entonces
            Si (Trunc(EPX) = Trunc(AxisX) O Trunc(EPX + 1) = Trunc(AxisX)) Y Trunc(EPY) = Trunc(AxisY) Entonces
                vida <- vida - 1
                EDisparando <- Falso
            FinSi
        FinSi
        
        // Renderizar
        Para i <- 10 Hasta 1 Con Paso -1 Hacer
            Para j <- 1 Hasta 50 Hacer
                Si j = Trunc(AxisX) Y i = Trunc(AxisY) Entonces
                    Si FacingRight Entonces
                        Escribir Sin Saltar "b"
                    SiNo
                        Escribir Sin Saltar "d"
                    FinSi
                SiNo
                    Si j = Trunc(EAxisX) Y i = Trunc(EAxisY) Entonces
                        Escribir Sin Saltar "A"
                    SiNo
                        Si Disparando Y (j = Trunc(PX) O j = Trunc(PX + 1)) Y i = Trunc(PY) Entonces
                            Escribir Sin Saltar "*"
                        SiNo
                            Si EDisparando Y (j = Trunc(EPX) O j = Trunc(EPX + 1)) Y i = Trunc(EPY) Entonces
                                Escribir Sin Saltar "^" // Proyectil enemigo
                            SiNo
                                Si i = 1 Entonces
                                    Escribir Sin Saltar "-"
                                SiNo
                                    Escribir Sin Saltar " "
                                FinSi
                            FinSi
                        FinSi
                    FinSi
                FinSi
            FinPara
            Escribir ""
        FinPara
        
        Escribir "Vida: ", vida, "   Vida Enemigo: ", vidaE
        
        // Fin del juego
        Si vida <= 0 Entonces
            Escribir "Game Over"
            GameOver <- Verdadero
        FinSi
        
        Si vidaE <= 0 Entonces
            Escribir "¡Has derrotado al enemigo!"
            GameOver <- Verdadero
        FinSi
        
        Si GameOver Entonces
            jugando <- Falso
        FinSi
        
        // Entrada
        Escribir "Presione A (Izquierda), D (Derecha), W (Saltar), O (Disparar) o X (Salir)"
        Leer tecla
        tecla <- Mayusculas(tecla)
        
        // Movimiento jugador
        Si tecla = 'A' Y AxisX > 2 Entonces
            AxisX <- AxisX - 2
            FacingRight <- Falso
        SiNo
            Si tecla = 'D' Y AxisX < 48 Entonces
                AxisX <- AxisX + 2
                FacingRight <- Verdadero
            FinSi
        FinSi
        
        // Salto
        Si tecla = 'W' Y InTheFloor Entonces
            SpdY <- 10
            InTheFloor <- Falso
        FinSi
        
        // Disparo jugador
        Si tecla = 'O' Y No Disparando Entonces
            Disparando <- Verdadero
            PX <- AxisX
            PY <- AxisY
            Si FacingRight Entonces
                ProyectilDir <- 1
            SiNo
                ProyectilDir <- -1
            FinSi
        FinSi
        
        // Física jugador
        Si No InTheFloor Entonces
            SpdY <- SpdY + Gravity * DeltaTime
            AxisY <- AxisY + SpdY * DeltaTime
            Si AxisY <= 2 Entonces
                AxisY <- 2
                SpdY <- 0
                InTheFloor <- Verdadero
            FinSi
        FinSi
        
        // Movimiento del proyectil jugador
        Si Disparando Entonces
            PX <- PX + 4 * ProyectilDir
            Si PX < 1 O PX > 49 Entonces
                Disparando <- Falso
            FinSi
        FinSi
        
        // Movimiento enemigo
        Si EAxisX > AxisX Entonces
            EAxisX <- EAxisX - 1
            EFacingRight <- Falso
        SiNo
            Si EAxisX < AxisX Entonces
                EAxisX <- EAxisX + 1
                EFacingRight <- Verdadero
            FinSi
        FinSi
        
        // Salto enemigo
        Si Trunc(AxisX) = Trunc(EAxisX) Y AxisY > EAxisY Entonces
            Si EInTheFloor Entonces
                ESpdY <- 10
                EInTheFloor <- Falso
            FinSi
        FinSi
        
        // Física enemigo
        Si No EInTheFloor Entonces
            ESpdY <- ESpdY + EGravity * EDeltaTime
            EAxisY <- EAxisY + ESpdY * EDeltaTime
            Si EAxisY <= 2 Entonces
                EAxisY <- 2
                ESpdY <- 0
                EInTheFloor <- Verdadero
            FinSi
        FinSi
        
        // Disparo enemigo con probabilidad si está a >=5 de distancia
        Si No EDisparando Y Abs(EAxisX - AxisX) >= 5 Entonces
            Si Azar(100) < 20 Entonces
                EDisparando <- Verdadero
                EPX <- EAxisX
                EPY <- EAxisY
                Si EFacingRight Entonces
                    EProyectilDir <- 1
                SiNo
                    EProyectilDir <- -1
                FinSi
                Si primerDisparoEnemigo Entonces
                    Escribir "¡Cuidado con el proyectil enemigo!"
                    primerDisparoEnemigo <- Falso
                FinSi
            FinSi
        FinSi
        
        // Movimiento proyectil enemigo
        Si EDisparando Entonces
            EPX <- EPX + 3 * EProyectilDir
            Si EPX < 1 O EPX > 49 Entonces
                EDisparando <- Falso
            FinSi
        FinSi
        
        // Salida
        Si tecla = 'X' Entonces
            jugando <- Falso
        FinSi
        
        Esperar 50 Milisegundos
        
    FinMientras
    
    Escribir "Gracias por jugar. ¡Adiós!"

FinAlgoritmo
