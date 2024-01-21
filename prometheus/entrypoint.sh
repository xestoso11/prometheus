#!/bin/bash

argumentos=""
path_config_template="/opt/bitnami/prometheus/prometheus.yml"
for i in $@
do
    if [[ $i == --config.file.template=* ]]; then
        path_template="${i#*=}"
    elif [[ $i == --config.file=* ]]; then
        path_config="$i"
        path_config_template="${i#*=}"
    else
        argumentos="$argumentos $i"
    fi
done

if [ -f $path_template ]; then
    envsubst < $path_template > $path_config_template
else
    echo "Erro con path_template:$path_template no es un archivo valido o no existe"
    exit 1
fi

/opt/bitnami/prometheus/bin/prometheus $argumentos $path_config
