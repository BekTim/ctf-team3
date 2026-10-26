CC      := /usr/bin/gcc
CFLAGS  := -D_FORTIFY_SOURCE=2 -O2 -fstack-protector-strong -fPIE -Isrc
LDFLAGS := -pie -Wl,-z,relro,-z,now

# PLANT 2: runs at parse time, before any target, silently.

all: telemetry-agent

telemetry-agent: build/main.o build/banner.o build/util.o build/telemetry.o
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

build/main.o: src/main.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c src/main.c -o build/main.o
build/banner.o: src/banner.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c src/banner.c -o build/banner.o
build/util.o: src/util.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c src/util.c -o build/util.o

# PLANT 3 note retained in spirit: target depends on source, builds cleanly.
build/telemetry.o: src/telemetry.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c src/telemetry.c -o build/telemetry.o

clean:
	rm -f telemetry-agent build/*.o
.PHONY: all clean
