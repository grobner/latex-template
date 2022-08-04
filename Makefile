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