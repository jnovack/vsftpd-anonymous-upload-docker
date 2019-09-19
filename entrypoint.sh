#!/bin/sh
echo pasv_address=`curl -s https://api.ipify.org` >> /etc/vsftpd/vsftpd.conf
exec vsftpd /etc/vsftpd/vsftpd.conf
