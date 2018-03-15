#!/bin/bash -e

sonarqube_home=/opt/sonarqube
backup_folder=/tmp/sonarqube-backup
sonarqube_backup_archive=$backup_folder/$(date +%Y-%m-%d-%H-%M)-sonarqube.tgz
retention_policy=14
remove_backups_older_than=$(date -d "$retention_policy days ago" +%Y-%m-%d-%H-%M)
file=/tmp/sonarqube_backups

mkdir -p $backup_folder
cd $sonarqube_home || exit 1

tar --exclude 'temp/*' \
    --exclude 'bin/*' \
    --exclude 'web/*' \
    --exclude 'lib/*' \
    --exclude 'data/*' \
    -czf $sonarqube_backup_archive .

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
