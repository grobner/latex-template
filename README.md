# exp-templete

実験のための、LaTeXのテンプレート

構成は
- gitignore
- kadai.tex (ここに色々書く　ファイル分割推奨)
- sankou.tex　(参考文献)
- Makefile コンパイル&表紙くっつけるやつ

## 取り込み

```
git remote add origin [HTTPS]
git pull origin master
```

## 差分PDF出力

```
latexdiff-vc -e utf8 --git --flatten --force -r [commit ID] kadai.tex
```

commit IDにはブランチ名も指定することができる。
latex-template
