
FROM debian:bookworm

RUN apt update &&\
	apt install -y nginx &&\
	apt install -y openssl &&\
	rm -fr /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx_cert.sh /usr/local/bin/nginx_cert.sh

RUN chmod +x /usr/local/bin/nginx_cert.sh

EXPOSE 443

ENTRYPOINT [ "/usr/local/bin/nginx_cert.sh"]