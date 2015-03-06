# Makefile for Adam Altmejd's resume
# TODO:
# - add bibliography support

## Markdown extension (e.g. md, markdown, mdown).
MEXT = md

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TEX=$(SRC:.md=.tex)

all:	$(PDFS) $(HTML) $(TEX)

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

%.pdf:	%.md
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

clean:
	rm -f *.html *.pdf *.tex *.aux *.log
