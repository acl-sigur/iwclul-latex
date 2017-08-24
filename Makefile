
FILES=iwclul-template.tex iwclul.bib Makefile acl_natbib.bst

.PHONY: all

all: iwclul-template.pdf \
	iwclul-template.zip \
	iwclul-template.tar.xz \
	iwclul-template.tar.bz2 \
	iwclul-template.tar.gz

%.pdf: %.tex
	xelatex $<
	-bibtex $*
	xelatex $<
	xelatex $<
	xelatex $<

iwclul-template.zip: $(FILES)
	zip $@ $^

iwclul-template.tar.gz: $(FILES)
	tar zcvf $@ $^

iwclul-template.tar.bz2: $(FILES)
	tar jcvf $@ $^

iwclul-template.tar.xz: $(FILES)
	tar Jcvf $@ $^

clean:
	-rm -f *.log *.bbl *.aux iwclul-template.pdf
