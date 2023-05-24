F=defence
all: compile clean

compile:
	mkdir -p tikz
	lualatex -shell-escape $F.tex
	biber $F
	lualatex -shell-escape $F.tex
	lualatex -shell-escape $F.tex

clean:
	rm -rf *.log *.out *.aux *.blg *.bbl *.auxlock *.nav *.snm *.toc *.dpth *.md5 *.bcf *.xml

deepclean: clean
	rm -rf tikz
