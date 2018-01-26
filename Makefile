.PHONY: clean all
MAIN=main
all:
	xelatex $(MAIN) && \
	makeindex $(MAIN).idx -s StyleInd.ist && \
	biber $(MAIN) && \
	xelatex $(MAIN) x 2

clean:
	$(RM) *.aux *.bbl *.bcf *.dvi *.blg *.ilg *.idx *.ind *.log \
		*.toc *.ptc *.ps *.xml

