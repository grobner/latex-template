# latex-templete

論文のための、LaTeXのテンプレート

構成は
- dockerfile (LaTeX + textlint立ち上げ用)
- gitignore (.DS_Storeもろもろ回避用)
- main.tex (ここに色々書く　ファイル分割推奨)
- Makefile コンパイル
- sankou.bib 参考文献

あとは論文の構造に合わせて階層を作っていけば良いと思う。



## 取り込み

このテンプレートを利用して新しくレポジトリを作る。


```
git init
git remote add origin [HTTPS]
git pull origin master
```


## Makefileの構成

- docker関連
	- `make build` Dockerをビルドする
	- `make shell` Dockerのshellに接続する
- コンパイル+PDF生成
	- `make compile` コンパイルしてdviファイルを作成
	- `make pdf` dviファイルからPDFを作成
- textlint
	- `make lint` textlintを動かして文法、用語チェック
	- `make fix` textlintを動かして修正する
- `make clean` Dockerを落とす + 副産物を全削除
- `make diff` commit IDやブランチ名を指定して差分PDFを出力
