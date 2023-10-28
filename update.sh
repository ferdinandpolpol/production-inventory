#!/bin/bash
#

git pull origin main
docker-compose stop
docker-compose up --build -d

sleep 60
docker-compose up -d
