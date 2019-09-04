# (テスト用) 適当に加工する
# python3 SmplProg_Anonymize/A2-MRLH.py Data/PWSCup2019_Osaka/orgtraces_team001_data01_IDP.csv Data_Anonymize/anotraces_team001_data01_IDP.csv


###### パラメータ ######

## チーム数
NUMBER_OF_TEAMS=20

## このファイルの場所
dir=$(dirname $0)

## 匿名加工データ配置ディレクトリ
DIR_ANO="$dir/Data/anotraces"

## 元データ配置ディレクトリ
DIR_ORG="$dir/Data/orgreftraces"

## 参照データ配置ディレクトリ
DIR_REF="$dir/Data/orgreftraces"

## ID識別対策用匿名加工データ配置ディレクトリ
DIR_ANO_IDP="$dir/Data/IDP/anotraces_idp"

## ID識別対策用元データ配置ディレクトリ
DIR_ORG_IDP="$dir/Data/IDP/orgtraces_idp"
DIR_REF_IDP="$dir/Data/IDP/reftraces_idp"

## トレース推定対策用匿名加工データ配置ディレクトリ
DIR_ANO_TRP="$dir/Data/TRP/anotraces_trp"

## トレース推定対策用元データ配置ディレクトリ
DIR_ORG_TRP="$dir/Data/TRP/orgtraces_trp"
DIR_REF_TRP="$dir/Data/TRP/reftraces_trp"

## バッチを回した日付
DATE=$(date "+%Y%m%d-%H%M%S")


###### 前準備 ######

# データをgoogle driveからダウンロードして、Data/anotrace以下に配置する
## TODO

# バックアップ
## backupディレクトリに、DATEを付してバックアップする

# tar -cvfz ./Backup/anotraces.tgz ./Data/anotraces

# ディレクトリの準備

## IDPとTRPディレクトリ
if [ ! -e $dir/Data/IDP ] ; then
  mkdir $dir/Data/IDP
else
  rm -r $dir/Data/IDP
  mkdir $dir/Data/IDP
fi

if [ ! -e $dir/Data/TRP ] ; then
  mkdir $dir/Data/TRP
else
  rm -r $dir/Data/TRP
  mkdir $dir/Data/TRP
fi

## ANOとOFGとREF
if [ ! -e ${DIR_ANO_IDP} ] ; then
  mkdir ${DIR_ANO_IDP}
fi

if [ ! -e ${DIR_ANO_TRP} ] ; then
  mkdir ${DIR_ANO_TRP}
fi

if [ ! -e ${DIR_ORG_IDP} ] ; then
  mkdir ${DIR_ORG_IDP}
fi

if [ ! -e ${DIR_ORG_TRP} ] ; then
  mkdir ${DIR_ORG_TRP}
fi

if [ ! -e ${DIR_REF_IDP} ] ; then
  mkdir ${DIR_REF_IDP}
fi

if [ ! -e ${DIR_REF_TRP} ] ; then
  mkdir ${DIR_REF_TRP}
fi

## 仮名化データ置き場
if [ ! -e ${DIR_ANO_IDP}_shuffle ] ; then
  mkdir ${DIR_ANO_IDP}_shuffle
fi

if [ ! -e ${DIR_ANO_TRP}_shuffle ] ; then
  mkdir ${DIR_ANO_TRP}_shuffle
fi

