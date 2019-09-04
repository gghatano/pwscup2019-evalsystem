seq -f %03g 20 | while read line 
do
  echo $line
  cp ./testdata/anotraces/anotraces_team001_data01_IDP.csv ./Data/anotraces/anotraces_team${line}_data01_IDP.csv
  cp ./testdata/orgreftraces/orgtraces_team001_data01_IDP.csv ./Data/orgreftraces/orgtraces_team${line}_data01_IDP.csv
  cp ./testdata/orgreftraces/reftraces_team001_data01_IDP.csv ./Data/orgreftraces/reftraces_team${line}_data01_IDP.csv

  cp ./testdata/anotraces/anotraces_team001_data02_TRP.csv ./Data/anotraces/anotraces_team${line}_data02_TRP.csv
  cp ./testdata/orgreftraces/orgtraces_team001_data02_TRP.csv ./Data/orgreftraces/orgtraces_team${line}_data02_TRP.csv
  cp ./testdata/orgreftraces/reftraces_team001_data02_TRP.csv ./Data/orgreftraces/reftraces_team${line}_data02_TRP.csv
done
