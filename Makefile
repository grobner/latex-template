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
	rm $(MAIN).aux
	rm $(MAIN).log
	rm $(MAIN).toc
	rm $(MAIN).pdf
	rm $(MAIN).fdb_latexmk
	rm $(MAIN).bbl
	rm $(MAIN).blg
	rm $(MAIN).dvi
	rm $(MAIN).fls
	rm $(MAIN).synctex.gz

.PHONY: lint
lint:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/、/，/g'
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) find . -name '*.tex' -print0 | xargs -0 sed -i '' -e 's/。/．/g'
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) npx textlint $(MAIN).tex */*.tex

.PHONY: fix
fix:
	docker run --rm -it -v $(PWD):/workdir $(IMAGE) npx textlint --fix $(MAIN).tex */*.tex