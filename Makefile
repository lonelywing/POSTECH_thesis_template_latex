# type "make" command in Unix to create asme2ej.pdf file 
all:
	latex Thesis_Ryu
	bibtex Thesis_Ryu
	latex Thesis_Ryu
	latex Thesis_Ryu
	dvips -o Thesis_Ryu.ps Thesis_Ryu
	ps2pdf Thesis_Ryu.ps Thesis_Ryu.pdf

clean:
	(rm -rf *.ps *.log *.dvi *.aux *.*% *.lof *.lop *.lot *.toc *.idx *.ilg *.ind *.bbl *blg)
