
FROM python:3.7
WORKDIR /app

RUN	apt-get update 
RUN	apt-get upgrade -y 

#RUN pip install "apache-airflow[celery]==2.1.4" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.1.4/constraints-3.7.txt"

RUN	apt-get install git -y 

RUN	git clone https://github.com/jgonzori3/Trabajo-BDFI.git

# Copiamos el directorio en /app/practica_big_data_2019
RUN	mv Trabajo-BDFI/practica_big_data_2019 . 


WORKDIR practica_big_data_2019/airflow
RUN	mkdir dags
RUN	mkdir logs
RUN	mkdir plugins

RUN	pip install -r requirements.txt -c constraints.txt

RUN	airflow initdb   ##esto lo he metido yo porque creo que hace falta

RUN	airflow users create \   ##ESTO IGUAL HABRIA QUE PONERLO TODO SEGUIDO
    --username admin \
    --firstname Jack \
    --lastname  Sparrow\
    --role Admin \
    --email example@mail.org
    
RUN	airflow webserver --port 8080
RUN	airflow sheduler
WORKDIR practica_big_data_2019  # esto tiene que hacerse porque el codigo de setup.py precisa que el workdir sea este

CMD python3 ./practica_big_data_2019/RESOURCES/airflow/setup.py  #de esta manera no deberia dar problemas el codigo de dentro
