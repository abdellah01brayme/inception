
FROM debian:bookworm

RUN apt update &&\
	apt install -y nginx &&\
	apt install -y openssl &&\
	rm -fr /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]