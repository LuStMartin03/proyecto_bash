#!/bin/bash

# Hacemos un loop infinito para procesar los archivos de /entrada:
while [ true ]; do
    # Verificamos que haya al menos un archivo en /entrada:
    if [ "$(ls -A "EPNro1/entrada")" ]; then
        for archivo in "./EPNro1/entrada"/*; do
            if [ -f "$archivo" ]; then
                # Procesamos el archivo:
                nombre_archivo=$(basename "$archivo")
                cat "$archivo" >> "./EPNro1/salida/${FILENAME}.txt"
                echo "" >> "./EPNro1/salida/${FILENAME}.txt"
                mv "$archivo" "./EPNro1/procesado/"
                echo "$(date '+%d/%m/%Y %H:%M:%S') - Procesado Archivo $nombre_archivo" >> "./EPNro1/procesado.log"
            fi
        done
    else
        echo "No hay archivos para procesar."
    fi
    sleep 5
done
