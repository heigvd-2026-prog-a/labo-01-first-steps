EXEC = gcd
CFLAGS = -std=c11 -g -Wall -Wextra -Werror

all: build

build: $(EXEC)

# What the Quiz platform runs before the tests (its default build command).
prepare: build

$(EXEC): $(EXEC).c
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

test: $(EXEC)
	pytest -v

clean:
	$(RM) $(EXEC) *.o a.out report.xml

.PHONY: all build test clean prepare
