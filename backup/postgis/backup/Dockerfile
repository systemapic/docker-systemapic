FROM systemapic/postgis

# add backup script
ADD ./backup_databases.sh /tmp/
ADD ./do_backup.sh /tmp/

# create log file
RUN touch /tmp/backup.log

# add cron job (once per day at midnight)
RUN echo '00 00 * * * root bash /tmp/do_backup.sh >> /tmp/backup.log 2>&1' >> /etc/cron.d/backup-cron

# run forever
CMD cron && tail -f /tmp/backup.log
