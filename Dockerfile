FROM ubuntu:latest

COPY files/etc /etc

RUN apt update && \
    apt install -y nginx && \
    rm -fv /etc/nginx/sites-enabled/default
