# Makefile for Adam Altmejd's resume

# Apart from latex, gawk and pandoc, needs the following fonts:
# XITS Math: https://github.com/khaledhosny/xits
# Operator Mono
# Gill Sans Std

## Source and output files
sources := cv.md cv_onepage.md
targets := cv.pdf cv_onepage.pdf index.md

# Settings
CSL = cv.csl
BIB = publications.bib

all: $(targets)

index.md: cv.md
	cp $< $@

%.html: %.md
	pandoc \
		--from markdown+yaml_metadata_block+header_attributes+definition_lists \
		--smart \
		--bibliography=$(BIB) \
		--csl=$(CSL) \
		--to html5 \
		--section-divs \
		--output $@ $<
	git add $@

%.tex: %.md
	sh ./vc -m
	pandoc \
		--from markdown+smart+yaml_metadata_block+header_attributes+definition_lists \
		--to latex \
		--pdf-engine=xelatex \
		--bibliography=$(BIB) \
		--csl=$(CSL) \
		--template=cv.template \
		--variable=vc-git \
		--standalone \
		--output $@ $<

%.pdf: %.tex
	latexmk -xelatex $<
	rm -f *.tex *.aux *.log *.fls *.out *.fdb_latexmk *.xdv


.PHONY: git clean

git:
	git add $(sources) $(targets)
	git commit -m "CV makefile auto commit."
	git push

clean:
	rm -f $(targets)