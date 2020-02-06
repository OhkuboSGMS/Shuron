# 修論テンプレート
これは,某大学向けの修論テンプレートです.
  
  修論の作成にmarkdownを使用して見やすく,わかりやすい文法で,修論を書くことが目標です.
  
  `markdown →(pandoc)→ tex →(platex)→ dvi →(dvipdfmx)→ pdf`の順で変換します.

参考文献にbibligraphyを使用.



# 環境
 マシン上に環境を整えるかDockerを使って環境を構築する必要があります。
 
 Dockerの方が簡単です.
## ローカルインストール

PC内に環境を構築します.

* [pandoc](http://pandoc.org/installing.html):markdown  → tex
* [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref):markdownないの参照解決
* [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc):参考文献の解決
* [basicTex](https://texwiki.texjp.org/?BasicTeX)

macのLatex環境->[link](https://qiita.com/sira/items/d7f5c411ccb0f90c43d8)

mac-brewであれば

```
brew install pandoc pandoc-crossref pandoc-citeproc
brew cask install basictex
brew install ghostscript
```

日本語環境のインストール
```shell script
sudo tlmgr update --self --all
sudo tlmgr install collection-langjapanese
```

pandocfilter(python)のインストール
```shell script
sudo pip3 install pandocfilters
sudo pip3 install pandoc-include # markdown内でmarkdownを埋め込み
```

## Docker 
Dockerをインストール,CLI上で実行できるようにする.
リポジトリをクローン
`git clone https://github.com/OhkuboSGMS/Shuron.git `

イメージを作成
`cd Shuron`
`docker build -t pandoc-thesis .`
コンテナを立ち上げ:
`docker run -it --rm  --name pandoc-latex -it -v {!!マウントするパス!!}:/markdown pandoc-thesis`
コンテナ内でmarkdownをlatex経由でをpdfに変換
`sh mp2.sh article`

# 使い方

1. このリポジトリをダウンロードします　`git clone https://github.com/OhkuboSGMS/Shuron.git `
2. [article.md](https://github.com/OhkuboSGMS/Shuron/blob/master/article.md)には各章からなる構成が示されています.
3. [section](https://github.com/OhkuboSGMS/Shuron/blob/master/section))に各章の内容を書きます.(背景,目的,関連研究,...etc)
3. [abstract](https://github.com/OhkuboSGMS/Shuron/blob/master/abstract)に日本語,英語の概要を書きます
4. [reference.bib](https://github.com/OhkuboSGMS/Shuron/blob/master/reference.bib)に参考文献を書きます
5. [mp2.sh](https://github.com/OhkuboSGMS/Shuron/blob/master/mp2.sh)で[article.md](https://github.com/OhkuboSGMS/Shuron/blob/master/article.md)をpdfに変換(shが動かせない環境の場合はmp2.shの中身を見れば大体わかると思います)

[img](./img)フォルダに使用する画像を保存することをお勧めします.

[仕様書](./resource/仕様書.pdf)
## 変換の実行

mardkdown -> latex -> dvi -> pdf 
```
  sh mp2.sh article(markdownファイル名,拡張子はつけない)

  or

  ./mp2.sh article

```


## タイトルとか日時とかを変えたい

[article.md](https://github.com/OhkuboSGMS/Shuron/blob/master/article.md)の一番上の部分のthesisとかtitleを変更すればOK

## mdでの書き方
[article.md](https://github.com/OhkuboSGMS/Shuron/blob/master/article.md)に基本的な書き方を載せていますので参考にしてください.

またこちらの[記事](https://qiita.com/Kumassy/items/5b6ae6b99df08fb434d9)もオススメです

## 参考文献のスタイル
[zotero.org/styles](https://www.zotero.org/styles)でお好みのスタイルをダウンロードしてきて mp2.shのcslの部分を変更してください.
## 例
exampleフォルダに修論の例があります.


# 注意事項
 * sectionラベルの付け方は{#sec:~}にする.
 * 図ラベルは{#fig:~}
 * 表ラベルは{#tbl:~}
 * コードラベルは{#lst:~}
 * labelにunderline(_)は認識されない
 * citeの順番を引用順にするには`csl`の<bibliography/>のsortの中身を消す(消した).