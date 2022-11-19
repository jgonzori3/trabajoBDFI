
FROM python:3.8
WORKDIR /app

RUN apt-get update 
RUN	apt-get upgrade -y 

RUN pip install joblib

RUN apt-get install git -y 

RUN	git clone https://github.com/jgonzori3/Trabajo-BDFI.git

# Copiamos el directorio en /app/practica_big_data_2019
RUN	mv Trabajo-BDFI/practica_big_data_2019 . 


WORKDIR /app/practica_big_data_2019
RUN pip install -r requirements.txt


WORKDIR /app/practica_big_data_2019/resources/web
CMD python3 predict_flask.py
