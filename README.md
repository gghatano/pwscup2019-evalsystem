PWSCUP2019 評価用スクリプト
==

## 概要
- gsuite 環境から、投稿されたデータを取得する
- 取得したデータについて、有用性、安全性を評価する
- csvにまとめて、google spreadsheetに書き出す

## 処理内容
### 匿名加工フェーズ
- ./Data/anotraces にIDP/TRPデータを配置する
- ./Data/orgreftraces に、org, reftracesを配置する
- Eval.bashを実行すると, ./Result/に結果.csvが配置される

 
## 注意 
- 実行可能者: PWSCUP2019 システム管理者 (村上、西山、波多野)のみ
- ./Data以下には、非公開データが配置されるので注意(gitignoreしてある)

## Todo
- gsuite環境からの呼び出しコマンド
- バックアップの取得
- google spreadsheetへの書き出し
