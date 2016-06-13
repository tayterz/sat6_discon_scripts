declare -i SIZE=0
declare -i MAX_SIZE=500
declare -i INDEX=0

read -r -a FILELIST <<< $(find /var/lib/pulp/exports/MPO-* -type f)
declare -i BUNDLE_NUM=1
BUNDLE_NAME="/var/lib/pulp/exports/bundles/newbundle"

echo NUM = ${#FILELIST[@]}
while [ $INDEX -lt ${#FILELIST[@]} ]
do
  SIZE=0
  tar -cvf $BUNDLE_NAME.$BUNDLE_NUM --files-from /dev/null
  while [ ${SIZE} -lt ${MAX_SIZE} ]
  do
    FOLDER=$(echo ${FILELIST[INDEX]} | cut -d/ -f-8) 
    FILE=$(echo ${FILELIST[INDEX]} | cut -d/ -f9-) 
#    echo INDEX = $INDEX
    echo "Adding $(basename ${FILELIST[INDEX]}) to bundle $BUNDLE_NUM"
    tar -rf $BUNDLE_NAME.$BUNDLE_NUM -C $FOLDER --remove-files $FILE
    INDEX+=1
#    echo SIZE = $SIZE
#    echo BUNDLE_NUM = $BUNDLE_NUM
    if [ $(( INDEX  )) -ge ${#FILELIST[@]} ]
    then
      break
    fi
    SIZE=$(ls -l --block-size=1M $BUNDLE_NAME.$BUNDLE_NUM | awk '{print $5}')
    SIZE+=$(ls -l --block-size=1M ${FILELIST[INDEX]}  | awk '{print $5}')
  done
    BUNDLE_NUM+=1
done
