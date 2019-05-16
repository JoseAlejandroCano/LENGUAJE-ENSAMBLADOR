;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID
;ISC 6B
;EJERCICIO DE LENGUAJES Y AUTOMATAS II
;ELABORADO POR:JOSE ALEJANDRO CANO HAU
;FECHA: 7/05/2019  
  
  DATA SEGMENT
      CADENA1 DB 'MENU DE OPERACIONES$'
      CADENA2 DB '[1]OPERACIONES BASICAS$'
      CADENA3 DB '[2]BUSCAR NUMERO MAYOR$'
      CADENA6 DB 'SELECCIONE UNA OPCION:$'
      
      ;VARIABLES DE OPERACIONES BASICAS
      
      MSJ1 DB 'NUMERO 1:$'
      MSJ2 DB 13,10,'NUMERO 2:$'      
      MSJ3 DB 13,10,'SUMA:$'
      MSJ4 DB 13,10,'RESTA:$'
      MSJ5 DB 13,10,'MULTIPLICACION:$'
      MSJ6 DB 13,10,'DIVISION:$'
      
      LINEA DB 13,10,'$'
      VAR1 DB 0
      VAR2 DB 0 
      
      ;VARIABLE DE LA OPERACION DE NUMERO MAYOR
      INCLUDE "EMU8086.INC"
        
      VARIABLE1 DB 0AH,0DH, "INGRESE TRES DIGITO DEL 0 AL 9 : ", "$"
      VARIABLE2 DB 0AH,0DH, "DIGITO 1: ", "$"
      VARIABLE3 DB 0AH,0DH, "SEGUNDO 2: ", "$"
      VARIABLE4 DB 0AH,0DH, "TERCER 3: ", "$"
      MAYOR DB 0AH,0DH, "EL DIGITO MAYOR ES: ", "$"
              
      DIGITO1 DB 100 DUP("$")
      DIGITO2 DB 100 DUP("$")
      DIGITO3 DB 100 DUP("$")
                 
  DATA ENDS
     
 
  CODE SEGMENT
     
     PRAC7.2:
     
     ASSUME DS:DATA, CS:CODE   

     MOV AH,06H
     MOV AL,0 
     
     MOV BH,0A4H ;FONDO PRINCIPAL  VERDE Y ROJO
     MOV CX,0000H
     MOV DX,184FH 
     INT 10H
  
     ;RECTANGULO1
     MOV AX, DATA
     MOV DS,AX
     MOV AH,06H
     MOV AL,0 
     MOV BH,008H ;FONDO NEGRO Y TEXTO AZUL CLARO
     MOV CX,020AH  
     MOV DX,0241H 
     INT 10H
     
     
     ;RECTANGULO2
     MOV AX, DATA
     MOV DS,AX
     
     ;FUNCION PARA RECORRER PANTALLA
     MOV AH,06H
     MOV AL,0 
     
     MOV BH,01FH ;FONDO AZUL Y TEXTO BLANCO BRILLANTE.
     MOV CX,050AH 
     MOV DX,1441H 
     INT 10H
         
     
        ;MENU
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 02H; 02
        MOV DL, 1EH; 30 
        INT 10H          
        
        MOV AH, 09H
        LEA DX, CADENA1
        INT 21H

        ;MENU DE OPCIONES
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 06H; 06 NUMERO DE RECORRIDO HACIA ABAJO   
        MOV DL, 0CH; 0C NUMERO DE RECORRIDO HACIA LA DERECHA
        INT 10H             
        MOV AH, 09H
        LEA DX, CADENA2
        INT 21H
        
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 08H; 08 RECORRIDO HACIA ABAJO  
        MOV DL, 0CH; 0C RECORRIDO A LA DERECHA
        INT 10H           
        MOV AH, 09H
        LEA DX, CADENA3
        INT 21H 
        
        ;SELECCION
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 16H; 22 RECORRIDO HACIA ABAJO
        MOV DL, 28H; 40 RECORRIDO HACIA LA DERRECHA
        INT 10H
        MOV AH, 09H
        LEA DX, CADENA6
        INT 21H          
        
        PAG:
            ;LEER CARACTER
            MOV AH, 0H
            INT 16H
            
            CMP AL, "1"
            JE OPEBASICAS
            CMP AL, "2"
            JE NUMGRANDE
            JMP FIN
        
        OPEBASICAS:
            MOV AH, 05H
            MOV AL, 1
            INT 10H
            MOV AH, 06H
            MOV AL, 0
            MOV BH, 1AH
            MOV CX, 0000H;0, 0
            MOV DX, 184FH;24,79
            INT 10H
            
            ; INICIO OPERACIONES BASICAS
            CALL LIMPIA
            MOV AH,09H
            LEA DX, MSJ1 ;DESPLEGAR NUMERO 1:
            INT 21H

            CALL LEER ;LEE PRIMER NUMERO
            SUB AL,30H ;RESTAR 30H PARA OBTENER EL NUMERO
            MOV VAR1,AL ;LO GUARDO EN VAR1
            MOV AH,09H
            LEA DX, MSJ2 ;DESPLEGAR NUMERO 2:
            INT 21H
            CALL LEER ;LEE SEGUNDO NUMERO
            SUB AL,30H ;RESTAR 30H PARA OBTENER SEGUNDO VALOR
            MOV VAR2,AL ;GUARDAR EN VAR2
            MOV BL,VAR2 ;MOVER A BL

            ;******************* SUMA
            
            ADD BL,VAR1 ; REALIZO LA SUMA DE VAR2(BL) Y VAR1 Y EL RESULTADO QUEDA EN BL
            MOV AH,09H
            LEA DX,MSJ3 ;IMPRIMIR SUMA
            INT 21H
            MOV DL,BL ;PONGO EN DL EL NUMERO A IMPRIMIR VAR2(BL)
            ADD DL,30H ; AGREGO 30H PARA OBTENER EL CARACTER    
            MOV AH,02H ;IMPRIME UN CARACTER
            INT 21H
            
            ;******************RESTA
            MOV BL,VAR1
            SUB BL,VAR2
            MOV AH,09H
            LEA DX,MSJ4 ;DESPLEGAR RESTA:
            INT 21H
            MOV DL,BL ;MOVER RESTA A DL PARA IMPRIMIR
            ADD DL,30H ;SUMAR 30 PARA OBTENER CARACTER
            MOV AH,02H ;IMPRIMIR UN CARACTER
            INT 21H
            
            ;******************MULTIPLICACION
            MOV AH,09H
            LEA DX,MSJ5 ;DESPLEGAR MULT
            INT 21H
            
            MOV AL,VAR1 
            MOV BL,VAR2
            MUL BL ;MULT AL=AL*BL
            MOV DL,AL ;MOVER AL A DL PARA IMPRIMIR
            ADD DL,30H ;SUMAR 30 PARA OBTENER CARACTER
            MOV AH,02H ;IMPRIMIR CARACTER
            INT 21H
            
            ;*****************DIVISION
            MOV AH,09H
            LEA DX,MSJ6 ;DESPLEGAR DIV
            INT 21H
            XOR AX,AX ;LIMPIAMOS EL REGISTRO AX. 
            MOV AL,VAR2
            MOV BL,AL
            MOV AL,VAR1
            DIV BL ; DIVIDE AX/BX EL RESULTADO LO ALMACENA EN AX, EL RESIDUO QUEDA EN DX
            MOV BL,AL
            MOV DL,BL
            ADD DL,30H
            MOV AH,02H
            INT 21H
            

            ; ****************PROCEDIMIENTOS
            SALTO PROC NEAR
            MOV AH,09H
            LEA DX,LINEA
            INT 21H
            MOV DL,00H
            RET
            SALTO ENDP
            
            LEER PROC NEAR
            MOV AH,01H;LEER CARACTER DESDE EL TECLADO
            INT 21H;LEE PRIMER CARACTER
            RET
            LEER ENDP
            
            LIMPIA PROC NEAR
            MOV AH,00H
            MOV AL,03H
            INT 10H
            RET
            LIMPIA ENDP
            
            ; FIN  
                    
            MOV AH, 0H
            INT 16H
            
            CMP AL, 008
            JE ATRAS
            JMP FIN 
            
            NUMGRANDE:
            
            MOV AH, 05H
            MOV AL, 1
            INT 10H
            MOV AH, 06H
            MOV AL, 0
            MOV BH, 1AH
            MOV CX, 0000H;0, 0
            MOV DX, 184FH;24,79
            INT 10H
            
            ; INICIO DE NUMERO MAYOR
            MOV SI,0
            MOV AX,@DATA
            MOV DS,AX
            MOV AH,09
            MOV DX,OFFSET VARIABLE1 ;IMPRESION DE MSJ1
            INT 21H
            
            CALL SALTODELINEA;LLAMAMOS EL METODO SALTODELINEA.
            
            CALL PEDIRCARACTER ;LLAMAMOS AL METODO
            
            MOV DIGITO1,AL ;LO GUARDADO EN AL A DIGITO1
            
            CALL SALTODELINEA
            
            CALL PEDIRCARACTER
            
            MOV DIGITO2,AL
            
            CALL SALTODELINEA
            
            CALL PEDIRCARACTER
            
            MOV DIGITO3,AL
            
            CALL SALTODELINEA
            
            ;>>>>>>>>>>>>>>>>>>>>>COMPARACIONES<<<<<<<<<<<<<<<<<<<<<;
            
            MOV AH,DIGITO1
            MOV AL,DIGITO2
            CMP AH,AL ;COMPARA PRIMERO CON EL SEGUNDO
            JA COMPARA-1-3 ;SI ES MAYOR EL PRIMERO, AHORA LO COMPARA CON EL TERCERO
            JMP COMPARA-2-3 ;SI EL PRIMERO NO ES MAYOR,AHORA COMPARA EL 2 Y 3 DIGITO
            COMPARA-1-3:
            MOV AL,DIGITO3 ;AH=PRIMER DIGITO, AL=TERCER DIGITO
            CMP AH,AL ;COMPARA PRIMERO CON TERCERO
            JA MAYOR1 ;SI ES MAYOR QUE EL TERCERO, ENTONCES EL PRIMERO ES MAYOR QUE LOS 3
            
            COMPARA-2-3:
            MOV AH,DIGITO2
            MOV AL,DIGITO3
            CMP AH,AL ;COMPARA 2 Y 3, YA NO ES NECESARIO COMPARARLO CON EL 1,PORQUE YA SABEMOS QUE EL 1 NO ES MAYOR QUE EL 2
            JA MAYOR2 ;SI ES MAYOR EL 2,NOS VAMOS AL METODO PARA IMPRIMIRLO
            JMP MAYOR3 ;SI EL 2 NO ES MAYOR, OBVIO EL 3 ES EL MAYOR
             
            MAYOR1:
            
            CALL MENSAJEMAYOR ;LLAMA AL METODO QUE DICE: EL DIGITO MAYOR ES:
            
            MOV DX, OFFSET DIGITO1 ;IMPRIR EL DIGITO 1 ES MAYOR
            MOV AH, 9
            INT 21H
            JMP EXIT
            
            MAYOR2:
            CALL MENSAJEMAYOR
            
            MOV DX, OFFSET DIGITO2 ;SALTO DE LINEA
            MOV AH, 9
            INT 21H
            JMP EXIT
            
            MAYOR3:
            CALL MENSAJEMAYOR
            
            MOV DX, OFFSET DIGITO3 ;SALTO DE LINEA
            MOV AH, 9
            INT 21H
            JMP EXIT
            
            ;>>>>>>>>>>>>>>>>>>>>>METODOS<<<<<<<<<<<<<<<<<<<<<;
            
            MENSAJEMAYOR:
            MOV DX, OFFSET MAYOR ;EL DIGITO MAYOR ES:
            MOV AH, 9
            INT 21H
            
            RET
            PEDIRCARACTER:
            MOV AH,01H; PEDIMOS PRIMER DIGITO
            INT 21H
            RET
            
            SALTODELINEA:
            MOV DX, OFFSET SALTO ;SALTO DE LINEA
            MOV AH, 9
            INT 21H
            RET
            
            EXIT:
            MOV AX, 4C00H;UTILIZAMOS EL SERVICIO 4C DE LA INTERRUPCION 21H
            INT 21H ;PARA TERMIANR EL PROGRAMA
            
            ; FIN DE NUMERO MAYOR  
                    
            MOV AH, 0H
            INT 16H
            
            CMP AL, 008
            JE ATRAS
            JMP FIN
        
        ATRAS:
            MOV AH, 05H
            MOV AL, 0
            INT 10H
            JMP PAG
        
        FIN:
        
            INT 21H            
CODE ENDS

END PRAC7.2
             

                                     
                                     
                                     