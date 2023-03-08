F=popsci
B=build
E=externalised
all: popsci

# compile with lualatex as many times as needed.
# copy output to main directory
popsci:
	mkdir -p $B
	mkdir -p $E
	latexmk -pdf -lualatex $F.tex
	cp $B/$F.pdf $F.pdf

# this will also force the re-compilation of the tikz
# figures even though it doesn't clean the tikz externalized
# directory
clean:
	rm -rf $B/*

