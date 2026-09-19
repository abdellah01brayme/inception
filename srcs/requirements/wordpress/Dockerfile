
FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php \
    php8.2-fpm \
    php8.2-mysqli \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

COPY conf/php-fpm_www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/wordpress_setup.sh /usr/local/bin/wordpress_setup.sh

RUN chmod +x /usr/local/bin/wordpress_setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress_setup.sh"]
