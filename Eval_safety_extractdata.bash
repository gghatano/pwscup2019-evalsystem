# ファイル選別
## 仮名表
dir=$(dirname $0)
etable_dir=$(echo ${dir}"/Data/etable")
etraces_dir=$(echo ${dir}"/Data/etraces")

echo $etable_dir
echo $etraces_dir

## 仮名表用ディレクトリ
if [ -e /tmp/pwscup2019/latest_etable_file ]; then
  rm -r /tmp/pwscup2019/latest_etable_file
  mkdir -p /tmp/pwscup2019/latest_etable_file
else 
  mkdir -p /tmp/pwscup2019/latest_etable_file
fi

## トレース用ディレクトリ
if [ -e /tmp/pwscup2019/latest_etraces_file ]; then
  rm -r /tmp/pwscup2019/latest_etraces_file
  mkdir -p /tmp/pwscup2019/latest_etraces_file
else 
  mkdir -p /tmp/pwscup2019/latest_etraces_file
fi

## ファイル名
ls $etable_dir | grep etable | awk -F_ -v OFS=_ '{print $1,$2,$3,$4}' > /tmp/pwscup2019/etable_file
ls $etraces_dir | grep etraces | awk -F_ -v OFS=_ '{print $1,$2,$3,$4}' > /tmp/pwscup2019/etraces_file

## 最新のファイルを抽出
cat /tmp/pwscup2019/etable_file | 
while read line
do
  echo $line
  latest_etable_file=$(ls ${etable_dir} | 
  grep ${line} | 
  tail -n 1)
  
  echo $latest_etable_file

  cp ${etable_dir}/${latest_etable_file} /tmp/pwscup2019/latest_etable_file/${line}

done

cat /tmp/pwscup2019/etraces_file | 
while read line
do
  echo $line
  latest_etraces_file=$(ls ${etraces_dir} | 
  grep ${line} | 
  tail -n 1)

  cp ${etraces_dir}/${latest_etraces_file} /tmp/pwscup2019/latest_etraces_file/

done


# 仮名推定表

# ファイル読み込みs
