# まとめ {#conclusion}
本章では,本論文の結論と今後の課題について述べる.

## 結論

本論文では,スーパーマリオメーカー2のゲームレベルを
抽出,挿入.抽出したデータを学習用に変換する環境
smm2Builderの設計と実装を行った.

従来の環境ではレベルデータが大量に存在しない問題があった.
その問題を解決するための設計を行い,smm2Builderを実装した.
実装した環境でGANを学習させて,レベルの出力を行い,正常に
レベルが読み込まれたことを確認した.

## 今後の展望
本実装であるsmm2Builderでは,現在
配置,取得できるオブジェクトがゲーム全体
に比べて数が少ない状態にあるため使用可能な
オブジェクト数を増やすようする必要がある.

また,本論文においてはゲームが実際に
プレイできるかどうか,またプレイしたゲームが
面白い,難易度があるなどレベルの評価については
行わなかった.レベルの生成の質を上げるための
評価法などを導入する必要があると考えられる.
