# exp-templete

実験のための、LaTeXのテンプレート

構成は
- gitignore (.DS_Store 回避用)
- main.tex (ここに色々書く　ファイル分割推奨)
- Makefile コンパイル&表紙
- sankou.bib 参考文献




## 取り込み

このテンプレートを利用して新しくレポジトリを作る。


```
git init
git remote add origin [HTTPS]
git pull origin master
```


## 差分PDF出力

```
latexdiff-vc -e utf8 --git --flatten --force -r [commit ID] main.tex
```

## Makefileの構成

- make単体　-> latexコンパイル
- clean pdfなどの副産物を削除
- lint 校正ツールを起動
- fix 直せるところは直してる

```
all: main.tex
	ptex2pdf -l main.tex
	pdfunite cover.pdf main.pdf "提出用タイトル.pdf"
clean:
	rm -rf *.pdf *.toc *.aux
tori: main.tex
	ptex2pdf -l main.tex

lint:
	find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/、/，/g'
	find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/。/．/g'
	npx textlint main.tex */*.tex

fix:
	npx textlint --fix main.tex */*.tex

```



commit IDにはブランチ名も指定することができる。
latex-template
