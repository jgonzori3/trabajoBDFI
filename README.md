# Trabajo-BDFI  Predicciones de retrasos de vuelos
Esta práctica que arranca del repositorio publicado https://github.com/ging/practica_big_data_2019 y este deriva de otro anterior https://github.com/rjurney/Agile_Data_Code_2 . 
En esta practica se resuelve el problema de desplegar el escenario con Docker Compose utilizando imagenes publicadas en Google Cloud.

##  Curso de análisis predictivo en tiempo real

[ <img src="images/video_course_cover.png"> ](http://datasyndrome.com/video)

## Descargar el proyecto principal 
Para poder arrancar con el despliegue de los componentes se ha estructurado un proyecto en un repositorio de github para poderse descargar en local.
El comando para importar el repositorio será el siguiente:
```
git clone https://github.com/jgonzori3/trabajo-BDFI.git
```

Debemos tener en cuenta que para este proyecto se necesita al menos trabajar en una maquina que tenga ubuntu 20.04 por temas de compatibilidad entre versiones.
Se trabajará con las siguientes versiones de software: 

 - [Intellij](https://www.jetbrains.com/help/idea/installation-guide.html) (jdk_1.8)
 - [Pyhton3](https://realpython.com/installing-python/) (version 3.8) 
 - [PIP](https://pip.pypa.io/en/stable/installing/)(version 20.0.2)
 - [SBT](https://www.scala-sbt.org/release/docs/Setup.html) (version 1.8.0)
 - [MongoDB](https://docs.mongodb.com/manual/installation/)(version 4.4.18)
 - [Spark](https://spark.apache.org/docs/latest/) (version 3.1.2)
 - [Scala](https://www.scala-lang.org)(version 2.12.10)
 - [Zookeeper](https://zookeeper.apache.org/releases.html) (version 3.4.13)
 - [Kafka](https://kafka.apache.org/quickstart) (version kafka_2.12-3.0.0)
 - [Airflow](https://airflow.apache.org/docs/apache-airflow/2.0.1/installation.html) (version 2.1.4)

# Procesos que se realizan

1. Descargar los datos de vuelos pasados.

2. Entrenar modelo de Machine Learning utilizando los datos de vuelos.

3. Desplegar el job de Spark que predice el retraso de los vuelos usando el modelo creado.

4. Por medio de una interfaz web, el usuario introducirá los datos del vuelo a predecir, que se enviarán al servidor web de Flask.

5. El servidor web enviará estos datos al job de predicción a través de Kafka.

6. El job realizará la predicción y la guardará en Mongo.

7. La interfaz web está constantemente haciendo polling para comprobar si se ha realizado ya la predicción.

8. En caso afirmativo, se muestra la predicción en la interfaz

# Hitos alcanzados

1. Lograr el funcionamiento de la práctica sin realizar modificaciones ejecutando el job de prediccion con intellij (4 puntos).
2. Ejecución del job de predicción con Spark Submit en vez de IntelliJ tanto de forma local como de forma Standalone con 2 workers(1 punto).
3. Dockerizar cada uno de los servicios que componen la arquitectura completa. (1 punto)
4. Desplegar el escenario completo usando docker-compose. (1 punto)
5. Desplegar el escenario completo en Google Cloud en una Maquina virtual accediendo a esta a traves del gestor de Interfaces grafias de Nomachine(1 punto).
6. Habilitar el despliegue del escenario completo en el Container Registry de Google cloud. 
7. Se propone una solucion que utiliza Airflow como gestor de tareas en la siguiente https://github.com/jgonzori3/trabajoBDFI_v2.git

Para complementar la solución desplegada en cloud (punto 6 de hitos alcanzados) se han publicado en Google Cloud todas las imágenes que usamos para hacer el docker compose garantizando así que siempre podremos tener acceso a ellas de forma universal accediendo a ellas ejecutando los siguientes pull:
```
docker pull gcr.io/imagenesdocker-368517/kafka:latest
docker pull gcr.io/imagenesdocker-368517/kafka2:latest
docker pull gcr.io/imagenesdocker-368517/mongo:latest
docker pull gcr.io/imagenesdocker-368517/spark:latest
docker pull gcr.io/imagenesdocker-368517/sparkdistribuido:latest
docker pull gcr.io/imagenesdocker-368517/webflask:latest
docker pull gcr.io/imagenesdocker-368517/zookeeper:latest

```

El comando que se ejecutará en la Shell de Google Cloud para publicar imagenes a partir de Dockerfiles es el siguiente.

```
gcloud builds submit --tag gcr.io/<proyect_id>/<tag_name>
```
Con esta solución el unico fichero que seria necesario seria el docker-compose.yml 

Para la automaticación de tareas hemos utilizado Apache Airflow que nos permite operaciones como borrar de la base de datos todas las peticiones que se hayan realizado en el ultimo mes, o reentrenar el modelo una vez a la semana anadiendo nuevos datos.

Para explicar la arquitectura de Apache Airflow la siguiete imagen es muy ilustrativa.

![Airflow Architecture](images/Airflow´s-General-Architecture.png)


Se puede observar una base de datos de metadatos que incluye toda la información de los workflows, de sus estados y de sus dependencias. Este primer módulo se conecta al scheduler, este modulo extrae de los metadatos la informacion relativas al orden de ejecucion de las tareas y su prioridad. Ligado estrechamente con este se encuentra el executor que se encarga de determinar el nodo que va a ejecutar cada tarea. Por último en la parte superior encontramos los workers que serán los que se encarguen de ejecutar la logica de las tareas.

En paralelo se encuentra el servidor web que hace uso tanto de la informacion de la base de datos como de los logs generados por los workers para presentar esta informacion en su interfaz web.



## Autores
- Alejandro Moreno 
- Jesús González


# Información Adicional Del Proyecto


##  La pirámide del valor de los datos

Originalmente por Pete Warden, la pirámide de valores de datos es cómo se organiza y estructura el libro. Lo subimos a medida que avanzamos cada capítulo.
![Data Value Pyramid](images/climbing_the_pyramid_chapter_intro.png)

## Arquitectura del sistema

Los siguientes diagramas se extraen del libro y expresan los conceptos básicos de la arquitectura del sistema. Las arquitecturas de front-end y back-end funcionan juntas para crear un sistema predictivo completo.

## Arquitectura Front End

Este diagrama muestra cómo funciona la arquitectura de front-end en nuestra aplicación de predicción de retrasos de vuelos. El usuario completa un formulario con información básica en un formulario en una página web, que se envía al servidor. El servidor completa algunos campos necesarios derivados de los del formulario como "día del año" y emite un mensaje de Kafka que contiene una solicitud de predicción. Spark Streaming está escuchando en una cola de Kafka para estas solicitudes y hace la predicción, almacenando el resultado en MongoDB. Mientras tanto, el cliente recibió un UUID en la respuesta del formulario y ha estado sondeando otro punto final cada segundo. Una vez que los datos están disponibles en Mongo, la próxima solicitud del cliente los recoge. ¡Finalmente, el cliente muestra el resultado de la predicción al usuario!

Esta configuración es extremadamente divertida de configurar, operar y observar. ¡Consulte los capítulos 7 y 8 para obtener más información!

![Front End Architecture](images/front_end_realtime_architecture.png)

## Arquitectura de back-end

El diagrama de la arquitectura de back-end muestra cómo entrenamos un modelo clasificador utilizando datos históricos (todos los vuelos desde 2015) en el disco (HDFS o Amazon S3, etc.) para predecir retrasos en los vuelos por lotes en Spark. Guardamos el modelo en el disco cuando esté listo. A continuación, lanzamos Zookeeper y una cola de Kafka. Usamos Spark Streaming para cargar el modelo clasificador y luego escuchamos las solicitudes de predicción en una cola de Kafka. Cuando llega una solicitud de predicción, Spark Streaming realiza la predicción y almacena el resultado en MongoDB, donde la aplicación web puede recogerlo.

Esta arquitectura es extremadamente poderosa y es un gran beneficio que podamos usar el mismo código por lotes y en tiempo real con PySpark Streaming.

![Backend Architecture](images/back_end_realtime_architecture.png)

# capturas de pantalla

A continuación se muestran algunos ejemplos de partes de la aplicación que construimos en este libro y en este repositorio. ¡Mira el libro para más!

## Página de la entidad de la aerolínea

Cada aerolínea tiene su propia página de entidad, completa con un resumen de su flota y una descripción extraída de Wikipedia.

![Airline Page](images/airline_page_enriched_wikipedia.png)

## Página de la flota de aviones

Demostramos resumir una entidad con una página de flota de aviones que describe toda la flota.

![Airplane Fleet Page](images/airplanes_page_chart_v1_v2.png)

## Interfaz de usuario de predicción de retrasos de vuelos

Creamos un sistema predictivo completo en tiempo real con un front-end web para enviar solicitudes de predicción.

![Predicting Flight Delays UI](images/predicting_flight_kafka_waiting.png)







