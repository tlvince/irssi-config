# A brittle script to bootstrap irssi scripts from AUR packages.
# Copyright 2012 Tom Vincent <http://tlvince.com/contact/>

list=script-list
scripts=$$HOME/proj/pkgbuild

all: install

install:
	mkdir -p scripts/autorun
	aurget -S --deps --noconfirm `cut -f 1 $(list)`
	for i in `cut -f 2 $(list)`; do \
		ln -s /usr/share/irssi/scripts/$$i scripts/autorun; \
	done

gen-list:
	for i in $(scripts)/irssi-script-*; do \
		script=`basename $$i`; \
		echo -ne "$$script\t" >> $(list); \
		grep "^_name" "$(scripts)/$$script/PKGBUILD" | sed "s/_name=//" >> $(list); \
	done

clean:
	rm -rf $(list) scripts

.PHONY: all install gen-list clean
