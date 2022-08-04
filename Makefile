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
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) latexmk $(MAIN).tex

.PHONY: clean
clean:
	docker container prune
	rm -f *.aux
	rm -f *.log
	rm -f *.toc
	rm -f *.pdf
	rm -f *.fdb_latexmk
	rm -f *.bbl
	rm -f *.blg
	rm -f *.dvi
	rm -f *.fls
	rm -f *.synctex.gz
	rm -f $(MAIN)-diff*
	rm -rf node_modules

.PHONY: lint
lint:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/、/，/g'
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/。/．/g'
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) npx textlint $(MAIN).tex */*.tex

.PHONY: fix
fix:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) npx textlint --fix $(MAIN).tex */*.tex

.PHONY: diff
diff: 
	@read -p "ENTER COMMIT ID OR BRANCH NAME: " commitID; \
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) latexdiff-vc -e utf8 --git --flatten --force -r "$$commitID" main.tex; \
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) latexmk $(MAIN)"-diff"$$commitID.tex