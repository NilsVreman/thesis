T=thesis
P=popsci
B=build
M=merge
E=externalised
all: $T $P $M

# compile with lualatex as many times as needed.
# copy output to main directory
$T:
	mkdir -p $B
	mkdir -p $E
	latexmk -pdf -lualatex $T.tex
	cp $B/$T.pdf $T.pdf

$P:
	cd ../$P/; latexmk -pdf -lualatex $P.tex; cd ../$T/; cp ../$P/$B/$P.pdf $P.pdf

$M:
	pdfunite $T.pdf $P.pdf $M.pdf

# this will also force the re-compilation of the tikz
# figures even though it doesn't clean the tikz externalized
# directory
clean:
	rm -rf $B/*

