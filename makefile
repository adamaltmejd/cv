# Makefile for Adam Altmejd's resume

# Apart from latex, gawk and pandoc, needs the following fonts:
# XITS Math: https://github.com/khaledhosny/xits
# Operator Mono
# Gill Sans Std

## Source and output files
# Because we have citations we need pandoc to build html file (rather than Jekyll)
sources := cv.md cv_onepage.md
targets := cv.pdf cv_onepage.pdf cv.html

# Settings
CSL = cv.csl
BIB = publications.bib

all: $(targets)

%.html: %.md
	pandoc \
		--from markdown+smart+yaml_metadata_block+header_attributes+definition_lists \
		--bibliography=$(BIB) \
		--csl=$(CSL) \
		--to html5 \
		--section-divs \
		--output $@ $<

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
	rm -f *.tex *.aux *.log *.fls *.out *.fdb_latexmk *.xdv