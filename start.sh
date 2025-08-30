#!/bin/bash

#1 Step: build/rebuild container
docker build -t http-router .

#2 Step: force stop the previous version of the container
docker kill http-router || true
docker rm http-router || true
docker network create --subnet=10.0.0.0/24 custom-network || true

#3 Step: run new container
docker run -d \
    --name http-router \
    --network custom-network \
    --ip 10.0.0.101 \
    -v /etc/letsencrypt/:/etc/letsencrypt/ \
    -p 80:80 \
    -p 443:443 \
    http-router:latest \
    /bin/bash -c "nginx -g 'daemon off;'"
