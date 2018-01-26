.PHONY: clean all demoRu
MAIN=main

#demoRu:
#	xelatex demoRu.tex
	
all:
	xelatex $(MAIN) && \
	makeindex $(MAIN).idx -s StyleInd.ist && \
	xelatex $(MAIN) x 2
	#biber $(MAIN) && \

clean:
	$(RM) *.aux *.bbl *.bcf *.dvi *.blg *.ilg *.idx *.ind *.log \
		*.toc *.ptc *.ps *.xml

