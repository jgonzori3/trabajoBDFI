FROM openjdk:8
WORKDIR /app

RUN apt-get update 

RUN apt-get upgrade -y 

# Descargamos zookeper en /app
RUN wget https://dlcdn.apache.org/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz
RUN tar -xvzf apache-zookeeper-3.8.0-bin.tar.gz


# Descargamos kafka en /app
RUN wget https://archive.apache.org/dist/kafka/3.0.0/kafka_2.12-3.0.0.tgz
RUN tar -xvzf kafka_2.12-3.0.0.tgz


WORKDIR /app/kafka_2.12-3.0.0

COPY . /app/kafka_2.12-3.0.0

RUN chmod +x ./start.sh

CMD ./start.sh


#CMD bin/kafka-server-start.sh config/server.properties
# CMD bin/kafka-topics.sh \
#       --create \
#       --zookeeper localhost:2181 \
#       --replication-factor 1 \
#       --partitions 1 \
#       --topic flight_delay_classification_request

#CMD bin/kafka-server-start.sh config/server.properties 
