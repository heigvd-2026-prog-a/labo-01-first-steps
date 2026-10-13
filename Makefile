EXEC = gcd
CFLAGS = -std=c11 -g -Wall -Wextra -Werror

all: build

build: $(EXEC)

# What the Quiz platform runs before the tests (its default build command):
# a fresh build without -Werror, so that a warning is reported (and graded
# by its own criterion) without keeping the program from being tested.
prepare:
	$(MAKE) --always-make build CFLAGS="$(filter-out -Werror,$(CFLAGS))"

$(EXEC): $(EXEC).c
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

test: $(EXEC)
	pytest -v

clean:
	$(RM) $(EXEC) *.o a.out report.xml

.PHONY: all build test clean prepare
