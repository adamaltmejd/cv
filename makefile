# Makefile for Adam Altmejd's resume

## Markdown extension (e.g. md, markdown, mdown).

## All markdown files in the working directory
SRC = index.md

PDF = $(SRC:.md=.pdf)
HTML = standalone.html
TEX = $(SRC:.md=.tex)

all:	$(HTML) $(PDF)

pdf:	$(PDF)
html:	$(HTML)
tex:	$(TEX)

standalone.html: $(SRC)
	pandoc \
		--from markdown+yaml_metadata_block+header_attributes+definition_lists \
		--to html5 \
		--standalone \
		--section-divs \
		--output $@ $<
	git add $@

%.tex: $(SRC)
	sh ./vc -m
	pandoc \
		--from markdown+yaml_metadata_block+header_attributes+definition_lists \
		--to latex \
		--latex-engine=xelatex \
		--template=cv.template \
		--smart \
		--variable=vc-git \
		--standalone \
		--output $@ $<

%.pdf: $(TEX)
	latexmk -xelatex $<

git:
	git add $(SRC) $(PDF) $(HTML)
	git commit -m "CV makefile auto commit."
	git push

clean:
	rm -f *.html *.pdf *.tex *.aux *.log *.fls *.out *.fdb_latexmk
