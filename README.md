# Funcionalidades de la imagen

Esta imagen permite usar variables de entorno de docker en el archivo prometheus.yml lo que nos facilita el cambio de los valores extrayéndose para un único archivo ya sea desde el docker-compose.yml o desde un .env.


# Cómo usar imagen prometheus

Para cargar la imagen y poder empezar a usarla se necesita descargar el prometheus.tar y cargarlo con los siguiente comandos dependiendo del sistema operativo que se use.
<br>

Windows
```
docker load -i < .\prometheus.tar
```
Linux
```
docker load < .\prometheus.tar
```
<br>

## Nombre de imagen
Para poder usar esta imagen hay que indicar en apartado de imagen que use: prometheus-prometheus:latest . No puede haber de antes otra imagen de docker que tenga este mismo nombre.

```
services:
  prometheus:
    image: prometheus-prometheus:latest
```


<br>

## Volumen

Indicar el volumen donde estará el template que se usará para generar el config, antes de los : es la ruta local del archivo y después de los : es la ruta que tendrá dentro del contenedor. 

```
    volumes:
      - ./config/prometheus.yml.template:/etc/prometheus/prometheus.yml.template
```

## Argumento que se añade
Se pueden usar exactamente los mismos argumentos que se pueden usar con una imagen normal de prometheus y a mayores está el siguiente argumento: 

```
services:
  prometheus:
    image: prometheus-prometheus:latest
    command:
      - "--config.file.template=/etc/prometheus/prometheus.yml.template"
    volumes:
      - ./config/prometheus.yml.template:/etc/prometheus/prometheus.yml.template
```
Este argumento que se ve en command permite indicar la ruta del archivo que se usa de plantilla para general el archivo de config de prometheus.
La ruta es la ruta donde está ubicado el archivo del templete dentro del contenedor.

## Uso de variables
 Se indicarán todas las variables de entorno que deseen, se necesitan tener declaradas en en el servicio y dentro del documentos llamarlas de la siguiente forma:

Se indican todas las variables de entorno en el archivo de docker de la siguiente forma en enviroment: nombre_variable_a_llamar=valor_variable

```
services:
  prometheus:
    image: prometheus-prometheus:latest
    command:
      - "--config.file.template=/etc/prometheus/prometheus.yml.template"
    environment:
      - ejemplo1=value1
      - ejemplo2=valor2
      - var1=192.168.1.1
      - url_grafana=grafana
      - url_prometheus=prometheus
      - url_alertmanager=alertmanager
      - url_rule_mysql=myslq
    volumes:
      - ./config/prometheus.yml.template:/etc/prometheus/prometheus.yml.template
```
Si se quiere tener los valores de las variable en un .env sustituir el valor de la variable por ${nombre_var_env} , tener en cuenta que el valor de la variable que se va a llamar desde de archivo del prometheus.yml.template va a ser el nombre que tenga en el enviroment

## Llamar variable desde el archivo

Para llamar las variables desde el documento del template se llamarían de la siguiente forma ${nombre_variable}
<br>
Siguiendo con el ejemplo del enviroment de antes seria
```
${ejemplo1}
${ejemplo2}
${var1}
${url_grafana}
${url_prometheus}
${url_alertmanager}
${url_rule_mysql}
```



# Carpeta prometheus
En la carpeta prometheus está todo el código que se usó para adaptar la imagen base.
Para crear esta imagen se creó el Dockerfile con todas las modificaciones necesarias para crear la imagen, y en el entrypoint.sh están todos los comandos que hacen que funcione.

# Imagen base 
La imagen base que se usó para generar esta fue
bitnami/prometheus:2.46.0-debian-11-r31
