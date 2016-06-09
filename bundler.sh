declare -i SIZE=0
declare -i MAX_SIZE=300
declare -i INDEX=0

#FILELIST=$(find /var/lib/pulp/exports/MPO-* -type f)
read -r -a FILELIST <<< $(find /var/lib/pulp/exports/MPO-* -type f)
declare -i BUNDLE_NUM=1
BUNDLE_NAME="/var/lib/pulp/exports/bundles/bundle"

while [ $INDEX -lt ${#FILELIST[@]} ]
do
  while [ ${SIZE} -lt ${MAX_SIZE} ]
  do
#   echo "Adding ${FILELIST[INDEX]} to the bundle $BUNDLE_NUM"
    echo tar -avf $BUNDLE_NAME.$BUNDLE_NUM ${FILELIST[INDEX]}
    SIZE+=$(ls -l --block-size=1M ${FILELIST[INDEX]}  | awk '{print $5}')
    BUNDLE_NUM+=1
    INDEX+=1
    echo SIZE = $SIZE
  done
done
