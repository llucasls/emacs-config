FILES := init.el $(wildcard conf.d/*.el)

ELC_FILES := $(FILES:%.el=%.elc)
ELN_FILES := $(FILES:%.el=%.eln)

CLIENT = emacsclient --alternate-editor=false

PACKAGES != awk '/^\(use-package/ { print gensub(")", "", 1, $$2) }' conf.d/melpa-packages.el

MAKEFLAGS := -j -Orecurse

BASENAMES = $(subst conf.d/,,$(FILES:%.el=%))

all: byte-code

byte-code: $(ELC_FILES)

$(ELC_FILES): %.elc: %.el
	@task.d/compile.el $<

native: $(ELN_FILES)

$(ELN_FILES): %.eln: %.el native-is-available
	$(CLIENT) $(FLAGS) --eval '(native-compile "$<")'

native-is-available:
	@task.d/native-is-available.el

install: $(PACKAGES)
	task.d/melpa-install.el $^

clean:
	rm -f $(ELC_FILES)

clean-native:
	for file in $(BASENAMES); do \
		if ls eln-cache/*/$${file}* > /dev/null 2>&1; then \
			unlink eln-cache/*/$${file}*; \
		fi; \
	done

.PHONY: all byte-code native clean native-is-available install $(PACKAGES) clean-native

.SILENT: all clean-native
