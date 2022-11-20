#!/bin/bash

set -e

docker build -t spark-base:2.3.1 base.Dockerfile
docker build -t spark-master:2.3.1 spark-master
docker build -t spark-worker:2.3.1 spark-worker
docker build -t spark-submit:2.3.1 spark-submit
