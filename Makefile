EXEC = gcd
CFLAGS = -std=c11 -g -Wall -Wextra -Werror

all: build

build: $(EXEC)

$(EXEC): $(EXEC).c
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

test: $(EXEC)
	pytest -v

clean:
	$(RM) $(EXEC) *.o a.out report.xml

.PHONY: all build test clean
