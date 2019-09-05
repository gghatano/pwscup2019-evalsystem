dir=$(dirname $0)

if [ ! -e $dir/Data/anotraces ] ; then
  mkdir $dir/Data/anotraces
else
  rm -r $dir/Data/anotraces
  mkdir $dir/Data/anotraces
fi

if [ ! -e $dir/Data/anotraces ] ; then
  mkdir $dir/Data/anotraces
else
  rm -r $dir/Data/anotraces
  mkdir $dir/Data/anotraces
fi
if [ ! -e $dir/Data/orgreftraces ] ; then
  mkdir $dir/Data/orgreftraces
else
  rm -r $dir/Data/orgreftraces
  mkdir $dir/Data/orgreftraces
fi

seq -f %03g 20 | while read line 
do
  
  echo $line

  cp ./Testdata/anotraces/anotraces_team001_data01_IDP.csv ./Data/anotraces/anotraces_team${line}_data01_IDP.csv
  cp ./Testdata/orgreftraces/orgtraces_team001_data01_IDP.csv ./Data/orgreftraces/orgtraces_team${line}_data01_IDP.csv
  cp ./Testdata/orgreftraces/reftraces_team001_data01_IDP.csv ./Data/orgreftraces/reftraces_team${line}_data01_IDP.csv

  cp ./Testdata/anotraces/anotraces_team001_data02_TRP.csv ./Data/anotraces/anotraces_team${line}_data02_TRP.csv
  cp ./Testdata/orgreftraces/orgtraces_team001_data02_TRP.csv ./Data/orgreftraces/orgtraces_team${line}_data02_TRP.csv
  cp ./Testdata/orgreftraces/reftraces_team001_data02_TRP.csv ./Data/orgreftraces/reftraces_team${line}_data02_TRP.csv
done
