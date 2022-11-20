FROM openjdk:8-alpine
ENV DAEMON_RUN=true
ENV SPARK_VERSION=3.1.2
ENV HADOOP_VERSION=2.7
ENV SCALA_VERSION=2.12.10
ENV SCALA_HOME=/usr/share/scala

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates -y
RUN    apk add --no-cache bash curl jq -y 
RUN    cd "/tmp"
RUN    wget --no-verbose "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" 
RUN   tar xzf "scala-${SCALA_VERSION}.tgz" 
RUN    mkdir "${SCALA_HOME}" 
RUN    rm -rf "/tmp/scala-${SCALA_VERSION}/bin/"*.bat

#RUN chmod +x /tmp/scala-${SCALA_VERSION}/bin
#RUN    mv -f "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" 
RUN    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" 
RUN   apk del .build-dependencies 
RUN    rm -rf "/tmp/"*
    
#Scala instalation
RUN export PATH="/usr/local/sbt/bin:$PATH" 
RUN apk update 
RUN apk add ca-certificates wget tar 
RUN mkdir -p "/usr/local/sbt"
#RUN wget -qO --no-check-certificate "https://cocl.us/sbt-0.13.16.tgz" 
#RUN tar xz -C /usr/local/sbt --strip-components=1 
#RUN sbt sbtVersion

RUN apk add --no-cache python3

      
RUN wget https://archive.apache.org/dist/spark/spark-3.1.2/spark-3.1.2-bin-hadoop2.7.tgz 
RUN tar -xzvf spark-3.1.2-bin-hadoop2.7.tgz
RUN mv spark-3.1.2-bin-hadoop2.7 spark

