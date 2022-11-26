
FROM python:3.8
WORKDIR /home/user1

RUN	apt-get update 
RUN	apt-get upgrade -y 

RUN	apt-get install git -y 

RUN	git clone https://github.com/jgonzori3/trabajoBDFI.git

# Copiamos el directorio en /app/practica_big_data_2019
RUN	mv trabajoBDFI/practica_big_data_2019 . 

WORKDIR /home/user1/practica_big_data_2019/resources/airflow

#RUN ls -ll

# INSTALAMOS APACHE AIRFLOW ENTRE OTRAS DEPENDENCIAS NECESARIAS
RUN pip install -r requirements.txt -c constraints.txt

# Con esto se crea la carpeta airflow y la bbdd inicial, donde vamos a meter el DAG. 
# La carpeta airflow va a estar en /root (se ha detectado viendo las trazas que daba el comando airflow db init)
RUN airflow db init

WORKDIR /root/airflow
RUN mkdir dags
RUN mkdir plugins

# Lo añadimos porque a veces habia problemas de escritura en carpeta
RUN chmod 777 dags
RUN chmod 777 plugins


RUN cp /home/user1/practica_big_data_2019/resources/airflow/setup.py /root/airflow/dags/

WORKDIR /root/airflow/dags
RUN chmod 777 setup.py

RUN airflow users create \
    --username admin \
    --firstname Jack \
    --lastname  Sparrow\
    --role Admin \
    --email example@mail.org\
    --password password 

COPY script.sh /home/user1

WORKDIR /home/user1

RUN chmod 777 script.sh

CMD ./script.sh








