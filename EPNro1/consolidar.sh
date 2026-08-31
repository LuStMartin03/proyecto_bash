#!/bin/bash

# Hacemos un loop infinito para procesar los archivos de /entrada:
while [ true ]; do
    # Verificamos que haya al menos un archivo en /entrada:
    if [ "$(ls -A "./entrada")" ]; then
        for archivo in "./entrada"/*; do
            if [ -f "$archivo" ]; then
                # Procesamos el archivo:
                nombre_archivo=$(basename "$archivo")
                echo "" >> "./salida/${FILENAME}.txt"
                cat "$archivo" >> "./salida/${FILENAME}.txt"
                mv "$archivo" "./procesado/"
                echo "$(date '+%d/%m/%Y %H:%M:%S') - Procesado Archivo $nombre_archivo" >> "./procesado.log"
            fi
        done
    else
        echo "No hay archivos para procesar."
    fi
    sleep 10
done
