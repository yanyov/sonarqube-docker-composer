FROM postgres:10.2-alpine
RUN apk add --update coreutils supervisor
RUN mkdir -p /etc/supervisor/conf.d /var/log/supervisor
COPY supervisor/supervisord.conf /etc/supervisord.conf
COPY supervisor/cron.conf /etc/supervisor/conf.d/cron.conf
COPY supervisor/postgresql.conf /etc/supervisor/conf.d/postgresql.conf
COPY backup_postgresql.sh /usr/local/bin/backup_postgresql.sh
COPY crontab /etc/crontabs/root
CMD ["/usr/bin/supervisord", "-nc", "/etc/supervisord.conf"]
