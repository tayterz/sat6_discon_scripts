for export in $(find /var/lib/pulp/exports/ -type d -name content)
do
  UUID=$(uuidgen | cut -c-8)
  OSFOLD=$(find $export -type d -name os | cut -d/ -f9-)
  REPOFOLD=$OSFOLD/repodata

  if [ $(grep $REPOFOLD /var/lib/pulp/exports/mapping.txt | wc -l) -lt 1 ]
  then
    echo -e "$UUID\t$OSFOLD" >> /var/lib/pulp/exports/mapping.txt
    echo -e "$UUID-r\t$REPOFOLD" >> /var/lib/pulp/exports/mapping.txt
  fi
done
