
FROM debian:bookworm

RUN apt update &&\
	apt install -y nginx &&\
	apt install -y openssl &&\
	apt clean && rm -fr /var/lib/apt/lists/*

COPY conf/nginx.conf /