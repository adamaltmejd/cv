# Makefile for Adam Altmejd's resume
#
# Requirements: pandoc, typst
# Fonts: EB Garamond, Lato, JetBrains Mono, Font Awesome 5
FONTPATH = fonts

## Source and output files
sources := cv.md cv_onepage.md
targets := cv.pdf cv_onepage.pdf cv.html

# Settings
CSL = cv.csl
BIB = publications.bib
TEMPLATE = cv.template.typ
PANDOC_FROM = markdown+smart+yaml_metadata_block+header_attributes+definition_lists

# Git metadata for footer
GIT_DATE := $(shell git log -1 --format=%cs HEAD 2>/dev/null)

all: $(targets)

%.html: %.md
	pandoc \
		--from $(PANDOC_FROM) \
		--citeproc \
		--bibliography=$(BIB) \
		--csl=$(CSL) \
		--to html5 \
		--section-divs \
		--output $@ $<

%.typ: %.md $(TEMPLATE) $(BIB) $(CSL)
	pandoc \
		--from $(PANDOC_FROM) \
		--to typst \
		--citeproc \
		--bibliography=$(BIB) \
		--csl=$(CSL) \
		--template=$(TEMPLATE) \
		--variable=git-date:"$(GIT_DATE)" \
		--standalone \
		--output $@ $<

%.pdf: %.typ
	typst compile --font-path $(FONTPATH) $<
	rm -f $<


.PHONY: git clean

git:
	git add $(sources) $(targets)
	git commit --allow-empty -m "CV makefile auto commit."
	git push

clean:
	rm -f $(targets)
	rm -f *.typ
