all: prog injlib.dylib

run: all
	DYLD_INSERT_LIBRARIES=injlib.dylib ./prog

prog: prog.m
	clang prog.m -framework Foundation -o prog

injlib.dylib: injlib.m
	clang injlib.m -dynamiclib -framework Foundation -o injlib.dylib

clean:
	rm prog injlib.dylib