# データを分類
cp ${DIR_ANO}/*_IDP.csv ${DIR_ANO_IDP}/
cp ${DIR_ANO}/*_TRP.csv ${DIR_ANO_TRP}/

cp ${DIR_ORG}/*_IDP.csv ${DIR_ORG_IDP}/
cp ${DIR_ORG}/*_TRP.csv ${DIR_ORG_TRP}/

cp ${DIR_REF}/*_IDP.csv ${DIR_REF_IDP}/
cp ${DIR_REF}/*_TRP.csv ${DIR_REF_TRP}/

# 匿名加工データを配置したディレクトリ以下の全ファイルを仮名化する
## シャッフル
python3 $dir/Prog_Shuffle/ShuffleIDs.py ${DIR_ANO_IDP} ${DIR_ANO_IDP}_shuffle
python3 $dir/Prog_Shuffle/ShuffleIDs.py ${DIR_ANO_TRP} ${DIR_ANO_TRP}_shuffle


# 評価結果を作る
## TODO: 並列処理する予定

echo NUM,UTILITY_IDP,SAFETY_IDP > ${dir}/Result/res_IDP_${DATE}
echo NUM,UTILITY_TRP,SAFETY_TRP > ${dir}/Result/res_TRP_${DATE}

function eval() {
  NUM=$1

  # ID識別対策

  FILENAME_ANOTRACES_IDP=$(echo ${DIR_ANO_IDP}"/anotraces_team"${NUM}"_data01_IDP.csv")
  FILENAME_ORGTRACES_IDP=$(echo ${DIR_ORG_IDP}"/orgtraces_team"${NUM}"_data01_IDP.csv")
  FILENAME_REFTRACES_IDP=$(echo ${DIR_REF_IDP}"/reftraces_team"${NUM}"_data01_IDP.csv")

  FILENAME_PTABLE_IDP=$(echo ${DIR_ANO_IDP}"_shuffle/ptable_team"${NUM}"_data01_IDP.csv")
  FILENAME_ETABLE_IDP=$(echo ${DIR_ANO_IDP}"_shuffle/pubtraces_team"${NUM}"_data01_TRP.csv")

  ### 有用性評価
  UTILITY_IDP=$(python3 $dir/Prog_Eval/EvalUtil.py $FILENAME_ORGTRACES_IDP $FILENAME_ANOTRACES_IDP || echo 0)

  ## 安全性評価
  ### 加工
  python3 $dir/SmplProg_IDDisclose/I1-rand.py ${FILENAME_REFTRACES_IDP} ${FILENAME_PTABLE_IDP} ${FILENAME_ETABLE_IDP} || echo 0
  ### 推定
  SAFETY_IDP=$( python3 $dir/Prog_Eval/EvalSecI.py ${FILENAME_PTABLE_IDP} ${FILENAME_ETABLE_IDP} || echo 0 )

  # トレース推定対策
  FILENAME_ANOTRACES_TRP=$(echo ${DIR_ANO_TRP}"/anotraces_team"${NUM}"_data02_TRP.csv")
  FILENAME_ORGTRACES_TRP=$(echo ${DIR_ORG_TRP}"/orgtraces_team"${NUM}"_data02_TRP.csv")
  FILENAME_REFTRACES_TRP=$(echo ${DIR_REF_TRP}"/reftraces_team"${NUM}"_data02_TRP.csv")

  FILENAME_PUBTRACES_TRP=$(echo ${DIR_ANO_TRP}"_shuffle/pubtraces_team"${NUM}"_data02_TRP.csv")
  FILENAME_ETRACES_TRP=$(echo ${DIR_ANO_TRP}"_shuffle/etraces_team"${NUM}"_data02_TRP.csv")

  ### 有用性評価
  UTILITY_TRP=$(python3 $dir/Prog_Eval/EvalUtil.py $FILENAME_ORGTRACES_TRP $FILENAME_ANOTRACES_TRP || echo 0)

  ## 安全性評価

  python3 $dir/SmplProg_TraceInfer/T1-rand.py ${FILENAME_REFTRACES_TRP} ${FILENAME_PUBTRACES_TRP} ${FILENAME_ETRACES_TRP} || echo 0
  SAFETY_TRP=$( python3 $dir/Prog_Eval/EvalSecT.py ${FILENAME_ORGTRACES_TRP} ${FILENAME_ETRACES_TRP} || echo 0 ) 
  
  echo ${NUM},${UTILITY_IDP},${SAFETY_IDP} >> $dir/Result/res_IDP_${DATE}
  echo ${NUM},${UTILITY_TRP},${SAFETY_TRP} >> $dir/Result/res_TRP_${DATE}
}



seq -f %03g ${NUMBER_OF_TEAMS} |
while read NUM
do
  eval $NUM
done 


