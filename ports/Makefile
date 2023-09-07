.SUFFIXES: .erl .beam

.erl.beam:
	erlc -W $<


MODS = example1

all: ${MODS:%=%.beam} example1

example1: example1.c erl_comm.c example1_driver.c
	gcc -o example1 example1.c erl_comm.c example1_driver.c
