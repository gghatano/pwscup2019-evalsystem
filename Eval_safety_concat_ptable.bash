
dir=$(dirname $0)

ptable_filedir=$(echo ${dir}/Data/ptable)

echo "team,data,user_id_anon,user_id_raw" > $dir/tmp.txt

ls $ptable_filedir | 
while read line
do
  team=$(echo $line |
  awk -F"[_|\.]" '{print $2}')

  data=$(echo $line |
  awk -F"[_|\.]" '{print $4}')

  echo "team: " $team
  echo "data: " $data

  cat ${dir}/Data/ptable/$line | 
  sed "1d" | 
  awk -v OFS=, -v T=$team -v D=$data '{print T,D,$1,$2}' >> $dir/tmp.txt
done
