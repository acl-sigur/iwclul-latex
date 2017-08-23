
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

iwclul-template.zip: iwclul-template.tex iwclul.bib Makefile
	zip $@ $^

iwclul-template.tar.gz: iwclul-template.tex iwclul.bib Makefile
	tar zcvf $@ $^

iwclul-template.tar.bz2: iwclul-template.tex iwclul.bib Makefile
	tar jcvf $@ $^

iwclul-template.tar.xz: iwclul-template.tex iwclul.bib Makefile
	tar Jcvf $@ $^

clean:
	-rm -f *.log *.bbl *.aux iwclul-template.pdf
