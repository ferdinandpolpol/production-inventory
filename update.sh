#!/bin/bash
#

git pull origin main

cp dc.prod.yml docker-compose.override.yml

docker-compose stop
docker-compose up --build -d

sleep 60
docker-compose up -d
