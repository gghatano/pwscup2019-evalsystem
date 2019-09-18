
dir=$(dirname $0)
filedir="/tmp/pwscup2019/latest_etable_file"

echo "attacker,target,user_id,user_id,estimated" > $dir/tmp.txt

ls $filedir | 
while read line
do
  tmp=$(echo $line | 
    grep -o -E "[0-9][0-9][0-9]-[0-9][0-9][0-9]")
  attacker=$(echo $tmp | cut -d"-" -f1)
  target=$(echo $tmp | cut -d"-" -f2)

  cat ${filedir}/$line | 
  sed "1d" | 
  awk -F, -v OFS=","  -v A=${attacker}, -v T=${target} '{print A T,NR,$1}' >> $dir/tmp.txt

  echo $line
done




