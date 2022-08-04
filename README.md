# exp-templete

実験のための、LaTeXのテンプレート

構成は
- gitignore (.DS_Store 回避用)
- main.tex (ここに色々書く　ファイル分割推奨)
- Makefile コンパイル
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

```

SOURCE = Dockerfile
IMAGE = texlive-ja:latest
MAIN = main

.PHONY: build
build: Dockerfile 
	docker image build -f ${SOURCE} -t $(IMAGE) .

.PHONY: shell
shell:
	docker container run -it --rm -v $(PWD):/workdir $(IMAGE)

.PHONY: compile
compile:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) uplatex $(MAIN).tex

.PHONY: pdf
pdf:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) dvipdfmx $(MAIN).dvi

.PHONY: clean
clean:
	docker container prune
	rm *.dvi
	rm *.aux
	rm *.log
	rm *.pdf

.PHONY: lint
lint:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/、/，/g'
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/。/．/g'
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) npx textlint $(MAIN).tex */*.tex

.PHONY: fix
fix:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) npx textlint --fix $(MAIN).tex */*.tex

```

commit IDにはブランチ名も指定することができる。
latex-template
