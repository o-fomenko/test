#!/bin/bash

USER="root"
PASSWORD="gfhjkm"
CUEDIR="/var/www/"
OUTPUT="/var/backups/"

mkdir $OUTPUT/`date +%Y%m%d`

databases='mysql --user=$USER --password=$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`


for db in $databases; do
	if [[ "$db != "information_schema" ]] && [[ "$db" != _* ]] then;
		echo "Dumping database: $db"
		mysqldump --force --opt --user=$USER --password=$PASSWORD --databases $db > $OUTPUT/`date +%Y%m%d`/`date +%Y%m%d`.$db.sql
	fi
done


rsync -avz $CUEDIR $OUTPUT/`date +%Y%m%d`/

tar -zcvf $OUTPUT/`date +%Y%m%d` $OUTPUT

