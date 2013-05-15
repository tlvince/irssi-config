# Bootstrap irssi scripts.
# © 2013 Tom Vincent <http://tlvince.com/contact>

PREFIX?=scripts/autorun
INSTALLDIR?=$(DESTDIR)$(PREFIX)

SCRIPTS=scripts.csv

all: install

init:
	mkdir -p $(INSTALLDIR)

install: init
	cd $(INSTALLDIR); \
	for script in `cut -d ',' -f 2 ../../$(SCRIPTS)`; do \
		curl -O "$$script"; \
	done

install-archlinux: init
	aurget -S --deps --noconfirm `cut ',' -f 3 $(SCRIPTS)`
	for i in `cut -d ',' -f 1 $(SCRIPTS)`; do \
		ln -s /usr/share/irssi/scripts/$$i scripts/autorun; \
	done

uninstall:
	rm -rf $(INSTALLDIR)

.PHONY: all init install install-archlinux uninstall
