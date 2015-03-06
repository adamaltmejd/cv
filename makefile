# Makefile for Adam Altmejd's resume
# Automatically commits and pushes changes to git repo.

## Markdown extension (e.g. md, markdown, mdown).
MEXT = md

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))

PDFS=$(SRC:.$(MEXT)=.pdf)
HTML=$(SRC:.$(MEXT)=.html)
TEX=$(SRC:.$(MEXT)=.tex)

all:	$(PDFS)

pdf:	clean $(PDFS)
html:	clean $(HTML)
tex:	clean $(TEX)

%.html:	%.md
	pandoc \
		--from markdown+yaml_metadata_block+header_attributes+definition_lists \
		--to html5 \
		--standalone \
		--section-divs \
		--output $@ $<

%.tex:	%.md
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

%.pdf:	%.tex
	latexmk -xelatex $<
	git add $@ $(SRC)
	git commit -m "CV makefile auto commit."
	git push

clean:
	rm -f *.html *.pdf *.tex *.aux *.log *.fls *.out *.fdb_latexmk
