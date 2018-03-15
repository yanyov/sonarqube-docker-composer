#!/bin/bash -e

backup_folder=/tmp/postgresql-backup
postgresql_backup_archive=$backup_folder/$(date +%Y-%m-%d-%H-%M)-postgresql-db.out
retention_policy=14
remove_backups_older_than=$(date -d "$retention_policy days ago" +%Y-%m-%d-%H-%M)
file=/tmp/postgresql_backups

#POSTGRES_USER is env variable from docker-compose
pg_dumpall -U $POSTGRES_USER > db.out

echo "Backup $sonarqube_backup_archive was created."

ls -l $backup_folder | awk '{print $9}' | sort -n > $file
sed -i '/^$/d' $file

#retention policy
while read backup ; do
  #get timestamp and remove triling slash
  time_stamp=$(echo $backup| awk -F '[a-z]' '{print $1}'| sed 's:-$::')
  if [[ $remove_backups_older_than > $time_stamp ]]; then
    echo "Backup $backup will be deleted. It's older than $retention_policy days"
    rm -f $backup_folder/$backup
  fi
done < $file

#cleanup
rm -f $file

exit 0
