# 特演テンプレート
　これは、某大学向けの特演予稿テンプレートです.

  無駄な作業を減らして出来るだけ楽しましょう.

  文書の作成にmarkdownを使用します.

  pandocでmarkdown->latexに変換し

  platex -> dvipdfmx ->pdf
でpdfに変換します.


# 環境
  * pandoc,pandoc-crossref,pandoc-citeproc
  * basicTex(platexが動く環境であればOK)

  日本語環境が必須


# インストール
* [pandoc](http://pandoc.org/installing.html)
* pandoc-crossref
* pandoc-citeproc
* [basicTex](https://texwiki.texjp.org/?BasicTeX)

macのLatex環境->[link](https://qiita.com/sira/items/d7f5c411ccb0f90c43d8)

mac-brewであれば
```
brew install pandoc pandoc-crossref pandoc-citeproc
brew cask install basictex
brew install ghostscript
```


# 使い方

1. このリポジトリをダウンロードします
1. [article.md](https://github.com/OhkuboSGMS/paper/blob/master/article.md)にレポートを書きます
2. [abstract.tex](https://github.com/OhkuboSGMS/paper/blob/master/article.tex)に英語のアブストラクトを書きます
3. reference.bibに参考文献を書きます
3.
4. mp2.shで[article.md](https://github.com/OhkuboSGMS/paper/blob/master/article.md)をpdfに変換(shが動かせない環境の場合はmp2.shの中身を見れば大体わかると思います)


## タイトルとか日時とかを変えたい

[article.md](https://github.com/OhkuboSGMS/paper/blob/master/article.md)の一番上の部分のthesisとかtitleを変更すればOK

## mdでの書き方
[article.md](https://github.com/OhkuboSGMS/paper/blob/master/article.md)に基本的な書き方を載せていますので参考にしてください.

またこちらの[記事](https://qiita.com/Kumassy/items/5b6ae6b99df08fb434d9)もオススメです

## 参考文献のスタイル
[https://www.zotero.org/styles](https://www.zotero.org/styles)でお好みのスタイルをダウンロードしてきて mp2.shのcslの部分を変更してください.
## ファイル構造
```
├── aaai.csl (参考文献の参照スタイル)
├── abstract.tex(英語のアブストラクト)
├── article.md(レポート本体)
├── article.pdf(出力)
├── example(レポートの例)
├── img(画像置き場-ここに置かなくてもいい)
│   └── img.jpg
├── mp2.sh(変換のシェルスクリプト)
├── reference.bib　-bibliographyのファイル(参照文献はここに)
└── templates
    └── template.tex (特演のテンプレート)

```
