.SUFFIXES: .tex .pdf

all:
	xelatex -shell-escape -interaction=nonstopmode 01introduction.tex

01introduction.pdf: 01introduction.tex
	xelatex -shell-escape -interaction=nonstopmode $<

02.pdf: 02typedesign.tex
	xelatex -shell-escape -interaction=nonstopmode $<

03.pdf: 03.tex
	xelatex -shell-escape -interaction=nonstopmode $<


	
