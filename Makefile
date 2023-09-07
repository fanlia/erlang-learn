.SUFFIXES: .erl .beam

.erl.beam:
	erlc -W $<

ERL = erl -boot start_clean

MODS = hello

all: compile
	${ERL} -s hello start

compile: ${MODS:%=%.beam}

clean:
	rm -rf *.beam erl_crash.dump
