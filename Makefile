# type "make" command in Unix to create asme2ej.pdf file
all:
	latex thesis
	bibtex thesis
	latex thesis
	latex thesis
	dvips -o thesis.ps thesis
	ps2pdf thesis.ps thesis.pdf

clean:
	(rm -rf *.ps *.log *.dvi *.aux *.*% *.lof *.lop *.lot *.toc *.idx *.ilg *.ind *.bbl *blg)
