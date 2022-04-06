all: kadai.tex
	#sed -e "s/。/./" -e "s/、/,/" kadai.tex > kadai.tex
	ptex2pdf -l kadai.tex
	pdfunite cover.pdf kadai.pdf "提出課題.pdf"
	rm kadai.pdf
clean:
	rm -rf *.tex *.pdf
tori: kadai.tex
	ptex2pdf -l kadai.tex
