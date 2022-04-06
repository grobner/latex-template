all: main.tex
	#sed -e "s/。/./" -e "s/、/,/" main.tex > main.tex
	ptex2pdf -l main.tex
	pdfunite cover.pdf main.pdf "提出用タイトル.pdf"
clean:
	rm -rf *.pdf
tori: main.tex
	ptex2pdf -l main.tex

lint:
	find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/、/，/g'
	find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/。/．/g'
	npx textlint main.tex */*.tex

fix:
	npx textlint --fix main.tex */*.tex
