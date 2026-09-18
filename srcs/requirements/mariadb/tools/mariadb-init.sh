#!/bin/bash
set -e 

MARIADB_ROOT_PASSWORD=$(cat /run/secrets/mariadb_root_password)
WORDPRESS_DB_USER_PASSWORD=$(cat /run/secrets/wordpress_db_user_password)

echo "[mariadb-init.sh] Applying database and credentiaks..."

mariadbd --user=mysql  --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB_NAME}\`;
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB_NAME}\`.* TO '${WORDPRESS_DB_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF


echo "[mariadb-init.sh] Starting MariaDB in foreground..."

exec mariadbd --user=mysql

