# Makefile for Adam Altmejd's resume

## Source and output files
# I use index.md so that Jekyll produces index.html automatically.
SRC = index.md
PDF = cv.pdf
HTML = cv.html
TEX = cv.tex

CSL = cv.csl
BIB = publications.bib

all:	$(HTML) $(PDF)

$(HTML): $(SRC)
	pandoc \
		--from markdown+yaml_metadata_block+header_attributes+definition_lists \
		--bibliography=$(BIB) \
		--csl=$(CSL) \
		--to html5 \
		--standalone \
		--section-divs \
		--output $@ $<
	git add $@

$(TEX): $(SRC)
	sh ./vc -m
	pandoc \
		--from markdown+yaml_metadata_block+header_attributes+definition_lists \
		--to latex \
		--latex-engine=xelatex \
		--bibliography=$(BIB) \
		--csl=$(CSL) \
		--template=cv.template \
		--smart \
		--variable=vc-git \
		--standalone \
		--output $@ $<

$(PDF): $(TEX)
	latexmk -xelatex $<
	rm -f *.tex *.aux *.log *.fls *.out *.fdb_latexmk

git:
	git add $(SRC) $(PDF) $(HTML)
	git commit -m "CV makefile auto commit."
	git push

clean:
	rm -f *.html *.pdf *.tex *.aux *.log *.fls *.out *.fdb_latexmk
