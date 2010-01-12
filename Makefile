.PHONY: all test clean

all:
	ooc {vector-test,matrix-test,qr,lu,gauss}.ooc -v -shout -t

test: all
	./vector-test
	./matrix-test
	./qr 3x2 2 3 2 4 1 1
	./lu 3x3 2 3 9 8 0 7 1 9 3
	./gauss 3x5 1 1 2 3 13 1 -2 1 1 8 3 1 1 -1 1
	
