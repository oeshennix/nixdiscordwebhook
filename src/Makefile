.PHONY: build #unittest

build: request.out

#unittest:
#	$(MAKE) -C unittest

request.out: main.c discord.c
	gcc $(flags) -lcurl discord.c main.c -o request.out

all: build unittest
