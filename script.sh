#!/bin/bash

opcion=0
PID_CONSOLIDAR="consolidar.pid"

# Verificamos si se paso el parametro optativo:
if [ "$1" == "-d" ]; then
    if [ -f "EPNro1/consolidar.sh" ]; then
        mv EPNro1/consolidar.sh consolidar.sh
    fi
    if [ -f "$PID_CONSOLIDAR" ] && kill -0 $(cat "$PID_CONSOLIDAR"); then
        kill $(cat "$PID_CONSOLIDAR")
        rm -f "$PID_CONSOLIDAR"
        rm -f nohup.out
        echo "Proceso consolidar.sh detenido."
    fi
    rm -rf EPNro1
    echo "Entorno eliminado."
fi

while [ $opcion -ne 7 ]; do
    # Mostramos el menu de opciones:
    echo "Menu de opciones:"
    echo "1. Crear entorno"
    echo "2. Correr proceso"
    echo "3. Mostrar listado de alumnos"
    echo "4. Mostrar las 10 notas mas altas"
    echo "5. Solicitar nro de padron"
    echo "6. Visualizar log"
    echo "7. Salir"

    read opcion

    if [[ ! "$opcion" =~ ^[1-7]$ ]]; then
        echo "Opción no válida. Debe ser un numero del 1 al 7."
        opcion=0

    elif [[ $opcion -eq 1 ]]; then
        # Creamos el entorno:
        mkdir -p EPNro1/entrada EPNro1/salida EPNro1/procesado

    elif [ $opcion -eq 2 ]; then
        # verifica si consolidar.sh se encuentra en el directorio actual y lo mueve a EPNro1 si es así
        if [ -f "consolidar.sh" ]; then
            mv consolidar.sh EPNro1/consolidar.sh    
        fi
        # verificamos si el proceso ya se está ejecutando y si no lo está, se inicia en background:
        if [ -f "$PID_CONSOLIDAR" ] && kill -0 $(cat "$PID_CONSOLIDAR"); then
            echo "El proceso ya se está ejecutando."
        else
            nohup EPNro1/consolidar.sh > nohup.out 2>&1 & echo $! > "$PID_CONSOLIDAR"
            echo "Proceso consolidar.sh iniciado correctamente en background."
        fi
        
    elif [[ $opcion -eq 3 ]]; then
        # Mostramos el listado de alumnos por padron:
        if [[ -f "EPNro1/salida/${FILENAME}.txt" ]]; then
            sort -n "EPNro1/salida/${FILENAME}.txt"
        else
            echo "El archivo no existe."
        fi

    elif [[ $opcion -eq 4 ]]; then
        # Mostramos el listado de diez alumnos por notas:
        if [[ -f "EPNro1/salida/${FILENAME}.txt" ]]; then
            sort -n -k5,5 -r "EPNro1/salida/${FILENAME}.txt" | head -n 10
        else
            echo "El archivo no existe."
        fi

    elif [[ $opcion -eq 5 ]]; then
        # Mostramos el alumno por padron:
        echo "Solicito tu padron"
        read padron
        grep $padron "EPNro1/salida/${FILENAME}.txt" || echo "No se encontró el padron."
    
    elif [[ $opcion -eq 6 ]]; then
        # Mostramos el log:
        if [[ -f "EPNro1/procesado.log" ]]; then
            cat "EPNro1/procesado.log"
        else
            echo "El archivo no existe."
        fi

    elif [[ $opcion -eq 7 ]]; then
        # Salimos del programa:
        echo "Saliendo del programa."
    else
        echo "Opción no válida."
        opcion=0
    fi
done