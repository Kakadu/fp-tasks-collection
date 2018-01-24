.PHONY: clean all

all:
	pdflatex main
	makeindex main.idx -s StyleInd.ist
	biber main
	pdflatex main x 2

clean:
	$(RM) *.aux *.bbl *.bcf *.dvi *.blg *.ilg *.idx *.ind *.log \
		*.toc *.ptc *.ps *.xml

