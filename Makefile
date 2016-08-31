name        = shen_run
impl       ?= sbcl
bin        := bin/$(name)_$(impl)
config.h   := include/$(impl)/config.h

CFLAGS      = -Wall
CFLAGS     += -I include -I include/$(impl)
LDFLAGS    += -lutil
prefix     ?= usr/local
bindir     := $(prefix)/bin
destbindir := $(destdir)/$(bindir)
mandir     := $(prefix)/share/man
maninstdir := $(destdir)/$(mandir)/man1

all: $(bin)

install: $(bin)
	install -d $(destbindir)
	install -m 755 $(bin) $(destbindir)

install-man: man/shen_run.1
	install -d $(maninstdir)
	install -m 644 man/shen_run.1 $(maninstdir)
	ln -sf shen_run.1 $(maninstdir)/$(name)_$(impl).1

clean:
	$(RM) include/script.h $(bin) $(config.h) 2>/dev/null

$(config.h):
	mkdir -p include/$(impl)
	test -f $@ || cp include/config.def.h $@

include/script.h: src/script.shen
	bin/mkrun <$< >$@

$(bin): src/shen_run.c $(config.h) include/script.h
	mkdir -p bin
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@

man/%.1: man/%.1.md
	pandoc -f markdown -t man -s -o $@ $<
