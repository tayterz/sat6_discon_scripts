

mapfile=/var/lib/pulp/exports/mapping.txt

cd /var/lib/pulp/exports/


for file in $(find MPO* -type f -not -name listing)
do
  contentpath=$(echo $file | cut -d/ -f4- | rev | cut -d / -f2- | rev )
  basefile=$(echo $file | rev | cut -d/ -f-1 | rev)
  hash=$(grep ${contentpath}\$ $mapfile | cut -d'	' -f1)

  echo file = $file
  echo contentpath = $contentpath
  echo basefile = $basefile
  echo hash = $hash

  curl -k -f -T $file https://10.0.93.8/file/satelite6/${hash}-${basefile} -v
done
