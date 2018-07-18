# SHA-1 for the original Tetris ROM dump.
TETRIS_SHA := 74591cc9501af93873f9a5d3eb12da12c0723bbc

# Expected SHA-1 after Itris patch is applied.
ITRIS_SHA  := 94fe2a79ecfd69c439f8079258a541526e48d3d5

.PHONY: all clean realclean check

all: itris.gb

tetris.gb:
	shasum -c <<< "$(TETRIS_SHA) *$@" || >&2 echo "You have to provide $@ with SHA-1 $(TETRIS_SHA)" ; exit 1

itris.gb: tetris.gb
	cp $< $@
	cat itris.patch | xxd -c 2 -r - $@

clean:
	rm -f itris.gb

realclean: clean
	rm -f tetris.gb

check: itris.gb
	shasum -c <<< "$(ITRIS_SHA) *$<"
