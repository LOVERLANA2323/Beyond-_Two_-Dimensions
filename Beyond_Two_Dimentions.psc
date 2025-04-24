Algoritmo Beyond_Two_Dimensions
	// Área inicial del juego
	Definir loadscreen Como Real
	loadscreen <- 0.0
	Repetir
		Esperar 70 Milisegundos
		loadscreen <- loadscreen + 1.0
		Escribir 'Cargando... ', loadscreen, '%'
		Si loadscreen >= 100.0 Entonces
			Esperar 1 Segundos
		FinSi
	Hasta Que loadscreen >= 100.0
	
	Definir Exit Como Lógico
	Exit <- Verdadero
	
	Mientras Exit = Verdadero Hacer
		Limpiar Pantalla
		Escribir '¿Quiere empezar? S (Sí) / N (No)'
		Leer Inicio
		Si Inicio = 'N' Entonces
			Exit <- Falso
		SiNo
			Si Inicio = 'S' Entonces
				Esperar 100 Milisegundos
				Limpiar Pantalla
				Escribir 'Se está reproduciendo la cinemática 1...'
				Esperar 3000 Milisegundos
				
				Definir Cinematica1 Como Lógico
				Cinematica1 <- Verdadero
				Mientras Cinematica1 = Verdadero Hacer
					Escribir '¿Desea saltar la cinemática? S (Sí) / N (No) / SA (Salir)'
					Leer SKIP
					Si SKIP = 'S' Entonces
						Cinematica1 <- Falso
					SiNo
						Si SKIP = 'N' Entonces
							Escribir 'Reproduciendo cinemática completa...'
							Esperar 10000 Milisegundos
							Cinematica1 <- Falso
						SiNo
							Si SKIP = 'SA' Entonces
								Exit <- Falso
								Cinematica1 <- Falso
							SiNo
								Escribir 'Opción no válida. Por favor, intente de nuevo.'
							FinSi
						FinSi
					FinSi
				FinMientras
				
				Si Exit Entonces
					Limpiar Pantalla
					Escribir 'Fin de la cinemática. Comienza el juego...'
					Esperar 5 Segundos
					Limpiar Pantalla
					
					// Variables de física
					Definir AxisX, AxisY, SpdX, SpdY, Gravity, DeltaTime Como Real
					Definir Floor Como Real
					Definir InTheFloor Como Lógico
					AxisX <- 1
					AxisY <- 2
					SpdX <- 0
					SpdY <- 0
					Gravity <- -9.8
					DeltaTime <- 0.1
					Floor <- 0
					InTheFloor <- Falso
					
					Definir tecla Como Caracter
					Definir jugando Como Lógico
					jugando <- Verdadero
					
					Mientras jugando Hacer
						Limpiar Pantalla
						
						// Renderizar pantalla
						Para i <- 10 Hasta 1 Con Paso -1 Hacer
							Para j <- 1 Hasta 50 Hacer
								Si j = Trunc(AxisX) Y i = Trunc(AxisY) Entonces
									Escribir Sin Saltar "|"
								SiNo
									Si i = 1 Entonces
										Escribir Sin Saltar "__"
									SiNo
										Escribir Sin Saltar " "
									FinSi
								FinSi
							FinPara
							Escribir ""
						FinPara
						
						// Leer entrada del usuario
						Escribir "Presione A (Izquierda), D (Derecha), W (Saltar) o X (Salir)"
						Leer tecla
						
						// Actualizar posición basada en entrada
						Si tecla = 'A' Entonces
							SpdX <- -5
						SiNo
							Si tecla = 'D' Entonces
								SpdX <- 5
							SiNo
								Si tecla = 'W' Y InTheFloor Entonces
									SpdY <- 10
									InTheFloor <- Falso
								SiNo
									Si tecla = 'X' Entonces
										jugando <- Falso
									FinSi
								FinSi
							FinSi
						FinSi
						
						// Aplicar gravedad
						SpdY <- SpdY + Gravity * DeltaTime
						AxisX <- AxisX + SpdX * DeltaTime
						AxisY <- AxisY + SpdY * DeltaTime
						
						// Colisión con el suelo
						Si AxisY <= 1 Entonces
							AxisY <- 1
							SpdY <- 0
							InTheFloor <- Verdadero
						FinSi
						
						// Frenar movimiento horizontal
						SpdX <- SpdX * 0.9
						
						Esperar 100 Milisegundos
					FinMientras
				FinSi
			SiNo
				Escribir 'Opción no válida. Intente de nuevo.'
			FinSi
		FinSi
	FinMientras
	
	Escribir 'Gracias por jugar. ¡Adiós!'
FinAlgoritmo

