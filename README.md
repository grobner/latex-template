# exp-templete

論文作成のための、LaTeXのテンプレート

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


commit IDにはブランチ名も指定することができる。
latex-template
