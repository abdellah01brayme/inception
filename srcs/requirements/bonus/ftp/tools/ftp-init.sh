#!/bin/bash

set -e

FTP_PASSWORD=$(cat /run/secrets/ftp_password)

if  ! id "$FTP_USER" >/dev/null 2>&1 ; then

	useradd -m "$FTP_USER" -d /var/www/html -s /bin/bash
	echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
	chown -R "$FTP_USER" /var/www/html

fi

exec vsftpd /etc/vsftpd.conf