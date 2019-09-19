FROM alpine:3.10

EXPOSE 20-21
EXPOSE 32022-32041

ENTRYPOINT ["/entrypoint.sh"]
VOLUME /var/lib/ftp/incoming
WORKDIR /var/lib/ftp

RUN set -xe \
    && apk --no-cache add -U vsftpd curl \
    && rm -rf /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh
ADD vsftpd.conf vsftpd.email_passwords vsftpd.banner /etc/vsftpd/
RUN set -xe \
    && ln -s /etc/vsftpd/vsftpd.email_passwords /etc/vsftpd.email_passwords \
    && ln -sf /dev/stdout /var/log/vsftpd.log \
    && install -d -m u+wx,u-r,g+rwxs,o-rwx -o ftp -g root /var/lib/ftp/incoming


#CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
