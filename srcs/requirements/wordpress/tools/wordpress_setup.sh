#!/bin/bash

set -e

WORDPRESS_DB_USER_PASSWORD=$(cat /run/secrets/wordpress_db_user_password)
WORDPRESS_USER_PASSWORD=$(cat /run/secrets/wordpress_user_password)
WORDPRESS_ADMIN_PASSWORD=$(cat /run/secrets/wordpress_admin_password)

if [ ! -f "${WORDPRESS_PATH}"/wp-config.php ]; then
    echo "First boot: downloading and configuring WordPress..."
    wp core download --allow-root --path="${WORDPRESS_PATH}"

    wp config create --allow-root --path="${WORDPRESS_PATH}" \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_USER_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST"

    wp core install --allow-root --path="${WORDPRESS_PATH}" \
        --url="https://$DOMAIN_NAME" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL"

    wp user create --allow-root --path="${WORDPRESS_PATH}" \
        "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" \
        --user_pass="$WORDPRESS_USER_PASSWORD" \
        --role=subscriber
else
    echo "wp-config.php already exists, skipping install."
fi


# redis configuration
wp  config set WP_REDIS_HOST redis --allow-root --path="${WORDPRESS_PATH}" 
wp  config set WP_REDIS_PORT "${REDIS_PORT}" --allow-root --path="${WORDPRESS_PATH}" 
# wp  config set WP_CACHE true --path="${WORDPRESS_PATH}" --allow-root --type=constant --raw

if ! wp plugin is-installed redis-cache --allow-root --path="${WORDPRESS_PATH}" ; then
    wp plugin install redis-cache --allow-root --path="${WORDPRESS_PATH}"
fi

wp plugin activate redis-cache --allow-root --path="${WORDPRESS_PATH}"

# chown -R www-data:www-data "${WORDPRESS_PATH}"

exec php-fpm8.2 -F