F1=spik
F2=data

all: ${F1} ${F2} clean

${F1}:
	pdflatex ${F1}.tex
	pdflatex ${F1}.tex

${F2}:
	pdflatex ${F2}.tex
	pdflatex ${F2}.tex

clean:
	rm -rf *.out *.log *.aux *.auxlock *.bbl *.blg
